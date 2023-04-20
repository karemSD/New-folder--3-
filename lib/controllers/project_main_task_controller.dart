import 'package:cloud_firestore/cloud_firestore.dart';


import '../constants/constant.dart';
import '../models/team/Project_main_task_Model.dart';
import '../services/collectionsrefrences.dart';
import 'taskController.dart';

class ProjectMainTaskController extends ProjectTaskController {
  Future<ProjectMainTaskModel> getProjectMainTaskById(
      {required String id}) async {
    DocumentSnapshot mainTaskDoc =
        await getDocById(reference: projectMainTasksRef, id: id);
    return mainTaskDoc.data() as ProjectMainTaskModel;
  }

  Stream<DocumentSnapshot<ProjectMainTaskModel>> getProjectMainTaskByIdStream(
      {required String id}) {
    Stream<DocumentSnapshot> stream =
        getDocByIdStream(reference: projectMainTasksRef, id: id);
    return stream.cast<DocumentSnapshot<ProjectMainTaskModel>>();
  }

  Future<ProjectMainTaskModel> getProjectMainTaskByName(
      {required String name, required String projectId}) async {
    DocumentSnapshot documentSnapshot = await getDocSnapShotByNameInTow(
        reference: projectMainTasksRef,
        field: projectIdK,
        value: projectId,
        name: name);
    return documentSnapshot.data() as ProjectMainTaskModel;
  }

  Stream<DocumentSnapshot<ProjectMainTaskModel>> getProjectMainTaskByNameStream(
      {required String name, required String projectId}) {
    Stream<DocumentSnapshot> stream = getDocByNameInTowStream(
        reference: projectMainTasksRef,
        field: projectIdK,
        value: projectId,
        name: name);
    return stream.cast<DocumentSnapshot<ProjectMainTaskModel>>();
  }

  Future<List<ProjectMainTaskModel>> getProjectMainTasks(
      String projectId) async {
    List<Object?>? list = await getListDataWhere(
        collectionReference: projectMainTasksRef,
        field: projectIdK,
        value: projectId);
    return list!.cast<ProjectMainTaskModel>();
  }

  Stream<QuerySnapshot<ProjectMainTaskModel>> getProjectMainTasksStream(
      String projectId) {
    Stream<QuerySnapshot> stream = (queryWhereStream(
        reference: projectMainTasksRef, field: projectIdK, value: projectId));
    return stream.cast<QuerySnapshot<ProjectMainTaskModel>>();
  }

  Future<List<ProjectMainTaskModel>> getProjectMainTasksForAStatus(
      {required String projectId, required String status}) async {
    List<Object?>? list = await getTasksForStatus(
      status: status,
      reference: projectMainTasksRef,
      field: projectIdK,
      value: projectId,
    );
    return list!.cast<ProjectMainTaskModel>();
  }

  Stream<QuerySnapshot<ProjectMainTaskModel>>
      getProjectMainTasksForAStatusStream(
          {required String projectId, required String status}) {
    Stream<QuerySnapshot> stream = getTasksForAStatusStream(
      status: status,
      reference: projectMainTasksRef,
      field: projectIdK,
      value: projectId,
    );
    return stream.cast<QuerySnapshot<ProjectMainTaskModel>>();
  }

  Future<double> getPercentOfMainTasksInAProjectForAStatus(
      String status, String projectId) async {
    return await getPercentOfTasksForAStatus(
      reference: projectMainTasksRef,
      status: status,
      field: projectIdK,
      value: projectId,
    );
  }

  Stream<double> getPercentOfMainTasksInAProjectForAStatusStream(
      String status, String projectId) {
    return getPercentOfTasksForAStatusStream(
        reference: projectMainTasksRef,
        field: projectIdK,
        value: projectId,
        status: status);
  }

  Future<double> getPercentOfMainTasksInAProjectForAStatusBetweenTowStartTime({
    required String status,
    required String projectId,
    required DateTime firstDate,
    required DateTime secondDate,
  }) {
    return getPercentOfTasksForAStatusBetweenTowStartTimes(
        reference: projectMainTasksRef,
        status: status,
        field: projectIdK,
        value: projectId,
        firstDate: firstDate,
        secondDate: secondDate);
  }

  Stream<double>
      getPercentOfMainTasksInAProjectForAStatusBetweenTowStartTimeStream({
    required String status,
    required String projectId,
    required DateTime firstDate,
    required DateTime secondDate,
  }) {
    return getPercentOfTasksForAStatusBetweenTowStartTimesStream(
        reference: projectMainTasksRef,
        status: status,
        field: projectIdK,
        value: projectId,
        firstDate: firstDate,
        secondDate: secondDate);
  }

  Future<List<ProjectMainTaskModel>> getProjectMainTasksForAnImportance(
      {required String projectId, required int importance}) async {
    List<Object?>? list = await getTasksForAnImportance(
      reference: projectMainTasksRef,
      field: projectIdK,
      value: projectId,
      importance: importance,
    );
    return list!.cast<ProjectMainTaskModel>();
  }

