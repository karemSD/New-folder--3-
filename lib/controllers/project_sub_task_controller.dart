import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:googleauth/controllers/taskController.dart';

import '../constants/constant.dart';
import '../models/team/Project_sub_task_Model.dart';
import '../services/collectionsrefrences.dart';


class ProjectSubTaskController extends ProjectTaskController {
  Future<List<ProjectSubTaskModel>> getMemberSubTasks(
      {required String memberId}) async {
    List<Object?>? list = await getListDataWhere(
        collectionReference: projectSubTasksRef,
        field: assignedToK,
        value: memberId);
    return list!.cast<ProjectSubTaskModel>();
  }
  Stream<QuerySnapshot<ProjectSubTaskModel>> getMemberSubTasksStream({required String memberId})  {
     Stream<QuerySnapshot> stream = (queryWhereStream(
        reference: projectSubTasksRef, field: assignedToK, value: memberId));
    return stream.cast<QuerySnapshot<ProjectSubTaskModel>>();
  }
  // Future<List<DocumentSnapshot>> getMemberSubTasksDocs(
  //     {required String memberId}) async {
  //   List<DocumentSnapshot> list = await getDocsSnapShotWhere(
  //       collectionReference: projectSubTasksRef,
  //       field: assignedToK,
  //       value: memberId);
  //   return list;
  // }

  Future<ProjectSubTaskModel> getProjectSubTaskById(
      {required String id}) async {
    DocumentSnapshot subtaskDoc =
        await getDocById(reference: projectSubTasksRef, id: id);
    return subtaskDoc.data() as ProjectSubTaskModel;
  }

  Stream<DocumentSnapshot<ProjectSubTaskModel>> getProjectSubTaskByIdStream(
      {required String id}) {
    Stream<DocumentSnapshot> stream =
        getDocByIdStream(reference: projectSubTasksRef, id: id);
    return stream.cast<DocumentSnapshot<ProjectSubTaskModel>>();
  }

  Future<ProjectSubTaskModel> getSubTaskByNameForProject(
      {required String name, required String projectId}) async {
    DocumentSnapshot documentSnapshot = await getDocSnapShotByNameInTow(
        reference: projectSubTasksRef,
        field: projectIdK,
        value: projectId,
        name: name);
    return documentSnapshot.data() as ProjectSubTaskModel;
  }

  Stream<DocumentSnapshot<ProjectSubTaskModel>>
      getSubTaskByNameForProjectStream(
          {required String name, required String projectId}) {
    Stream<DocumentSnapshot> stream = getDocByNameInTowStream(
        reference: projectSubTasksRef,
        field: projectIdK,
        value: projectId,
        name: name);
    return stream.cast<DocumentSnapshot<ProjectSubTaskModel>>();
  }

  Future<ProjectSubTaskModel> getSubTaskByNameForMainTask(
      {required String name, required String mainTaskId}) async {
    DocumentSnapshot documentSnapshot = await getDocSnapShotByNameInTow(
        reference: projectSubTasksRef,
        field: mainTaskIdK,
        value: mainTaskId,
        name: name);
    return documentSnapshot.data() as ProjectSubTaskModel;
  }

  Stream<DocumentSnapshot<ProjectSubTaskModel>>
      getSubTaskByNameForMainTaskStream(
          {required String name, required String mainTaskId}) {
    Stream<DocumentSnapshot> stream = getDocByNameInTowStream(
        reference: projectSubTasksRef,
        field: mainTaskIdK,
        value: mainTaskId,
        name: name);
    return stream.cast<DocumentSnapshot<ProjectSubTaskModel>>();
  }

  Future<List<ProjectSubTaskModel>> getProjectSubTasks(
      {required String projectId}) async {
    List<Object?>? list = await getListDataWhere(
        collectionReference: projectSubTasksRef,
        field: projectIdK,
        value: projectId);
    return list!.cast<ProjectSubTaskModel>();
  }

  Stream<QuerySnapshot<ProjectSubTaskModel>> getProjectSubTasksStream(
      {required String projectId}) {
    Stream<QuerySnapshot> stream = (queryWhereStream(
        reference: projectSubTasksRef, field: projectIdK, value: projectId));
    return stream.cast<QuerySnapshot<ProjectSubTaskModel>>();
  }

  Future<List<ProjectSubTaskModel>> getSubTasksForAMainTask(
      {required String mainTaskId}) async {
    List<Object?>? list = await getListDataWhere(
        collectionReference: projectSubTasksRef,
        field: mainTaskIdK,
        value: mainTaskId);
    return list!.cast<ProjectSubTaskModel>();
  }

