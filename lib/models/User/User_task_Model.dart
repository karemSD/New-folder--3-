import 'package:cloud_firestore/cloud_firestore.dart';

import '../../constants/constant.dart';
import '../../utils/utils.dart';
import '../team/Task_model.dart';

//الكلاس الخاصة بالمهمة الخاصة بالمستخدم
class UserTaskModel extends TaskClass {
  //باني خاص بالصف الخاص بمهمة المستخدم
  UserTaskModel({
    //اي دي المستخدم صاحب المهمة
    //foriegn key
    required String userIdParameter,
    //اي دي التصنيف الذي تندرج تحته المهمة
    //foriegn key
    required String folderIdParameter,
    //اي دي المهمة الأب إن وجدت
    //foriegn key
    required DocumentReference? taskFatherIdParameter,
    //الوصف الخاص بالمهمة
    required String descriptionParameter,
    //الاي دي الخاص بالمهمة
    //primary key
    required String idParameter,
    //الاسم الخاص بالمهمة
    required String nameParameter,
    //الاي دي الخاص بحالة المهمة
    //foriegn key
    required String statusIdParameter,
    //مستوى الأهمية الخاص بالمهمة من واحد إلى 5
    required int importanceParameter,
    //وقت إنشاء المهمة
    required DateTime createdAtParameter,
    //وقت تحديث المهمة
    required DateTime updatedAtParameter,
    //الوقت الذي ستبدأ فيه المهمة
    required DateTime startDateParameter,
    //الوقت الذي ستنتهي فيه المهمة
    required DateTime endDateParameter,
  }) {
    //هنا نقوم بإسناد القيم إلى المتحولات لكن عبر عملية set
    setFolderId = folderIdParameter;
    setId = idParameter;
    setName = nameParameter;
    setDescription = descriptionParameter;
    setStatusId = statusIdParameter;
    setimportance = importanceParameter;
    setCreatedAt = createdAtParameter;
    setUpdatedAt = updatedAtParameter;
    setStartDate = startDateParameter;
    setEndDate = endDateParameter;
    setUserId = userIdParameter;
    setTaskFatherId = taskFatherIdParameter;
  }
  UserTaskModel.lateTask({
    required String userIdParameter,
    required String folderIdParameter,
    required DocumentReference? taskFatherIdParameter,
    required String descriptionParameter,
    required String idParameter,
    required String nameParameter,
    required String statusIdParameter,
    required int importanceParameter,
    required DateTime createdAtParameter,
    required DateTime updatedAtParameter,
    required DateTime startDateParameter,
    required DateTime endDateParameter,
  }) {
    setFolderId = folderIdParameter;
    setId = idParameter;
    setName = nameParameter;
    setDescription = descriptionParameter;
    setStatusId = statusIdParameter;
    setimportance = importanceParameter;
    setCreatedAt = createdAtParameter;
    setUpdatedAt = updatedAtParameter;
    startDate = startDateParameter;
    setEndDate = endDateParameter;
    setUserId = userIdParameter;
    setTaskFatherId = taskFatherIdParameter;
  }
  UserTaskModel.firestoreConstructor({
    //اي دي المستخدم صاحب المهمة
    //foriegn key
    required this.userId,
    //اي دي التصنيف الذي تندرج تحته المهمة
    //foriegn key
    required this.folderId,
    //اي دي المهمة الأب إن وجدت
    //foriegn key
    this.taskFatherId,
    //الوصف الخاص بالمهمة
    String? descriptionParameter,
    //الاي دي الخاص بالمهمة
    //primary key
    required String idParameter,
    //الاسم الخاص بالمهمة
    required String nameParameter,
    //الاي دي الخاص بحالة المهمة
    //foriegn key
    required String statusIdParameter,
    //مستوى الأهمية الخاص بالمهمة من واحد إلى 5
    required int importanceParameter,
    //وقت إنشاء المهمة
    required DateTime createdAtParameter,
    //وقت تحديث المهمة
    required DateTime updatedAtParameter,
    //الوقت الذي ستبدأ فيه المهمة
    required DateTime startDateParameter,
    //الوقت الذي ستنتهي فيه المهمة
    required DateTime endDateParameter,
  }) {
    id = idParameter;
    name = nameParameter;
    description = descriptionParameter;
    statusId = statusIdParameter;
    importance = importanceParameter;
    createdAt = createdAtParameter;
    updatedAt = updatedAtParameter;
    startDate = startDateParameter;
    endDate = endDateParameter;
  }

  late String userId;
  //اي دي الدوكيومينت الخاص المستخدم الذي يملك المهمة

