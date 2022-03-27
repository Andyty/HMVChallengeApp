part of 'schedule_bloc.dart';

enum ScheduleStatus { initial, success, error, loading }

extension ScheduleStatusX on ScheduleStatus {
  bool get isInitial => this == ScheduleStatus.initial;
  bool get isSuccess => this == ScheduleStatus.success;
  bool get isError => this == ScheduleStatus.error;
  bool get isLoading => this == ScheduleStatus.loading;
}

class ScheduleState extends Equatable {

  const ScheduleState({
    this.status = ScheduleStatus.initial,
    this.schedules = const []
  });

  final ScheduleStatus status;
  final List<Schedule> schedules;

  @override
  List<Object> get props => [status, schedules];

  ScheduleState copyWith({
    List<Schedule>? schedules,
    ScheduleStatus? status,
  }) {
    return ScheduleState(
      schedules: schedules ?? this.schedules,
      status: status ?? this.status,
    );
  }
}
