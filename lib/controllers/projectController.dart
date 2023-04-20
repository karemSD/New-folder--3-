import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/constant.dart';
import '../models/team/Project_model.dart';
import '../services/collectionsrefrences.dart';
import '../utils/utils.dart';
import 'taskController.dart';

class ProjectController extends ProjectTaskController {
  Future<List<ProjectModel>> getAllManagersProjects() async {
    List<Object?>? list = await getAllListDataForRef(refrence: projectsRef);

    return list!.cast<ProjectModel>();
  }

  Stream<QuerySnapshot<ProjectModel>> getAllManagersProjectsStream() {
    Stream<QuerySnapshot> stream =
        getAllListDataForRefStream(refrence: projectsRef);
    return stream.cast<QuerySnapshot<ProjectModel>>();
  }

  Future<ProjectModel> getManagerProjectByName(
      {required String name, required String managerId}) async {
    DocumentSnapshot documentSnapshot = await getDocSnapShotByNameInTow(
        reference: projectsRef,
        field: managerIdK,
        value: managerId,
        name: name);
    return documentSnapshot.data() as ProjectModel;
  }

  Stream<DocumentSnapshot<ProjectModel>> getManagerProjectByNameStream(
      {required String name, required String managerId}) {
    Stream<DocumentSnapshot> stream = getDocByNameInTowStream(
        reference: projectsRef,
        field: managerIdK,
        value: managerId,
        name: name);
    return stream.cast<DocumentSnapshot<ProjectModel>>();
  }

  Future<void> addProject({required ProjectModel projectModel}) async {
    // الشرط الأول للتأكد من انو مدير هل المشروع موجود بالداتا بيز او لأ بجدول المانجرز
    if (await existByOne(
        collectionReference: managersRef,
        field: idK,
        value: projectModel.managerId)) {
      if (projectModel.teamId != null) {
        //الشرط التاني انو اذا كان ضايف تتيم ضغري اول ماانشئ المشروع شوف انو هل التيم يلي ضفتو موجود بالداتا بيز اولا ويكون مدير المشروع هاد هو نفسو مدير هل التيم
        if (await existByTow(
            reference: teamsRef,
            field: idK,
            value: projectModel.teamId,
            field2: managerIdK,
            value2: projectModel.managerId)) {
          //في حال تحقق الشرطين انو المانجر بالداتا بيز والفريق وموجود والمناجر نفسو للتنين بيضيف المشروع
          await addDoc(reference: projectsRef, model: projectModel);
          return;
        } else {
          //في حال كان المانجر موجود بالداتا بيز والمشروع الو فريق بس هل الفريق مالو بالداتا بيز او المدير تبع هل التيم غير مدير المشروع مابيسمحلو يضيف
          Exception exception = Exception(
              "Sorry there is something Wrong about the team or the manger ");
          throw exception;
        }
      }
      {
        //في حال موجود المانجر وتمام بس مافي فريق بيضيف ضغري لانو مسموح هل الشي
        await addDoc(reference: projectsRef, model: projectModel);
        return;
      }
    } else {
      //في حال إعطاء ايدي لمانجر غير موجود بالداتا بيز اصلا
      Exception exception =
          Exception("Sorry the manger of the Project is not exist");
      throw exception;
    }
  }

// لجلب المشروع الخاص بهل الفريق  إن وجد
  Future<ProjectModel?> getProjectOfTeam({required String teamId}) async {
    DocumentSnapshot? porjectDoc = await getDocSnapShotWhere(
        collectionReference: projectsRef, field: teamIdK, value: teamId);
    if (porjectDoc != null) {
      return porjectDoc.data() as ProjectModel;
    }
    return null;
  }

  getProjectOfTeamStream({required String teamId}) {
    Stream<DocumentSnapshot> projectDoc = getDocWhereStream(
        collectionReference: projectsRef, field: teamIdK, value: teamId);
    return projectDoc.cast<ProjectModel>();
  }

  //جلب جميع المشاريع الخاصة بهل المانجر
  Future<List<ProjectModel?>?> getProjectsOfManager(String mangerId) async {
    List<Object?>? list = await getListDataWhere(
        collectionReference: projectsRef, field: managerIdK, value: mangerId);
    if (list != null && list.isNotEmpty) {
      return list.cast<ProjectModel>();
    }
    return null;
  }

  Stream<QuerySnapshot<ProjectModel>> getProjectsOfManagerStream(
      String mangerId) {
    Stream<QuerySnapshot> projectsStream = queryWhereStream(
        reference: projectsRef, field: managerIdK, value: mangerId);
    return projectsStream.cast<QuerySnapshot<ProjectModel>>();
  }

//جلب المشروع بواسطة الايدي
  Future<ProjectModel?> getProjectById({required String id}) async {
    DocumentSnapshot projectDoc =
        await getDocById(reference: projectsRef, id: id);
    return projectDoc.data() as ProjectModel?;
  }

  getProjectByIdStream({required String id}) {
    Stream<DocumentSnapshot> projectDoc =
        getDocByIdStream(reference: projectsRef, id: id);
    return projectDoc.cast<DocumentSnapshot<ProjectModel>>();
  }

  Future<List<ProjectModel>> getManagerProjectsStartInADay(
      {required DateTime date, required String mangerId}) async {
    List<Object?>? list = await getTasksStartInADay(
      reference: projectsRef,
      date: date,
      field: managerIdK,
      value: mangerId,
    );
    return list!.cast<ProjectModel>();
  }

  Stream<QuerySnapshot<ProjectModel>> getManagerProjectsStartInADayStream(
      {required DateTime date, required String managerId}) {
    Stream<QuerySnapshot> stream = getTasksStartInADayStream(
        reference: projectsRef,
        date: date,
        field: managerIdK,
        value: managerId);
    return stream.cast<QuerySnapshot<ProjectModel>>();
  }

