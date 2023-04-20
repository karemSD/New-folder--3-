import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../constants/constant.dart';
import '../models/User/User_task_Model.dart';
import '../services/collectionsrefrences.dart';
import 'taskController.dart';


class UserTaskController extends ProjectTaskController {
  Future<List<UserTaskModel>> getAllUsersTasks() async {
    List<Object?>? list = await getAllListDataForRef(refrence: usersTasksRef);

    return list!.cast<UserTaskModel>();
  }

  Stream<QuerySnapshot<UserTaskModel>> getAllUsersTasksStream() {
    Stream<QuerySnapshot> stream =
        getAllListDataForRefStream(refrence: usersTasksRef);
    return stream.cast<QuerySnapshot<UserTaskModel>>();
  }

  Future<UserTaskModel> getUserTaskById({required String id}) async {
    DocumentSnapshot taskDoc =
        await getDocById(reference: usersTasksRef, id: id);
    return taskDoc.data() as UserTaskModel;
  }

  Stream<DocumentSnapshot<UserTaskModel>> getUserTaskByIdStream(String id) {
    Stream<DocumentSnapshot> stream =
        getDocByIdStream(reference: usersTasksRef, id: id);
    return stream.cast<DocumentSnapshot<UserTaskModel>>();
  }

  Future<UserTaskModel> getUserTaskByNameForUser(
      {required String name, required String userId}) async {
    DocumentSnapshot documentSnapshot = await getDocSnapShotByNameInTow(
        reference: usersTasksRef, field: userIdK, value: userId, name: name);
    return documentSnapshot.data() as UserTaskModel;
  }

  Stream<DocumentSnapshot<UserTaskModel>> getUserTaskByNameForUserStream(
      {required String name, required String userId}) async* {
    Stream<DocumentSnapshot> stream = getDocByNameInTowStream(
        reference: usersTasksRef, field: userIdK, value: userId, name: name);
    yield* stream.cast<DocumentSnapshot<UserTaskModel>>();
  }

  Future<UserTaskModel> getCategoryTaskByNameForUser(
      {required String name, required String folderId}) async {
    DocumentSnapshot documentSnapshot = await getDocSnapShotByNameInTow(
        reference: usersTasksRef,
        field: folderIdK,
        value: folderId,
        name: name);
    return documentSnapshot.data() as UserTaskModel;
  }

  Stream<DocumentSnapshot<UserTaskModel>> getCategoryTaskByNameForUserStream(
      {required String name, required String folderId}) async* {
    Stream<DocumentSnapshot> stream = getDocByNameInTowStream(
        reference: usersTasksRef,
        field: folderIdK,
        value: folderId,
        name: name);
    yield* stream.cast<DocumentSnapshot<UserTaskModel>>();
  }

  Future<List<UserTaskModel>> getUserTasks(String userId) async {
    List<Object?>? list = await getListDataWhere(
        collectionReference: usersTasksRef, field: userIdK, value: userId);
    List<UserTaskModel> listOfUserTasks = list!.cast<UserTaskModel>();
    return listOfUserTasks;
  }

  Stream<QuerySnapshot<UserTaskModel>> getUserTasksStream(String userId) {
    Stream<QuerySnapshot> stream = (queryWhereStream(
        reference: usersTasksRef, field: userIdK, value: userId));
    return stream.cast<QuerySnapshot<UserTaskModel>>();
  }

  Future<List<UserTaskModel>> getCategoryTasks(
      {required String folderId}) async {
    List<Object?>? list = await getListDataWhere(
      collectionReference: usersTasksRef,
      field: folderIdK,
      value: folderId,
    );
    List<UserTaskModel> listOfUserTasks = list!.cast<UserTaskModel>();
    return listOfUserTasks;
  }

  Stream<QuerySnapshot<UserTaskModel>> getCategoryTasksStream(String folderId) {
    Stream<QuerySnapshot> stream = queryWhereStream(
        reference: usersTasksRef, field: folderIdK, value: folderId);
    return stream.cast<QuerySnapshot<UserTaskModel>>();
  }

