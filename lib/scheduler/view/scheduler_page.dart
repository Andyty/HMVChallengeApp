import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hmv_challenge_app/scheduler/bloc/pacient_schedule_bloc.dart';
import 'package:hmv_challenge_app/scheduler/view/schedule_calendar.dart';
import 'package:hmv_challenge_app/scheduler/view/schedule_specialty_selection.dart';
import 'package:schedule_repository/schedule_repository.dart' hide Schedule;

class SchedulerPage extends StatefulWidget {
  const SchedulerPage({Key? key}) : super(key: key);

  @override
  State<SchedulerPage> createState() => _SchedulerPageState();

  static Route route() {
    return MaterialPageRoute(builder: (_) => SchedulerPage());
  }
}

class _SchedulerPageState extends State<SchedulerPage> {
  final idUser = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus Agendamentos"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                SchedulesSpecialtySelection.route(idUser),
              );
            },
            icon: const Icon(Icons.add)
          )
        ],
      ),
      body: RepositoryProvider(
        create: (context) => ScheduleRepository(),
        child: BlocProvider<PacientScheduleBloc>(
          create: (context) {
            return PacientScheduleBloc(
              scheduleRepository: context.read<ScheduleRepository>(),
            )..add(GetPacientSchedules(idUser));
          },
          child: ScheduleCalendar(),
        ),
      )
    );
  }

}