import 'package:flutter/material.dart';
import 'package:hmv_challenge_app/scheduler/view/schedule_calendar.dart';
import 'package:hmv_challenge_app/scheduler/view/schedule_type.dart';

class SchedulerPage extends StatefulWidget {
  const SchedulerPage({Key? key}) : super(key: key);

  @override
  State<SchedulerPage> createState() => _SchedulerPageState();
}

class _SchedulerPageState extends State<SchedulerPage> {

  int _scheduleStep = 0;
  ScheduleTypes? _scheduleTypeSelected;


  @override
  Widget build(BuildContext context) {

    Widget _currentStepWidget;
    switch(_scheduleStep) {
      case 0: {
        _currentStepWidget = ScheduleCalendar(createEvent: createEvent,);
      }
      break;

      case 1: {
        _currentStepWidget = ScheduleType(selectScheduleType: selectScheduleType);
      }
      break;

      case 2: {
        _currentStepWidget = Center(
          child: Text(_scheduleTypeSelected.toString()),
        );
      }
      break;

      default: {
        _currentStepWidget = Container();
      }
      break;
    }


    return _currentStepWidget;
    // return ListView(
    //   children: [
    //     _currentStepWidget
    //   ],
    // );
  }

  void selectScheduleType(ScheduleTypes type) {
    setState(() {
      _scheduleStep = 2;
      _scheduleTypeSelected = type;
      //AlertDialog(content: Text(_scheduleTypeSelected.toString()),);
    });
  }

  void createEvent() {
    setState(() {
      _scheduleStep = 1;
    });
  }
}



// class SchedulerPage extends StatelessWidget {
//   const SchedulerPage({Key? key}) : super(key: key);
//
//   int _scheduleStep = 0;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: ListView(
//         children: [
//
//         ],
//       ),
//     );
//   }
// }
