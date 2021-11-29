// To parse this JSON data, do
//
//     final feedResponse = feedResponseFromJson(jsonString);

import 'dart:convert';

import 'package:fit_beat/app/data/model/recipe/add_recipe_request_entity.dart';

FeedResponse feedResponseFromJson(String str) =>
    FeedResponse.fromJson(json.decode(str));

String feedResponseToJson(FeedResponse data) => json.encode(data.toJson());

class FeedResponse {
  FeedResponse({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  Data data;

  factory FeedResponse.fromJson(Map<String, dynamic> json) => FeedResponse(
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
    this.feeds,
    this.count,
  });

  List<Feed> feeds;
  int count;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        feeds: json.containsKey("rows")
            ? List<Feed>.from(json["rows"].map((x) => Feed.fromJson(x)))
            : null,
        count: json["count"] == null ? null : json["count"],
      );

  Map<String, dynamic> toJson() => {
        "rows": feeds == null
            ? null
            : List<dynamic>.from(feeds.map((x) => x.toJson())),
        "count": count == null ? null : count,
      };
}

class Feed {
  Feed(
      {this.uniqueId,
      this.userId,
      this.profileUrl,
      this.fullName,
      this.type,
      this.title,
      this.descriptions,
      this.foodType,
      this.cookingDuration,
      this.createDatetimeUnix,
      this.createDatetime,
      this.updateDatetime,
      this.lostKgs,
      this.duration,
      this.isMyLike,
      this.isMyBookmark,
      this.totalLikes,
      this.totalComments,
      this.triedCount,
      this.userMedia,
      this.userTags,
      this.userRecipeColories,
      this.masterCuisines,
      this.userRecipePreparationSteps,
      this.userRecipeIngredients,
      this.userRecipeCategory,
      this.masterCuisineId,
      this.recipeId,
      this.servings});

  int uniqueId;
  int userId;
  dynamic profileUrl;
  String fullName;
  int type;
  String title;
  String descriptions;
  int foodType;
  String cookingDuration;
  String createDatetimeUnix;
  DateTime createDatetime;
  DateTime updateDatetime;
  dynamic lostKgs;
  dynamic duration;
  int isMyLike;
  int isMyBookmark;
  int totalLikes;
  int totalComments;
  int triedCount;
  int recipeId;
  List<UserMedia> userMedia;
  List<FeedUserTag> userTags;
  List<RecipeColories> userRecipeColories;
  List<MasterCuisine> masterCuisines;
  List<UserRecipeIngredient> userRecipeIngredients;
  List<UserRecipePreparationStep> userRecipePreparationSteps;
  List<UserRecipeCategory> userRecipeCategory;
  dynamic servings;
  int masterCuisineId;