  Future<List<UserTaskModel>> getChildTasks(
      {required DocumentReference taskFatherId}) async {
    List<Object?>? list = await getListDataWhere(
      collectionReference: usersTasksRef,
      field: taskFatherIdK,
      value: taskFatherId,
    );
    List<UserTaskModel> listOfUserTasks = list!.cast<UserTaskModel>();
    return listOfUserTasks;
  }

  Stream<QuerySnapshot<UserTaskModel>> getChildTasksStream(
      {required DocumentReference taskFatherId}) {
    Stream<QuerySnapshot> stream = (queryWhereStream(
      reference: usersTasksRef,
      field: taskFatherIdK,
      value: taskFatherId,
    ));
    return stream.cast<QuerySnapshot<UserTaskModel>>();
  }

  Future<List<UserTaskModel>> getUserTasksForAStatus(
      {required String userId, required String status}) async {
    List<Object?>? list = await getTasksForStatus(
      status: status,
      reference: usersTasksRef,
      field: userIdK,
      value: userId,
    );
    return list!.cast<UserTaskModel>();
  }

  Stream<QuerySnapshot<UserTaskModel>> getUserTasksForAStatusStream(
      {required String userId, required String status}) {
    Stream<QuerySnapshot> stream = getTasksForAStatusStream(
      status: status,
      reference: usersTasksRef,
      field: userIdK,
      value: userId,
    );
    return stream.cast<QuerySnapshot<UserTaskModel>>();
  }

  Future<List<UserTaskModel>> getCategoryTasksForAStatus(
      {required String folderId, required String status}) async {
    List<Object?>? list = await getTasksForStatus(
      status: status,
      reference: usersTasksRef,
      field: folderIdK,
      value: folderId,
    );
    return list!.cast<UserTaskModel>();
  }

  Stream<QuerySnapshot<UserTaskModel>> getCategoryTasksForAStatusStream(
      {required String folderId, required String status}) {
    Stream<QuerySnapshot> stream = getTasksForAStatusStream(
      status: status,
      reference: usersTasksRef,
      field: folderIdK,
      value: folderId,
    );
    return stream.cast<QuerySnapshot<UserTaskModel>>();
  }

  Future<List<UserTaskModel>> getChildTasksForAStatus(
      {required String status, required String taskFatherId}) async {
    List<Object?>? list = await getTasksForStatus(
      status: status,
      reference: usersTasksRef,
      field: taskFatherIdK,
      value: taskFatherId,
    );
    return list!.cast<UserTaskModel>();
  }

  Stream<QuerySnapshot<UserTaskModel>> getChildTasksForAStatusStream(
      {required String status, required String taskFatherId}) {
    Stream<QuerySnapshot> stream = getTasksForAStatusStream(
      status: status,
      reference: usersTasksRef,
      field: taskFatherIdK,
      value: taskFatherId,
    );
    return stream.cast<QuerySnapshot<UserTaskModel>>();
  }

  Future<double> getPercentOfUserTasksForAStatus({
    required String status,
    required String userId,
  }) async {
    return await getPercentOfTasksForAStatus(
      reference: usersTasksRef,
      status: status,
      field: userIdK,
      value: userId,
    );
  }

  Stream<double> getPercentOfUserTasksForAStatusStream(
      String status, String userId) {
    return getPercentOfTasksForAStatusStream(
        reference: usersTasksRef,
        field: userIdK,
        value: userId,
        status: status);
  }

  Future<double> getPercentOfCategoryTasksForAStatus({
    required String status,
    required String folderId,
  }) async {
    return await getPercentOfTasksForAStatus(
      reference: usersTasksRef,
      status: status,
      field: folderIdK,
      value: folderId,
    );
  }