  Stream<QuerySnapshot<ProjectSubTaskModel>> getSubTasksForAMainTaskStream(
      {required String mainTaskId}) {
    Stream<QuerySnapshot> stream = (queryWhereStream(
      reference: projectMainTasksRef,
      field: mainTaskIdK,
      value: mainTaskId,
    ));
    return stream.cast<QuerySnapshot<ProjectSubTaskModel>>();
  }

  Future<List<ProjectSubTaskModel>> getProjectSubTasksForAStatus(
      {required String projectId, required String status}) async {
    List<Object?>? list = await getTasksForStatus(
      status: status,
      reference: projectSubTasksRef,
      field: projectIdK,
      value: projectId,
    );
    return list!.cast<ProjectSubTaskModel>();
  }

  Stream<QuerySnapshot<ProjectSubTaskModel>> getProjectSubTasksForAStatusStream(
      {required String projectId, required String status}) {
    Stream<QuerySnapshot> stream = getTasksForAStatusStream(
      status: status,
      reference: projectSubTasksRef,
      field: projectIdK,
      value: projectId,
    );
    return stream.cast<QuerySnapshot<ProjectSubTaskModel>>();
  }

  Future<List<ProjectSubTaskModel>> getMainTaskSubTasksForAStatus(
      {required String mainTaskId, required String status}) async {
    List<Object?>? list = await getTasksForStatus(
      status: status,
      reference: projectSubTasksRef,
      field: mainTaskIdK,
      value: mainTaskId,
    );
    return list!.cast<ProjectSubTaskModel>();
  }

  Stream<QuerySnapshot<ProjectSubTaskModel>>
      getMainTaskSubTasksForAStatusStream(
          {required String mainTaskId, required String status}) {
    Stream<QuerySnapshot> stream = getTasksForAStatusStream(
      status: status,
      reference: projectSubTasksRef,
      field: mainTaskIdK,
      value: mainTaskId,
    );
    return stream.cast<QuerySnapshot<ProjectSubTaskModel>>();
  }

  Future<double> getPercentOfSubTasksInAProjectForAStatus(
      {required String status, required String projectId}) async {
    return await getPercentOfTasksForAStatus(
      reference: projectSubTasksRef,
      status: status,
      field: projectIdK,
      value: projectId,
    );
  }

  Stream<double> getPercentOfSubTasksInAProjectForAStatusStream(
      {required String status, required String projectId}) {
    return getPercentOfTasksForAStatusStream(
        reference: projectSubTasksRef,
        field: projectIdK,
        value: projectId,
        status: status);
  }

  Future<double> getPercentOfSubTasksInAMainTaskForAStatus(
      {required String status, required String mainTaskId}) async {
    return await getPercentOfTasksForAStatus(
      reference: projectSubTasksRef,
      status: status,
      field: mainTaskIdK,
      value: mainTaskId,
    );
  }

  Stream<double> getPercentOfSubTasksInAMainTaskForAStatusStream(
      {required String status, required String mainTaskId}) {
    return getPercentOfTasksForAStatusStream(
        reference: projectSubTasksRef,
        field: mainTaskIdK,
        value: mainTaskId,
        status: status);
  }

  Future<double> getPercentOfSubTasksInAProjectForAStatusBetweenTowTime({
    required String status,
    required String projectId,
    required DateTime firstDate,
    required DateTime secondDate,
  }) {
    return getPercentOfTasksForAStatusBetweenTowStartTimes(
        reference: projectSubTasksRef,
        status: status,
        field: projectIdK,
        value: projectId,
        firstDate: firstDate,
        secondDate: secondDate);
  }

  Stream<double>
      getPercentOfSubTasksInAProjectForAStatusBetweenTowStartTimeStream({
    required String status,
    required String projectId,
    required DateTime firstDate,
    required DateTime secondDate,
  }) {
    return getPercentOfTasksForAStatusBetweenTowStartTimesStream(
        reference: projectSubTasksRef,
        status: status,
        field: projectIdK,
        value: projectId,
        firstDate: firstDate,
        secondDate: secondDate);
  }

  Future<double> getPercentOfSubTasksInAMainTaskForAStatusBetweenTowTimes({
    required String status,
    required String mainTaskId,
    required DateTime firstDate,
    required DateTime secondDate,
  }) {
    return getPercentOfTasksForAStatusBetweenTowStartTimes(
        reference: projectSubTasksRef,
        status: status,
        field: mainTaskIdK,
        value: mainTaskId,
        firstDate: firstDate,
        secondDate: secondDate);
  }

