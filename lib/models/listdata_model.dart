import 'dart:convert';

List<ListDataModel> listDataModelFromJson(String str) =>
    List<ListDataModel>.from(
        json.decode(str).map((x) => ListDataModel.fromJson(x)));

String listDataModelToJson(List<ListDataModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListDataModel {
  ListDataModel({
    this.login = '',
    this.description = '',
    this.language = '',
    this.openIssues = '',
    this.watchers = '',
  });

  String login;
  String description;
  String language;
  String openIssues;
  String watchers;

  factory ListDataModel.fromJson(Map<String, dynamic> json) => ListDataModel(
        login: json["owner"]['login'] ?? "",
        description: json["description"] ?? "",
        language: json["language"] ?? "",
        openIssues: json["open_issues"].toString(),
        watchers: json["watchers"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "login": login,
        "description": description,
        "language": language,
        "open_issues": openIssues,
        "watchers": watchers,
      };
}
