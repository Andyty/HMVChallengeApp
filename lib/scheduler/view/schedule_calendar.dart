import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hmv_challenge_app/scheduler/bloc/pacient_schedule_bloc.dart';
import 'package:hmv_challenge_app/scheduler/models/schedule.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleCalendar extends StatefulWidget {
  const ScheduleCalendar({Key? key}) : super(key: key);

  @override
  State<ScheduleCalendar> createState() => _ScheduleCalendarState();
}

class _ScheduleCalendarState extends State<ScheduleCalendar> {
  late final ValueNotifier<List<Schedule>> _selectedEvents = ValueNotifier([]);
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final DateTime _firstDay = DateTime.now().subtract(const Duration(days: 180));
  final DateTime _lastDay = DateTime.now().add(const Duration(days: 180));
  final CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PacientScheduleBloc, PacientScheduleState>(
        builder: (context, state) {
          _selectedEvents.value = _getEventsForDay(_selectedDay!, state);
          return Column(
              children: [
                TableCalendar(
                  locale: 'pt_BR',
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                  ),
                  calendarStyle: const CalendarStyle(
                    outsideDaysVisible: true,
                  ),
                  firstDay: state.scheduleDates.isEmpty ? _firstDay : state.scheduleDates.first.subtract(const Duration(days: 180)),
                  lastDay: state.scheduleDates.isEmpty ? _lastDay : state.scheduleDates.last.add(const Duration(days: 180)),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
                    _onDaySelected(selectedDay, focusedDay, state);
                  },
                  calendarFormat: _calendarFormat,
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                  eventLoader: (day) {
                    return _getEventsForDay(day, state);
                  },
                ),
                Expanded(
                    child: ValueListenableBuilder<List<Schedule>>(
                      valueListenable: _selectedEvents,
                      builder: (context, value, _) {
                        return state.status.isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : value.isEmpty
                              ? const Padding(
                                  padding: EdgeInsets.all(12),
                                  child: ListTile(
                                    title: Text("Não há agendamentos para o dia selecionado"),
                                  ),

                                )
                              : ListView.builder(
                                itemCount: value.length,
                                itemBuilder: (context, index) {
                                  final DateFormat dateFormat = DateFormat("dd/MM/yy kk:mm");
                                  return Card(
                                    child: ListTile(
                                      title: Text(value[index].medicName),
                                      //leading: ,
                                      trailing: Text(dateFormat.format(value[index].scheduleDate)),
                                    ),
                                  );
                                }
                              );
                      },
                    )

                ),
              ]
          );
        }
    );
  }


  List<Schedule> _getEventsForDay(DateTime day, PacientScheduleState state) {
    final DateFormat dateFormat = DateFormat("yyyyMMdd");

    return state.schedulesMap[dateFormat.format(day)] ?? [];
  }

  void _onDaySelected (DateTime selectedDay, DateTime focusedDay, PacientScheduleState state) {
    if (!isSameDay(_selectedDay, selectedDay)){
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
    }
    _selectedEvents.value = _getEventsForDay(selectedDay, state);
  }


}
