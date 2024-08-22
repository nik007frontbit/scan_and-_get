part of 'nutritional_cubit.dart';

@immutable
sealed class NutritionalState {}

final class NutritionalInitialState extends NutritionalState {}
final class NutritionalLoadingState extends NutritionalState {}
final class NutritionalSuccessState extends NutritionalState {}
final class NutritionalErrorState extends NutritionalState {
  String error;

  NutritionalErrorState({required this.error});
}