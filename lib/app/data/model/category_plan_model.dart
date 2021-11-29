class CategoryPlanModel {
  CategoryPlanModel({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  List<CategoryPlan> data;

  factory CategoryPlanModel.fromJson(Map<String, dynamic> json) => CategoryPlanModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<CategoryPlan>.from(json["data"].map((x) => CategoryPlan.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class CategoryPlan {
  CategoryPlan({
    this.fitnessCategoryId,
    this.title,
    this.fitnessCategoryPlans,
  });

  int fitnessCategoryId;
  String title;
  List<FitnessCategoryPlan> fitnessCategoryPlans;

  factory CategoryPlan.fromJson(Map<String, dynamic> json) => CategoryPlan(
    fitnessCategoryId: json["fitness_category_id"] == null ? null : json["fitness_category_id"],
    title: json["title"] == null ? null : json["title"],
    fitnessCategoryPlans: json["fitness_category_plans"] == null ? null : List<FitnessCategoryPlan>.from(json["fitness_category_plans"].map((x) => FitnessCategoryPlan.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "fitness_category_id": fitnessCategoryId == null ? null : fitnessCategoryId,
    "title": title == null ? null : title,
    "fitness_category_plans": fitnessCategoryPlans == null ? null : List<dynamic>.from(fitnessCategoryPlans.map((x) => x.toJson())),
  };
}

class FitnessCategoryPlan {
  FitnessCategoryPlan({
    this.fitnessCategoryPlanId,
    this.title,
    this.type,
    this.duration,
    this.description,
    this.note,
    this.rate,
  });

  int fitnessCategoryPlanId;
  String title;
  String type;
  String duration;
  String description;
  String note;
  int rate;

  factory FitnessCategoryPlan.fromJson(Map<String, dynamic> json) => FitnessCategoryPlan(
    fitnessCategoryPlanId: json["fitness_category_plan_id"] == null ? null : json["fitness_category_plan_id"],
    title: json["title"] == null ? null : json["title"],
    type: json["type"] == null ? null : json["type"],
    duration: json["duration"] == null ? null : json["duration"],
    description: json["description"] == null ? null : json["description"],
    note: json["note"] == null ? null : json["note"],
    rate: json["rate"] == null ? null : json["rate"],
  );

  Map<String, dynamic> toJson() => {
    "fitness_category_plan_id": fitnessCategoryPlanId == null ? null : fitnessCategoryPlanId,
    "title": title == null ? null : title,
    "type": type == null ? null : type,
    "duration": duration == null ? null : duration,
    "description": description == null ? null : description,
    "note": note == null ? null : note,
    "rate": rate == null ? null : rate,
  };
}
