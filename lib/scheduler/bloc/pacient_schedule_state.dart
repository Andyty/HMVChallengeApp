part of 'pacient_schedule_bloc.dart';

enum PacientScheduleStatus { initial, success, error, loading }

extension PacientScheduleStatusX on PacientScheduleStatus {
  bool get isInitial => this == PacientScheduleStatus.initial;
  bool get isSuccess => this == PacientScheduleStatus.success;
  bool get isError => this == PacientScheduleStatus.error;
  bool get isLoading => this == PacientScheduleStatus.loading;
}


class PacientScheduleState extends Equatable {
  const PacientScheduleState({
    this.status = PacientScheduleStatus.initial,
    this.schedulesMap = const <String, List<Schedule>>{},
    this.scheduleDates = const [],
  });


  final PacientScheduleStatus status;
  final Map<String, List<Schedule>> schedulesMap;
  final List<DateTime> scheduleDates;


  @override
  List<Object> get props => [status, schedulesMap];

  PacientScheduleState copyWith({
    Map<String, List<Schedule>>? schedulesMap,
    PacientScheduleStatus? status,
    List<DateTime>? scheduleDates,
  }) {
    return PacientScheduleState(
      schedulesMap: schedulesMap ?? this.schedulesMap,
      status: status ?? this.status,
      scheduleDates: scheduleDates ?? this.scheduleDates
    );
  }
}

