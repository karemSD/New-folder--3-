// ignore_for_file: constant_identifier_names

import 'package:googleauth/models/lang/lang.dart';

class AppConstants {
  static const String countryCode = 'country_code';
  static const String languageCode = 'language_code';

  static List<LanguageModel> languages = [
    LanguageModel(
        imgUrl: null,
        languageName: "Arabic",
        languageCode: "ar",
        countryCode: "sy"),
    LanguageModel(
        imgUrl: null,
        languageCode: "en",
        countryCode: "US",
        languageName: "English"),
  ];

  static const String app_name_key = "app_name";
  static const String tasks_key = "tasks";
  static const String categories_key = "categories";
  static const String assign_task_key = "assign_task";
  static const String task_name_key = "task_name";
  static const String category_name_key = "category_name";
  static const String start_time_key = "start_time";
  static const String end_time_key = "end_time";
  static const String add_task_key = "add_task";
  static const String edit_task_key = "edit_task";
  static const String delete_task_key = "delete_task";
  static const String save_changes_key = "save_changes";
  static const String cancel_key = "cancel";
  static const String success_key = "success";
  static const String error_key = "error";
  static const String confirm_delete_key = "confirm_delete";
  static const String task_created_successfully_key =
      "task_created_successfully";
  static const String task_updated_successfully_key =
      "task_updated_successfully";
  static const String task_deleted_successfully_key =
      "task_deleted_successfully";
  static const String teams_key = "teams";
  static const String team_name_key = "team_name";
  static const String add_team_key = "add_team";
  static const String edit_team_key = "edit_team";
  static const String delete_team_key = "delete_team";
  static const String team_created_successfully_key =
      "team_created_successfully";
  static const String team_updated_successfully_key =
      "team_updated_successfully";
  static const String team_deleted_successfully_key =
      "team_deleted_successfully";
  static const String members_key = "members";
  static const String task_list_key = "task_list";
  static const String task_description_key = "task_description";
  static const String save_key = "save";
  static const String yes_key = "yes";
  static const String no_key = "no";
  static const String confirm_delete_task_key = "confirm_delete_task";
  static const String welcome_message_key = "welcome_message";
  static const String team_list_key = "team_list";
  static const String team_description_key = "team_description";
  static const String team_members_key = "team_members";
  static const String invite_members_key = "invite_members";
  static const String project_list_key = "project_list";
  static const String project_main_tasks_key = "project_main_tasks";
  static const String project_sub_tasks_key = "project_sub_tasks";
  static const String project_members_key = "project_members";
  static const String project_manager_key = "project_manager";
  static const String project_start_time_key = "project_start_time";
  static const String project_end_time_key = "project_end_time";
  static const String team_leader_key = "team_leader";
  static const String project_description_key = "project_description";
  static const String project_team_key = "project_team";
  static const String due_date_key = "due_date";
  static const String task_assigned_successfully_key =
      "task_assigned_successfully";
  static const String due_date_validation_key = "due_date";
  static const String add_member_key = "add_member";
  static const String edit_member_key = "edit_member";
  static const String delete_member_key = "delete_member";
  static const String member_name_key = "member_name";
  static const String member_email_key = "member_email";
  static const String member_role_key = "member_role";
  static const String member_role_manager_key = "member_role_manager";
  static const String member_role_member_key = "member_role_member";
  static const String member_created_successfully_key =
      "member_created_successfully";
  static const String member_updated_successfully_key =
      "member_updated_successfully";
  static const String member_deleted_successfully_key =
      "member_deleted_successfully";
  static const String invite_user_key = "invite_user";
  static const String project_name_key = "project_name";
  static const String add_project_key = "add_project";
  static const String edit_project_key = "edit_project";
  static const String delete_project_key = "delete_project";
  static const String project_created_successfully_key =
      "project_created_successfully";
  static const String project_updated_successfully_key =
      "project_updated_successfully";
  static const String project_deleted_successfully_key =
      "project_deleted_successfully";
  static const String main_tasks_key = "main_tasks";
  static const String sub_tasks_key = "sub_tasks";
  static const String add_main_task_key = "add_main_task";
  static const String edit_main_task_key = "edit_main_task";
  static const String delete_main_task_key = "delete_main_task";
  static const String add_sub_task_key = "add_sub_task";
  static const String edit_sub_task_key = "edit_sub_task";
  static const String delete_sub_task_key = "delete_sub_task";
  static const String assign_main_task_key = "assign_main_task";
  static const String assign_sub_task_key = "assign_sub_task";
  static const String main_task_name_key = "main_task_name";
  static const String sub_task_name_key = "sub_task_name";
  static const String assignee_key = "assignee";
  static const String start_date_key = "start_date";
  static const String end_date_key = "end_date";
  static const String description_key = "description";
  static const String my_tasks_key = "my_tasks";
  static const String select_language_key = "select_language";
}