  late String folderId;
  //اي دي  الدوكيومينت الخاص بالمجلد التي تكون المهمة موجودة بداخله

  DocumentReference? taskFatherId;
  //الريفرينس للمهمة الأب إن وجدت

  set setUserId(String userIdParameter) {
    //قواعد إضافة الاي دي الخاص بالدوكيومنت الخاص بالمستخدم الذي يملك المهمة
    Exception exception;
    //لا يمكن لآي دي الدوكيومنت الخاص بالمستخدم  أن يكون فارغ
    if (userIdParameter.isEmpty) {
      exception = Exception("task user id  cannot be empty");
      throw exception;
    }
    //التحقق من وجود المستخدم الذي يتم إسناد المهمة له

    userId = userIdParameter;
  }

  set setFolderId(String folderIdParameter) {
    //قواعد إضافة الاي دي الخاص بالدوكيومنت الخاص بالمستخدم الذي يملك المهمة
    Exception exception;
    //لا يمكن لآي دي الدوكيومنت الخاص بالمستخدم أن يكون فارغ
    if (folderIdParameter.isEmpty) {
      exception = Exception("folder id cannot be empty");
      throw exception;
    }
    //التحقق من وجود التصنيف الذي تندرج تحته المهمة

    folderId = folderIdParameter;
  }

  //لا يوجد قيود على إضافة المهمة الأب
  set setTaskFatherId(DocumentReference? taskFatherIdParameter) {
    taskFatherId = taskFatherIdParameter;
  }
  // TODO:this method is just for demo make the method to make a query in firebase to know that if the task name already been stored in the firebase for this project for this model

  @override
  set setName(String? nameParameter) {
    //الشروط الخاصة باسم المهمة
    Exception exception;
    //لا يمكن أن يكون اسم المهمة بدون قيمة
    if (nameParameter == null) {
      exception = Exception("task name cannot be null");
      throw exception;
    }
    //لا يمكن ان يكون اسم المهمة فارغاً
    if (nameParameter.isEmpty) {
      exception = Exception("task name cannot be empty");
      throw exception;
    }
    //لا يمكن ان يكون اسم المهمة مكرراً في نفس المجلد
    // () async {
    //   if (await exist(
    //           reference: usersTasksRef,
    //           field: "userId",
    //           value: firebaseAuth.currentUser!.uid,
    //           field2: "name",
    //           value2: nameParameter) >
    //       1) {
    //     exception = Exception("task already been added");
    //     throw exception;
    //   }
    // }();

    name = nameParameter;
  }

  @override
  set setDescription(String? descriptionParameter) {
    description = descriptionParameter;
  }

  @override
  set setId(String idParameter) {
    //الشروط الخاصة بالدوكيومينت آي دي الخاص بالمهمة
    Exception exception;
    //إذا كان الآي دي فارغ لا يتم قبوله
    if (idParameter.isEmpty) {
      exception = Exception("user task id canno't be empty");
      throw exception;
    }
    id = idParameter;
  }

  @override
  set setStatusId(String statusIdParameter) {
    //الشروط الخاصة بالدوكيومينت آي دي الخاص بالحالة
    Exception exception;
    //يتم رفض الدوكيومينت آي دي الخاص بالحالة اذا فارغاً
    if (statusIdParameter.isEmpty) {
      exception = Exception("task status id canno't be empty");
      throw exception;
    }
    statusId = statusIdParameter;
  }

  @override
  set setimportance(int importanceParameter) {
    //الشروط التي تنطبق على الأهمية
    Exception exception;
    //الأهمية لا يمكن أن تكون أقل من صفر أو تساويه
    if (importanceParameter <= 0) {
      exception = Exception("importance can't be less than zero");
      throw exception;
    }
    //الأهمية لا يمكن أن تكون أكبر من 5 وهي مهم جداً
    if (importanceParameter > 5) {
      exception = Exception("importance can't be bigger than five");
      throw exception;
    }
    importance = importanceParameter;
  }

  @override
  set setCreatedAt(DateTime createdAtParameter) {
    Exception exception;
    //الشروط الخاصة بتاريخ ووقت إضافة الدوكيومنت الخاص بالمهمة
    createdAtParameter = firebaseTime(createdAtParameter);
    DateTime now = firebaseTime(DateTime.now());

    //تاريخ إضافة مهمة المستخدم لا يمكن أن يكون بعد الوقت الحالي
    if (createdAtParameter.isAfter(now)) {
      exception = Exception("user task create time cannot be in the future");
      throw exception;
    }
    //تاريخ إضافة الدوكيومنت لا يمكن أن يكون قبل الوقت الحالي
    if (firebaseTime(createdAtParameter).isBefore(now)) {
      exception = Exception("user task create time cannot be in the past");
      throw exception;
    }
    createdAt = firebaseTime(createdAtParameter);
  }

