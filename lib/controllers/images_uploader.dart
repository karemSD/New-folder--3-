import 'dart:convert';
import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../utils/utils.dart';

class ImageUtils {
  //تحويل الصورة إلى ملف
  static Future<File> imageToFile({required String imageName}) async {
    ByteData data = await rootBundle.load(imageName);
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = '${tempDir.path}/${DateTime.now().millisecond}.png';
    File tempFile = File(tempPath);
    await tempFile.writeAsBytes(data.buffer.asUint8List(), flush: true);

    return tempFile;
  }
}

class ImagesUploader extends GetxController {
  final String imageFolderPath = "/images";

  @override
  void onReady() async {
    if (await filesIsUploaded()) {
      dev.log("start upload");
      uploadImages();
    } else {
      dev.log("images has uploaded");
    }
    super.onReady();
  }

  Future<bool> filesIsUploaded() async {
    final res = await firebaseStorage.ref().child(imageFolderPath).list();
    dev.log(res.items.isEmpty.toString());
    return res.items.isEmpty;
  }

//اخذ الصور من الاسيت وتحويلها لملفات ورفعها
  Future<void> uploadImages() async {
    final manifestContent = await DefaultAssetBundle.of(Get.context!)
        .loadString("AssetManifest.json");
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    final paperInAssets = manifestMap.keys
        .where((path) =>
            path.startsWith("assets/storage_files") && path.contains(".png"))
        .toList();
    dev.log(paperInAssets.toString());
    for (var image in paperInAssets) {
      uploadFileToFirebaseStorage(image);
    }
    dev.log("So");
  }

  //تحميل الملفات للستوريج
  Future<void> uploadFileToFirebaseStorage(String image) async {
    File tempFile = await ImageUtils.imageToFile(imageName: image);
    final ref = firebaseStorage
        .ref()
        .child(imageFolderPath)
        .child(image.split("/").last);
    ref.putFile(tempFile);
  }
}
