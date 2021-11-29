// To parse this JSON data, do
//
//     final addRecipeRequestEntity = addRecipeRequestEntityFromMap(jsonString);

import 'dart:convert';

import 'package:fit_beat/app/data/model/add_post/media_upload_response.dart';

AddRecipeRequestEntity addRecipeRequestEntityFromMap(String str) =>
    AddRecipeRequestEntity.fromMap(json.decode(str));

String addRecipeRequestEntityToMap(AddRecipeRequestEntity data) =>
    json.encode(data.toMap());

class AddRecipeRequestEntity {
  AddRecipeRequestEntity({
    this.title,
    this.description,
    this.masterCuisineId,
    this.foodType,
    this.masterCategoryId,
    this.cookingDuration,
    this.servings,
    this.userMedia,
    this.userTags,
    this.calories,
    this.userRecipeIngredients,
    this.userRecipePreparationSteps,
    this.recipeId,
  });

  String title;
  String description;
  int masterCuisineId;
  int foodType;
  List<int> masterCategoryId;

  int recipeId;
  String cookingDuration;
  String servings;
  List<MediaUrl> userMedia;
  List<UserTag> userTags;
  Calories calories;
  List<UserRecipeIngredient> userRecipeIngredients;
  List<UserRecipePreparationStep> userRecipePreparationSteps;

  factory AddRecipeRequestEntity.fromMap(Map<String, dynamic> json) =>
      AddRecipeRequestEntity(
        title: json["title"] == null ? null : json["title"],
        recipeId: json["user_recipe_id"] == null ? 0 : json["user_recipe_id"],
        description: json["description"] == null ? null : json["description"],
        masterCuisineId: json["master_cuisine_id"] == null
            ? null
            : json["master_cuisine_id"],
        foodType: json["food_type"] == null ? null : json["food_type"],
        masterCategoryId: json["master_category_id"] == null
            ? null
            : json["master_category_id"],
        cookingDuration:
            json["cooking_duration"] == null ? null : json["cooking_duration"],
        servings: json["servings"] == null ? null : json["servings"],
        userMedia: json["user_media"] == null
            ? null
            : List<MediaUrl>.from(
                json["user_media"].map((x) => MediaUrl.fromJson(x))),
        userTags: json["user_tags"] == null
            ? null
            : List<UserTag>.from(
                json["user_tags"].map((x) => UserTag.fromMap(x))),
        calories: json["calories"] == null
            ? null
            : Calories.fromMap(json["calories"]),
        userRecipeIngredients: json["user_recipe_ingredients"] == null
            ? null
            : List<UserRecipeIngredient>.from(json["user_recipe_ingredients"]
                .map((x) => UserRecipeIngredient.fromMap(x))),
        userRecipePreparationSteps:
            json["user_recipe_preparation_steps"] == null
                ? null
                : List<UserRecipePreparationStep>.from(
                    json["user_recipe_preparation_steps"]
                        .map((x) => UserRecipePreparationStep.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "title": title == null ? null : title,
        "user_recipe_id": recipeId == null ? 0 : recipeId,
        "description": description == null ? null : description,
        "master_cuisine_id": masterCuisineId == null ? null : masterCuisineId,
        "food_type": foodType == null ? null : foodType,
        "master_category_id":
            masterCategoryId == null ? null : masterCategoryId,
        "cooking_duration": cookingDuration == null ? null : cookingDuration,
        "servings": servings == null ? null : servings,
        "user_media": userMedia == null
            ? null
            : List<dynamic>.from(userMedia.map((x) => x.toJson())),
        "user_tags": userTags == null
            ? null
            : List<dynamic>.from(userTags.map((x) => x.toMap())),
        "calories": calories == null ? null : calories.toMap(),
        "user_recipe_ingredients": userRecipeIngredients == null
            ? null
            : List<dynamic>.from(userRecipeIngredients.map((x) => x.toMap())),
        "user_recipe_preparation_steps": userRecipePreparationSteps == null
            ? null
            : List<dynamic>.from(
                userRecipePreparationSteps.map((x) => x.toMap())),
      };
}

class Calories {
  Calories({
    this.protein,
    this.carbs,
    this.fat,
  });

  double protein;
  double carbs;
  double fat;

  factory Calories.fromMap(Map<String, dynamic> json) => Calories(
        protein: json["protein"] == null ? null : json["protein"],
        carbs: json["carbs"] == null ? null : json["carbs"],
        fat: json["fat"] == null ? null : json["fat"],
      );

  Map<String, dynamic> toMap() => {
        "protein": protein == null ? null : protein,
        "carbs": carbs == null ? null : carbs,
        "fat": fat == null ? null : fat,
      };
}

class UserMedia {
  UserMedia({
    this.mediaType,
    this.mediaUrl,
  });

  int mediaType;
  String mediaUrl;

  factory UserMedia.fromMap(Map<String, dynamic> json) => UserMedia(
        mediaType: json["media_type"] == null ? null : json["media_type"],
        mediaUrl: json["media_url"] == null ? null : json["media_url"],
      );

  Map<String, dynamic> toMap() => {
        "media_type": mediaType == null ? null : mediaType,
        "media_url": mediaUrl == null ? null : mediaUrl,
      };
}

class UserRecipeIngredient {
  UserRecipeIngredient({
    this.title,
    this.user_recipe_ingredient_id,
    this.user_recipe_id,
  });

  String title;
  int user_recipe_ingredient_id;
  int user_recipe_id;

  factory UserRecipeIngredient.fromMap(Map<String, dynamic> json) =>
      UserRecipeIngredient(
        title: json["title"] == null ? null : json["title"],
        user_recipe_ingredient_id: json["user_recipe_ingredient_id"] == null
            ? null
            : json["user_recipe_ingredient_id"],
        user_recipe_id:
            json["user_recipe_id"] == null ? null : json["user_recipe_id"],
      );

  Map<String, dynamic> toMap() => {
        "title": title == null ? null : title,
        "user_recipe_ingredient_id": user_recipe_ingredient_id == null
            ? null
            : user_recipe_ingredient_id,
        "user_recipe_id": user_recipe_id == null ? null : user_recipe_id,
      };
}

class UserRecipePreparationStep {
  UserRecipePreparationStep({
    this.description,
  });

  String description;

  factory UserRecipePreparationStep.fromMap(Map<String, dynamic> json) =>
      UserRecipePreparationStep(
        description: json["description"] == null ? null : json["description"],
      );

  Map<String, dynamic> toMap() => {
        "description": description == null ? null : description,
      };
}

class UserTag {
  UserTag({
    this.masterTagId,
    this.userTagId,
    this.title,
  });

  int masterTagId;
  int userTagId;
  String title;

  factory UserTag.fromMap(Map<String, dynamic> json) => UserTag(
        masterTagId:
            json["master_tag_id"] == null ? null : json["master_tag_id"],
        userTagId: json["user_tag_id"] == null ? 0 : json["user_tag_id"],
        title: json["title"] == null ? null : json["title"],
      );

  Map<String, dynamic> toMap() => {
        "master_tag_id": masterTagId == null ? null : masterTagId,
        "title": title == null ? null : title,
      };

  Map<String, dynamic> toJson() => {
        "master_tag_id": masterTagId == null ? null : masterTagId,
        "user_tag_id": userTagId == null ? 0 : userTagId,
        "title": title == null ? null : title,
      };
}
