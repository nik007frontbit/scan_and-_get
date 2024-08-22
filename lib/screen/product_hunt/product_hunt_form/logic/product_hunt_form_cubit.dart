import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:scan_and_get_images/src/core/utils/shared_preference/pref_key.dart';
import 'package:scan_and_get_images/src/core/utils/shared_preference/shared_pref.dart';

import '../../../batch_reader/model/address_search_model_entity.dart';
import '../../../batch_reader/model/medicine_search_entity.dart';

part 'product_hunt_form_state.dart';

class ProductHuntFormCubit extends Cubit<ProductHuntFormState> {
  ProductHuntFormCubit() : super(ProductHuntFormInitial());
  TextEditingController medicineSearchController = TextEditingController();
  String? medicineId;
  AddressSearchModelDataResult? addressSearchModelDataResult;
  TextEditingController nameController = TextEditingController();

  // TextEditingController mrpController = TextEditingController();

// Define a list of medicine types
  final List<String> medicineTypes = ["drug", "fmcg", "nutraceutical","other"];
  final List<String> dosageTypes = [
    "tablet",
    "capsule",
    "drop",
    "injection",
    "cream",
    "syrup",
    "powder",
  ];

  // Track the selected medicine type
  String? selectedMedicineType;
  String? selectedDosageType;

  medicineSearchSelect(AddressSearchModelDataResult addressSearchModel) {
    emit(ProductHuntFormLoadingState());
    nameController.text = addressSearchModel.medicineName;
    medicineSearchController.text = addressSearchModel.medicineName;
    selectedMedicineType = addressSearchModel.medicineType;
    medicineId = addressSearchModel.medicineId.toString();
    emit(ProductHuntFormSuccessState());
  }

  medicineSearchSelectBarcode(
      MedicineSearchDataMedicinesResult addressSearchModel) {
    emit(ProductHuntFormLoadingState());
    nameController.text = addressSearchModel.medicineName!;
    medicineSearchController.text = addressSearchModel.medicineName!;
    if (medicineTypes.contains(addressSearchModel.medicineType.toString())) {
      selectedMedicineType = addressSearchModel.medicineType.toString();
    }else{
      selectedMedicineType = "other";
    }
    medicineId = addressSearchModel.medicineId.toString();
    emit(ProductHuntFormSuccessState());
  }

  medicineSearchCancel() {
    emit(ProductHuntFormLoadingState());
    nameController.text = "";
    medicineSearchController.text = "";
    selectedMedicineType = null;
    medicineId = null;
    emit(ProductHuntFormSuccessState());
  }

  List<String> historyListOfProduct = [];

  historyRefresh() async {
    historyListOfProduct = await SharedPref.getStringList(PrefKey.historyList);
    emit(ProductHuntFormSuccessState());
  }

  historyAddAndRefresh(String value) async {
    // Get the history list from Shared Preferences
    List<String> tempList = await SharedPref.getStringList(PrefKey.historyList);

    // Make a modifiable copy of the list
    historyListOfProduct = List<String>.from(tempList);

    // Add the new value to the list
    historyListOfProduct.add(value);

    // Save the updated list back to Shared Preferences
    await SharedPref.setStringList(PrefKey.historyList, historyListOfProduct);

    // Emit success state
    emit(ProductHuntFormSuccessState());
  }
}
