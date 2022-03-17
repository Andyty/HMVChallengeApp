import 'package:flutter/material.dart';

enum ScheduleTypes { exams, medic }

class ScheduleType extends StatefulWidget {
  final void Function(ScheduleTypes newStep) selectScheduleType;

  const ScheduleType({Key? key, required this.selectScheduleType})
      : super(key: key);

  @override
  State<ScheduleType> createState() => _ScheduleTypeState();
}

class _ScheduleTypeState extends State<ScheduleType> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Escolha qual agendamento deseja fazer:",
          textAlign: TextAlign.center,
        ),
        ElevatedButton(
          onPressed: () {
            widget.selectScheduleType(ScheduleTypes.exams);
          },
          child: const Text("Exames Clínicos")
        ),
        ElevatedButton(
            onPressed: () {
              widget.selectScheduleType(ScheduleTypes.medic);
            },
            child: const Text("Consulta Médica")
        ),
      ],
    );
  }
}