  Stream<double> getPercentOfCategoryTasksForAStatusStream(
      String status, String folderId) {
    return getPercentOfTasksForAStatusStream(
        reference: usersTasksRef,
        field: folderIdK,
        value: folderId,
        status: status);
  }

  Future<double> getPercentOfUserTasksForAStatusBetweenTowTimes({
    required String status,
    required String userId,
    required DateTime firstDate,
    required DateTime secondDate,
  }) {
    return getPercentOfTasksForAStatusBetweenTowStartTimes(
        reference: usersTasksRef,
        status: status,
        field: userIdK,
        value: userId,
        firstDate: firstDate,
        secondDate: secondDate);
  }

  Stream<double> getPercentOfUserTasksForAStatusBetweenTowTimesStream({
    required String status,
    required String userId,
    required DateTime firstDate,
    required DateTime secondDate,
  }) {
    return getPercentOfTasksForAStatusBetweenTowStartTimesStream(
        reference: usersTasksRef,
        status: status,
        field: userIdK,
        value: userId,
        firstDate: firstDate,
        secondDate: secondDate);
  }

  Future<double> getPercentOfCategoryTasksForAStatusBetweenTowTimes({
    required String status,
    required String folderId,
    required DateTime firstDate,
    required DateTime secondDate,
  }) {
    return getPercentOfTasksForAStatusBetweenTowStartTimes(
        reference: usersTasksRef,
        status: status,
        field: folderIdK,
        value: folderId,
        firstDate: firstDate,
        secondDate: secondDate);
  }

  Stream<double> getPercentOfCategoryTasksForAStatusBetweenTowTimesStream({
    required String status,
    required String folderId,
    required DateTime firstDate,
    required DateTime secondDate,
  }) {
    return getPercentOfTasksForAStatusBetweenTowStartTimesStream(
        reference: usersTasksRef,
        status: status,
        field: folderIdK,
        value: folderId,
        firstDate: firstDate,
        secondDate: secondDate);
  }

  Future<List<UserTaskModel>> getUserTasksForAnImportance(
      {required String userId, required int importance}) async {
    List<Object?>? list = await getTasksForAnImportance(
      reference: usersTasksRef,
      field: userIdK,
      value: userId,
      importance: importance,
    );
    return list!.cast<UserTaskModel>();
  }

  Stream<QuerySnapshot<UserTaskModel>> getUserTasksForAnImportanceStream(
      {required String userId, required int importance}) {
    Stream<QuerySnapshot> stream = getTasksForAnImportanceStream(
        reference: usersTasksRef,
        field: userIdK,
        value: userId,
        importance: importance);
    return stream.cast<QuerySnapshot<UserTaskModel>>();
  }

  Future<List<UserTaskModel>> getCategoryTasksForAnImportance(
      {required String folderId, required int importance}) async {
    List<Object?>? list = await getTasksForAnImportance(
      reference: usersTasksRef,
      field: folderIdK,
      value: folderId,
      importance: importance,
    );
    return list!.cast<UserTaskModel>();
  }

  Stream<QuerySnapshot<UserTaskModel>> getCategoryTasksForAnImportanceStream(
      {required String folderId, required int importance}) {
    Stream<QuerySnapshot> stream = getTasksForAnImportanceStream(
        reference: usersTasksRef,
        field: folderIdK,
        value: folderId,
        importance: importance);
    return stream.cast<QuerySnapshot<UserTaskModel>>();
  }

  Future<List<UserTaskModel>> getUserTasksStartInADay(
      {required DateTime date, required String userId}) async {
    List<Object?>? list = await getTasksStartInADay(
      reference: usersTasksRef,
      date: date,
      field: userIdK,
      value: userId,
    );
    return list!.cast<UserTaskModel>();
  }

  Stream<QuerySnapshot<UserTaskModel>> getUserTasksStartInADayStream(
      {required DateTime date, required String userId}) {
    Stream<QuerySnapshot> stream = getTasksStartInADayStream(
        reference: usersTasksRef, date: date, field: userIdK, value: userId);
    return stream.cast<QuerySnapshot<UserTaskModel>>();
  }