  Stream<double>
      getPercentOfSubTasksInAMainTaskForAStatusBetweenTowTimesStream({
    required String status,
    required String mainTaskId,
    required DateTime firstDate,
    required DateTime secondDate,
  }) {
    return getPercentOfTasksForAStatusBetweenTowStartTimesStream(
        reference: projectSubTasksRef,
        status: status,
        field: mainTaskIdK,
        value: mainTaskId,
        firstDate: firstDate,
        secondDate: secondDate);
  }

  Future<List<ProjectSubTaskModel>> getProjectSubTasksForAnImportance(
      {required String projectId, required int importance}) async {
    List<Object?>? list = await getTasksForAnImportance(
      reference: projectSubTasksRef,
      field: projectIdK,
      value: projectId,
      importance: importance,
    );
    return list!.cast<ProjectSubTaskModel>();
  }

  Stream<QuerySnapshot<ProjectSubTaskModel>>
      getProjectSubTasksForAnImportanceStream(
          {required String projectId, required int importance}) {
    Stream<QuerySnapshot> stream = getTasksForAnImportanceStream(
        reference: projectSubTasksRef,
        field: projectIdK,
        value: projectId,
        importance: importance);
    return stream.cast<QuerySnapshot<ProjectSubTaskModel>>();
  }

  Future<List<ProjectSubTaskModel>> getMainTaskSubTasksForAnImportance(
      {required String mainTaskId, required int importance}) async {
    List<Object?>? list = await getTasksForAnImportance(
      reference: projectSubTasksRef,
      field: mainTaskIdK,
      value: mainTaskId,
      importance: importance,
    );
    return list!.cast<ProjectSubTaskModel>();
  }

  Stream<QuerySnapshot<ProjectSubTaskModel>>
      getMainTaskSubTasksForAnImportanceStream(
          {required String mainTaskId, required int importance}) {
    Stream<QuerySnapshot> stream = getTasksForAnImportanceStream(
        reference: projectSubTasksRef,
        field: mainTaskIdK,
        value: mainTaskId,
        importance: importance);
    return stream.cast<QuerySnapshot<ProjectSubTaskModel>>();
  }

  Future<List<ProjectSubTaskModel>> getProjectSubTasksStartInADay(
      {required DateTime date, required String projectId}) async {
    List<Object?>? list = await getTasksStartInADay(
      reference: projectSubTasksRef,
      date: date,
      field: projectIdK,
      value: projectId,
    );
    return list!.cast<ProjectSubTaskModel>();
  }

  Stream<QuerySnapshot<ProjectSubTaskModel>>
      getProjectSubTasksStartInADayStream(
          {required DateTime date, required String projectId}) {
    Stream<QuerySnapshot> stream = getTasksStartInADayStream(
        reference: projectSubTasksRef,
        date: date,
        field: projectIdK,
        value: projectId);
    return stream.cast<QuerySnapshot<ProjectSubTaskModel>>();
  }

  Future<List<ProjectSubTaskModel>> getMainTaskSubTasksStartInADay(
      {required DateTime date, required String mainTaskId}) async {
    List<Object?>? list = await getTasksStartInADay(
      reference: projectSubTasksRef,
      date: date,
      field: mainTaskIdK,
      value: mainTaskId,
    );
    return list!.cast<ProjectSubTaskModel>();
  }

  Stream<QuerySnapshot<ProjectSubTaskModel>>
      getMainTaskSubTasksStartInADayStream(
          {required DateTime date, required String mainTaskId}) {
    Stream<QuerySnapshot> stream = getTasksStartInADayStream(
        reference: projectSubTasksRef,
        date: date,
        field: mainTaskIdK,
        value: mainTaskId);
    return stream.cast<QuerySnapshot<ProjectSubTaskModel>>();
  }

  Future<List<ProjectSubTaskModel>> getProjectSubTasksStartBetweenTowTimes({
    required DateTime firstDate,
    required DateTime secondDate,
    required String projectId,
  }) async {
    List<Object?>? list = await getTasksStartBetweenTowTimes(
      reference: projectSubTasksRef,
      field: projectIdK,
      value: projectId,
      firstDate: firstDate,
      secondDate: secondDate,
    );
    return list!.cast<ProjectSubTaskModel>();
  }

