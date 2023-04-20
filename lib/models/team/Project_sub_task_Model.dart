import 'package:cloud_firestore/cloud_firestore.dart';


import '../../constants/constant.dart';
import '../../utils/utils.dart';
import 'Task_model.dart';

//الكلاس الخاص بالمهمة الفرعية في البروجيكت
// why used Datetime instead of this.
// because we cant access to the fields in the sons from the abstract class that they inherit from
// so instead of making too much work we did this
class ProjectSubTaskModel extends TaskClass {
  ProjectSubTaskModel({
    //الاي دي الخاص بالمشروع الذي تندرج تحته المهمة الفرعية
    //foreign key
    required String projectIdParameter,
    //الاي دي الخاص بالمهمة الأساسية التي تندرج تحتها المهمة الفرعية
    //foreign key
    required String mainTaskIdParameter,
    //وصف المهمة الفرعية
    required String descriptionParameter,
    //الاي دي الخاص بالمهمة الفرعية يتم اعطاؤه تلقائياً من فاير ستور
    //primary key
    required String idParameter,
    //اسم المهمة الفرعية
    required String nameParameter,
    //الاي دي الخاص بحالة المهمة الفرعية
    //foreign key
    required String statusIdParameter,
    //أهمية المهمة من واحد إلى 5
    required int importanceParameter,
    //تاريخ إنشاء المهمة الفرعية
    required DateTime createdAtParameter,
    //تاريخ تعديل المهمة الفرعية
    required DateTime updatedAtParameter,
    //تاريخ بدأ المهمة الفرعية
    required DateTime startDateParameter,
    //تاريخ نهاية المهمة الفرعية
    required DateTime endDateParameter,
    //اي دي العضو المسندة له المهمة الفرعية
    //foreign key
    required String assignedToParameter,
  }) {
    setMainTaskId = mainTaskIdParameter;
    setId = idParameter;
    setName = nameParameter;
    setDescription = descriptionParameter;
    setStatusId = statusIdParameter;
    setimportance = importanceParameter;
    setCreatedAt = createdAtParameter;
    setUpdatedAt = updatedAtParameter;
    setStartDate = startDateParameter;
    setEndDate = endDateParameter;
    setAssignedTo = assignedToParameter;
    setprojectId = projectIdParameter;
  }
  ProjectSubTaskModel.firestoreConstructor({
    //الاي دي الخاص بالمشروع الذي تندرج تحته المهمة الفرعية
    //foreign key
    required String projectIdParameter,
    //الاي دي الخاص بالمهمة الأساسية التي تندرج تحتها المهمة الفرعية
    //foreign key
    required String mainTaskIdParameter,
    //وصف المهمة الفرعية
    String? descriptionParameter,
    //الاي دي الخاص بالمهمة الفرعية يتم اعطاؤه تلقائياً من فاير ستور
    //primary key
    required String idParameter,
    //اسم المهمة الفرعية
    required String nameParameter,
    //الاي دي الخاص بحالة المهمة الفرعية
    //foreign key
    required String statusIdParameter,
    //أهمية المهمة من واحد إلى 5
    required int importanceParameter,
    //تاريخ إنشاء المهمة الفرعية
    required DateTime createdAtParameter,
    //تاريخ تعديل المهمة الفرعية
    required DateTime updatedAtParameter,
    //تاريخ بدأ المهمة الفرعية
    required DateTime startDateParameter,
    //تاريخ نهاية المهمة الفرعية
    required DateTime endDateParameter,
    //اي دي العضو المسندة له المهمة الفرعية
    //foreign key
    required String assignedToParameter,
  }) {
    mainTaskId = mainTaskIdParameter;
    id = idParameter;
    name = nameParameter;
    description = descriptionParameter;
    statusId = statusIdParameter;
    importance = importanceParameter;
    createdAt = createdAtParameter;
    updatedAt = updatedAtParameter;
    startDate = startDateParameter;
    endDate = endDateParameter;
    assignedTo = assignedToParameter;
  }

  late String assignedTo;

  //الدوكيومنت اي دي الخاص بالشخص الذي سيتم اسناد المهمة له
  set setAssignedTo(String assignedToParameter) {
    //الشروط الخاصة بالدوكيومنت آي دي الخاص  بالشخص الذي سيتم اسناد المهمة له
    Exception exception;
    //لا يمكن أن يكون الدوكيومنت آي دي الخاص  بالشخص الذي سيتم اسناد المهمة له فارغاً
    if (assignedToParameter.isEmpty) {
      exception = Exception("team member assigned to id cannot be empty");
      throw exception;
    }

    assignedTo = assignedToParameter;
  }

