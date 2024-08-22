import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:scan_and_get_images/screen/nutraceuticals/logic/nutraceuticals_cubit.dart';
import 'package:scan_and_get_images/src/core/component/dialog/alert_box.dart';
import 'package:scan_and_get_images/src/core/component/dialog/barcodeSearchDialoug.dart';
import 'package:scan_and_get_images/src/core/component/image_block/selected_image_block.dart';
import 'package:scan_and_get_images/src/core/utils/snackbar.dart';

import '../../src/core/component/text_field_view.dart';
import '../batch_reader/logic/medicine_search_repository.dart';
import '../batch_reader/model/address_search_model_entity.dart';

class NutraceuticalScreen extends StatefulWidget {
  const NutraceuticalScreen({super.key});

  @override
  State<NutraceuticalScreen> createState() => _NutraceuticalScreenState();
}

class _NutraceuticalScreenState extends State<NutraceuticalScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return BlocConsumer<NutraceuticalsCubit, NutraceuticalsState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is NutraceuticalsErrorState) {
          showSnackBar(context, state.error, isError: true);
        }
      },
      builder: (context, state) {
        NutraceuticalsCubit cubit =
            BlocProvider.of<NutraceuticalsCubit>(context);
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
                          prefix: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.search),
                          ),
                          hintText: "Search for Medicine",
                          // hintStyle: TextStyles.customFont(
                          //     color: Colors.black26,
                          //     fontWeight: FontWeight.w600,
                          //     fontSize: 16),
                          border: InputBorder.none,
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
                        ),
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
                    "Nutraceutical Product",
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
              children: <Widget>[
                cubit.medicineId == null
                    ? const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(
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
                          // DropdownFieldView(
                          //   label: "Medicine Type",
                          //   currentValue: cubit.selectedMedicineType,
                          //   medicineType: cubit.medicineTypes,
                          // ),
                          // DropdownFieldView(
                          //   label: "Dosage Type",
                          //   currentValue: cubit.selectedDosageType,
                          //   medicineType: cubit.dosageTypes,
                          // ),
                        ],
                      ),
                cubit.selectedImagesWithName.length > 0
                    ? const Text(
                        "Uploaded Product Images",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : const SizedBox(),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(8),
                  shrinkWrap: true,
                  itemCount: cubit.selectedImagesWithName.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertBoxDelete(
                              onTap: () async =>
                                  await cubit.deleteImageFromList(
                                index: index,
                                context: context,
                              ),
                            ),
                          );
                        },
                        child: SelectedImageBlock(
                          imagePath: cubit.selectedImagesWithName[index]
                              ['image'],
                          batch: cubit.selectedImagesWithName[index]['name'],
                        ));
                  },
                )
              ],
            ),
          ),
          floatingActionButton: cubit.medicineId != null
              ? SpeedDial(
                  activeIcon: Icons.close,
                  activeForegroundColor: Colors.red,
                  activeBackgroundColor: Colors.red,
                  animationCurve: Curves.elasticInOut,
                  icon: Icons.menu,
                  // renderOverlay: false,
                  spacing: 3,
                  tooltip: 'Menu',
                  children: [
                    SpeedDialChild(
                      child: const Icon(CupertinoIcons.photo_on_rectangle),
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      label: 'Add Document',
                      onTap: () async {
                        await cubit.addImageFromGallery(
                          context: context,
                        );
                      },
                    ),
                    SpeedDialChild(
                      child: const Icon(CupertinoIcons.camera),
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      label: 'Scan Document',
                      onTap: () async =>
                          await cubit.addImageFromCamara(context: context),
                    ),
                  ],
                )
              : const SizedBox(), // This trailing comma makes auto-formatting nicer for build methods.
        );
      },
    );
  }
}