  Future<List<UserTaskModel>> getCategoryTasksStartInADay(
      {required DateTime date, required String folderId}) async {
    List<Object?>? list = await getTasksStartInADay(
      reference: usersTasksRef,
      date: date,
      field: folderIdK,
      value: folderId,
    );
    return list!.cast<UserTaskModel>();
  }

  Stream<QuerySnapshot<UserTaskModel>> getCategoryTasksStartInADayStream(
      {required DateTime date, required String folderId}) {
    Stream<QuerySnapshot> stream = getTasksStartInADayStream(
      reference: usersTasksRef,
      date: date,
      field: folderIdK,
      value: folderId,
    );
    return stream.cast<QuerySnapshot<UserTaskModel>>();
  }

  Future<List<UserTaskModel>> getUserTasksBetweenTowTimes({
    required DateTime firstDate,
    required DateTime secondDate,
    required String userId,
  }) async {
    List<Object?>? list = await getTasksStartBetweenTowTimes(
      reference: usersTasksRef,
      field: userIdK,
      value: userId,
      firstDate: firstDate,
      secondDate: secondDate,
    );
    return list!.cast<UserTaskModel>();
  }

  Stream<QuerySnapshot<UserTaskModel>> getUserTasksBetweenTowTimesStream(
      {required DateTime firstDate,
      required DateTime secondDate,
      required String userId}) {
    Stream<QuerySnapshot> stream = getTasksStartBetweenTowTimesStream(
        reference: usersTasksRef,
        field: userIdK,
        value: userId,
        firstDate: firstDate,
        secondDate: secondDate);
    return stream.cast<QuerySnapshot<UserTaskModel>>();
  }

  Future<List<UserTaskModel>> getCategoryTasksBetweenTowTimes({
    required DateTime firstDate,
    required DateTime secondDate,
    required String folderId,
  }) async {
    List<Object?>? list = await getTasksStartBetweenTowTimes(
      reference: usersTasksRef,
      field: folderIdK,
      value: folderId,
      firstDate: firstDate,
      secondDate: secondDate,
    );
    return list!.cast<UserTaskModel>();
  }

  Stream<QuerySnapshot<UserTaskModel>> getCategoryTasksBetweenTowTimesStream(
      {required DateTime firstDate,
      required DateTime secondDate,
      required String folderId}) {
    Stream<QuerySnapshot> stream = getTasksStartBetweenTowTimesStream(
        reference: usersTasksRef,
        field: folderIdK,
        value: folderId,
        firstDate: firstDate,
        secondDate: secondDate);
    return stream.cast<QuerySnapshot<UserTaskModel>>();
  }

  Future<List<UserTaskModel>> getUserTasksStartInASpecificTime(
      {required DateTime date, required String userId}) async {
    List<Object?>? list = await getTasksStartInASpecificTime(
        reference: usersTasksRef, date: date, field: userIdK, value: userId);
    return list!.cast<UserTaskModel>();
  }

  Stream<QuerySnapshot<UserTaskModel>> getUserTasksStartInASpecificTimeStream(
      {required DateTime date, required String userId}) {
    Stream<QuerySnapshot> stream = getTasksStartInASpecificTimeStream(
        reference: usersTasksRef, date: date, field: userIdK, value: userId);
    return stream.cast<QuerySnapshot<UserTaskModel>>();
  }

  Future<List<UserTaskModel>> getCategoryTasksStartInASpecificTime(
      {required DateTime date, required String folderId}) async {
    List<Object?>? list = await getTasksStartInASpecificTime(
        reference: usersTasksRef,
        date: date,
        field: folderIdK,
        value: folderId);
    return list!.cast<UserTaskModel>();
  }

