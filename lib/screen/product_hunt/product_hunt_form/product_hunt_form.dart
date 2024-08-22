import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:scan_and_get_images/screen/product_hunt/product_hunt_form/logic/product_hunt_form_cubit.dart';
import 'package:scan_and_get_images/src/core/component/dropdown_button_view.dart';
import 'package:scan_and_get_images/src/core/component/text_field_view.dart';

import '../../../src/core/component/dialog/barcodeSearchDialoug.dart';
import '../../batch_reader/logic/medicine_search_repository.dart';
import '../../batch_reader/model/address_search_model_entity.dart';
import '../hunting_stage/hunting_stage.dart';

class ProductHunt extends StatelessWidget {
  ProductHunt({Key? key}) : super(key: key);

  // TextEditingController Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductHuntFormCubit, ProductHuntFormState>(
        listener: (context, state) {
      print("object");
      // TODO: implement listener
    }, builder: (context, state) {
      ProductHuntFormCubit cubit =
          BlocProvider.of<ProductHuntFormCubit>(context);

      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: cubit.medicineId == null
              ? TypeAheadField(
                  controller: cubit.medicineSearchController,
                  hideWithKeyboard: true,
                  debounceDuration: const Duration(milliseconds: 500),
                  builder: ((context, controller, focusNode) {
                    return TextField(
                      controller: controller,
                      focusNode: focusNode,
                      // style: TextStyles.customFont(
                      //   fontWeight: FontWeight.w600,
                      // ),
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () => barcodeSearchDialog(
                              context: context,
                              onSuccess: (detailsList) {
                                if (detailsList.isNotEmpty) {
                                  cubit.medicineSearchSelectBarcode(
                                      detailsList.first);
                                }
                              },
                            ),
                            icon: Icon(Icons.barcode_reader),
                          ),
                          prefix: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.search),
                          ),
                          hintText: "Search for Medicine",
                          // hintStyle: TextStyles.customFont(
                          //     color: Colors.black26,
                          //     fontWeight: FontWeight.w600,
                          //     fontSize: 16),
                          border: InputBorder.none),
                    );
                  }),
                  onSelected: (pattern) {},
                  itemBuilder: (context, suggestion) {
                    if (suggestion is AddressSearchModelDataResult) {
                      return ListTile(
                        onTap: () => cubit.medicineSearchSelect(suggestion),
                        contentPadding: const EdgeInsets.all(2),
                        leading: Image.network(suggestion.image),
                        title: Text(suggestion.medicineName),
                        subtitle: Text(suggestion.content),
                      );
                    } else {
                      return const SizedBox(
                        height: 40,
                        child: Center(
                          child: Text(
                            "Type 3 or more letter for search",
                            // style: TextStyles.customFont(
                            //     fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                        ),
                      );
                    }
                  },
                  suggestionsCallback: (pattern) async {
                    if (pattern.length >= 3) {
                      var map = {
                        "medicine_name": pattern.toString(),
                        "chemist_id": "48935",
                        "accesstoken": "UPAF5ZohkN9Jj2Bg",
                        "device_id": "9b0ada0e-9af4-4afa-b7b6-06f0101f9b7f",
                        // "app_version": "1",
                        // "os": "android",
                        "apikey": "R08mGEm4550Bi69AHobdH9E4QY02f1N7"
                      };

                      return await MedicineSearchRepository()
                          .callMedicineSearchApi(map);
                    } else {
                      return ["No Data"];
                    }
                  })
              : const Text(
                  "Product Hunt Form",
                ),
          actions: [
            cubit.medicineId != null
                ? IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => cubit.medicineSearchCancel(),
                  )
                : const SizedBox(),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              cubit.medicineId == null
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: const Center(
                          child: Text(
                        "Search Product first",
                      )),
                    )
                  : Column(
                      children: [
                        TextFieldView(
                          title: "Product Name",
                          textEditingController: cubit.nameController,
                        ),
                        DropdownFieldView(
                          label: "Medicine Type",
                          currentValue: cubit.selectedMedicineType,
                          medicineType: cubit.medicineTypes,
                        ),
                        // DropdownFieldView(
                        //   label: "Dosage Type",
                        //   currentValue: cubit.selectedDosageType,
                        //   medicineType: cubit.dosageTypes,
                        // ),
                        ElevatedButton(
                            onPressed: () async {
                              // BlocProvider.of<HuntingStageCubit>(context)
                              //     .resetState();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HuntingStageScreen(
                                      map: {
                                        'medicine_id': cubit.medicineId,
                                        'medicine_name':
                                            cubit.nameController.text,
                                        'medicine_type':
                                            cubit.selectedMedicineType,
                                      },
                                    ),
                                  ));
                            },
                            child: const Text(
                              "Start Hunt",
                            ))
                      ],
                    ),
              cubit.historyListOfProduct.length > 0
                  ? Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "History Of Recent Product",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: cubit.historyListOfProduct.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                  cubit.historyListOfProduct[index].toString()),
                            );
                          },
                        )
                      ],
                    )
                  : SizedBox()
            ],
          ),
        ),
      );
    });
  }
}
