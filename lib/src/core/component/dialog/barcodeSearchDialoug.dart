import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../screen/batch_reader/logic/medicine_search_repository.dart';
import '../../../../screen/batch_reader/model/medicine_search_entity.dart';
import '../../utils/snackbar.dart';

barcodeSearchDialog({
  required BuildContext context,
  required Function(List<MedicineSearchDataMedicinesResult>) onSuccess,
}) {
  MobileScannerController cameraController = MobileScannerController();

  bool isNeedToWait = false;
  int counter = 0;
  String lastText = "";
  bool isBarcodeManuallyTyped = false;
  bool isAllowQrScan = true;
  String codeType = "";
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: SizedBox(
        height: MediaQuery.of(context).size.height / 3,
        child: MobileScanner(
            allowDuplicates: true,
            controller: cameraController,
            onDetect: (barcode, args) async {
              if (barcode.rawValue == null) {
                debugPrint('Failed to scan Barcode');
              } else {
                if (barcode.format == BarcodeFormat.qrCode) {
                  return;
                }

                if (isNeedToWait) return;
                isNeedToWait = true;

                if (barcode.rawValue!.isEmpty || barcode.rawValue == lastText) {
// Prevent duplicate scans
                  isNeedToWait = false;
                  return;
                }

//bip sound
//=======================
// final player = AudioPlayer();
// player.play(AssetSource('audio/beep.mp3'));
                if (barcode.format == BarcodeFormat.qrCode) {
                  codeType = "QrCode";
                } else {
                  codeType = "Barcode";
                }
                lastText = barcode.rawValue ?? "";
                Future.delayed(const Duration(seconds: 2), () {
                  lastText = "";
                });

                Future.delayed(const Duration(milliseconds: 500), () {
// isNeedToWait = false;
                });
// if (isDigitsOnly(barcode.rawValue) ||
//     (barcode.rawValue!).contains('evital')) {
                cameraController.stop();
                var map = {
                  'searchstring': barcode.rawValue ?? "",
                };
                List<MedicineSearchDataMedicinesResult> detailsList =
                    await MedicineSearchRepository()
                        .callMedicineSearchApiForBarcode(map);
                if (detailsList.length > 0) {
                  await onSuccess(detailsList);
                  Navigator.pop(context);
                } else {
                  Navigator.pop(context);
                  showSnackBar(context, "Not Found data", isError: true);
                }

//   } else {
//     showSnackBarRed(context, "Not valid scanned code.");
//   }
              }
// _onScannedBarcode(barcode);
            }),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cencel"),
        ),
      ],
    ),
  ).then(
    (value) {
// value
    },
  );
}
