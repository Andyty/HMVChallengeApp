import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hmv_challenge_app/scheduler/bloc/medical_specialty_bloc.dart';
import 'package:hmv_challenge_app/scheduler/view/free_schedules_list.dart';
import 'package:schedule_repository/schedule_repository.dart';

enum ScheduleSpecialtySelection { exams, medic }

class SchedulesSpecialtySelection extends StatelessWidget {
  final int idUser;
  const SchedulesSpecialtySelection({Key? key, required this.idUser}) : super(key: key);

  static Route route(int idUser) {
    return MaterialPageRoute(builder: (context) => SchedulesSpecialtySelection(idUser: idUser,));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Novo Agendamento"),
      ),
      body: RepositoryProvider(
        create: (context) => ScheduleRepository(),
        child: BlocProvider<MedicalSpecialtyBloc>(
          create: (context) {
            return MedicalSpecialtyBloc(
              scheduleRepository: context.read<ScheduleRepository>()
            )..add(GetMedicalSpecialties());

          },
          child: BlocBuilder<MedicalSpecialtyBloc, MedicalSpecialtyState>(
            builder: (context, state) {
              return Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
                    child: Text(
                      "Escolha a especialidade desejada:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                      ),
                    ),
                  ),
                  Expanded(child: _buildList(context, state))
                ],
              );
            },
          ),
        ),
      )
    );
  }

  Widget _buildList(BuildContext context, MedicalSpecialtyState state) {
    const emptyList = Padding(
      padding: EdgeInsets.all(12),
      child: Text("Nenhuma especialidade encontrada"),
    );
    if(state.status.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if(state.status.isError) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text('Não foi possível obter a lista de especialidades. Por favor, tente atualizar a lista.'),
            behavior: SnackBarBehavior.floating,
            action: SnackBarAction(
                label: "Atualizar",
                onPressed: () {
                  context.read<MedicalSpecialtyBloc>().add(GetMedicalSpecialties());
                }),
          ),
        );
      return emptyList;

    } else {
      return ListView.builder(
        itemCount: state.specialties.length,
        itemBuilder: (context, index) {
          return Card(
            child: InkWell(
              splashColor: Theme.of(context).colorScheme.primary.withAlpha(30),
              onTap: () {
                // ScaffoldMessenger.of(context)
                //   ..hideCurrentSnackBar()
                //   ..showSnackBar(
                //   SnackBar(content: Text(state.specialties[index].specialtyName),)
                // );
                Navigator.push(
                  context,
                  FreeSchedulesList.route(state.specialties[index].specialtyId, idUser),
                );
              },
              child: ListTile(
                title: Text(state.specialties[index].specialtyName),
              ),
            ),
          );
        }
      );
    }
  }
}