  Stream<QuerySnapshot<ProjectMainTaskModel>>
      getProjectMainTasksForAnImportanceStream(
          {required String projectId, required int importance}) {
    Stream<QuerySnapshot> stream = getTasksForAnImportanceStream(
        reference: projectMainTasksRef,
        field: projectIdK,
        value: projectId,
        importance: importance);
    return stream.cast<QuerySnapshot<ProjectMainTaskModel>>();
  }

  Future<List<ProjectMainTaskModel>> getProjectMainTasksStartInADay(
      {required DateTime date, required String projectId}) async {
    List<Object?>? list = await getTasksStartInADay(
      reference: projectMainTasksRef,
      date: date,
      field: projectIdK,
      value: projectId,
    );
    return list!.cast<ProjectMainTaskModel>();
  }

  Stream<QuerySnapshot<ProjectMainTaskModel>>
      getProjectMainTasksStartInADayStream(
          {required DateTime date, required String projectId}) {
    Stream<QuerySnapshot> stream = getTasksStartInADayStream(
        reference: projectMainTasksRef,
        date: date,
        field: projectIdK,
        value: projectId);
    return stream.cast<QuerySnapshot<ProjectMainTaskModel>>();
  }

  Future<List<ProjectMainTaskModel>> getProjectMainTasksStartInASpecificTime(
      {required DateTime date, required String projectId}) async {
    List<Object?>? list = await getTasksStartInASpecificTime(
        reference: projectMainTasksRef,
        date: date,
        field: projectIdK,
        value: projectId);
    return list!.cast<ProjectMainTaskModel>();
  }

  Stream<QuerySnapshot<ProjectMainTaskModel>>
      getProjectMainTasksStartInASpecificTimeStream(
          {required DateTime date, required String projectId}) {
    Stream<QuerySnapshot> stream = getTasksStartInASpecificTimeStream(
        reference: projectMainTasksRef,
        date: date,
        field: projectIdK,
        value: projectId);
    return stream.cast<QuerySnapshot<ProjectMainTaskModel>>();
  }

  Future<List<ProjectMainTaskModel>> getProjectMainTasksStartBetweenTowTimes({
    required DateTime firstDate,
    required DateTime secondDate,
    required String projectId,
  }) async {
    List<Object?>? list = await getTasksStartBetweenTowTimes(
      reference: projectMainTasksRef,
      field: projectIdK,
      value: projectId,
      firstDate: firstDate,
      secondDate: secondDate,
    );
    return list!.cast<ProjectMainTaskModel>();
  }

  Stream<QuerySnapshot<ProjectMainTaskModel>>
      getProjectMainTasksStartBetweenTowTimesStream(
          {required DateTime firstDate,
          required DateTime secondDate,
          required String projectId}) {
    Stream<QuerySnapshot> stream = getTasksStartBetweenTowTimesStream(
        reference: projectMainTasksRef,
        field: projectIdK,
        value: projectId,
        firstDate: firstDate,
        secondDate: secondDate);
    return stream.cast<QuerySnapshot<ProjectMainTaskModel>>();
  }

  Future<void> addProjectMainTask(
      {required ProjectMainTaskModel projectMainTaskModel}) async {
    await addTask(
      reference: projectMainTasksRef,
      field: projectIdK,
      value: projectMainTaskModel.projectId,
      taskModel: projectMainTaskModel,
      exception: Exception("task already exist in main task"),
    );
  }

  Future<void> updateProjectMainTask(
      {required Map<String, dynamic> value, required String id}) async {
    updateNonRelationalFields(reference: usersTasksRef, data: value, id: id);
  }

  Future<void> deleteProjectMainTask({required String mainTaskId}) async {
    WriteBatch batch = fireStore.batch();
    QuerySnapshot query = await queryWhere(
        reference: projectSubTasksRef, field: mainTaskIdK, value: mainTaskId);
    DocumentSnapshot documentSnapshot =
        await getDocById(reference: projectMainTasksRef, id: mainTaskId);
    deleteDocUsingBatch(documentSnapshot: documentSnapshot, refbatch: batch);
    deleteDocsUsingBatch(list: query.docs, refBatch: batch);
    batch.commit();
  }

  Future<void> updateMainTask(
      {required Map<String, dynamic> data, required String id}) async {
    DocumentSnapshot snapshot =
        await getDocById(reference: usersTasksRef, id: id);
    ProjectMainTaskModel mainTaskModel =
        snapshot.data() as ProjectMainTaskModel;
    updateTask(
        reference: projectSubTasksRef,
        data: data,
        id: id,
        exception: Exception("main task already exist in Project"),
        field: projectIdK,
        value: mainTaskModel.projectId);
  }
}
