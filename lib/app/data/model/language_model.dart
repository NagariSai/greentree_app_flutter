class LanguageModel {
  LanguageModel({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  List<Language> data;

  factory LanguageModel.fromJson(Map<String, dynamic> json) => LanguageModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<Language>.from(
                json["data"].map((x) => Language.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Language {
  Language({
    this.masterLanguageId,
    this.title,
  });

  int masterLanguageId;
  String title;

  factory Language.fromJson(Map<String, dynamic> json) => Language(
        masterLanguageId: json["master_language_id"] == null
            ? null
            : json["master_language_id"],
        title: json["title"] == null ? null : json["title"],
      );

  Map<String, dynamic> toJson() => {
        "master_language_id":
            masterLanguageId == null ? null : masterLanguageId,
        "title": title == null ? null : title,
      };
}
