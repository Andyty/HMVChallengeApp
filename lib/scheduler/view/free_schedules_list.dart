import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/sliver_grouped_list.dart';
import 'package:hmv_challenge_app/scheduler/bloc/book_schedule_bloc.dart';
import 'package:hmv_challenge_app/scheduler/bloc/medic_bloc.dart';
import 'package:hmv_challenge_app/scheduler/bloc/schedule_bloc.dart';
import 'package:hmv_challenge_app/scheduler/models/models.dart';
import 'package:hmv_challenge_app/scheduler/view/scheduler_page.dart';
import 'package:intl/intl.dart';
import 'package:schedule_repository/schedule_repository.dart'
    hide Medic, Schedule;
import 'package:table_calendar/table_calendar.dart';

class FreeSchedulesList extends StatefulWidget {
  final int idSpecialty;
  final int idUser;
  const FreeSchedulesList(
      {Key? key, required this.idSpecialty, required this.idUser})
      : super(key: key);

  static Route route(int idSpecialty, int idUser) {
    return MaterialPageRoute(
        builder: (context) => FreeSchedulesList(
              idSpecialty: idSpecialty,
              idUser: idUser,
            ));
  }

  @override
  State<FreeSchedulesList> createState() => _FreeSchedulesListState();
}

class _FreeSchedulesListState extends State<FreeSchedulesList> {
  final DateFormat dateFormat = DateFormat("dd/MM/yyyy");
  DateTime dtStart = DateTime.now();
  DateTime dtEnd = DateTime.now().add(const Duration(days: 90));
  int? idMedic;

  TextEditingController dtStartInput = TextEditingController();