  late String mainTaskId;
  //الدوكيومنت آي دي الخاص بالمهمة الأساسية في المشروع التي تندرج بداخلها المهمة الفرعية
  set setMainTaskId(String mainTaskIdParameter) {
    //الشروط الخاصة بالدوكيومنت آي دي الخاص بالمهمة الأساسية
    Exception exception;
    //لا يمكن أن يكون  آي دي الخاص بالمهمة الأساسية فارغاً
    if (mainTaskIdParameter.isEmpty) {
      exception = Exception("project sub Task id cannot be empty");
      throw exception;
    }
    //التأكد من وجود المهمة الأساسية
    //TODO make this function
    // if (!checkExist("project_main_tasks", mainTaskIdParameter)) {
    //   exception = Exception("project Main Task id cannot be found");
    //   throw exception;
    // }
    mainTaskId = mainTaskIdParameter;
  }

  late String projectId;
  //اي دي الدوكيومنت الخاص بالمشروع الذي يتضمن المهمة الفرعية
  set setprojectId(String projectIdParameter) {
    //قواعد إضافة الاي دي الخاص بالدوكيومنت الخاص بالبروجيكت الذي يحتوي المهمة
    Exception exception;
    //لا يمكن لآي دي الدوكيومنت الخاص بالبروجيكت أن يكون فارغاُ
    if (projectIdParameter.isEmpty) {
      exception = Exception("project id cannot be empty");
      throw exception;
    }

    //التحقق من وجود المشروع في الداتا بيس

    projectId = projectIdParameter;
  }

  @override
  set setDescription(String? descriptionParameter) {
    //يمكن لقائد المشروع أن يضيف الوصف الذي يراه مناسباً بدون قيود
    description = descriptionParameter;
  }

  @override
  set setId(String idParameter) {
    //الشروط الخاصة بالدوكيومينت آي دي الخاص بالمهمة الفرعية
    Exception exception;
    //لا يمكن أن يكون آي دي المهمة الفرعية للمشروع فارغاً
    if (idParameter.isEmpty) {
      exception = Exception("project sub task id canno't be empty");
      throw exception;
    }
    id = idParameter;
  }

  // TODO:this method is just for demo make the method to make a query in firebase to know that if the task name already been stored in the firebase for this project for this model
  bool taskExist(String taskName) {
    return true;
  }

  @override
  set setName(String? nameParameter) {
    //الشروط الخاصة باسم المهمة الفرعية في المهمة الأساسية في البروجيكت
    Exception exception;
    //لا يمكن أن يكون اسم المهمة الفرعية في المشروع بدون قيمة
    if (nameParameter == null) {
      exception = Exception("project sub task name cannot be null");
      throw exception;
    }
    //لا يمكن أن يكون اسم المهمة الفرعية في المشروع فارغاُ
    if (nameParameter.isEmpty) {
      exception = Exception("project sub task name cannot be empty");
      throw exception;
    }
    //TODO::don't forget to edit here
    name = nameParameter;
  }

  @override
  set setStatusId(String statusIdParameter) {
    //الشروط الخاصة بالدوكيومينت آي دي الخاص بالحالة
    Exception exception;
    //يتم رفض الدوكيومينت آي دي الخاص بالحالة اذا فارغاً
    if (statusIdParameter.isEmpty) {
      exception = Exception("project sub task status id canno't be empty");
      throw exception;
    }
    //ميثود تقوم بالتحقق من صحة الاي دي الخاصة بالحالة
    //TODO complete this function that check if the id is valid
    // if (!checkExist("status", statusIdParameter)) {
    //   exception = Exception("status id is not found");
    //   throw exception;
    // }
    statusId = statusIdParameter;
  }

  @override
  set setimportance(int importanceParameter) {
    //تتراوح قيمة الأهمية بين ال1 وال5
    //الشروط التي تنطبق على الأهمية
    Exception exception;
    //الأهمية لا يمكن أن تكون أقل من واحد
    if (importanceParameter < 1) {
      exception =
          Exception("project sub task importance can't be less than one");
      throw exception;
    }
    //لا يمكن أن تكون للأهمية قيمة أكبر من 5
    if (importanceParameter > 5) {
      exception =
          Exception("project sub task importance can't be bigger than five");
      throw exception;
    }
    importance = importanceParameter;
  }

  @override
  set setCreatedAt(DateTime createdAtParameter) {
    Exception exception;
    createdAtParameter = firebaseTime(createdAtParameter);
    //الشروط الخاصة بتاريخ ووقت إضافة الدوكيومنت الخاص بالمهمة الفرعية
    DateTime now = firebaseTime(DateTime.now());
    createdAtParameter = firebaseTime(createdAtParameter);
    if (createdAtParameter.isAfter(now)) {
      exception =
          Exception("project sub task create time cannot be in the future");
      throw exception;
    }
    //تاريخ إضافة الدوكيومنت الخاص بالمهمة الفرعية لا يمكن أن يكون قبل الوقت الحالي
    if (firebaseTime(createdAtParameter).isBefore(now)) {
      exception =
          Exception("project  sub task create time cannot be in the past");
      throw exception;
    }
    createdAt = firebaseTime(createdAtParameter);
  }

