import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:fit_beat/app/constant/api_endpoint.dart';
import 'package:fit_beat/app/data/model/add_post/media_upload_response.dart';
import 'package:fit_beat/app/data/model/auth/forgot_password_response.dart';
import 'package:fit_beat/app/data/model/auth/login_response.dart';
import 'package:fit_beat/app/data/model/auth/resend_otp_response.dart';
import 'package:fit_beat/app/data/model/auth/signup_response.dart';
import 'package:fit_beat/app/data/model/category_plan_model.dart';
import 'package:fit_beat/app/data/model/chat/chat_request_response.dart';
import 'package:fit_beat/app/data/model/chat/chat_response.dart';
import 'package:fit_beat/app/data/model/chat/invite_new_chat_user_response.dart';
import 'package:fit_beat/app/data/model/chat/my_chats_response.dart';
import 'package:fit_beat/app/data/model/coach_enroll_user_response.dart';
import 'package:fit_beat/app/data/model/coach_list_model.dart';
import 'package:fit_beat/app/data/model/coach_payment_resoponse.dart';
import 'package:fit_beat/app/data/model/coach_profile_info_model.dart';
import 'package:fit_beat/app/data/model/coach_review_model.dart';
import 'package:fit_beat/app/data/model/coach_trained_people.dart';
import 'package:fit_beat/app/data/model/comment_response.dart';
import 'package:fit_beat/app/data/model/common_response.dart';
import 'package:fit_beat/app/data/model/exercise_list_model.dart';
import 'package:fit_beat/app/data/model/exercise_muscle_type_model.dart';
import 'package:fit_beat/app/data/model/feed/details_response.dart';
import 'package:fit_beat/app/data/model/feed/feed_response.dart';
import 'package:fit_beat/app/data/model/fitness_catgory_model.dart';
import 'package:fit_beat/app/data/model/language_model.dart';
import 'package:fit_beat/app/data/model/master/master_category_entity.dart';
import 'package:fit_beat/app/data/model/master/master_cuisine_entity.dart';
import 'package:fit_beat/app/data/model/master/master_tag_entity.dart';
import 'package:fit_beat/app/data/model/notification_model.dart';
import 'package:fit_beat/app/data/model/nutrition_list_model.dart';
import 'package:fit_beat/app/data/model/progress_graph_response.dart';
import 'package:fit_beat/app/data/model/recipe/add_recipe_request_entity.dart';
import 'package:fit_beat/app/data/model/schedule_activity_list_model.dart';
import 'package:fit_beat/app/data/model/user/block_user_model.dart';
import 'package:fit_beat/app/data/model/user/profile_model.dart';
import 'package:fit_beat/app/data/model/user/user_detail_entity.dart';
import 'package:fit_beat/app/data/model/user/user_follow.dart';
import 'package:fit_beat/app/data/model/water_progress_track.dart';
import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/schedule/calendar_view_response.dart';
import 'package:fit_beat/app/features/home/controllers/progress_controller.dart';
import 'package:fit_beat/app/utils/pref_user_data.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:meta/meta.dart';
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart';

class ApiRepository {
  final ApiClient apiClient;

  ApiRepository({@required this.apiClient}) : assert(apiClient != null);

  Future<LoginResponse> doLogin(
      bool isSocialLogin,
      String email,
      String password,
      String deviceType,
      String ip,
      String loginType,
      String appVersion,
      [String fullName,
      String socialId]) async {
    var requestBody = new Map<String, Object>();
    requestBody["is_social_login"] = isSocialLogin;
    requestBody["email_address"] = email;
    if (!isSocialLogin) {
      requestBody["password"] = password;
    } else {
      requestBody["full_name"] = fullName;
      requestBody["social_id"] = socialId;
    }
    requestBody["device_type"] = deviceType;
    requestBody["login_type"] = loginType;
    requestBody["app_version"] = appVersion;
    requestBody["ip_address"] = ip;
    // requestBody["device_info"] = countryCode;

    final response =
        await apiClient.post(ApiEndpoint.loginApi, body: requestBody);
    return LoginResponse.fromJson(response);
  }

  Future<SignUpResponse> doSignUp(
      bool isSocialLogin,
      String email,
      String password,
      String fullName,
      String phoneNo,
      String referralCode,
      String deviceType,
      String ip,
      String loginType,
      String appVersion,
      String countryCode) async {
    print("fname $fullName");
    print("email $email");
    print("referralCode $referralCode");
    print("phoneNo $phoneNo");
    print("password $password");
    var requestBody = new Map<String, Object>();
    requestBody["is_social_login"] = isSocialLogin;
    requestBody["email_address"] = email;
    requestBody["password"] = password;
    requestBody["full_name"] = fullName;
    requestBody["phone_number"] = phoneNo;
    requestBody["country_code"] = phoneNo;
    requestBody["referral_code"] = referralCode;
    requestBody["device_type"] = deviceType;
    requestBody["login_type"] = loginType;
    requestBody["app_version"] = appVersion;
    requestBody["ip_address"] = ip;
    // requestBody["device_info"] = countryCode;

    final response =
        await apiClient.post(ApiEndpoint.signUpApi, body: requestBody);
    return SignUpResponse.fromJson(response);
  }

  Future<ForgotPasswordResponse> doForgotPassword(String emailId) async {
    var requestBody = new Map<String, String>();
    requestBody["email_address"] = emailId;

    final response =
        await apiClient.post(ApiEndpoint.forgotPasswordApi, body: requestBody);
    return ForgotPasswordResponse.fromJson(response);
  }

  Future<ResendOtpResponse> doResendOtp(int userId) async {
    var requestBody = new Map<String, int>();
    requestBody["user_id"] = userId;

    final response =
        await apiClient.post(ApiEndpoint.resendCodeApi, body: requestBody);
    return ResendOtpResponse.fromJson(response);
  }

