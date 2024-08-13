part of 'product_hunt_form_cubit.dart';

@immutable
sealed class ProductHuntFormState {}

final class ProductHuntFormInitial extends ProductHuntFormState {}
final class ProductHuntFormLoadingState extends ProductHuntFormState {}
final class ProductHuntFormSuccessState extends ProductHuntFormState {}