  Stream<QuerySnapshot<ProjectSubTaskModel>>
      getProjectSubTasksStartBetweenTowTimesStream(
          {required DateTime firstDate,
          required DateTime secondDate,
          required String projectId}) {
    Stream<QuerySnapshot> stream = getTasksStartBetweenTowTimesStream(
        reference: projectSubTasksRef,
        field: projectIdK,
        value: projectId,
        firstDate: firstDate,
        secondDate: secondDate);
    return stream.cast<QuerySnapshot<ProjectSubTaskModel>>();
  }

  Future<List<ProjectSubTaskModel>> getMainTaskSubTasksStartBetweenTowTimes({
    required DateTime firstDate,
    required DateTime secondDate,
    required String mainTaskId,
  }) async {
    List<Object?>? list = await getTasksStartBetweenTowTimes(
      reference: projectSubTasksRef,
      field: mainTaskIdK,
      value: mainTaskId,
      firstDate: firstDate,
      secondDate: secondDate,
    );
    return list!.cast<ProjectSubTaskModel>();
  }

  Stream<QuerySnapshot<ProjectSubTaskModel>>
      getMainTaskSubTasksStartBetweenTowTimesStream({
    required DateTime firstDate,
    required DateTime secondDate,
    required String mainTaskId,
  }) {
    Stream<QuerySnapshot> stream = getTasksStartBetweenTowTimesStream(
        reference: projectSubTasksRef,
        field: mainTaskIdK,
        value: mainTaskId,
        firstDate: firstDate,
        secondDate: secondDate);
    return stream.cast<QuerySnapshot<ProjectSubTaskModel>>();
  }

  Future<List<ProjectSubTaskModel>> getProjectSubTasksStartInASpecificTime(
      {required DateTime date, required String projectId}) async {
    List<Object?>? list = await getTasksStartInASpecificTime(
        reference: projectSubTasksRef,
        date: date,
        field: projectIdK,
        value: projectId);
    return list!.cast<ProjectSubTaskModel>();
  }

  Stream<QuerySnapshot<ProjectSubTaskModel>>
      getProjectSubTasksStartInASpecificTimeStream(
          {required DateTime date, required String projectId}) {
    Stream<QuerySnapshot> stream = getTasksStartInASpecificTimeStream(
        reference: projectSubTasksRef,
        date: date,
        field: projectIdK,
        value: projectId);
    return stream.cast<QuerySnapshot<ProjectSubTaskModel>>();
  }

  Future<List<ProjectSubTaskModel>> getMainTaskSubTasksStartInASpecificTime(
      {required DateTime date, required String mainTaskId}) async {
    List<Object?>? list = await getTasksStartInASpecificTime(
        reference: projectSubTasksRef,
        date: date,
        field: mainTaskIdK,
        value: mainTaskId);
    return list!.cast<ProjectSubTaskModel>();
  }

  Stream<QuerySnapshot<ProjectSubTaskModel>>
      getMainTaskSubTasksStartInASpecificTimeStream(
          {required DateTime date, required String mainTaskId}) {
    Stream<QuerySnapshot> stream = getTasksStartInASpecificTimeStream(
        reference: projectSubTasksRef,
        date: date,
        field: mainTaskId,
        value: mainTaskId);
    return stream.cast<QuerySnapshot<ProjectSubTaskModel>>();
  }

  Future<void> changeAssignedTo(
      {required String id, required String newAssignedTo}) async {
    await updateNonRelationalFields(
        reference: projectSubTasksRef,
        id: id,
        data: {assignedToK: newAssignedTo});
  }

  Future<void> addProjectSubTask(
      {required ProjectSubTaskModel projectsubTaskModel}) async {
    await addTask(
      reference: projectSubTasksRef,
      field: mainTaskIdK,
      value: projectsubTaskModel.mainTaskId,
      taskModel: projectsubTaskModel,
      exception: Exception("task already exist in main task"),
    );
  }

  Future<void> deleteProjectSubTask(String id) async {
    WriteBatch batch = fireStore.batch();
    DocumentSnapshot? documentSnapshot = await getDocSnapShotWhere(
        collectionReference: projectSubTasksRef, field: idK, value: id);
    deleteDocUsingBatch(documentSnapshot: documentSnapshot!, refbatch: batch);
  }

  Future<void> updateSubTask(
      {required Map<String, dynamic> data, required String id}) async {
    DocumentSnapshot snapshot =
        await getDocById(reference: usersTasksRef, id: id);
    ProjectSubTaskModel subTaskModel = snapshot.data() as ProjectSubTaskModel;
    updateTask(
        reference: projectSubTasksRef,
        data: data,
        id: id,
        exception: Exception("sub task already exist in main task"),
        field: mainTaskIdK,
        value: subTaskModel.mainTaskId);
  }
}
