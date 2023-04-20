import 'package:cloud_firestore/cloud_firestore.dart';


import '../constants/constant.dart';
import '../models/statusmodel.dart';
import '../models/team/Task_model.dart';
import '../models/tops/TopModel_model.dart';
import '../services/collectionsrefrences.dart';
import '../utils/utils.dart';
import 'topController.dart';

class ProjectTaskController extends TopController {
  Future<List<Object?>?> getTasksForStatus<t extends TopModel>({
    required String status,
    required CollectionReference reference,
    required String field,
    required dynamic value,
  }) async {
    DocumentSnapshot? documentSnapshot = await getDocSnapShotWhere(
      collectionReference: statusesRef,
      field: nameK,
      value: status,
    );
    final StatusModel statusModel = documentSnapshot!.data() as StatusModel;
    return await getListDataWhereAndWhere(
      collectionReference: reference,
      firstField: statusIdK,
      firstValue: statusModel.id,
      secondField: field,
      secondValue: value,
    );
  }

  Stream<QuerySnapshot<Object?>> getTasksForAStatusStream({
    required String status,
    required CollectionReference reference,
    required String field,
    required dynamic value,
  }) async* {
    DocumentSnapshot? documentSnapshot = await getDocSnapShotWhere(
      collectionReference: statusesRef,
      field: nameK,
      value: status,
    );
    final StatusModel statusModel = documentSnapshot!.data() as StatusModel;

    yield* queryWhereAndWhereStream(
      reference: reference,
      firstField: statusIdK,
      firstValue: statusModel.id,
      secondField: field,
      secondValue: value,
    );
  }

  Future<double> getPercentOfTasksForAStatus(
      {required String field,
      required dynamic value,
      required String status,
      required CollectionReference reference}) async {
    DocumentSnapshot? documentSnapshot = await getDocSnapShotWhere(
      collectionReference: statusesRef,
      field: nameK,
      value: status,
    );
    final StatusModel statusModel = documentSnapshot!.data() as StatusModel;
    int matchingStatusAndFieldValue = (await queryWhereAndWhere(
            reference: reference,
            firstField: statusIdK,
            firstValue: statusModel,
            secondField: field,
            secondValue: value))
        .size;
    int totalMatchingFieldValue =
        (await queryWhere(reference: reference, field: field, value: value))
            .size;
    if (totalMatchingFieldValue == 0) {
      return 0;
    }
    return (matchingStatusAndFieldValue / totalMatchingFieldValue) * 100;
  }

  Stream<double> getPercentOfTasksForAStatusStream(
      {required String field,
      required dynamic value,
      required String status,
      required CollectionReference reference}) async* {
    DocumentSnapshot? documentSnapshot = await getDocSnapShotWhere(
      collectionReference: statusesRef,
      field: nameK,
      value: status,
    );
    final StatusModel statusModel = documentSnapshot!.data() as StatusModel;
    int matchingStatusAndFieldValue = await (queryWhereAndWhereStream(
            reference: reference,
            firstField: statusIdK,
            firstValue: statusModel,
            secondField: field,
            secondValue: value))
        .length;
    int totalMatchingFieldValue = await (queryWhereStream(
            reference: reference, field: field, value: value))
        .length;
    if (totalMatchingFieldValue == 0) {
      yield 0;
    }
    yield (matchingStatusAndFieldValue / totalMatchingFieldValue) * 100;
  }

//! TODO make this func work

  Future<double> getPercentOfTasksForAStatusBetweenTowStartTimes({
    required CollectionReference reference,
    required String status,
    required String field,
    required dynamic value,
    required DateTime firstDate,
    required DateTime secondDate,
  }) async {
    DocumentSnapshot? documentSnapshot = await getDocSnapShotWhere(
      collectionReference: statusesRef,
      field: nameK,
      value: status,
    );
    final StatusModel statusModel = documentSnapshot!.data() as StatusModel;
    int matchingStatusAndFieldValue = (await queryWhereAndWhereForDate(
            reference: reference,
            firstField: statusIdK,
            firstValue: statusModel,
            secondField: field,
            secondValue: value,
            startDateField: startDateK,
            startDateFieldValue: firstDate,
            endDateField: endDateK,
            endDateValue: secondDate))
        .size;
    int totalMatchingFieldValue = (await queryWhereForDate(
            reference: reference,
            firstField: field,
            firstValue: value,
            startDateField: startDateK,
            startDateValue: firstDate,
            //TODO
            endDateField: endDateK,
            endDateValue: secondDate))
        .size;
    if (totalMatchingFieldValue == 0) {
      return 0;
    }
    return (matchingStatusAndFieldValue / totalMatchingFieldValue) * 100;
  }

  Stream<double> getPercentOfTasksForAStatusBetweenTowStartTimesStream({
    required CollectionReference reference,
    required String status,
    required String field,
    required dynamic value,
    required DateTime firstDate,
    required DateTime secondDate,
  }) async* {
    DocumentSnapshot? documentSnapshot = await getDocSnapShotWhere(
      collectionReference: statusesRef,
      field: nameK,
      value: status,
    );
    final StatusModel statusModel = documentSnapshot!.data() as StatusModel;
    int matchingStatusAndFieldValue = await (queryWhereAndWhereForDateStream(
            reference: reference,
            firstField: statusIdK,
            firstValue: statusModel,
            secondField: field,
            secondValue: value,
            startDateField: startDateK,
            startDateFieldValue: firstDate,
            //TODO
            endDateField: startDateK,
            endDateValue: secondDate))
        .length;
    int totalMatchingFieldValue = await queryWhereForDateStream(
            reference: reference,
            field: field,
            value: value,
            startDateField: startDateK,
            startDateFieldValue: firstDate,
            //TODO
            endDateField: startDateK,
            endDateValue: secondDate)
        .length;
    if (totalMatchingFieldValue == 0) {
      yield 0;
    }
    yield (matchingStatusAndFieldValue / totalMatchingFieldValue) * 100;
  }

