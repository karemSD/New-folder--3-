import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';



import '../constants/constant.dart';
import '../models/team/Manger_model.dart';
import '../models/team/Project_model.dart';
import '../models/team/Team_model.dart';
import '../models/tops/TopModel_model.dart';
import '../services/collectionsrefrences.dart';
import 'manger_controller.dart';
import 'topController.dart';
//import 'package:rxdart/rxdart.dart';

class TeamController extends TopController {
  addTeam(TeamModel teamModel) async {
    if (await existByOne(
        collectionReference: managersRef,
        field: "id",
        value: teamModel.managerId)) {
      await addDoc(reference: teamsRef, model: teamModel);
    } else {
      Exception exception = Exception("Cannot found the manger of team");
      throw exception;
    }
  }

  Future<List<TeamModel>> getAllTeams() async {
    List<Object?>? list = await getAllListDataForRef(refrence: teamsRef);

    return list!.cast<TeamModel>();
  }

  Stream<QuerySnapshot<TeamModel>> getAllTeamsStream() {
    Stream<QuerySnapshot> stream =
        getAllListDataForRefStream(refrence: teamsRef);
    return stream.cast<QuerySnapshot<TeamModel>>();
  }

  Stream<DocumentSnapshot<TeamModel>> getTeamByIdStream<t extends TopModel>(
      {required String id}) {
    Stream<DocumentSnapshot> stream =
        getDocByIdStream(reference: teamsRef, id: id);
    return stream.cast<DocumentSnapshot<TeamModel>>();
  }

  Future<List<TeamModel>?> getTeamsOfUser({required String userId}) async {
    ManagerController controller = Get.put(ManagerController());
    ManagerModel? managerModel =
        await controller.getMangerWhereUserIs(userId: userId);
    if (managerModel != null) {
      return getTeamsOfManager(managerId: managerModel.id);
    }
    return null;
  }

  Stream<QuerySnapshot<TeamModel>?> getTeamsOfUserStream(
      {required String userId}) async* {
    ManagerController controller = Get.put(ManagerController());
    ManagerModel? managerModel =
        await controller.getMangerWhereUserIs(userId: userId);
    yield* getTeamsOfManagerStream(managerId: managerModel!.id);
  }

//جلب جميع التيمات الخاصة بهل المانجر
  Future<List<TeamModel>> getTeamsOfManager({required String managerId}) async {
    List<Object?>? list = await getListDataWhere(
        collectionReference: teamsRef, field: "managerId", value: managerId);
    return list!.cast<TeamModel>();
  }

  Stream<QuerySnapshot<TeamModel>> getTeamsOfManagerStream(
      {required String managerId}) {
    Stream<QuerySnapshot> stream = queryWhereStream(
        reference: teamsRef, field: "managerId", value: managerId);
    return stream.cast<QuerySnapshot<TeamModel>>();
  }

//getTeamOfProject(String teamIdOfproject) {}
// هي نفسها يلي تحت لانو ببساطة وقت بدك مشروع بس بتعطيه الايدي تيم يلي موجود بالكوليكشين تبعو بيقوم بيجيبو
//وهاد حسب تصميم الداتا بيز المتفق عليه
  Future<TeamModel> getTeamById({required String id}) async {
    DocumentSnapshot? documentSnapshot = await getDocSnapShotWhere(
        collectionReference: teamsRef, field: "id", value: id);
    return documentSnapshot!.data() as TeamModel;
  }

  // Future<TeamModel> getTeamByName({required String name}) async {
  //   DocumentSnapshot? doc = await getDocWhere(
  //     collectionReference: teamsRef,
  //     field: "name",
  //     value: name,
  //   );
  //   return doc!.data() as TeamModel;
  // }
  Future<TeamModel> getTeamByName(
      {required String name, required String managerId}) async {
    DocumentSnapshot? doc = await getDocSnapShotByNameInTow(
        reference: teamsRef, field: "managerId", value: managerId, name: name);
    return doc.data() as TeamModel;
  }

