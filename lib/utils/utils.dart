import 'package:firebase_storage/firebase_storage.dart';

DateTime firebaseTime(DateTime dateTime) {
  //هنا حيث نستقبل الوقت الممدخل ونتأكد من سلامة البيانات وانها تتدخل بشكل صحيح ومن ثم نرجع تلك القيمة للكائن
  DateTime newDate = DateTime(
    dateTime.year,
    dateTime.month,
    dateTime.day,
    dateTime.hour,
    dateTime.minute,
    0,
  );
  return newDate;
}

DateTime firebaseTime2(DateTime dateTime) {
  //هنا حيث نستقبل الوقت الممدخل ونتأكد من سلامة البيانات وانها تتدخل بشكل صحيح ومن ثم نرجع تلك القيمة للكائن
  DateTime newDate = DateTime(
    dateTime.year,
    dateTime.month,
    dateTime.day,
    dateTime.hour,
    dateTime.minute,
    0,
  );
  return newDate;
}

final firebaseStorage = FirebaseStorage.instance;
