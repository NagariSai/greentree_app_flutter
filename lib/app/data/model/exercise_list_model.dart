import 'package:fit_beat/app/data/model/schedule_activity_list_model.dart';

class ExerciseListModel {
  ExerciseListModel({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  Data data;

  factory ExerciseListModel.fromJson(Map<String, dynamic> json) =>
      ExerciseListModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data.toJson(),
      };
}

class Data {
  Data({
    this.count,
    this.rows,
  });

  int count;
  List<ExerciseData> rows;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        count: json["count"] == null ? null : json["count"],
        rows: json["rows"] == null
            ? null
            : List<ExerciseData>.from(
                json["rows"].map((x) => ExerciseData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count == null ? null : count,
        "rows": rows == null
            ? null
            : List<dynamic>.from(rows.map((x) => x.toJson())),
      };
}
