class CoachProfileInfoModel {
  CoachProfileInfoModel({
    this.status,
    this.message,
    this.coach,
  });

  bool status;
  String message;
  CoachProfile coach;

  factory CoachProfileInfoModel.fromJson(Map<String, dynamic> json) =>
      CoachProfileInfoModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        coach:
            json["data"] == null ? null : CoachProfile.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": coach == null ? null : coach.toJson(),
      };
}

class CoachProfile {
  CoachProfile(
      {this.sessionSlot,
      this.userId,
      this.fullName,
      this.profileUrl,
      this.bio,
      this.backgroundProfileUrl,
      this.gender,
      this.dateOfBirth,
      this.noOfExperience,
      this.emailAddress,
      this.phoneNumber,
      this.country,
      this.countryCode,
      this.experienceLevel,
      this.userFitnessCategories,
      this.userCertificates,
      this.followersCount,
      this.followingCount,
      this.isFollow,
      this.rating,
      this.trained,
      this.pending,
      this.availSlots,
      this.isBtn,
      this.speciality,
      this.isMyReview});

  int sessionSlot;
  int userId;
  String fullName;
  dynamic profileUrl;
  String bio;
  String backgroundProfileUrl;
  int gender;
  DateTime dateOfBirth;
  int noOfExperience;
  String emailAddress;
  String phoneNumber;
  String country;
  String countryCode;
  int experienceLevel;
  List<UserFitnessCategory> userFitnessCategories;
  List<UserCertificate> userCertificates;
  int followersCount;
  int followingCount;
  int isFollow;
  String rating;
  int trained;
  int pending;
  int availSlots;
  int isBtn;
  int isMyReview;
  String speciality;

  factory CoachProfile.fromJson(Map<String, dynamic> json) => CoachProfile(
        isMyReview: json["is_my_review"] == null ? 0 : json["is_my_review"],
        speciality: json["speciality"] == null
            ? ""
            : json["speciality"] is int
                ? json["speciality"].toString()
                : json["speciality"],
        sessionSlot: json["session_slot"] == null ? null : json["session_slot"],
        userId: json["user_id"] == null ? null : json["user_id"],
        fullName: json["full_name"] == null ? null : json["full_name"],
        profileUrl: json["profile_url"],
        bio: json["bio"] == null ? null : json["bio"],
        backgroundProfileUrl: json["background_profile_url"] == null
            ? null
            : json["background_profile_url"],
        gender: json["gender"] == null ? null : json["gender"],
        dateOfBirth: json["date_of_birth"] == null
            ? null
            : DateTime.parse(json["date_of_birth"]),
        noOfExperience:
            json["no_of_experience"] == null ? null : json["no_of_experience"],
        emailAddress:
            json["email_address"] == null ? null : json["email_address"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        country: json["country"] == null ? null : json["country"],
        countryCode: json["country_code"] == null ? null : json["country_code"],
        experienceLevel:
            json["experience_level"] == null ? null : json["experience_level"],
        userFitnessCategories: json["user_fitness_categories"] == null
            ? null
            : List<UserFitnessCategory>.from(json["user_fitness_categories"]
                .map((x) => UserFitnessCategory.fromJson(x))),
        userCertificates: json["user_certificates"] == null
            ? null
            : List<UserCertificate>.from(json["user_certificates"]
                .map((x) => UserCertificate.fromJson(x))),
        followersCount:
            json["followers_count"] == null ? null : json["followers_count"],
        followingCount:
            json["following_count"] == null ? null : json["following_count"],
        isFollow: json["is_follow"] == null ? null : json["is_follow"],
        rating: json["rating"] == null ? null : json["rating"],
        trained: json["trained"] == null ? null : json["trained"],
        pending: json["pending"] == null ? null : json["pending"],
        availSlots: json["avail_slots"] == null ? null : json["avail_slots"],
        isBtn: json["is_btn"] == null ? null : json["is_btn"],
      );

  Map<String, dynamic> toJson() => {
        "speciality": speciality == null ? null : speciality,
        "is_my_review": isMyReview == null ? null : isMyReview,
        "session_slot": sessionSlot == null ? null : sessionSlot,
        "user_id": userId == null ? null : userId,
        "full_name": fullName == null ? null : fullName,
        "profile_url": profileUrl,
        "bio": bio == null ? null : bio,
        "background_profile_url":
            backgroundProfileUrl == null ? null : backgroundProfileUrl,
        "gender": gender == null ? null : gender,
        "date_of_birth":
            dateOfBirth == null ? null : dateOfBirth.toIso8601String(),
        "no_of_experience": noOfExperience == null ? null : noOfExperience,
        "email_address": emailAddress == null ? null : emailAddress,
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "country": country == null ? null : country,
        "country_code": countryCode == null ? null : countryCode,
        "experience_level": experienceLevel == null ? null : experienceLevel,
        "user_fitness_categories": userFitnessCategories == null
            ? null
            : List<dynamic>.from(userFitnessCategories.map((x) => x)),
        "user_certificates": userCertificates == null
            ? null
            : List<dynamic>.from(userCertificates.map((x) => x)),
        "followers_count": followersCount == null ? null : followersCount,
        "following_count": followingCount == null ? null : followingCount,
        "is_follow": isFollow == null ? null : isFollow,
        "rating": rating == null ? null : rating,
        "trained": trained == null ? null : trained,
        "pending": pending == null ? null : pending,
        "avail_slots": availSlots == null ? null : availSlots,
        "is_btn": isBtn == null ? null : isBtn,
      };
}

class UserFitnessCategory {
  UserFitnessCategory({
    this.userFitnessCategoryId,
    this.userId,
    this.fitnessCategoryId,
    this.title,
  });

  int userFitnessCategoryId;
  int userId;
  int fitnessCategoryId;
  String title;

  factory UserFitnessCategory.fromJson(Map<String, dynamic> json) =>
      UserFitnessCategory(
        userFitnessCategoryId: json["user_fitness_category_id"] == null
            ? null
            : json["user_fitness_category_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        fitnessCategoryId: json["fitness_category_id"] == null
            ? null
            : json["fitness_category_id"],
        title: json["title"] == null ? null : json["title"],
      );

  Map<String, dynamic> toJson() => {
        "user_fitness_category_id":
            userFitnessCategoryId == null ? null : userFitnessCategoryId,
        "user_id": userId == null ? null : userId,
        "fitness_category_id":
            fitnessCategoryId == null ? null : fitnessCategoryId,
        "title": title == null ? null : title,
      };
}

class UserCertificate {
  UserCertificate({
    this.userCertificateId,
    this.userId,
    this.certificateUrl,
  });

  int userCertificateId;
  int userId;
  String certificateUrl;

  factory UserCertificate.fromJson(Map<String, dynamic> json) =>
      UserCertificate(
        userCertificateId: json["user_certificate_id"] == null
            ? null
            : json["user_certificate_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        certificateUrl:
            json["certificate_url"] == null ? null : json["certificate_url"],
      );

  Map<String, dynamic> toJson() => {
        "user_certificate_id":
            userCertificateId == null ? null : userCertificateId,
        "user_id": userId == null ? null : userId,
        "certificate_url": certificateUrl == null ? null : certificateUrl,
      };
}
