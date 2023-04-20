import 'package:get/get.dart';
import 'package:googleauth/controllers/images_uploader.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(ImagesUploader());
  }
}