  @override
  set setUpdatedAt(DateTime updatedAtParameter) {
    //الشروط الخاصة بال التاريخ والوقت لتحديث المهمة
    Exception exception;

    updatedAtParameter = firebaseTime(updatedAtParameter);
    //تاريخ تحديث الدوكيومنت لا يمكن أن يكون قبل تاريخ إنشائه
    if (updatedAtParameter.isBefore(createdAt)) {
      exception =
          Exception("task updating date cannot be before creating date");
      throw exception;
    }
    updatedAt = firebaseTime(updatedAtParameter);
  }

  @override
  set setStartDate(DateTime? startDateParameter) {
    //الشروط الخاصة بتاريخ ووقت البداية
    Exception exception;

    if (startDateParameter == null) {
      //متل أيا عاقل حتقول لحالك انو وقت البداية مالازم يكون عديم القيمة برابو أخي
      exception = Exception("user task start date can't be null");
      throw exception;
    }
    startDateParameter = firebaseTime(startDateParameter);
    DateTime now = firebaseTime(DateTime.now());
    //تاريخ ووقت البداية البداية لا يمكن أن يكون قبل التاريخ والوقت الحالي
    if (startDateParameter.isBefore(now)) {
      exception =
          Exception("user task start date must not be before the current day");
      throw exception;
    }
    //TODO check this line
    //التحقق من وجود مهمات بنفس الوقت لإبلاغ المستخدم عنها
    // if (dateduplicated(startDateParameter)) {
    //   exception = Exception("start date can't be after end date");
    //   throw exception;
    // }

    startDate = firebaseTime(startDateParameter);
  }

  @override
  set setEndDate(DateTime? endDateParameter) {
    //الشروط الخاصة بتاريخ ووقت انتهاء المهمة
    Exception exception;
    //لا يمكن لتاريخ ووقت المهمة أن يكون عديم الوقت
    if (endDateParameter == null) {
      exception = Exception("user task end date can't be null");
      throw exception;
    }
    endDateParameter = firebaseTime(endDateParameter);
    //تاريخ ووقت نهاية المهمة لا يمكن أن يكون بنفس تاريخ ووقت بداية المهمة
    if (endDateParameter.isAtSameMomentAs(startDate)) {
      exception = Exception(
        "user task start date can't be in the same time as end date",
      );
    }
    //لا يمكن أن يكون هناك فارق أقل من 5 دقائق بين بداية المهمة الأساسية ونهايتها
    if (differeInTime(getStartDate, endDateParameter).inMinutes < 5) {
      exception = Exception(
          "time between task start time and end time must be 5 minute of longer");
      throw exception;
    }
    //تاريخ انتهاء المهمة لا يمكن أن يكون قبل بداية المهمة
    if (endDateParameter.isBefore(startDate)) {
      exception = Exception("user task end date can't be before end date");
      throw exception;
    }
    endDate = firebaseTime(endDateParameter);
  }

  factory UserTaskModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    Map<String, dynamic>? data = snapshot.data()!;
    return UserTaskModel.firestoreConstructor(
      nameParameter: data[nameK],
      idParameter: data[idK],
      descriptionParameter: data[descriptionK],
      userId: data[userIdK],
      folderId: data[folderIdK],
      taskFatherId: data[taskFatherIdK],
      statusIdParameter: data[statusIdK],
      importanceParameter: data[importanceK],
      createdAtParameter: data[createdAtK].toDate(),
      updatedAtParameter: data[updatedAtK].toDate(),
      startDateParameter: data[startDateK].toDate(),
      endDateParameter: data[endDateK].toDate(),
    );
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      nameK: name,
      idK: id,
      descriptionK: description,
      userIdK: userId,
      folderIdK: folderId,
      taskFatherIdK: taskFatherId,
      statusIdK: statusId,
      importanceK: importance,
      createdAtK: createdAt,
      updatedAtK: updatedAt,
      startDateK: startDate,
      endDateK: endDate,
    };
  }

  @override
  String toString() {
    return "user task name is $name id:$id description:$description userId:$userId folderId$folderId \n task_father_id:$taskFatherId statusId:$statusId importance:$importance createdAt:$createdAt updatedAt:$updatedAt startDate:$startDate endDate:$endDate";
  }
}
