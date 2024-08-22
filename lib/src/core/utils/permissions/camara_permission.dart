
import 'package:permission_handler/permission_handler.dart';

Future<void> requestCamaraPermissions() async {
  var cameraStatus = await Permission.camera.status;

  switch (cameraStatus) {
    case PermissionStatus.granted:
    // Permission is already granted, proceed with your logic
      break;
    case PermissionStatus.denied:
    // Permission is denied, request it again
      await Permission.camera.request();
      //await requestCamaraPermissions(); // Recursive call
      break;
    default:
      await openAppSettings();
      break;
  }
}