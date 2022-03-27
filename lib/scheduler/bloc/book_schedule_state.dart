part of 'book_schedule_bloc.dart';

enum BookScheduleStatus { initial, success, error, loading }

extension BookScheduleStatusX on BookScheduleStatus {
  bool get isInitial => this == BookScheduleStatus.initial;
  bool get isSuccess => this == BookScheduleStatus.success;
  bool get isError => this == BookScheduleStatus.error;
  bool get isLoading => this == BookScheduleStatus.loading;
}


class BookScheduleState extends Equatable {
  BookScheduleState({
    this.status = BookScheduleStatus.initial,
    BookSchedule? bookSchedule,
  }) : bookSchedule = bookSchedule ?? BookSchedule.empty;

  final BookScheduleStatus status;
  final BookSchedule bookSchedule;

  @override
  List<Object?> get props => [status, bookSchedule];

  BookScheduleState copyWith({
    BookSchedule? bookSchedule,
    BookScheduleStatus? status,
  }) {
    return BookScheduleState(
      bookSchedule: bookSchedule ?? this.bookSchedule,
      status: status ?? this.status,
    );
  }
}