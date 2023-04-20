import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../constants/constant.dart';
import '../../utils/utils.dart';
import '../tops/Var2TopModel.dart';

class ProjectModel extends Var2TopModel {
  ProjectModel({
    //اسم المشروع الخاص بالفريق
    required String nameParameter,
    //الاي دي الخاص بالفريق
    //يتم أخذه تلقائياً من فاير ستور
    //primary key
    required String idParameter,
    //صورة المشروع الخاص بالفريق
    required String imageUrlParameter,
    //الوصف الخاص بالمشروع
    required String descriptionParameter,
    //الاي دي الخاص بالتيم الذي سيعمل على لمشروع
    //foreign key
    required String teamIdParameter,
    //الاي دي الخاص بالحالة لمعرفة حالة المشروع
    required String stausIdParameter,
    //تاريخ نهاية المشروع
    required DateTime endDateParameter,
    //تاريخ بداية المشروع
    required DateTime startDateParameter,
    //تاريخ إنشاء المشروع
    required DateTime createdAtParameter,
    //تاريخ آخر تعديل على المشروع
    required DateTime updatedAtParameter,
    required String managerIdParameter,
  }) {
    setId = idParameter;
    setCreatedAt = createdAtParameter;
    setUpdatedAt = updatedAtParameter;
    setDescription = descriptionParameter;
    setEndDate = endDateParameter;
    setName = nameParameter;
    setStartDate = startDateParameter;
    setTeamId = teamIdParameter;
    setStatusId = stausIdParameter;
    setImageUrl = imageUrlParameter;
    setmanagerId = managerIdParameter;
  }

  ProjectModel.firestoreConstructor({
    //اسم المشروع الخاص بالفريق
    required String nameParameter,
    //الاي دي الخاص بالفريق
    //يتم أخذه تلقائياً من فاير ستور
    //primary key
    required String idParameter,
    //صورة المشروع الخاص بالفريق
    required String imageUrlParameter,
    //الوصف الخاص بالمشروع
    required String descriptionParameter,
    //الاي دي الخاص بالتيم الذي سيعمل على لمشروع
    //foreign key
    required String teamIdParameter,
    //الاي دي الخاص بالحالة لمعرفة حالة المشروع
    required String stausIdParameter,
    //تاريخ نهاية المشروع
    required DateTime endDateParameter,
    //تاريخ بداية المشروع
    required DateTime startDateParameter,
    //تاريخ إنشاء المشروع
    required DateTime createdAtParameter,
    //تاريخ آخر تعديل على المشروع
    required DateTime updatedAtParameter,
    required this.managerId,
  }) {
    id = idParameter;
    createdAt = createdAtParameter;
    updatedAt = updatedAtParameter;
    description = descriptionParameter;
    endDate = endDateParameter;
    name = nameParameter;
    startDate = startDateParameter;
    teamId = teamIdParameter;
    statusId = stausIdParameter;
    imageUrl = imageUrlParameter;
  }

  final _regex = RegExp(r'^[\p{P}\p{S}\p{N}]+$');
  late String imageUrl;
  set setImageUrl(String imageUrl) {
    Exception exception;
    if (imageUrl.isEmpty) {
      //الشرط الأول لايمكن ان يكون فارغ
      exception = Exception("project imageUrl cannot be Empty");
      throw exception;
    }
    this.imageUrl = imageUrl;
  }

  late String managerId;

  set setmanagerId(String managerIdParameter) {
    // مجرد مايكون التيم بالداتا بيز معناها هو محقق الشروط
    managerId = managerIdParameter;
  }

  //ايدي الفريق المسؤول عن هذا المشروع لايمكن ان يكون فارغ
  late String? teamId;
  set setTeamId(String teamIdParameter) {
    // مجرد مايكون التيم بالداتا بيز معناها هو محقق الشروط
    teamId = teamIdParameter;
  }

  @override
  set setStatusId(String statusIdParameter) {
    // TODO   //CheckExist(statusId,collectionName);هون منحط الميثود المسؤولة عن التأكد من وجود هل الفريق بالداتا بيز او لأ
    // مجرد مايكون التيم بالداتا بيز معناها هو محقق الشروط
    statusId = statusIdParameter;
  }

  @override
  set setCreatedAt(DateTime createdAtParameter) {
    //الشروط الخاصة بتاريخ ووقت إضافة الدوكيومنت الخاص بالمشروع
    Exception exception;

    DateTime now = firebaseTime(DateTime.now());
    createdAtParameter = firebaseTime(createdAtParameter);
    //تاريخ إضافة الدوكيومنت الخاص بالمشروع لا يمكن أن يكون بعد الوقت الحالي
    if (createdAtParameter.isAfter(now)) {
      exception = Exception("project creating cannot be in the future");
      throw exception;
    }
    //تاريخ إضافة الدوكيومنت الخاص بالمشروع لا يمكن أن يكون قبل الوقت الحالي
    if (createdAtParameter.isBefore(now)) {
      exception = Exception("project  creating time cannot be in the past");
      throw exception;
    }
    createdAt = createdAtParameter;
  }

