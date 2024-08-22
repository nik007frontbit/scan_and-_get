import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:scan_and_get_images/screen/batch_reader/component/batch_reader_image_block.dart';
import 'package:scan_and_get_images/screen/batch_reader/logic/batch_reader_cubit.dart';
import 'package:scan_and_get_images/src/core/utils/snackbar.dart';

import '../../src/core/component/dialog/alert_box.dart';
import '../../src/core/component/dialog/image_upload_dialog.dart';
import 'model/medicine_verification_pending_model.dart';

class BatchReaderScreen extends StatefulWidget {
  BatchReaderScreen({super.key});

  @override
  State<BatchReaderScreen> createState() => _BatchReaderScreenState();
}

class _BatchReaderScreenState extends State<BatchReaderScreen> {
  List<String> selectedImages = [];

  @override
  Widget build(BuildContext cnt) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return BlocConsumer<BatchReaderCubit, BatchReaderState>(
      listener: (context, state) {
        // TODO: implement listener

        if (state is BatchReaderErrorState) {
          // BatchReaderCubit cubit = BlocProvider.of<BatchReaderCubit>(context);
          showSnackBar(cnt, state.error, isError: true);
        }
      },
      builder: (context, state) {
        BatchReaderCubit cubit = BlocProvider.of<BatchReaderCubit>(context);
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: const Text("Batch reader"),
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          const BoxShadow(
                              color: Colors.black12,
                              offset: Offset(5, 5),
                              blurRadius: 5)
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Product Type?",
                          style: TextStyle(fontSize: 20),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: RadioListTile(
                                value: true,
                                groupValue: cubit.isDrug,
                                title: const Text("Drug"),
                                onChanged: (value) =>
                                    cubit.changeValueOfDrug(value!),
                              ),
                            ),
                            Expanded(
                              child: RadioListTile(
                                value: false,
                                groupValue: cubit.isDrug,
                                title: const Text("FMCG"),
                                onChanged: (value) =>
                                    cubit.changeValueOfDrug(value!),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const ListTile(
                    title: Text("Unverified Batch"),
                  ),
                  Column(
                    children: List.generate(
                      cubit.batchVerificationPending.length,
                      (index) {
                        MedicineVerificationPendingModel
                            medicineVerificationPendingModel =
                            cubit.batchVerificationPending[index];
                        return ListTile(
                          title: Text(
                            medicineVerificationPendingModel.medicineName,
                          ),
                          subtitle: Text(
                            "Batch No : ${medicineVerificationPendingModel.batchId}",
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              medicineVerificationPendingModel.image != ""
                                  ? Image.file(File(
                                      medicineVerificationPendingModel.image))
                                  : IconButton(
                                      onPressed: () {
                                        imageUploadDialog(
                                          context: context,
                                          onImageSelect: (
                                              {required context,
                                              required imagePath}) {
                                            medicineVerificationPendingModel
                                                .image = imagePath;
                                            // setState(() {});
                                            cubit.batchVerificationImageSend(
                                                medicineVerificationPendingModel);
                                          },
                                        );
                                      },
                                      icon: Icon(Icons.upload)),
                              Icon(
                                Icons.check_circle,
                                color:
                                    medicineVerificationPendingModel.isVerified
                                        ? Colors.green
                                        : Colors.grey,
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Wrap(
                    runAlignment: WrapAlignment.spaceBetween,
                    alignment: WrapAlignment.spaceBetween,
                    children: cubit.selectedImages
                        .map(
                          (
                            e,
                          ) =>
                              GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertBoxDelete(
                                        onTap: () async =>
                                            await cubit.deleteImageFromList(
                                          element: e,
                                          context: context,
                                        ),
                                      ),
                                    );
                                  },
                                  child: BatchReaderImageBlock(
                                    image: e['image']!,
                                    batch: e['data'].batch == null ||
                                            e['data'].batch == ""
                                        ? "Not Found"
                                        : e['data'].batch!.toString(),
                                    exp: e['data'].exp == null ||
                                            e['data'].exp == ""
                                        ? "Not Found"
                                        : e['data'].exp.toString(),
                                    mrp: e['data'].mrp == null ||
                                            e['data'].mrp == ""
                                        ? "Not Found"
                                        : e['data'].mrp.toString(),
                                  )),
                        )
                        .toList(),
                  ),
                  // Expanded(
                  //   child: GridView.builder(
                  //     padding: const EdgeInsets.all(8),
                  //     shrinkWrap: true,
                  //     itemCount: cubit.selectedImages.length,
                  //     gridDelegate:
                  //         const SliverGridDelegateWithFixedCrossAxisCount(
                  //             crossAxisCount: 2,
                  //             crossAxisSpacing: 10,
                  //             mainAxisSpacing: 10),
                  //     itemBuilder: (BuildContext context, int index) {
                  //       return GestureDetector(
                  //           onTap: () {
                  //             showDialog(
                  //               context: context,
                  //               builder: (context) => AlertBoxDelete(
                  //                 onTap: () async =>
                  //                     await cubit.deleteImageFromList(
                  //                   index: index,
                  //                   context: context,
                  //                 ),
                  //               ),
                  //             );
                  //           },
                  //           child: BatchReaderImageBlock(
                  //             image: cubit.selectedImages[index]['image']!,
                  //             batch: cubit.selectedImages[index]['batch']!,
                  //             exp: cubit.selectedImages[index]['exp']!,
                  //             mrp: cubit.selectedImages[index]['mrp']!,
                  //           ));
                  //     },
                  //   ),
                  // )
                ],
              ),
            ),
            // This trailing comma makes auto-formatting nicer for build methods.
            floatingActionButton: SpeedDial(
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
            ));
      },
    );
  }
}
