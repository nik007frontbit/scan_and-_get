part of 'nutraceuticals_cubit.dart';

@immutable
sealed class NutraceuticalsState {}

final class NutraceuticalsInitialState extends NutraceuticalsState {}
final class NutraceuticalsLoadingState extends NutraceuticalsState {}
final class NutraceuticalsSuccessState extends NutraceuticalsState {}
final class NutraceuticalsErrorState extends NutraceuticalsState {
  String error;

  NutraceuticalsErrorState({required this.error});
}