  @override
  set setUpdatedAt(DateTime updatedAtParameter) {
    Exception exception;
    updatedAtParameter = firebaseTime(updatedAtParameter);
    //تاريخ تحديث الدوكيومنت الخاص بالمشروع لا يمكن أن يكون قبل تاريخ الإنشاء
    if (updatedAtParameter.isBefore(createdAt)) {
      exception = Exception("updating time cannot be before the creating time");
      throw exception;
    }
    updatedAt = updatedAtParameter;
  }

  @override
  set setDescription(String? descriptionParameter) {
    description = descriptionParameter;
  }

  @override
  set setId(String idParameter) {
    Exception exception;
    //لا يمكن أن يكون اي دي الدوكيومنت الخاص بالمشروع فارغ
    if (idParameter.isEmpty) {
      exception = Exception("project id cannot be empty");
      throw exception;
    }
    id = idParameter;
  }

  @override
  set setName(String nameParameter) {
    Exception exception;
    //هذه الخاصية تستخدم لوضع قيمة لاسم المستخدم وضمان ان هذه القيمة يتم ادخالها حسب الشروط الموضوعة في التطبيق
    //لا يمكن أن ان يكون اسم المشروع فارغاً
    if (nameParameter.isEmpty) {
      exception = Exception("Team Name cannot be Empty");
      throw exception;
    }
    //لايمكن ان يكون اسم المشروع مؤلف من اقل من ثلاث محارف
    if (nameParameter.length <= 3) {
      exception = Exception("Team Name cannot be less than 3 characters");
      throw exception;
    }

    //لايمكن ان يحوي اسم المشروع اي ارقام او محارف خاصة فقطط احرف
    if (_regex.hasMatch(nameParameter)) {
      exception =
          Exception("Team Name cannot contain special characters or numbers");
      throw exception;
    }
    //TODO: write the function taskExist
    // if (projectexist(nameParameter)) {
    //   exception = Exception("project main task already been added");
    //   throw exception;
    // }
    //في حال مرروره على جميع الشروط وعدم رمي اكسيبشن فذلك يعني تحقيقه للشروط المطلوبة وعندها سيتم وضع القيمة
    name = nameParameter;
  }

  @override
  set setStartDate(DateTime? startDateParameter) {
    Exception exception;
    //لا يمكن أن يكون وقت بداية المشروع عديم القيمة
    if (startDateParameter == null) {
      exception = Exception("start date cannot be null");
      throw exception;
    }

    startDateParameter = firebaseTime(startDateParameter);
    DateTime now = firebaseTime(DateTime.now());
    //لا يمكن أن يكون تاريخ بداية المشروع قبل الوقت الحالي
    if (startDateParameter.isBefore(now)) {
      exception =
          Exception("project  start date must not be before the current day");
      throw exception;
    }

    startDate = firebaseTime(startDateParameter);
  }

  // // TODO:this method is just for demo make the method to make a query in firebase to know that if there is another task in the same time for this model
  // bool dateduplicated(DateTime starttime) {
  //   return true;
  // }

  @override
  set setEndDate(DateTime? endDateParameter) {
    Exception exception;
    //لا يمكن أن يكون تاريخ نهاية المشروع عديم القيمة
    if (endDateParameter == null) {
      exception = Exception("project end date cannot be null");
      throw exception;
    }
    endDateParameter = firebaseTime(endDateParameter);
    //لا يمكن أن يكون تاريخ نهاية المشروع قبل تاريخ بداية المشروع
    if (endDateParameter.isBefore(getStartDate)) {
      exception = Exception("project end time cannot be before the start time");
      throw exception;
    }
    //لا يمكن أن يكون تاريخ نهاية المشروع بنفس وقت تاريخ بداية المشروع
    if (getStartDate.isAtSameMomentAs(endDateParameter)) {
      exception = Exception(
          "project end time cannot be in the same time as start time");
      throw exception;
    }
    //لا يمكن أن يكون الفرق بين تاريخ بداية المشروع ونهايته أقل منن 5 دقائق
    Duration diff = endDateParameter.difference(getStartDate);
    if (diff.inMinutes < 5) {
      exception = Exception(
          "the time difference between start time of project and ending time cannot be less then five minutes");
      throw exception;
    }
    endDate = endDateParameter;
  }

  //TODO make tojson from json
  factory ProjectModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data()!;

    return ProjectModel.firestoreConstructor(
      idParameter: data[idK],
      teamIdParameter: data[teamIdK],
      stausIdParameter: data[statusIdK],
      descriptionParameter: data[descriptionK],
      imageUrlParameter: data['imageUrl'],
      nameParameter: data[nameK],
      createdAtParameter: data[createdAtK].toDate(),
      updatedAtParameter: data[updatedAtK].toDate(),
      startDateParameter: data[startDateK].toDate(),
      endDateParameter: data[endDateK].toDate(),
      managerId: data[managerIdK],
    );
  }
  //لترحيل البيانات القادمة  من مودل على شكل جيسون (ماب) إلى الداتا بيز
  @override
  Map<String, dynamic> toFirestore() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[idK] = id;
    data[teamIdK] = teamId;
    data[statusIdK] = statusId;
    data[descriptionK] = description;
    data[imageUrlK] = imageUrl;
    data[nameK] = name;
    data[createdAtK] = createdAt;
    data[updatedAtK] = updatedAt;
    data[startDateK] = startDate;
    data[endDateK] = endDate;
    data[managerIdK] = managerId;
    return data;
  }
}