  factory Feed.fromJson(Map<String, dynamic> json) => Feed(
        masterCuisineId: json["master_cuisine_id"] == null
            ? null
            : json["master_cuisine_id"],
        recipeId:
            json["user_recipe_id"] == null ? null : json["user_recipe_id"],
        servings: json["servings"] == null ? "" : json["servings"],
        uniqueId: json["unique_id"] == null ? null : json["unique_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        profileUrl: json["profile_url"] == null ? "" : json["profile_url"],
        fullName: json["full_name"] == null ? null : json["full_name"],
        type: json["type"] == null ? null : json["type"],
        title: json["title"] == null ? null : json["title"],
        descriptions:
            json["descriptions"] == null ? null : json["descriptions"],
        foodType: json["food_type"] == null ? null : json["food_type"],
        cookingDuration:
            json["cooking_duration"] == null ? null : json["cooking_duration"],
        createDatetimeUnix: json["create_datetime_unix"] == null
            ? null
            : json["create_datetime_unix"],
        createDatetime: json["create_datetime"] == null
            ? null
            : DateTime.parse(json["create_datetime"]),
        updateDatetime: json["update_datetime"] == null
            ? null
            : DateTime.parse(json["update_datetime"]),
        lostKgs: json["lost_kgs"] == null
            ? null
            : json["lost_kgs"] is int
                ? json["lost_kgs"].toString()
                : json["lost_kgs"],
        duration: json["duration"] == null ? null : json["duration"],
        isMyLike: json["is_my_like"] == null ? null : json["is_my_like"],
        isMyBookmark:
            json["is_my_bookmark"] == null ? null : json["is_my_bookmark"],
        totalLikes: json["total_likes"] == null ? null : json["total_likes"],
        totalComments:
            json["total_comments"] == null ? null : json["total_comments"],
        triedCount: json["tried_count"] == null ? null : json["tried_count"],
        userRecipeIngredients: json["user_recipe_ingredients"] == null
            ? null
            : List<UserRecipeIngredient>.from(json["user_recipe_ingredients"]
                .map((x) => UserRecipeIngredient.fromMap(x))),
        userMedia: json["user_media"] == null
            ? null
            : List<UserMedia>.from(
                json["user_media"].map((x) => UserMedia.fromJson(x))),
        userTags: json["user_tags"] == null
            ? null
            : List<FeedUserTag>.from(
                json["user_tags"].map((x) => FeedUserTag.fromJson(x))),
        masterCuisines: json["master_cuisines"] == null
            ? null
            : List<MasterCuisine>.from(
                json["master_cuisines"].map((x) => MasterCuisine.fromJson(x))),
        userRecipePreparationSteps:
            json["user_recipe_preparation_steps"] == null
                ? null
                : List<UserRecipePreparationStep>.from(
                    json["user_recipe_preparation_steps"]
                        .map((x) => UserRecipePreparationStep.fromMap(x))),
        userRecipeColories: json["user_recipe_colories"] == null
            ? null
            : List<RecipeColories>.from(json["user_recipe_colories"]
                .map((x) => RecipeColories.fromJson(x))),
        userRecipeCategory: json["user_recipe_category"] == null
            ? null
            : List<UserRecipeCategory>.from(json["user_recipe_category"]
                .map((x) => UserRecipeCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "master_cuisine_id": masterCuisineId == null ? null : masterCuisineId,
        "user_recipe_id": recipeId == null ? null : recipeId,
        "servings": servings == null ? null : servings,
        "unique_id": uniqueId == null ? null : uniqueId,
        "user_id": userId == null ? null : userId,
        "profile_url": profileUrl,
        "full_name": fullName == null ? null : fullName,
        "type": type == null ? null : type,
        "title": title == null ? null : title,
        "descriptions": descriptions == null ? null : descriptions,
        "food_type": foodType == null ? null : foodType,
        "cooking_duration": cookingDuration == null ? null : cookingDuration,
        "create_datetime_unix":
            createDatetimeUnix == null ? null : createDatetimeUnix,
        "create_datetime":
            createDatetime == null ? null : createDatetime.toIso8601String(),
        "update_datetime":
            updateDatetime == null ? null : updateDatetime.toIso8601String(),
        "lost_kgs": lostKgs == null ? null : lostKgs,
        "duration": duration == null ? null : duration,
        "is_my_like": isMyLike == null ? null : isMyLike,
        "is_my_bookmark": isMyBookmark == null ? null : isMyBookmark,
        "total_likes": totalLikes == null ? null : totalLikes,
        "total_comments": totalComments == null ? null : totalComments,
        "tried_count": triedCount == null ? null : triedCount,
        "user_recipe_ingredients": userRecipeIngredients == null
            ? null
            : List<dynamic>.from(userRecipeIngredients.map((x) => x.toMap())),
        "master_cuisines": masterCuisines == null
            ? null
            : List<dynamic>.from(masterCuisines.map((x) => x.toJson())),
        "user_media": userMedia == null
            ? null
            : List<dynamic>.from(userMedia.map((x) => x.toJson())),
        "user_tags": userTags == null
            ? null
            : List<dynamic>.from(userTags.map((x) => x.toJson())),
        "user_recipe_preparation_steps": userRecipePreparationSteps == null
            ? null
            : List<dynamic>.from(userRecipePreparationSteps.map((x) => x)),
        "user_recipe_colories": userRecipeColories == null
            ? null
            : List<dynamic>.from(userRecipeColories.map((x) => x)),
        "user_recipe_category": userRecipeCategory == null
            ? null
            : List<dynamic>.from(userRecipeCategory.map((x) => x)),
      };
}

class RecipeColories {
  RecipeColories({this.user_recipe_id, this.protein, this.carbs, this.fat});
  int user_recipe_id;
  int protein;
  int carbs;
  int fat;
  factory RecipeColories.fromJson(Map<String, dynamic> json) => RecipeColories(
        user_recipe_id:
            json["user_recipe_id"] == null ? null : json["user_recipe_id"],
        protein: json["protein"] == null
            ? null
            : json["protein"] is int
                ? json["protein"]
                : json["protein"].toInt(),
        carbs: json["carbs"] == null
            ? null
            : json["carbs"] is int
                ? json["carbs"]
                : json["carbs"].toInt(),
        fat: json["fat"] == null
            ? null
            : json["fat"] is int
                ? json["fat"]
                : json["fat"].toInt(),
      );
  Map<String, dynamic> toJson() => {
        "user_recipe_id": user_recipe_id == null ? null : user_recipe_id,
        "protein": protein == null ? null : protein,
        "carbs": carbs == null ? null : carbs,
        "fat": fat == null ? null : fat
      };
}

class UserMedia {
  UserMedia({
    this.userMediaId,
    this.mediaType,
    this.mediaUrl,
    this.mediaUrl2,
    this.globalId,
    this.globalType,
    this.viewCount,
  });

  int userMediaId;
  int mediaType;
  String mediaUrl;
  String mediaUrl2;
  int globalId;
  int globalType;
  int viewCount;

  factory UserMedia.fromJson(Map<String, dynamic> json) => UserMedia(
        userMediaId:
            json["user_media_id"] == null ? null : json["user_media_id"],
        mediaType: json["media_type"] == null ? null : json["media_type"],
        mediaUrl: json["media_url"] == null ? null : json["media_url"],
        mediaUrl2: json["media_url2"] == null ? null : json["media_url2"],
        globalId: json["global_id"] == null ? null : json["global_id"],
        globalType: json["global_type"] == null ? null : json["global_type"],
        viewCount: json["view_count"] == null ? null : json["view_count"],
      );

  Map<String, dynamic> toJson() => {
        "user_media_id": userMediaId == null ? null : userMediaId,
        "media_type": mediaType == null ? null : mediaType,
        "media_url": mediaUrl == null ? null : mediaUrl,
        "media_url2": mediaUrl2 == null ? null : mediaUrl2,
        "global_id": globalId == null ? null : globalId,
        "global_type": globalType == null ? null : globalType,
        "view_count": viewCount == null ? null : viewCount,
      };
}

class FeedUserTag {
  FeedUserTag({
    this.userTagId,
    this.masterTagId,
    this.title,
    this.masterTagTitle,
    this.globalId,
    this.globalType,
  });

  int userTagId;
  int masterTagId;
  String title;
  String masterTagTitle;
  int globalId;
  int globalType;

  factory FeedUserTag.fromJson(Map<String, dynamic> json) => FeedUserTag(
        userTagId: json["user_tag_id"] == null ? null : json["user_tag_id"],
        masterTagId:
            json["master_tag_id"] == null ? null : json["master_tag_id"],
        title: json["title"] == null ? null : json["title"],
        masterTagTitle:
            json["master_tag_title"] == null ? null : json["master_tag_title"],
        globalId: json["global_id"] == null ? null : json["global_id"],
        globalType: json["global_type"] == null ? null : json["global_type"],
      );

  Map<String, dynamic> toJson() => {
        "user_tag_id": userTagId == null ? null : userTagId,
        "master_tag_id": masterTagId == null ? null : masterTagId,
        "title": title == null ? null : title,
        "master_tag_title": masterTagTitle == null ? null : masterTagTitle,
        "global_id": globalId == null ? null : globalId,
        "global_type": globalType == null ? null : globalType,
      };
}

class MasterCuisine {
  MasterCuisine({
    this.masterCuisineId,
    this.title,
  });

  int masterCuisineId;
  String title;

  factory MasterCuisine.fromJson(Map<String, dynamic> json) => MasterCuisine(
        masterCuisineId: json["master_cuisine_id"] == null
            ? null
            : json["master_cuisine_id"],
        title: json["title"] == null ? null : json["title"],
      );

  Map<String, dynamic> toJson() => {
        "master_cuisine_id": masterCuisineId == null ? null : masterCuisineId,
        "title": title == null ? null : title,
      };
}

class UserRecipeCategory {
  UserRecipeCategory({
    this.masterCategoryId,
    this.userRecipeId,
    this.userRecipeCategoryId,
  });

  int masterCategoryId;
  int userRecipeId;
  int userRecipeCategoryId;

  factory UserRecipeCategory.fromJson(Map<String, dynamic> json) =>
      UserRecipeCategory(
        masterCategoryId: json["master_category_id"] == null
            ? null
            : json["master_category_id"],
        userRecipeId:
            json["user_recipe_id"] == null ? 0 : json["user_recipe_id"],
        userRecipeCategoryId: json["user_recipe_category_id"] == null
            ? null
            : json["user_recipe_category_id"],
      );

  Map<String, dynamic> toMap() => {
        "master_category_id":
            masterCategoryId == null ? null : masterCategoryId,
        "user_recipe_id": userRecipeId == null ? null : userRecipeId,
        "user_recipe_category_id":
            userRecipeCategoryId == null ? null : userRecipeCategoryId,
      };

  Map<String, dynamic> toJson() => {
        "master_category_id":
            masterCategoryId == null ? null : masterCategoryId,
        "title": userRecipeId == null ? null : userRecipeId,
        "user_recipe_category_id":
            userRecipeCategoryId == null ? null : userRecipeCategoryId,
      };
}
