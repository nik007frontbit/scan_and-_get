part of 'batch_reader_cubit.dart';

@immutable
sealed class BatchReaderState {}

final class BatchReaderInitialState extends BatchReaderState {}

final class BatchReaderLoadingState extends BatchReaderState {}

final class BatchReaderSuccessState extends BatchReaderState {}

final class BatchReaderErrorState extends BatchReaderState {
  String error;

  BatchReaderErrorState({required this.error});
}

final class BatchReaderInitial extends BatchReaderState {}