  Future<List<Object?>?> getTasksForAnImportance<t extends TopModel>({
    required CollectionReference reference,
    required String field,
    required String value,
    required int importance,
  }) async {
    Exception exception;
    if (importance < 1) {
      exception = Exception("importance cannot be less than 1");
      throw exception;
    }
    if (importance > 5) {
      exception = Exception("importance cannot be bigger than 5");
      throw exception;
    }
    return await getListDataWhereAndWhere(
      collectionReference: reference,
      firstField: field,
      firstValue: value,
      secondField: importanceK,
      secondValue: importance,
    );
  }

  Stream<QuerySnapshot<Object?>>
      getTasksForAnImportanceStream<t extends TopModel>({
    required CollectionReference reference,
    required String field,
    required String value,
    required int importance,
  }) {
    Exception exception;
    if (importance < 1) {
      exception = Exception("importance cannot be less than 1");
      throw exception;
    }
    if (importance > 5) {
      exception = Exception("importance cannot be bigger than 5");
      throw exception;
    }
    return queryWhereAndWhereStream(
      reference: reference,
      firstField: field,
      firstValue: value,
      secondField: importanceK,
      secondValue: importance,
    );
  }

  Future<List<Object?>?> getTasksStartInADay<t extends TopModel>({
    required CollectionReference reference,
    required DateTime date,
    required String field,
    required dynamic value,
  }) async {
    date = firebaseTime(date);
    return await getDocsWhereForDate(
      reference: reference,
      firstField: field,
      firstValue: value,
      startDateField: startDateK,
      startDateFieldValue: date,
      endDateField: startDateK,
      endDateValue: date.add(
        const Duration(days: 1),
      ),
    );
  }

  Stream<QuerySnapshot<Object?>> getTasksStartInADayStream({
    required CollectionReference reference,
    required DateTime date,
    required String field,
    required dynamic value,
  }) {
    date = firebaseTime(date);
    return queryWhereForDateStream(
      reference: reference,
      field: field,
      value: value,
      startDateField: startDateK,
      startDateFieldValue: date,
      endDateField: startDateK,
      endDateValue: date.add(
        const Duration(days: 1),
      ),
    );
  }

  Future<List<Object?>?> getTasksStartInASpecificTime<t extends TopModel>({
    required CollectionReference reference,
    required DateTime date,
    required String field,
    required dynamic value,
  }) async {
    date = firebaseTime(date);
    return await getListDataWhereAndWhere(
      collectionReference: reference,
      firstField: field,
      firstValue: value,
      secondField: startDateK,
      secondValue: date,
    );
  }

  Stream<QuerySnapshot<Object?>> getTasksStartInASpecificTimeStream({
    required CollectionReference reference,
    required DateTime date,
    required String field,
    required dynamic value,
  }) {
    date = firebaseTime(date);
    return queryWhereAndWhereStream(
      reference: reference,
      firstValue: field,
      firstField: value,
      secondField: startDateK,
      secondValue: date,
    );
  }

  Future<List<Object?>?> getTasksStartBetweenTowTimes<t extends TaskClass>({
    required CollectionReference reference,
    required String field,
    required String value,
    required DateTime firstDate,
    required DateTime secondDate,
  }) async {
    return await getDocsWhereForDate(
        reference: reference,
        firstField: field,
        firstValue: value,
        startDateField: startDateK,
        startDateFieldValue: firstDate,
        endDateField: startDateK,
        endDateValue: secondDate);
  }

  Stream<QuerySnapshot<Object?>> getTasksStartBetweenTowTimesStream({
    required CollectionReference reference,
    required String field,
    required String value,
    required DateTime firstDate,
    required DateTime secondDate,
  }) {
    return queryWhereForDateStream(
        reference: reference,
        field: field,
        value: value,
        startDateField: startDateK,
        startDateFieldValue: firstDate,
        endDateField: startDateK,
        endDateValue: secondDate);
  }

  Future<void> addTask<t extends TaskClass>({
    required t taskModel,
    required String field,
    required dynamic value,
    required CollectionReference reference,
    required Exception exception,
  }) async {
    if (await existByTow(
      reference: reference,
      field: field,
      value: value,
      field2: nameK,
      value2: taskModel.name,
    )) {
      throw exception;
    }

    await addDoc(reference: reference, model: taskModel);
  }

  Future<void> addLateTask<t extends TaskClass>({
    required TaskClass taskModel,
    required String field,
    required String value,
    required CollectionReference reference,
    required Exception exception,
  }) async {
    if (await existByTow(
      reference: reference,
      field: field,
      value: value,
      field2: nameK,
      value2: taskModel.name,
    )) {
      throw exception;
    }
    DocumentSnapshot? documentSnapshot = await getDocSnapShotWhere(
      collectionReference: statusesRef,
      field: nameK,
      value: "done",
    );
    final StatusModel statusModel = documentSnapshot!.data() as StatusModel;
    taskModel.statusId = statusModel.id;
    await addDoc(reference: projectSubTasksRef, model: taskModel);
  }

  Future<void> updateTask({
    required Map<String, dynamic> data,
    required String id,
    required String field,
    required String value,
    required CollectionReference reference,
    required Exception exception,
  }) async {
    //TODO مرر البارمترات يلي بدك تضيفن حسب الحكي يلي حكيناه اخر مرة
    updateNonRelationalFields(reference: reference, data: data, id: id);
    return;
  }
}
