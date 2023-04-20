import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:googleauth/models/team/Project_model.dart';
import 'package:googleauth/models/team/Team_model.dart';
import 'dart:developer' as dev;
import '../constants/constant.dart';
import '../models/team/Manger_model.dart';
import '../services/collectionsrefrences.dart';
import 'topController.dart';

class ManagerController extends TopController {
  addManger(ManagerModel model) async {
    if (await existByOne(
        collectionReference: usersRef, field: idK, value: model.userId)) {
      addDoc(reference: managersRef, model: model);
    } else {
      Exception exception = Exception("user Id Not Found");
      throw exception;
    }
  }

  Future<ManagerModel> getMangerById({required String id}) async {
    DocumentSnapshot mangerDoc =
        await getDocById(reference: managersRef, id: id);
    return mangerDoc.data() as ManagerModel;
  }

  Stream<DocumentSnapshot<ManagerModel>> getMangerByIdStream(
      {required String id}) {
    Stream<DocumentSnapshot> stream =
        getDocByIdStream(reference: managersRef, id: id);
    return stream.cast<DocumentSnapshot<ManagerModel>>();
  }

  Future<ManagerModel> getMangerOfTeam({required TeamModel teamModel}) async {
    DocumentSnapshot? doc = await getDocSnapShotWhere(
        collectionReference: managersRef,
        field: idK,
        value: teamModel.managerId);
    return doc!.data() as ManagerModel;
  }

  Stream<DocumentSnapshot<ManagerModel>> getMangerOfTeamStream(
      {required TeamModel teamModel}) {
    Stream<DocumentSnapshot> docStream = getDocWhereStream(
        collectionReference: managersRef,
        field: idK,
        value: teamModel.managerId);
    return docStream.cast<DocumentSnapshot<ManagerModel>>();
  }

  Future<ManagerModel?> getMangerWhereUserIs({required String userId}) async {
    DocumentSnapshot? doc = await getDocSnapShotWhere(
        collectionReference: managersRef, field: userIdK, value: userId);
    return doc!.data() as ManagerModel;
  }

  Stream<DocumentSnapshot<ManagerModel>> getMangerWhereUserIsStream(
      String userId) {
    Stream<DocumentSnapshot> doc = getDocWhereStream(
        collectionReference: managersRef, field: userIdK, value: userId);
    return doc.cast<DocumentSnapshot<ManagerModel>>();
  }

  Future<ManagerModel?> getMangerOfProject(
      {required ProjectModel projectModel}) async {
    DocumentSnapshot? doc = await getDocSnapShotWhere(
        collectionReference: managersRef,
        field: idK,
        value: projectModel.managerId);
    return doc!.data() as ManagerModel;
  }

  Stream<DocumentSnapshot<ManagerModel>> getMangerOfProjectStream(
      {required ProjectModel projectModel}) {
    Stream<DocumentSnapshot> doc = getDocWhereStream(
        collectionReference: managersRef,
        field: idK,
        value: projectModel.managerId);
    return doc.cast<DocumentSnapshot<ManagerModel>>();
  }

  Future<void> updateManger(String id, Map<String, dynamic> data) async {
    if (data.containsKey(userIdK)) {
      Exception exception = Exception("userId cannot be updated");
      throw exception;
    }

    updateNonRelationalFields(reference: managersRef, data: data, id: id);
  }

  Future<void> deleteManger(
      {required String id, WriteBatch? writeBatch}) async {
    WriteBatch batch = fireStore.batch();
    if (writeBatch != null) {
      batch = writeBatch;
    }

    //جلب المانجر
    DocumentSnapshot? doc = await getDocSnapShotWhere(
        collectionReference: managersRef, field: idK, value: id);
    //جلب جميع التيمات يلي الهن المناجر هاد
    List<DocumentSnapshot?>? teams = await getDocsSnapShotWhere(
        collectionReference: teamsRef, field: managerIdK, value: id);
    //حذف المانجر
    deleteDocUsingBatch(documentSnapshot: doc, refbatch: batch);
    //حذف التيمات يلي جبناهن
    deleteDocsUsingBatch(list: teams, refBatch: batch);

    List<DocumentSnapshot> members = [];
    //اضافة جميع اضاء هذه التيمات الى ليست الاعضاء
    for (var team in teams) {
      DocumentSnapshot? documentSnapshot = await getDocSnapShotWhere(
          collectionReference: teamMembersRef, field: teamIdK, value: team!.id);
      members.add(documentSnapshot!);
    }
    //حذف جميع الاعضاء الذي تم جلبهم
    deleteDocsUsingBatch(list: members, refBatch: batch);
    //جلب جميع البروجكتات يلي مشترك فيها واحد من التيمات يلي الها المانجر هاد
    List<DocumentSnapshot?> listProjects = [];
    for (var team in teams) {
      dev.log("it passed");
      List<DocumentSnapshot?>? projectDos = await getDocsSnapShotWhere(
          collectionReference: projectsRef, field: teamIdK, value: team!.id);
      listProjects.addAll(projectDos);
    }
    //حذف جميع البروجكتات التي تم جليها
    deleteDocsUsingBatch(list: listProjects, refBatch: batch);
    //جلب جميع المهمات الرئيسية التي تنتمي لاحد المشاريع التي لها التيم الذي له هل المانجر الذي يحذف
    List<DocumentSnapshot> listMainTasks = [];
    for (var project in listProjects) {
      List<DocumentSnapshot> mainTasks = await getDocsSnapShotWhere(
          collectionReference: projectMainTasksRef,
          field: projectIdK,
          value: project!.id);
      listMainTasks.addAll(mainTasks);
    }
    //حذف جميع المهام الرئيسية التي تم جلبها قبل قليل
    deleteDocsUsingBatch(list: listMainTasks, refBatch: batch);
    //جلب جميع المهام التي تتبع لأحد المهام الرئيسية التي سوف يتم حذفها
    List<DocumentSnapshot> listSubTasks = [];
    for (var mainTask in listMainTasks) {
      List<DocumentSnapshot> subTasks = await getDocsSnapShotWhere(
          collectionReference: projectSubTasksRef,
          field: mainTaskIdK,
          value: mainTask.id);
      listSubTasks.addAll(subTasks);
    }
    //حذف جميع المهام الفرعية التي تتبع لأي مهمة رئيسة من المهام السابقة
    deleteDocsUsingBatch(list: listSubTasks, refBatch: batch);
    batch.commit();
  }
}
