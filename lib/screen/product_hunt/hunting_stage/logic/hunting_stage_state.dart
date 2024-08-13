part of 'hunting_stage_cubit.dart';

@immutable
sealed class HuntingStageState {}

final class HuntingStageInitialState extends HuntingStageState {}

final class HuntingStageLoadingState extends HuntingStageState {}

final class HuntingStageSuccessState extends HuntingStageState {}

final class HuntingStageErrorState extends HuntingStageState {
  String error;

  HuntingStageErrorState({required this.error});
}