  Stream<QuerySnapshot<UserTaskModel>>
      getCategoryTasksStartInASpecificTimeStream(
          {required DateTime date, required String folderId}) {
    Stream<QuerySnapshot> stream = getTasksStartInASpecificTimeStream(
        reference: usersTasksRef,
        date: date,
        field: folderIdK,
        value: folderId);
    return stream.cast<QuerySnapshot<UserTaskModel>>();
  }

  Future<void> addUserTask({required UserTaskModel userTaskModel}) async {
    // bool exist = await existByTow(
    //     reference: usersTasksRef,
    //     field: "name",
    //     value: userTaskModel.name,
    //     field2: "folderId",
    //     value2: userTaskModel.folderId);
    // if (exist) {
    //   Exception exception;
    //   exception = Exception("Task name already Exist in this ");
    //   throw exception;
    // }
    QuerySnapshot snapshot = await queryWhereForDate(
        reference: usersTasksRef,
        firstField: userIdK,
        firstValue: userTaskModel.userId,
        startDateField: startDateK,
        startDateValue: userTaskModel.startDate,
        endDateField: endDateK,
        endDateValue: userTaskModel.startDate);
    int numOfTasksInSameTime = snapshot.size;
    if (numOfTasksInSameTime >= 1) {
      Get.defaultDialog(
        title: "Task Time Error",
        middleText:
            "There is $numOfTasksInSameTime That start in this time \n Would you Like To Add Task Any Way?",
        onConfirm: () async {
          await addTask(
            reference: usersTasksRef,
            field: folderIdK,
            value: userTaskModel.folderId,
            taskModel: userTaskModel,
            exception: Exception("task already exist in Category"),
          );
        },
        onCancel: () {
          Get.back();
        },
      );
    }
    await addTask(
      reference: usersTasksRef,
      field: folderIdK,
      value: userTaskModel.folderId,
      taskModel: userTaskModel,
      exception: Exception("task already exist in Category"),
    );
  }

  Future<void> addUserLateTask({required UserTaskModel userTaskModel}) async {
    await addLateTask(
        taskModel: userTaskModel,
        field: folderIdK,
        value: userTaskModel.folderId,
        reference: usersTasksRef,
        exception: Exception("task already been added"));
  }

  Future<void> deleteUserTask({required String id}) async {
    WriteBatch batch = fireStore.batch();
    QuerySnapshot querySnapshot = await queryWhere(
        reference: usersTasksRef, field: taskFatherIdK, value: id);
    deleteDocsUsingBatch(list: querySnapshot.docs, refBatch: batch);
    batch.commit();
  }

  Future<void> updateUserTask(
      {required Map<String, dynamic> data, required String id}) async {
    DocumentSnapshot snapshot =
        await getDocById(reference: usersTasksRef, id: id);
    UserTaskModel userTaskModel = snapshot.data() as UserTaskModel;
    if (data.containsKey(startDateK)) {
      QuerySnapshot snapshot1 = await queryWhereForDate(
          reference: usersTasksRef,
          firstField: userIdK,
          firstValue: userTaskModel.userId,
          startDateField: startDateK,
          startDateValue: userTaskModel.startDate,
          endDateField: endDateK,
          endDateValue: userTaskModel.startDate);
      int numOfTasksInSameTime = snapshot1.size;
      if (numOfTasksInSameTime >= 1) {
        Get.defaultDialog(
          title: "Task Time Error",
          middleText:
              "There is $numOfTasksInSameTime That start in this time \n Would you Like To update Task Any Way?",
          onConfirm: () async {
            await addTask(
              reference: usersTasksRef,
              field: folderIdK,
              value: userTaskModel.folderId,
              taskModel: userTaskModel,
              exception: Exception("task already exist in Category"),
            );
          },
          onCancel: () {
            Get.back();
          },
        );
      }
    }

    await updateTask(
      reference: usersTasksRef,
      data: data,
      id: id,
      field: folderIdK,
      value: userTaskModel.folderId,
      exception: Exception("task already exist in category"),
    );
  }
}