  @override
  set setUpdatedAt(DateTime updatedAtParameter) {
    //الشروط الخاصة بال التاريخ والوقت لتحديث المهمة الفرعية في البروجيكت
    Exception exception;
    updatedAtParameter = firebaseTime(updatedAtParameter);
    //لا يمكن أن يكون تاريخ التحديث قبل تاريخ إنشاء المهمة
    if (updatedAtParameter.isBefore(createdAt)) {
      exception = Exception(
          "project sub task updating date cannot be before creating date");
      throw exception;
    }
    updatedAt = firebaseTime(updatedAtParameter);
  }

  @override
  set setStartDate(DateTime? startDateParameter) {
    //الشروط الخاصة بتاريخ ووقت البداية
    Exception exception;
    //تاريخ بداية المهمة لا يمكن أن يكون عديم القيمة
    if (startDateParameter == null) {
      exception = Exception("project sub task start date can't be null");
      throw exception;
    }
    startDateParameter = firebaseTime(startDateParameter);
    DateTime now = firebaseTime(DateTime.now());
    //تاريخ ووقت البداية البداية لا يمكن أن يكون قبل التاريخ والوقت الحالي
    if (startDateParameter.isBefore(now)) {
      exception = Exception(
          "project sub task start date must not be before the current day");
      throw exception;
    }

    startDate = startDateParameter;
  }

  bool dateduplicated(DateTime starttime) {
    return true;
  }

  @override
  set setEndDate(DateTime? endDateParameter) {
    //الشروط الخاصة بتاريخ ووقت نهاية المهمة الفرعية في البروجكت
    Exception exception;
    //لا يمكن أن يكون تاريخ ووقت نهاية المهمة الفرعية معدوم القيمة
    if (endDateParameter == null) {
      exception = Exception("project sub task start date can't be null");
      throw exception;
    }
    endDateParameter = firebaseTime(endDateParameter);
    //لا يمكن أن يكون تاريخ نهاية المهمة المهمة الفرعية قبل تاريخ بدايتها
    if (endDateParameter.isBefore(startDate)) {
      exception =
          Exception("project sub task start date can't be after end date");
      throw exception;
    }
    //لا يمكن أن يكون تاريخ ووقت نهاية وبدايتها متساويين

    if ((endDateParameter).isAtSameMomentAs(getStartDate)) {
      exception = Exception(
        "project sub task start date can't be in the same time as end date",
      );
      throw exception;
    }
    //لا يمكن أن يكون الفرق بين تاريخ بداية المهمة الفرعية ونهايتها أقل من 5 دقائق
    Duration diff = endDateParameter.difference(startDate);
    if (diff.inMinutes < 5) {
      exception = Exception(
          "time difference between task start time and end time must be 5 minute of longer");
      throw exception;
    }
    endDate = firebaseTime(endDateParameter);
  }

  factory ProjectSubTaskModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data()!;
    return ProjectSubTaskModel.firestoreConstructor(
      nameParameter: data[nameK],
      idParameter: data[idK],
      assignedToParameter: data[assignedToK],
      descriptionParameter: data[descriptionK],
      mainTaskIdParameter: data[mainTaskIdK],
      statusIdParameter: data[statusIdK],
      importanceParameter: data[importanceK],
      createdAtParameter: data[createdAtK].toDate(),
      updatedAtParameter: data[updatedAtK].toDate(),
      startDateParameter: data[startDateK].toDate(),
      endDateParameter: data[endDateK].toDate(),
      projectIdParameter: data[projectIdK],
    );
  }
    factory ProjectSubTaskModel.fromJson(
   Map<String, dynamic> data,
    
  ) {
    
    return ProjectSubTaskModel.firestoreConstructor(
      nameParameter: data[nameK],
      idParameter: data[idK],
      assignedToParameter: data[assignedToK],
      descriptionParameter: data[descriptionK],
      mainTaskIdParameter: data[mainTaskIdK],
      statusIdParameter: data[statusIdK],
      importanceParameter: data[importanceK],
      createdAtParameter: data[createdAtK].toDate(),
      updatedAtParameter: data[updatedAtK].toDate(),
      startDateParameter: data[startDateK].toDate(),
      endDateParameter: data[endDateK].toDate(),
      projectIdParameter: data[projectIdK],
    );
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      nameK: name,
      idK: id,
      descriptionK: description,
      mainTaskIdK: mainTaskId,
      assignedToK: assignedTo,
      statusIdK: statusId,
      importanceK: importance,
      createdAtK: createdAt,
      updatedAtK: updatedAt,
      startDateK: startDate,
      endDateK: endDate,
      projectIdK: projectId,
    };
  }
}