  Future<List<ProjectModel>> getManagerProjectsStartInASpecificTime(
      {required DateTime date, required String managerId}) async {
    List<Object?>? list = await getTasksStartInASpecificTime(
        reference: projectsRef,
        date: date,
        field: managerIdK,
        value: managerId);
    return list!.cast<ProjectModel>();
  }

  Stream<QuerySnapshot<ProjectModel>>
      getManagerProjectsStartInASpecificTimeStream(
          {required DateTime date, required String managerId}) {
    Stream<QuerySnapshot> stream = getTasksStartInASpecificTimeStream(
        reference: projectsRef,
        date: date,
        field: managerIdK,
        value: managerId);
    return stream.cast<QuerySnapshot<ProjectModel>>();
  }

  Future<List<ProjectModel>> getManagerProjectsBetweenTowTimes({
    required DateTime firstDate,
    required DateTime secondDate,
    required String managerId,
  }) async {
    List<Object?>? list = await getTasksStartBetweenTowTimes(
      reference: projectsRef,
      field: managerIdK,
      value: managerId,
      firstDate: firstDate,
      secondDate: secondDate,
    );
    return list!.cast<ProjectModel>();
  }

  Stream<QuerySnapshot<ProjectModel>> getManagerProjectsBetweenTowTimesStream(
      {required DateTime firstDate,
      required DateTime secondDate,
      required String managerId}) {
    Stream<QuerySnapshot> stream = getTasksStartBetweenTowTimesStream(
        reference: projectsRef,
        field: managerIdK,
        value: managerId,
        firstDate: firstDate,
        secondDate: secondDate);
    return stream.cast<QuerySnapshot<ProjectModel>>();
  }

  Future<List<ProjectModel>> getManagerProjectsForAStatus(
      {required String managerId, required String status}) async {
    List<Object?>? list = await getTasksForStatus(
      status: status,
      reference: projectsRef,
      field: managerIdK,
      value: managerId,
    );
    return list!.cast<ProjectModel>();
  }

  Stream<QuerySnapshot<ProjectModel>> getManagerProjectsForAStatusStream(
      {required String managerId, required String status}) {
    Stream<QuerySnapshot> stream = getTasksForAStatusStream(
      status: status,
      reference: projectsRef,
      field: managerIdK,
      value: managerId,
    );
    return stream.cast<QuerySnapshot<ProjectModel>>();
  }

  Future<double> getPercentOfManagerProjectsForAStatus({
    required String status,
    required String managerId,
  }) async {
    return await getPercentOfTasksForAStatus(
      reference: projectsRef,
      status: status,
      field: userIdK,
      value: managerId,
    );
  }

  Future<double> getPercentOfManagerProjectsForAStatusBetweenTowTimes({
    required String status,
    required String managerId,
    required DateTime firstDate,
    required DateTime secondDate,
  }) {
    return getPercentOfTasksForAStatusBetweenTowStartTimes(
        reference: projectsRef,
        status: status,
        field: mainTaskIdK,
        value: managerId,
        firstDate: firstDate,
        secondDate: secondDate);
  }

//تحديث معلومات المشروع والشروط الخاصة بهذا العمل
  Future<void> updateProject(
      {required String id, required Map<String, dynamic> data}) async {
    ProjectModel? projectModel = await getProjectById(id: id);

    if (data.containsKey(startDateK)) {
      DateTime? newStartDate = data[startDateK] as DateTime;
      if (newStartDate.isAfter(projectModel!.endDate!)) {
        Exception exception = Exception(
            " Start Date Of project cannot be updated cause the new time of start date is after End Date of project");
        throw exception;
      }
      if (projectModel.endDate!.isBefore(firebaseTime(DateTime.now()))) {
        Exception exception = Exception(
            "can not update the start date after the end of project  date is passed");
        throw exception;
      }
      if (await existByOne(
          collectionReference: projectMainTasksRef,
          field: projectIdK,
          value: projectModel.id)) {
        Exception exception = Exception("Sorry the project is already Started");
        throw exception;
      }
    }
    if (data.containsKey(teamIdK)) {
      Exception exception = Exception("Sorry the team id  cannot be updated ");
      throw exception;
    }
    await updateNonRelationalFields(reference: projectsRef, data: data, id: id);
  }

//حذف المشروع وجميع المهام الرئيسية والفرعية الخاصة به
  Future<void> deleteProject(String id) async {
    WriteBatch batch = fireStore.batch();
    DocumentSnapshot project =
        //جلب هذا المشروع
        await getDocById(reference: projectsRef, id: id);
    ProjectModel projectModel = project.data() as ProjectModel;
    //حذفه
    deleteDocUsingBatch(documentSnapshot: project, refbatch: batch);
    //حذف الصورة الخاصة بالمشروع من الداتا بيز
    firebaseStorage.refFromURL(projectModel.imageUrl).delete();
    //جلب جميع المهام الرئيسة
    List<DocumentSnapshot> listMainTasks = await getDocsSnapShotWhere(
        collectionReference: projectMainTasksRef, field: projectIdK, value: id);
    //جلب جميع المهام الفرعية
    List<DocumentSnapshot> listSubTasks = await getDocsSnapShotWhere(
        collectionReference: projectSubTasksRef, field: projectIdK, value: id);
    //حذفهما
    deleteDocsUsingBatch(list: listMainTasks, refBatch: batch);
    deleteDocsUsingBatch(list: listSubTasks, refBatch: batch);
    batch.commit();
  }
}
