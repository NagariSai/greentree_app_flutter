class FitnessCategoryModel {
  FitnessCategoryModel({
    this.status,
    this.message,
    this.fitnessCategory,
  });

  bool status;
  String message;
  List<FitnessCategory> fitnessCategory;

  factory FitnessCategoryModel.fromJson(Map<String, dynamic> json) =>
      FitnessCategoryModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        fitnessCategory: json["data"] == null
            ? null
            : List<FitnessCategory>.from(
                json["data"].map((x) => FitnessCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": fitnessCategory == null
            ? null
            : List<FitnessCategory>.from(
                fitnessCategory.map((x) => x.toJson())),
      };
}

class FitnessCategory {
  FitnessCategory({
    this.fitnessCategoryId,
    this.title,
  });

  int fitnessCategoryId;
  String title;

  factory FitnessCategory.fromJson(Map<String, dynamic> json) =>
      FitnessCategory(
        fitnessCategoryId: json["fitness_category_id"] == null
            ? null
            : json["fitness_category_id"],
        title: json["title"] == null ? null : json["title"],
      );

  Map<String, dynamic> toJson() => {
        "fitness_category_id":
            fitnessCategoryId == null ? null : fitnessCategoryId,
        "title": title == null ? null : title,
      };
}
