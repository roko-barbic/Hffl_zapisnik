import 'dart:typed_data';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler_platform_interface/permission_handler_platform_interface.dart';
import 'package:permission_handler/permission_handler.dart';

class UploadPicture extends StatefulWidget {
  final Function(String) onUpload;
  UploadPicture({ required this.onUpload ,super.key});

  @override
  State<UploadPicture> createState() => _UploadPictureState();
}

class _UploadPictureState extends State<UploadPicture> {
  Uint8List? _imageBytes;

  Future<void> pickImageFromGallery() async {
    // XFile? pickedFile = await ImagePicker()
    //     .pickImage(source: ImageSource.gallery, maxHeight: 800, maxWidth: 800);
    //
    // if (pickedFile != null) {
    //   Uint8List bytes = await pickedFile.readAsBytes();
    //}

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {

      if (result.files.single.bytes != null) {
        Uint8List bytes = result.files.single.bytes!;
        setState(() {
          _imageBytes = bytes;//fileName
        });
        widget.onUpload(result.files.single.path ?? "");
      } else {
        String? path = result.files.single.path;

        if (path != null) {
          File file = File(path);
          Uint8List bytes = await file.readAsBytes();
          setState(() {
            _imageBytes = bytes;
          });
          widget.onUpload(result.files.single.path ?? "");
        }
      }
    }
  }

  Future<void> checkPermission() async {
    Permission permission = Permission.photos;

    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo =
          await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt <= 32) {
        permission = Permission.storage;
      }
    }

    PermissionStatus status = await permission.status;
    if (status.isGranted || status.isLimited) {
      await pickImageFromGallery();
    } else {
      if (await permission.isDenied) {
        bool shouldShowRequestRationale = false;
        if (Platform.isAndroid) {
          shouldShowRequestRationale =
              await permission.shouldShowRequestRationale;
        }
        permission.request().then<void>((PermissionStatus value) {
          if (value == PermissionStatus.granted) {
            pickImageFromGallery();
          } else if (!shouldShowRequestRationale &&
              value == PermissionStatus.permanentlyDenied) {
            //todo napravi popup
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_imageBytes != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      elevation: 10,
                      child: Image.memory(
                        _imageBytes!,
                        width: 170,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _imageBytes = null;
                          });
                        },
                        child: const Icon(Icons.delete),
                      ),
                    ),
                  ],
                ),
              )
            else
              ElevatedButton(
                onPressed: checkPermission,
                child: const Text("Odaberi sliku za cover"),
              ),
          ],
        ));
  }
}