  @override
  void initState() {
    dtStart = DateTime(dtStart.year, dtStart.month, dtStart.day);
    dtEnd = DateTime(dtEnd.year, dtEnd.month, dtEnd.day, 23, 59, 59);
    dtStartInput.text =
        "${dateFormat.format(dtStart)} - ${dateFormat.format(dtEnd)}"; //set the initial value of text field

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (context) => ScheduleRepository(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<MedicBloc>(create: (context) {
              return MedicBloc(
                  scheduleRepository: context.read<ScheduleRepository>())
                ..add(GetMedicList(widget.idSpecialty));
            }),
            BlocProvider<ScheduleBloc>(create: (context) {
              return ScheduleBloc(
                  scheduleRepository: context.read<ScheduleRepository>())
                ..add(ScheduleGetFreeSchedules(
                    dtStart, dtEnd, widget.idSpecialty, idMedic));
            }),
            BlocProvider(
                create: (context) => BookScheduleBloc(
                    scheduleRepository: context.read<ScheduleRepository>()))
          ],
          child: BlocConsumer<BookScheduleBloc, BookScheduleState>(
            listener: (context, state) {
              if (state.status.isError) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(const SnackBar(
                    content: Text(
                        "Ocorreu um erro ao efetuar ao agendamento, por favor tente novamente ou escolha um novo horário."),
                  ));
              }
              if (state.status.isSuccess && !state.bookSchedule.isBooked) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(const SnackBar(
                    content: Text(
                        "Não foi possível efetuar o agendamento do horário escolhido, por favor escolha outro horário."),
                  ));
              }
              if (state.status.isSuccess && state.bookSchedule.isBooked) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(const SnackBar(
                    content: Text("Agendamento efetuado com sucesso!"),
                  ));
                Navigator.pushAndRemoveUntil(context, SchedulerPage.route(), (route) => false);
              }
            },
            builder: (bookScheduleBlocContext, state) {
              if (state.status.isInitial
                  || state.status.isError
                  || (state.status.isSuccess && !state.bookSchedule.isBooked)  ) {
                return Scaffold(
                    appBar: AppBar(
                      title: const Text('Novo Agendamento'),
                    ),
                    body: CustomScrollView(
                      slivers: [
                        BlocBuilder<ScheduleBloc, ScheduleState>(
                          builder: (context, state) {
                            return SliverPersistentHeader(
                              floating: true,
                              delegate: FilterArea(
                                  buildFilterArea: _buildFilterArea,
                                  ctx: context),
                            );
                          },
                        ),
                        BlocBuilder<ScheduleBloc, ScheduleState>(
                          builder: (scheduleBlocContext, state) {
                            return SliverPadding(
                                padding: const EdgeInsets.all(12),
                                sliver: _buildResultList(scheduleBlocContext, bookScheduleBlocContext, state));
                          },
                        )
                      ],
                    ));
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
          }),
        ));
  }

  Widget _buildFilterArea(BuildContext ctx) {
    return Container(
      decoration: const BoxDecoration(
          color: Color.fromRGBO(240, 240, 240, 1),
          border: Border(
              bottom: BorderSide(
            width: 2,
            color: Colors.white,
          ))),
      height: 160,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: dtStartInput,
              readOnly: true,
              decoration: InputDecoration(
                label: const Text("Selecione o período:"),
                errorText: normalizeDate(dtStart)
                            .isBefore(normalizeDate(DateTime.now())) ||
                        dtEnd.isBefore(dtStart)
                    ? 'Selecione um período válido'
                    : null,
              ),
              onTap: () async {
                DateTime now = DateTime.now();
                DateTimeRange? pickedRange = await showDateRangePicker(
                  context: context,
                  firstDate: now,
                  lastDate: DateTime(now.year + 2),
                  currentDate: now,
                  locale: const Locale('pt', 'BR'),
                  initialEntryMode: DatePickerEntryMode.calendarOnly,
                  initialDateRange: DateTimeRange(start: dtStart, end: dtEnd),
                );

                if (pickedRange != null) {
                  setState(() {
                    dtStart = DateTime(pickedRange.start.year,
                        pickedRange.start.month, pickedRange.start.day);
                    dtEnd = DateTime(pickedRange.end.year,
                        pickedRange.end.month, pickedRange.end.day, 23, 59, 59);
                    dtStartInput.text =
                        "${dateFormat.format(dtStart)} - ${dateFormat.format(dtEnd)}";
                  });
                  ctx.read<ScheduleBloc>().add(ScheduleGetFreeSchedules(
                      dtStart, dtEnd, widget.idSpecialty, idMedic));
                }
              },
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: BlocBuilder<MedicBloc, MedicState>(
                builder: (context, state) {
                  List<Medic> medics =
                      state.status.isSuccess ? state.medics : [];
                  List<DropdownMenuItem<int>> items = [
                    const DropdownMenuItem(
                        value: 0, child: Text("Todos os profissionais")),
                    ...medics.map((m) => DropdownMenuItem(
                        value: m.medicId, child: Text(m.medicName)))
                  ].toList();
                  return DropdownButton(
                      value: idMedic,
                      icon: const Icon(Icons.arrow_drop_down),
                      hint: const Text("Todos os profissionais"),
                      items: items,
                      onChanged: (newValue) {
                        setState(() {
                          idMedic = newValue as int == 0 ? null : newValue;
                        });
                        ctx.read<ScheduleBloc>().add(ScheduleGetFreeSchedules(
                            dtStart, dtEnd, widget.idSpecialty, idMedic));
                      });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultList(BuildContext scheduleBlocContext, BuildContext bookScheduleBlocContext, ScheduleState state) {
    if (state.status.isLoading) {
      return const SliverToBoxAdapter(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (state.status.isError ||
        (state.status.isSuccess && state.schedules.isEmpty)) {
      return const SliverPadding(
        padding: EdgeInsets.all(12),
        sliver: SliverToBoxAdapter(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text("Nenhuma agenda livre encontrada."),
          ),
        ),
      );
    } else {
      return SliverGroupedListView(
          elements: state.schedules, //state.schedules,
          groupBy: (Schedule el) => el.medicName,
          groupComparator: (String value1, String value2) =>
              value2.compareTo(value1),
          groupSeparatorBuilder: (String value) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  value,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
          itemComparator: (Schedule item1, Schedule item2) =>
              item2.scheduleDate.compareTo(item2.scheduleDate),
          itemBuilder: (context, Schedule element) {
            return Card(
              child: InkWell(
                splashColor:
                    Theme.of(context).colorScheme.primary.withAlpha(30),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Confirmar agendamento'),
                      content: Text(
                          "Confirmar agendamento da consulta com ${element.medicName} para o dia ${DateFormat("dd/MM/yyyy 'às' HH:mm").format(element.scheduleDate)}"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, 'OK');
                            bookScheduleBlocContext.read<BookScheduleBloc>().add(
                                BookNewSchedule(widget.idUser,
                                    element.scheduleId, 1));
                          },
                          child: const Text('CONFIRMAR'),
                        ),
                      ],
                    ),
                  );
                },
                child: ListTile(
                  title: Text(element.medicName),
                  trailing: Text(
                    DateFormat("dd/MM/yyyy HH:mm").format(element.scheduleDate),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            );
          });
    }
  }
}

class FilterArea extends SliverPersistentHeaderDelegate {
  FilterArea(
      {required this.ctx, required this.buildFilterArea(BuildContext ctx)});

  final BuildContext ctx;
  final Function(BuildContext context) buildFilterArea;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return buildFilterArea(ctx);
  }

  @override
  double get maxExtent => 160;

  @override
  double get minExtent => 160;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