  // Stream<DocumentSnapshot<TeamModel>> getUserbyUserNameStream(
  //     {required String name}) async* {
  //   Stream<DocumentSnapshot> stream = getDocWhereStream(
  //     collectionReference: teamsRef,
  //     field: "name",
  //     value: name,
  //   );
  //   yield* stream.cast<DocumentSnapshot<TeamModel>>();
  // }
  Stream<DocumentSnapshot<TeamModel>> getTeamByNameNameStream(
      {required String name, required String managerId}) async* {
    Stream<DocumentSnapshot> stream = getDocByNameInTowStream(
        reference: teamsRef, field: "managerId", value: managerId, name: name);
    yield* stream.cast<DocumentSnapshot<TeamModel>>();
  }

  Future<TeamModel> getTeamOfProject({required ProjectModel project}) async {
    DocumentSnapshot? doc = await getDocSnapShotWhere(
        collectionReference: teamsRef, field: "id", value: project.teamId);
    return doc!.data() as TeamModel;
  }

  Stream<DocumentSnapshot<TeamModel>> getTeamOfProjectStream(
      {required ProjectModel project}) {
    Stream<DocumentSnapshot> stream = getDocWhereStream(
        collectionReference: teamsRef, field: "id", value: project.teamId);
    return stream.cast<DocumentSnapshot<TeamModel>>();
  }

  updateTeam(String id, Map<String, dynamic> data) {
    if (data.containsKey("managerId")) {
      Exception exception = Exception("Manager Id cannot be updated");
      throw exception;
    }
    updateNonRelationalFields(reference: teamsRef, data: data, id: id);
  }

  deleteTeam({required String id}) async {
    WriteBatch batch = fireStore.batch();
    //جلب التيم المحدد لهذا الايدي
    DocumentSnapshot team = await getDocById(reference: teamsRef, id: id);
    //حذف ذلك التيم
    deleteDocUsingBatch(documentSnapshot: team, refbatch: batch);
    //جلب المشروع الذي مستلمه هذا الفريق
    //لانو حسب ماساوينا اخر شي انو الفريق بيستلم مشروع واحد\ حسب كلام راغب كمان
    DocumentSnapshot? project = await getDocSnapShotWhere(
        collectionReference: projectsRef, field: "teamId", value: id);
    //حذف هذا المشروع
    deleteDocUsingBatch(documentSnapshot: project, refbatch: batch);
    //جلب جميع الأعضاء التي من هذا الفريق
    List<DocumentSnapshot> listOfMembes = await getDocsSnapShotWhere(
        collectionReference: teamMembersRef, field: teamIdK, value: id);
    //حذف الأعضاء الذي ينمتون لهذا الفريق
    deleteDocsUsingBatch(list: listOfMembes, refBatch: batch);
//جلب جميع المهام الرئيسية التي تنتمي للمشروع السابق الذي تم جلبه
    List<DocumentSnapshot> listOfMainTasks = await getDocsSnapShotWhere(
        collectionReference: projectMainTasksRef,
        field: projectIdK,
        value: project!.id);
    //حذف المهام الرئيسية لهذا المشروع
    deleteDocsUsingBatch(list: listOfMainTasks, refBatch: batch);

    //جلب جميع المهمات الفرعية التي من احد اعضاء هذا الفريق
    List<DocumentSnapshot> listSubTasks = [];
    for (var member in listOfMembes) {
      List<DocumentSnapshot> subTasks = await getDocsSnapShotWhere(
          collectionReference: projectSubTasksRef,
          field: assignedToK,
          value: member.id);
      listSubTasks.addAll(subTasks);
    }
    //حذف جميع هذه المهام
    deleteDocsUsingBatch(list: listSubTasks, refBatch: batch);
    batch.commit();
  }
}
