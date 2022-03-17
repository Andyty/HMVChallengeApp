import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:hmv_challenge_app/scheduler/models/scheduleTO.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleCalendar extends StatefulWidget {
  final void Function() createEvent;
  const ScheduleCalendar({Key? key, required this.createEvent})
      : super(key: key);

  @override
  State<ScheduleCalendar> createState() => _ScheduleCalendarState();
}

class _ScheduleCalendarState extends State<ScheduleCalendar> {
  // TODO: replace this hardcoded var with rest call result
  // TODO: use this as reference https://bloclibrary.dev/#/flutterinfinitelisttutorial
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _firstDate = DateTime.now().subtract(const Duration(days: 365 * 3));
  DateTime _lastDate = DateTime.now().add(const Duration(days: 365));

  HashMap<DateTime, List<ScheduleTO>> events =
      HashMap<DateTime, List<ScheduleTO>>(
    equals: isSameDay,
    hashCode: (DateTime key) {
      return key.day * 1000000 + key.month * 10000 + key.year;
    },
  );

  final List<ScheduleTO> _list = [
    ScheduleTO(
        idAgenda: 1,
        idTipoExame: 1,
        dtAgenda: DateTime(2022, 03, 18, 10, 0),
        nmMedico: "Dr. Ricardo Silva",
        nmExame: ""),
    ScheduleTO(
        idAgenda: 2,
        idTipoExame: 1,
        dtAgenda: DateTime(2022, 03, 20, 10, 30),
        nmMedico: "Dra. Cristina Almeida",
        nmExame: ""),
    ScheduleTO(
        idAgenda: 3,
        idTipoExame: 2,
        dtAgenda: DateTime(2022, 04, 10, 15, 0),
        nmMedico: "",
        nmExame: "Raio-X Cabeça"),
    ScheduleTO(
        idAgenda: 5,
        idTipoExame: 2,
        dtAgenda: DateTime(2022, 04, 10, 15, 10),
        nmMedico: "",
        nmExame: "Ressonância Magnética"),
    ScheduleTO(
        idAgenda: 4,
        idTipoExame: 2,
        dtAgenda: DateTime(2022, 04, 10, 15, 20),
        nmMedico: "",
        nmExame: "Ultrasonografia"),
    ScheduleTO(
        idAgenda: 6,
        idTipoExame: 2,
        dtAgenda: DateTime(2022, 04, 10, 15, 30),
        nmMedico: "",
        nmExame: "Teste Ergométrico"),
    ScheduleTO(
        idAgenda: 7,
        idTipoExame: 2,
        dtAgenda: DateTime(2022, 04, 10, 16, 0),
        nmMedico: "",
        nmExame: "Ecocardiograma"),
    ScheduleTO(
        idAgenda: 8,
        idTipoExame: 2,
        dtAgenda: DateTime(2022, 04, 20, 8, 25),
        nmMedico: "",
        nmExame: "Cintilografia"),
    ScheduleTO(
        idAgenda: 9,
        idTipoExame: 1,
        dtAgenda: DateTime(2022, 05, 3, 9, 0),
        nmMedico: "Dr. Ricardo Silva",
        nmExame: ""),
    ScheduleTO(
        idAgenda: 10,
        idTipoExame: 1,
        dtAgenda: DateTime(2022, 04, 12, 12, 30),
        nmMedico: "Dra. Ana Souza",
        nmExame: ""),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    HashMap<DateTime, List<ScheduleTO>> ev =
        HashMap<DateTime, List<ScheduleTO>>(
      equals: isSameDay,
      hashCode: (DateTime key) {
        return key.day * 1000000 + key.month * 10000 + key.year;
      },
    );
    for (var item in _list) {
      ev.update(item.dtAgenda, (value) {
        value.add(item);
        return value;
      }, ifAbsent: () => [item]);
    }
    setState(() {
      events = ev;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Column(

      children: [
        TableCalendar(
          locale: 'pt_BR',
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
          ),
          firstDay: _firstDate,
          lastDay: _lastDate,
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          },
          calendarFormat: _calendarFormat,
          onFormatChanged: (format) {
            setState(() {
              _calendarFormat = format;
            });
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
          eventLoader: (day) {
            return _getEventsForDay(day);
          },
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _list.length,
            itemBuilder: eventListBuilder
          ),
        ),
      ]
    );


  }

  List<ScheduleTO> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  Widget eventListBuilder(BuildContext context, int index) {
    final item = _list[index];
    final DateFormat dateFormat = DateFormat("dd/MM/yy kk:mm");

    if (item.idTipoExame == 1) {
      return ListTile(
        title: Text(item.nmMedico),
        //leading: ,
        trailing: Text(dateFormat.format(item.dtAgenda)),
      );
    } else {
      return ListTile(
        title: Text(item.nmExame),
        //leading: ,
        trailing: Text(dateFormat.format(item.dtAgenda)),
      );
    }
  }
}
