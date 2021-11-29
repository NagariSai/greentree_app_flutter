import 'dart:io';
import 'package:fit_beat/app/common_widgets/permission_dialog.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  bool granted = false;

  Permission _permission;
  final String subHeading;

  PermissionService.gallery(
      {this.subHeading = "Photos permission is needed to select photos"}) {
    if (Platform.isIOS) {
      _permission = Permission.photos;
    } else {
      _permission = Permission.storage;
    }
  }

  PermissionService.storage(
      {this.subHeading = "Storage permission is needed"}) {
    _permission = Permission.storage;
  }

  PermissionService.audio(
      {this.subHeading = "Microphone permission is needed"}) {
    _permission = Permission.microphone;
  }

  PermissionService.camera(
      {this.subHeading = "Camera permission is needed to click photos"}) {
    _permission = Permission.camera;
  }

  Future<void> getPermission(context) async {
    PermissionStatus permissionStatus = await _permission.status;

    if (permissionStatus == PermissionStatus.restricted) {
      _showOpenAppSettingsDialog(context, subHeading);

      permissionStatus = await _permission.status;

      if (permissionStatus != PermissionStatus.granted) {
        //Only continue if permission granted
        return;
      }
    }

    if (permissionStatus == PermissionStatus.permanentlyDenied) {
      _showOpenAppSettingsDialog(context, subHeading);

      permissionStatus = await _permission.status;

      if (permissionStatus != PermissionStatus.granted) {
        //Only continue if permission granted
        return;
      }
    }

    if (permissionStatus == PermissionStatus.undetermined) {
      permissionStatus = await _permission.request();

      if (permissionStatus != PermissionStatus.granted) {
        //Only continue if permission granted
        return;
      }
    }

    if (permissionStatus == PermissionStatus.denied) {
      if (Platform.isIOS) {
        _showOpenAppSettingsDialog(context, subHeading);
      } else {
        permissionStatus = await _permission.request();
      }

      if (permissionStatus != PermissionStatus.granted) {
        //Only continue if permission granted
        return;
      }
    }

    if (permissionStatus == PermissionStatus.granted) {
      granted = true;
      return;
    }
  }

  _showOpenAppSettingsDialog(context, String subHeading) {
    return PermissionDialog.show(
      context,
      'Permission needed',
      subHeading,
      'Open settings',
      openAppSettings,
    );
  }
}