  Future<ResendOtpResponse> resetPassword(
      int userId, String passcode, String password) async {
    var requestBody = new Map<String, Object>();
    requestBody["user_id"] = userId;
    requestBody["passcode"] = passcode;
    requestBody["password"] = password;

    final response =
        await apiClient.put(ApiEndpoint.setPasswordApi, body: requestBody);
    return ResendOtpResponse.fromJson(response);
  }

  Future<ResendOtpResponse> doVerifyOtp(int userId, String passcode) async {
    var requestBody = new Map<String, Object>();
    requestBody["user_id"] = userId;
    requestBody["passcode"] = passcode;

    final response =
        await apiClient.post(ApiEndpoint.verifyCodeApi, body: requestBody);
    return ResendOtpResponse.fromJson(response);
  }

  Future<ResendOtpResponse> doLogout() async {
    var header = new Map<String, String>();
    print("token ${PrefData().getAuthToken()}");
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();
    final response =
        await apiClient.put(ApiEndpoint.logoutApi, headers: header);
    return ResendOtpResponse.fromJson(response);
  }

  Future<MasterTagEntity> getTags() async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();
    final response = await apiClient.get(ApiEndpoint.tagsApi, headers: header);
    return MasterTagEntity.fromMap(response);
  }

  Future<MediaUploadResponse> uploadMedia(
      List<File> mediaFiles, int mediaCategory) async {
    var header = new Map<String, String>();
    print("token ${PrefData().getAuthToken()}");

    if (PrefData().getAuthToken() != null) {
      header["Authorization"] = "Bearer " + PrefData().getAuthToken();
    }
    // var mediaData = await getMultipartFiles(mediaFiles);
    /* FormData formData = FormData.fromMap({
      'location': mediaCategory,
      'media_data': await getMultipartFiles(mediaFiles)
    });*/

    var formData = dio.FormData();
    formData.fields.add(MapEntry('location', mediaCategory.toString()));
    for (var file in mediaFiles) {
      var fileName = basename(file.path);
      String mimeType = mime(fileName);
      String mimee = mimeType.split('/')[0];
      String type = mimeType.split('/')[1];
      formData.files.add(
        MapEntry(
            "media_data",
            await dio.MultipartFile.fromFile(file.path,
                contentType: MediaType(mimee, type), filename: fileName)),
      );
    }
    final response = await apiClient.postMedia(ApiEndpoint.uploadMedia,
        headers: header, body: formData, uploadProgress: (double progress) {
      Get.find<ProgressController>().updateProgress(progress);
    });
    return MediaUploadResponse.fromJson(response);
  }

  Future<MediaUploadResponse> uploadCoachMedia(
      List<File> mediaFiles, int mediaCategory) async {
    var header = new Map<String, String>();
    print("token ${PrefData().getAuthToken()}");

    if (PrefData().getAuthToken() != null) {
      header["Authorization"] = "Bearer " + PrefData().getAuthToken();
    }
    var formData = dio.FormData();
    formData.fields.add(MapEntry('location', mediaCategory.toString()));
    for (var file in mediaFiles) {
      var fileName = basename(file.path);
      String mimeType = mime(fileName);
      String mimee = mimeType.split('/')[0];
      String type = mimeType.split('/')[1];
      formData.files.add(
        MapEntry(
            "media_data",
            await dio.MultipartFile.fromFile(file.path,
                contentType: MediaType(mimee, type), filename: fileName)),
      );
    }
    final response = await apiClient.postMedia(ApiEndpoint.uploadCoachMedia,
        headers: header, body: formData, uploadProgress: (double progress) {
      Get.find<ProgressController>().updateProgress(progress);
    });
    return MediaUploadResponse.fromJson(response);
  }

  Future<MediaUploadResponse> uploadSingleMedia(
      File mediaFile, int mediaCategory) async {
    var header = new Map<String, String>();
    print("token ${PrefData().getAuthToken()}");
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();
    // var mediaData = await getMultipartFiles(mediaFiles);
    String mimeType = mime(basename(mediaFile.path));
    String mimee = mimeType.split('/')[0];
    String type = mimeType.split('/')[1];

    dio.FormData formData = dio.FormData.fromMap({
      'location': mediaCategory.toString(),
      'media_data': await dio.MultipartFile.fromFile(mediaFile.path,
          contentType: MediaType(mimee, type),
          filename: basename(mediaFile.path))
    });

    final response = await apiClient.postMedia(ApiEndpoint.uploadMedia,
        headers: header, body: formData, uploadProgress: (double progress) {});
    return MediaUploadResponse.fromJson(response);
  }

  Future<List<dio.MultipartFile>> getMultipartFiles(
      List<File> mediaFiles) async {
    print("multi called");
    List<dio.MultipartFile> list = List();
    for (File file in mediaFiles) {
      String mimeType = mime(basename(file.path));
      String mimee = mimeType.split('/')[0];
      String type = mimeType.split('/')[1];
      print(basename(file.path));
      dio.MultipartFile data = await dio.MultipartFile.fromFile(file.path,
          contentType: MediaType(mimee, type), filename: basename(file.path));
      list.add(data);
    }
    return list;
  }

  Future<ResendOtpResponse> postDiscussion(
      List<MediaUrl> url, String title, String description, List<UserTag> tags,
      [int uniqueId, Feed feed]) async {
    var header = new Map<String, String>();
    print("token ${PrefData().getAuthToken()}");
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = new Map<String, Object>();
    if (feed != null) {
      body["user_discussion_id"] = feed.uniqueId;

      for (MediaUrl data in url) {
        data.userMediaId = feed.userMedia[0].userMediaId;
      }
    }

    body["title"] = title;
    body["descriptions"] = description;
    body["user_media"] = url;
    body["user_tags"] = tags;
    if (uniqueId != null) {
      body["parent_user_discussion_id"] = uniqueId;
    }

    print(jsonEncode(body));

    final response = feed == null
        ? await apiClient.post(
            ApiEndpoint.postDiscussionApi,
            headers: header,
            body: body,
          )
        : await apiClient.put(
            ApiEndpoint.postDiscussionApi,
            headers: header,
            body: jsonEncode(body),
          );

    return ResendOtpResponse.fromJson(response);
  }

  Future<ResendOtpResponse> postChallenge(
      List<MediaUrl> url, String title, String description, List<UserTag> tags,
      [int uniqueId, Feed feed]) async {
    var header = new Map<String, String>();
    print("token ${PrefData().getAuthToken()}");
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = new Map<String, Object>();

    if (feed != null) {
      body["user_challenge_id"] = feed.uniqueId;

      for (MediaUrl data in url) {
        data.userMediaId = feed.userMedia[0].userMediaId;
      }
    }

    body["title"] = title;
    body["descriptions"] = description;
    body["user_media"] = url;
    body["user_tags"] = tags;
    if (uniqueId != null) {
      body["parent_user_challenge_id"] = uniqueId;
    }

    final response = feed == null
        ? await apiClient.post(
            ApiEndpoint.postChallengeApi,
            headers: header,
            body: body,
          )
        : await apiClient.put(
            ApiEndpoint.postChallengeApi,
            headers: header,
            body: jsonEncode(body),
          );
    return ResendOtpResponse.fromJson(response);
  }

  Future<ResendOtpResponse> postTransformation(
      String beforeUrl,
      String afterUrl,
      String description,
      List<UserTag> tags,
      String lostKgs,
      String duration,
      Feed feed) async {
    var header = new Map<String, String>();
    print("token ${PrefData().getAuthToken()}");
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = new Map<String, Object>();
    if (feed != null) {
      body["user_transformation_id"] = feed.uniqueId;
    }
    body["descriptions"] = description;
    body["lost_kgs"] = double.parse(lostKgs);
    body["duration"] = double.parse(duration);
    body["user_tags"] = tags;
    body["user_media"] = {
      // "media_type": 1,
      "user_media_id": feed != null ? feed.userMedia[0].userMediaId : 0,

      "media_url": beforeUrl,
      "media_url2": afterUrl,
    };
    // body["user_transformation_id"] = 0;

    final response = feed == null
        ? await apiClient.post(
            ApiEndpoint.postTransformationApi,
            headers: header,
            body: body,
          )
        : await apiClient.put(
            ApiEndpoint.postTransformationApi,
            headers: header,
            body: jsonEncode(body),
          );
    return ResendOtpResponse.fromJson(response);
  }

  Future<ResendOtpResponse> postUpdate(
      List<MediaUrl> url, String description, List<UserTag> tags,
      [Feed feed]) async {
    var header = new Map<String, String>();
    print("token ${PrefData().getAuthToken()}");
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = new Map<String, Object>();
    if (feed != null) {
      body["user_update_id"] = feed.uniqueId;

      for (MediaUrl data in url) {
        data.userMediaId = feed.userMedia[0].userMediaId;
      }
    }
    body["descriptions"] = description;
    body["user_media"] = url;
    body["user_tags"] = tags;

    print(jsonEncode(body));
    final response = feed == null
        ? await apiClient.post(
            ApiEndpoint.postUpdateApi,
            headers: header,
            body: body,
          )
        : await apiClient.put(
            ApiEndpoint.postUpdateApi,
            headers: header,
            body: jsonEncode(body),
          );
    return ResendOtpResponse.fromJson(response);
  }

  Future<FeedResponse> getFeeds(int pageNo, int filterType, int pageLimit,
      {var userProfileId}) async {
    var body = new Map<String, Object>();
    body["PageRecord"] = pageLimit;
    body["PageNo"] = pageNo;
    body["filter"] = filterType;

    if (userProfileId != null) {
      body["user_profile_id"] = userProfileId;
    }

    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();
    final response =
        await apiClient.post(ApiEndpoint.feedApi, headers: header, body: body);
    return FeedResponse.fromJson(response);
  }

  Future<FeedResponse> getOtherFeeds(
      int pageNo, int pageLimit, int uniqueId, int filterType) async {
    var body = new Map<String, Object>();
    body["PageRecord"] = pageLimit;
    body["PageNo"] = pageNo;
    body["filter"] = filterType;
    body["unique_id"] = uniqueId;

    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();
    final response =
        await apiClient.post(ApiEndpoint.feedApi, headers: header, body: body);
    return FeedResponse.fromJson(response);
  }

  Future<MasterCuisineEntity> getCuisines() async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    final response = await apiClient.get(
      ApiEndpoint.recipeCuisinesApi,
      headers: header,
    );
    return MasterCuisineEntity.fromMap(response);
  }

  Future<MasterCategoryEntity> getCategories() async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    final response = await apiClient.get(
      ApiEndpoint.categoryTypeApi,
      headers: header,
    );
    return MasterCategoryEntity.fromMap(response);
  }

  ///fetch recipe list
  Future<FeedResponse> getRecipeFeeds(
      {int pageNo,
      var catFilter,
      var foodFilter,
      int pageLimit,
      String query}) async {
    var body;
    if (query == null || query.isEmpty) {
      body = {
        "PageRecord": pageLimit,
        "PageNo": pageNo,
        "cat_filter": catFilter,
        "food_filter": foodFilter
      };
    } else {
      body = {
        "search_data": query,
      };
    }

    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();
    final response = await apiClient.post(ApiEndpoint.recipeFeedApi,
        headers: header, body: body);
    return FeedResponse.fromJson(response);
  }

  ///fetch recipe detail page
  Future<DetailsResponse> getRecipeDetails({var id}) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var url = "${ApiEndpoint.recipeDetailApi}$id";

    final response = await apiClient.get(url, headers: header);
    return DetailsResponse.fromJson(response);
  }

  ///search data
  Future<FeedResponse> searchData({var query}) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = {
      "search_data": query,
    };

    final response = await apiClient.post(ApiEndpoint.searchApi,
        headers: header, body: body);
    return FeedResponse.fromJson(response);
  }

  ///like post
  Future<CommonResponse> likePost({var uniqueId, var type}) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = {
      "unique_id": uniqueId,
      "type": type,
    };

    final response = await apiClient.put(ApiEndpoint.likePostApi,
        headers: header, body: body);
    return CommonResponse.fromJson(response);
  }

  ///bookmark post
  Future<CommonResponse> bookmarkPost({var uniqueId, var type}) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = {
      "unique_id": uniqueId,
      "type": type,
    };

    final response = await apiClient.put(ApiEndpoint.bookMarkPostApi,
        headers: header, body: body);
    return CommonResponse.fromJson(response);
  }

  ///fetch detail page
  Future<DetailsResponse> getDetailsInfo({var uniqueId, var type}) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = {
      "unique_id": uniqueId,
      "type": type,
    };

    final response = await apiClient.post(ApiEndpoint.detailsApi,
        headers: header, body: body);
    return DetailsResponse.fromJson(response);
  }

  ///fetch comment list
  Future<CommentResponse> getCommentList(
      {var uniqueId, var type, var pageLimit, var pageNo}) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = {
      "PageRecord": pageLimit,
      "PageNo": pageNo,
      "unique_id": uniqueId,
      "type": type,
    };

    final response = await apiClient.post(ApiEndpoint.commentListApi,
        headers: header, body: body);
    return CommentResponse.fromJson(response);
  }

  ///add comment list
  Future<CommonResponse> addComment(
      {var uniqueId,
      var type,
      var description,
      var parentUserCommentId}) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = {"unique_id": uniqueId, "type": type};

    if (description != null) {
      body["comment_description"] = description;
    }

    if (parentUserCommentId != null) {
      body["parent_user_comment_id"] = parentUserCommentId;
    }

    final response = await apiClient.post(ApiEndpoint.addcommentApi,
        headers: header, body: body);
    return CommonResponse.fromJson(response);
  }

  ///like unlike comment
  Future<CommonResponse> likeComment({var userCommentId}) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = {
      "user_comment_id": userCommentId,
    };

    final response = await apiClient.put(ApiEndpoint.likecommentApi,
        headers: header, body: body);
    return CommonResponse.fromJson(response);
  }

  /// get profile info
  Future<ProfileModel> getUserProfileFromId({var profileId}) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = {
      "user_profile_id": profileId,
    };

    final response = await apiClient.post(ApiEndpoint.userProfileApi,
        headers: header, body: body);
    return ProfileModel.fromJson(response);
  }

  /// set follow unfollow
  Future<CommonResponse> followUnFollowUser(
      {var userProfileId, var isFollow}) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = {
      "user_profile_id": userProfileId,
      "is_follow": isFollow,
    };

    final response = await apiClient.put(ApiEndpoint.followUnFollowUserApi,
        headers: header, body: body);
    return CommonResponse.fromJson(response);
  }

  ///following list
  Future<UserFollowModel> getFollowingList(var userProfileId) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = {
      "user_profile_id": userProfileId,
    };

    final response = await apiClient.post(ApiEndpoint.followingListApi,
        headers: header, body: body);
    return UserFollowModel.fromJson(response);
  }

  ///follower list
  Future<UserFollowModel> getFollowerList(var userProfileId) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = {
      "user_profile_id": userProfileId,
    };

    final response = await apiClient.post(ApiEndpoint.followerListApi,
        headers: header, body: body);
    return UserFollowModel.fromJson(response);
  }

  /// report user
  Future<CommonResponse> reportUser(
      {var userProfileId, var reportTag, var description}) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = {
      "user_profile_id": userProfileId,
      "report_tag": reportTag,
      "description": description,
    };

    final response = await apiClient.post(ApiEndpoint.userReportApi,
        headers: header, body: body);
    return CommonResponse.fromJson(response);
  }

  /// report post
  Future<CommonResponse> reportPost({
    var uniqueId,
    var reportTag,
    var description,
    var type,
  }) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = {
      "unique_id": uniqueId,
      "report_tag": reportTag,
      "type": type,
      "description": description,
    };

    final response = await apiClient.post(ApiEndpoint.postReportApi,
        headers: header, body: body);
    return CommonResponse.fromJson(response);
  }

  /// block user
  Future<CommonResponse> blockUser({var userProfileId}) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = {
      "user_profile_id": userProfileId,
    };

    final response = await apiClient.post(ApiEndpoint.blockUserApi,
        headers: header, body: body);
    return CommonResponse.fromJson(response);
  }

  ///get my profile info
  Future<UserDetailEntity> getMyProfile() async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    final response =
        await apiClient.get(ApiEndpoint.myProfileApi, headers: header);
    return UserDetailEntity.fromMap(response);
  }

  ///bookmark data
  Future<FeedResponse> getBookMarkList({var pageRecord, var pageNo}) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = {
      "PageRecord": pageRecord,
      "PageNo": pageNo,
    };

    final response = await apiClient.post(ApiEndpoint.bookmarkPostApi,
        headers: header, body: body);
    return FeedResponse.fromJson(response);
  }

  ///block user list
  Future<BlockUserModel> getBlockUserList({var pageRecord, var pageNo}) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = {
      "PageRecord": pageRecord,
      "PageNo": pageNo,
    };

    final response = await apiClient.post(ApiEndpoint.blockUserListApi,
        headers: header, body: body);
    return BlockUserModel.fromJson(response);
  }

  /// un block user
  Future<CommonResponse> unBlockUser({var userProfileId}) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = {
      "user_block_id": userProfileId,
    };

    final response = await apiClient.put(ApiEndpoint.unBlockUserApi,
        headers: header, body: body);
    return CommonResponse.fromJson(response);
  }

  ///delete post
  Future<CommonResponse> deletePost({var uniqueId, var type}) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = {
      "unique_id": uniqueId,
      "type": type,
    };

    final response = await apiClient.put(ApiEndpoint.deletePostApi,
        headers: header, body: body);
    return CommonResponse.fromJson(response);
  }

  ///edit my profile
  Future<CommonResponse> editMyProfile(
      {var gender,
      var dateofbirth,
      var heightUnit,
      var height,
      var weightType,
      var weight,
      var foodPreference,
      var fitnessLevel,
      var userBrings,
      var userInterests,
      var bio,
      var phone_number,
      var country,
      var country_code,
      var profileUrl}) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = {};

    if (gender != null) {
      body["gender"] = gender;
    }
    if (dateofbirth != null) {
      body["date_of_birth"] = dateofbirth;
    }
    if (heightUnit != null) {
      body["height_unit"] = heightUnit;
    }
    if (height != null) {
      body["height"] = height;
    }
    if (weightType != null) {
      body["weight_type"] = weightType;
    }
    if (weight != null) {
      body["weight"] = weight;
    }
    if (foodPreference != null) {
      body["food_preference"] = foodPreference;
    }
    if (fitnessLevel != null) {
      body["fitness_level"] = fitnessLevel;
    }
    if (userBrings != null) {
      body["user_brings"] = userBrings;
    }
    if (userInterests != null) {
      body["user_interests"] = userInterests;
    }
    if (phone_number != null) {
      body["phone_number"] = phone_number;
    }
    if (bio != null) {
      body["bio"] = bio;
    }
    if (country != null) {
      body["country"] = country;
    }

    if (country_code != null) {
      body["country_code"] = country_code;
    }

    if (profileUrl != null) {
      body["profile_url"] = profileUrl;
    }

    final response = await apiClient.put(ApiEndpoint.editMyProfileApi,
        headers: header, body: body);
    return CommonResponse.fromJson(response);
  }

  ///get fitness category
  Future<FitnessCategoryModel> getFitnessCategory() async {
    final response = await apiClient.get(ApiEndpoint.fitnessCategoryApi);
    return FitnessCategoryModel.fromJson(response);
  }

  ///get coach list data
  Future<CoachListModel> getCoachList(
      {var pageRecord,
      var pageNo,
      var fitnessCategoryId,
      var gender,
      var experienceLevel,
      var userLanguages,
      var rating}) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = {
      "PageRecord": pageRecord,
      "PageNo": pageNo,
      "fitness_category_id": fitnessCategoryId,
      "gender": gender,
      "experience_level": experienceLevel,
      "user_languages": userLanguages,
      "rating": rating,
    };

    final response = await apiClient.post(ApiEndpoint.coachListApi,
        headers: header, body: body);
    return CoachListModel.fromJson(response);
  }

  /// get coach profile
  Future<CoachProfileInfoModel> getCoachProfile({var coachProfileId}) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    final response = await apiClient
        .get("${ApiEndpoint.coachProfileApi}/$coachProfileId", headers: header);
    return CoachProfileInfoModel.fromJson(response);
  }

  /// get Language list
  Future<LanguageModel> getLanguageList() async {
    /*var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();
*/
    final response =
        await apiClient.get(ApiEndpoint.languagesApi /*, headers: header*/);
    return LanguageModel.fromJson(response);
  }

  /// coach review list
  Future<CoachReviewModel> getCoachReview(
      {var pageRecord, var pageNo, var coachUserId}) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = {
      "PageRecord": pageRecord,
      "PageNo": pageNo,
      "coach_user_id": coachUserId,
    };

    final response = await apiClient.post(ApiEndpoint.coachReviewsApi,
        headers: header, body: body);
    return CoachReviewModel.fromJson(response);
  }

  ///give coach review
  Future<CommonResponse> giveCoachRating(
      {var review_content, var rating, var coachUserId}) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = {
      "review_content": review_content,
      "rating": rating,
      "coach_user_id": coachUserId,
    };

    final response = await apiClient.post(ApiEndpoint.giveCoachReviewsApi,
        headers: header, body: body);
    return CommonResponse.fromJson(response);
  }

  ///give coach review
  Future<CategoryPlanModel> getCategoryPlan(
      {var fitnessCategoryId, var coachUserId}) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = {
      "fitness_category_id": fitnessCategoryId,
      "coach_user_id": coachUserId,
    };

    final response = await apiClient.post(ApiEndpoint.getCategoryPlanApi,
        headers: header, body: body);
    return CategoryPlanModel.fromJson(response);
  }

  ///set User CoachEnrollment
  Future<CommonResponse> setUserCoachEnrollment({
    var fitnessCategoryId,
    var coachUserId,
    var isEnroll,
    var fitnessCategoryPlanId,
    var finalAmount,
    var requestNote,
  }) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = {
      "fitness_category_id": fitnessCategoryId,
      "coach_user_id": coachUserId,
      "is_enroll": isEnroll,
      "fitness_category_plan_id": fitnessCategoryPlanId,
      "final_amount": finalAmount,
      "request_note": requestNote,
    };

    final response = await apiClient.post(ApiEndpoint.setUserCoachEnrollmentApi,
        headers: header, body: body);
    return CommonResponse.fromJson(response);
  }

  ///register coach
  Future<CommonResponse> registerCoach(
      {var fullName,
      var gender,
      var dateOfBirth,
      var noOfExperience,
      var workExperience,
      var countryCode,
      var phoneNumber,
      var emailAddress,
      var profileUrl,
      var userCertificates,
      var fitnessCategory,
      var userLanguages,
      var country,
      var userInterestId}) async {
    var body = {
      "full_name": fullName,
      "gender": gender,
      "date_of_birth": dateOfBirth,
      "no_of_experience": noOfExperience,
      "work_experience": workExperience,
      "country_code": countryCode,
      "phone_number": phoneNumber,
      "email_address": emailAddress,
      "profile_url": profileUrl,
      "user_certificates": userCertificates,
      "fitness_category": fitnessCategory,
      "user_languages": userLanguages,
      "country": country,
      "user_interest_id": userInterestId,
    };

    final response =
        await apiClient.post(ApiEndpoint.coachRegister, body: body);
    return CommonResponse.fromJson(response);
  }

  /// set chat invite
  Future<CommonResponse> sendChatInvite(
      {var userProfileId, var message}) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = {
      "user_profile_id": userProfileId,
      "msg": message,
    };

    final response = await apiClient.post(ApiEndpoint.sendChatInvitation,
        headers: header, body: body);
    return CommonResponse.fromJson(response);
  }

  ///getExerciseMuscleType
  Future<ExerciseMuscleTypeModel> getExerciseMuscleType() async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    final response = await apiClient.get(ApiEndpoint.getExerciseMuscleTypeApi,
        headers: header);
    return ExerciseMuscleTypeModel.fromJson(response);
  }

  ///getExerciseList
  Future<ExerciseListModel> getExerciseList(
      {var pageRecord,
      var pageNo,
      var exerciseMuscleTypeId,
      var search}) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = {
      "PageRecord": pageRecord,
      "PageNo": pageNo,
      "exercise_muscle_type_id": exerciseMuscleTypeId,
      "search": search,
    };

    final response = await apiClient.post(ApiEndpoint.getExerciseDataApi,
        headers: header, body: body);
    return ExerciseListModel.fromJson(response);
  }

  ///addExercises
  Future<CommonResponse> addExercises(
      {var title,
      var exerciseMuscleTypeId,
      var duration,
      var exerciseVideo,
      var description,
      var rest_bw_sets,
      var rest_bw_exercises,
      var exercisesSpecifications}) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = {
      "title": title,
      "exercise_muscle_type_id": exerciseMuscleTypeId,
      "description": description,
      "exercise_video": exerciseVideo,
      "rest_bw_sets": rest_bw_sets,
      "rest_bw_exercises": rest_bw_exercises,
      "exercises_specifications": exercisesSpecifications
    };

    final response = await apiClient.put(ApiEndpoint.addExercisesApi,
        headers: header, body: jsonEncode(body));
    return CommonResponse.fromJson(response);
  }

  ///addNutritions
  Future<CommonResponse> addNutritions({
    var title,
    var foodType,
    var kcal,
    var masterCategoryTypeId,
    var quantity,
    var nutritionMedia,
    var nutritionCalories,
    var description,
  }) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = {
      "title": title,
      "food_type": foodType,
      "kcal": kcal,
      "master_category_type_id": masterCategoryTypeId,
      "quantity": quantity,
      "nutrition_media": nutritionMedia,
      "nutrition_calories": nutritionCalories,
      "description": description,
    };

    final response = await apiClient.put(ApiEndpoint.addNutritionsApi,
        headers: header, body: body);
    return CommonResponse.fromJson(response);
  }

  ///getNutritionData
  Future<NutritionListModel> getNutritionData(
      {var pageRecord,
      var pageNo,
      var foodType,
      var masterCategoryTypeId,
      var search}) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = {
      "PageRecord": pageRecord,
      "PageNo": pageNo,
      "food_type": foodType,
      "food_type": foodType,
      "master_category_type_id": masterCategoryTypeId,
      "search": search,
    };

    final response = await apiClient.post(ApiEndpoint.getNutritionDataApi,
        headers: header, body: body);
    return NutritionListModel.fromJson(response);
  }

  ///getScheduleActivityListForExercise
  Future<ScheduleActivityListModel> getScheduleActivityListForExercise(
      {var startDate, var endDate}) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = {
      "start_date": startDate,
      "end_date": endDate,
      "type": 2,
    };

    final response = await apiClient.post(ApiEndpoint.scheduleActivityApi,
        headers: header, body: body);
    return ScheduleActivityListModel.fromJson(response);
  }

  ///getScheduleActivityListForExercise
  Future<CommentResponse> updateSpecificationStatus(
      {var userScheduleActivitySpecificationId}) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = {
      "user_schedule_activity_specification_id":
          userScheduleActivitySpecificationId,
    };

    final response = await apiClient.put(ApiEndpoint.updateSpecification,
        headers: header, body: body);
    return CommentResponse.fromJson(response);
  }

  ///getScheduleActivityListForExercise
  Future<ScheduleActivityListModel> getScheduleActivityListForNutrition(
      {var startDate, var endDate}) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = {
      "start_date": startDate,
      "end_date": endDate,
      "type": 1,
    };

    final response = await apiClient.post(ApiEndpoint.scheduleActivityApi,
        headers: header, body: body);
    return ScheduleActivityListModel.fromJson(response);
  }

  ///addScheduleActivityForExercise
  Future<CommonResponse> addScheduleActivityForExercise(
      {var userScheduleId, var scheduleDate, var isKcal, var exercises}) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = {
      "user_schedule_id": userScheduleId,
      "schedule_date": scheduleDate,
      "is_kcal": isKcal,
      "nutritions": [],
      "exercises": exercises,
    };

    final response = await apiClient.put(ApiEndpoint.scheduleActivityApi,
        headers: header, body: jsonEncode(body));
    return CommonResponse.fromJson(response);
  }

  ///deleteScheduleActivityForExercise
  Future<CommonResponse> deleteScheduleActivity(
      {var activityType,
      var userScheduleId,
      var userScheduleActivityId}) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = {
      "activity_type": activityType,
      "user_schedule_id": userScheduleId,
    };

    final response = await apiClient.put(
        "${ApiEndpoint.scheduleActivityDeleteApi}/$userScheduleActivityId",
        headers: header,
        body: body);
    return CommonResponse.fromJson(response);
  }

  /// to start chat with new users
  Future<InviteNewChatResponse> getChatUsersList(int pageNo, int pageLimit,
      [String query]) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = new Map<String, Object>();
    body["PageRecord"] = pageLimit;
    body["PageNo"] = pageNo;
    body["search"] = query ?? "";

    final response = await apiClient.post(ApiEndpoint.newChatUsersList,
        headers: header, body: body);
    return InviteNewChatResponse.fromJson(response);
  }

  Future<ChatRequestResponse> getChatRequestReceivedList() async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    final response = await apiClient.get(
      ApiEndpoint.chatInvitationReceived,
      headers: header,
    );
    return ChatRequestResponse.fromJson(response);
  }

  Future<ChatRequestResponse> getChatRequestSentList() async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    final response = await apiClient.get(
      ApiEndpoint.chatInvitationSent,
      headers: header,
    );
    return ChatRequestResponse.fromJson(response);
  }

  ///addScheduleActivityForNutrition
  Future<CommonResponse> addScheduleActivityForNutrition(
      {var userScheduleId,
      var scheduleDate,
      var isKcal,
      var setKcal,
      var masterCategoryTypeId,
      var nutritions}) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    print("nut ${nutritions[0].masterCategoryId}");
    var body = {
      "user_schedule_id": userScheduleId,
      "schedule_date": scheduleDate,
      "is_kcal": isKcal,
      "set_kcal": setKcal,
      "nutritions": nutritions,
      "master_category_type_id": masterCategoryTypeId,
      "exercises": [],
    };

    final response = await apiClient.put(ApiEndpoint.scheduleActivityApi,
        headers: header, body: body);
    return CommonResponse.fromJson(response);
  }

  ///scheduleActivityComplete
  Future<CommonResponse> scheduleActivityComplete({
    var userScheduleId,
    var activityType,
    var isComplete,
    var userScheduleActivityId,
  }) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = {
      "user_schedule_id": userScheduleId,
      "activity_type": activityType,
      "is_complete": isComplete,
    };

    final response = await apiClient.put(
        "${ApiEndpoint.scheduleActivityCompleteApi}/$userScheduleActivityId",
        headers: header,
        body: body);
    return CommonResponse.fromJson(response);
  }

  /// to start chat with new users
  Future<MyChatResponse> getChatRoomsList(int pageNo, int pageLimit,
      [String query]) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = new Map<String, Object>();
    body["PageRecord"] = pageLimit;
    body["PageNo"] = pageNo;
    body["search"] = query ?? "";

    final response = await apiClient.post(ApiEndpoint.chatRoomsApi,
        headers: header, body: body);
    return MyChatResponse.fromJson(response);
  }

  /// set chat invite
  Future<CommonResponse> cancelChatInvite({var userProfileId}) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = {
      "user_chat_connection_id": userProfileId,
    };

    final response = await apiClient.put(ApiEndpoint.cancelChatInviteApi,
        headers: header, body: body);
    return CommonResponse.fromJson(response);
  }

  /// set chat invite
  Future<CommonResponse> acceptChatInvite({var userProfileId}) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = {
      "user_chat_connection_id": userProfileId,
    };

    final response = await apiClient.put(ApiEndpoint.acceptChatInviteApi,
        headers: header, body: body);
    return CommonResponse.fromJson(response);
  }

  /// scheduleActivitycalories
  Future<CommonResponse> scheduleActivityCalories(
      {var userScheduleId, var scheduleDate, var kCal}) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = {
      "user_schedule_id": userScheduleId,
      "schedule_date": scheduleDate,
      "set_kcal": kCal,
    };

    final response = await apiClient.put(
        ApiEndpoint.scheduleActivitycaloriesApi,
        headers: header,
        body: body);
    return CommonResponse.fromJson(response);
  }

  ///getScheduleActivityListForWater
  Future<ScheduleActivityListModel> getScheduleActivityForWater(
      {var startDate, var endDate}) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = {
      "start_date": startDate,
      "end_date": endDate,
      "type": 3,
    };

    final response = await apiClient.post(ApiEndpoint.scheduleActivityApi,
        headers: header, body: body);
    return ScheduleActivityListModel.fromJson(response);
  }

  ///updateScheduleActivityForWater
  Future<CommonResponse> updateScheduleActivityForWater(
      {var userScheduleId,
      var scheduleDate,
      var waterLevel,
      var reminderStartTime,
      var reminderTimeTime,
      var reminderSchedule}) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = {
      "user_schedule_id": userScheduleId ?? 0,
      "schedule_date": scheduleDate,
      "water_level": waterLevel,
      if (reminderStartTime != null) "reminder_start_time": reminderStartTime,
      if (reminderTimeTime != null) "reminder_time_time": reminderTimeTime,
      "reminder_schedule": reminderSchedule,
    };

    final response = await apiClient.put(ApiEndpoint.scheduleActivityWaterApi,
        headers: header, body: body);
    return CommonResponse.fromJson(response);
  }

  ///calorie calendar view
  Future<CalendarViewResponse> getCalenderData(int year, int month) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = {
      "year": year.toString(),
      "month": month.toString(),
    };

    final response = await apiClient.post(ApiEndpoint.calorieCalendarApi,
        headers: header, body: body);
    return CalendarViewResponse.fromJson(response);
  }

  /// chat data of a user
  Future<ChatResponse> getChatData(
      int pageNo, int pageLimit, int userProfileId) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = new Map<String, Object>();
    body["PageRecord"] = pageLimit;
    body["PageNo"] = pageNo;
    body["user_profile_id"] = userProfileId;

    final response = await apiClient.post(ApiEndpoint.chatDataApi,
        headers: header, body: body);
    return ChatResponse.fromJson(response);
  }

  Future<ChatResponse> sendChat(int userChatConnectionId, int userProfileId,
      int chatType, String content) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = new Map<String, Object>();
    body["user_chat_connection_id"] = userChatConnectionId;
    body["user_profile_id"] = userProfileId;
    body["chat_type"] = chatType;
    body["content"] = content;

    final response = await apiClient.post(ApiEndpoint.sendChatApi,
        headers: header, body: body);
    return ChatResponse.fromJson(response);
  }

  ///getCoachEnrollUserList
  Future<CoachEnrollUserResponse> getCoachEnrollUserList({
    var startDate,
    var endDate,
    var status,
    var pageRecord,
    var pageNo,
    var fitnessCategoryId,
    var fitnessCategoryPackageId,
  }) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = {
      "start_date": startDate,
      "end_date": endDate,
      "status": status,
      "PageRecord": pageRecord,
      "PageNo": pageNo,
      "fitness_category_id": fitnessCategoryId,
      "fitness_category_package_id": fitnessCategoryPackageId,
    };

    final response = await apiClient.post(ApiEndpoint.coachEnrollUserListApi,
        headers: header, body: body);
    return CoachEnrollUserResponse.fromJson(response);
  }

  Future<CalendarViewResponse> sendPostVideoViewEvent(
      int uniqueId, int mediaId) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = {
      "unique_id": uniqueId,
      "user_media_id": mediaId,
    };

    final response = await apiClient.post(ApiEndpoint.postViewViewApi,
        headers: header, body: body);
    return CalendarViewResponse.fromJson(response);
  }

  Future<ResendOtpResponse> changePassword(
      String oldPassword, String newPassword) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = {
      "old_password": oldPassword,
      "new_password": newPassword,
    };

    final response = await apiClient.put(ApiEndpoint.resetPasswordApi,
        headers: header, body: body);
    return ResendOtpResponse.fromJson(response);
  }

  Future<ResendOtpResponse> helpAndSupport(
      int helpId, String description) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = {
      "help_topic_id": helpId,
      "description": description,
    };

    final response = await apiClient.post(ApiEndpoint.helpSupportApi,
        headers: header, body: body);
    return ResendOtpResponse.fromJson(response);
  }

  ///delete account
  Future<CommonResponse> deleteAccount() async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();
    final response =
        await apiClient.delete(ApiEndpoint.deleteaccountApi, headers: header);
    return CommonResponse.fromJson(response);
  }

  ///deactivate Account
  Future<CommonResponse> deactivateAccount({var uniqueId, var type}) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();
    final response = await apiClient.delete(ApiEndpoint.deactivateaccountApi,
        headers: header);
    return CommonResponse.fromJson(response);
  }

  ///edit coach profile
  Future<CommonResponse> editCoachProfile(
      {var backgroundProfileUrl,
      var profileUrl,
      var gender,
      var dateOfBirth,
      var noOfExperience,
      var speciality,
      var userCertificates,
      var fitnessCategory,
      var userLanguages,
      var workExperience,
      var fullName,
      var country,
      var countryCode,
      var emailAddress}) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = {};
    if (backgroundProfileUrl != null) {
      body["background_profile_url"] = backgroundProfileUrl;
    }
    if (profileUrl != null) {
      body["profile_url"] = profileUrl;
    }
    if (gender != null) {
      body["gender"] = gender;
    }
    if (dateOfBirth != null) {
      body["date_of_birth"] = dateOfBirth;
    }
    if (noOfExperience != null) {
      body["no_of_experience"] = noOfExperience;
    }
    if (speciality != null) {
      body["speciality"] = speciality;
    }
    if (userCertificates != null) {
      body["user_certificates"] = userCertificates;
    }
    if (fitnessCategory != null) {
      body["fitness_category"] = fitnessCategory;
    }
    if (userLanguages != null) {
      body["user_languages"] = userLanguages;
    }
    if (workExperience != null) {
      body["work_experience"] = workExperience;
    }
    if (fullName != null) {
      body["full_name"] = fullName;
    }
    if (country != null) {
      body["country"] = country;
    }
    if (countryCode != null) {
      body["countryCode"] = countryCode;
    }
    if (emailAddress != null) {
      body["email_address"] = emailAddress;
    }

    final response = await apiClient.put(ApiEndpoint.editCoachProfileApi,
        headers: header, body: body);
    return CommonResponse.fromJson(response);
  }

  ///update qty
  Future<CommonResponse> updateQty(
      var quantity, var userScheduleActivityId) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = {
      "quantity": quantity,
      "user_schedule_activity_id": userScheduleActivityId,
    };

    final response =
        await apiClient.put(ApiEndpoint.updateQty, headers: header, body: body);
    return CommonResponse.fromJson(response);
  }

  Future<WaterProgressResponse> getWaterProgress({var startDate}) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = {
      "activity_date": startDate,
    };

    final response = await apiClient.post(ApiEndpoint.waterProgress,
        headers: header, body: body);
    return WaterProgressResponse.fromJson(response);
  }

  Future<WaterProgressResponse> updateWaterProgress(
      {var date, var waterLevel, var bodyWeight, var activityId}) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = {
      "prog_track_activity_id": activityId ?? "0",
      "activity_date": date.toString(),
      "water_level": waterLevel.toString(),
      "body_weight": bodyWeight.toString(),
    };

    final response = await apiClient.put(ApiEndpoint.waterProgress,
        headers: header, body: body);
    return WaterProgressResponse.fromJson(response);
  }

  Future<ProgressGraphResponse> getProgressGraph({
    var month,
    var year,
  }) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = {
      "month": month,
      "year": year,
    };

    final response = await apiClient.post(ApiEndpoint.progressGraphApi,
        headers: header, body: body);
    return ProgressGraphResponse.fromJson(response);
  }

  ///notification data
  Future<NotificationModel> notificationList(
      {var pageRecord, var pageNo}) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = {
      "PageRecord": pageRecord,
      "PageNo": pageNo,
    };

    final response = await apiClient.post(ApiEndpoint.notificationApi,
        headers: header, body: body);
    return NotificationModel.fromJson(response);
  }

  ///delete notification data
  Future<CommentResponse> deleteNotificationData(
      {var pageRecord, var pageNo}) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = {};

    final response = await apiClient.delete(ApiEndpoint.deletenotificationApi,
        headers: header, body: body);
    return CommentResponse.fromJson(response);
  }

  ///trained pople Data
  Future<CoachTrainedPeople> getCoachTrainedPeople(
      {var pageRecord, var pageNo, var search}) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = {"PageRecord": pageRecord, "PageNo": pageNo, "search": search};

    final response = await apiClient.post(ApiEndpoint.coachTrainedPople,
        headers: header, body: body);
    return CoachTrainedPeople.fromJson(response);
  }

  Future<CommonResponse> sendFcmToken(String fcmToken) async {
    var header = new Map<String, String>();

    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = {
      "user_auth_id": PrefData().getUserData().userAuthId,
      "device_token": fcmToken
    };

    final response =
        await apiClient.post(ApiEndpoint.fcmToken, headers: header, body: body);
    return CommonResponse.fromJson(response);
  }

  Future<CoachPaymentResponse> getCoachPayments({
    var month,
    var year,
  }) async {
    var header = new Map<String, String>();
    header["Authorization"] = "Bearer " + PrefData().getAuthToken();

    var body = {
      "month": month,
      "year": year,
    };

    final response = await apiClient.post(ApiEndpoint.coachPaymentApi,
        headers: header, body: body);
    return CoachPaymentResponse.fromJson(response);
  }
}
