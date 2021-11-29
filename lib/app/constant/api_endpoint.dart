class ApiEndpoint {
  //static final String BASE_URL = "http://1ba5-116-73-195-33.ngrok.io/";

  static final String BASE_URL = "http://3.120.65.206:8080/";

  static final String loginApi = "${BASE_URL}app/v1/login";
  static final String forgotPasswordApi = "${BASE_URL}app/v1/forget";
  static final String resendCodeApi = "${BASE_URL}app/v1/resetotp";
  static final String setPasswordApi = "${BASE_URL}app/v1/setpassword";
  static final String signUpApi = "${BASE_URL}app/v1/register";
  static final String verifyCodeApi = "${BASE_URL}app/v1/varifypasscode";
  static final String logoutApi = "${BASE_URL}app/v1/logout";
  static final String tagsApi = "${BASE_URL}app/v1/gettagsdata";
  static final String uploadMedia = "${BASE_URL}app/v1/postmedia";
  static final String uploadCoachMedia = "${BASE_URL}app/v1/postcoachmedia";
  static final String postDiscussionApi = "${BASE_URL}app/v1/discussionsdata";
  static final String postUpdateApi = "${BASE_URL}app/v1/updatesdata";
  static final String postChallengeApi = "${BASE_URL}app/v1/challengesdata";
  static final String postTransformationApi ="${BASE_URL}app/v1/transformationsdata";
  static final String feedApi = "${BASE_URL}app/v1/getHomeData";
  static final String recipeCuisinesApi = "${BASE_URL}app/v1/getcuisinesdata";
  static final String categoryTypeApi = "${BASE_URL}app/v1/getcategorytypedata";

  static final String recipeFeedApi = "${BASE_URL}app/v1/getRecipesData";
  static final String recipeDetailApi = "${BASE_URL}app/v1/getRecipesDetails/";
  static final String searchApi = "${BASE_URL}app/v1/searchDataResult/";
  static final String likePostApi = "${BASE_URL}app/v1/postLikeData/";
  static final String bookMarkPostApi = "${BASE_URL}app/v1/postBookmarkData/";
  static final String detailsApi = "${BASE_URL}app/v1/getPostDetails/";
  static final String commentListApi = "${BASE_URL}app/v1/postCommentData/";
  static final String addcommentApi = "${BASE_URL}app/v1/postComment";
  static final String likecommentApi = "${BASE_URL}app/v1/postCommentLike";
  static final String userProfileApi = "${BASE_URL}app/v1/userProfile";
  static final String followUnFollowUserApi ="${BASE_URL}app/v1/userFollowStatus";
  static final String followingListApi = "${BASE_URL}app/v1/userFollowingList";
  static final String followerListApi = "${BASE_URL}app/v1/userFollowersList";
  static final String userReportApi = "${BASE_URL}app/v1/userProfileReport";
  static final String blockUserApi = "${BASE_URL}app/v1/userProfileBlock";
  static final String myProfileApi = "${BASE_URL}app/v1/getuser";
  static final String bookmarkPostApi = "${BASE_URL}app/v1/userBookmarkPost";
  static final String blockUserListApi = "${BASE_URL}app/v1/blockUserList";
  static final String unBlockUserApi = "${BASE_URL}app/v1/unblockUser";
  static final String postReportApi = "${BASE_URL}app/v1/userPostReport";
  static final String deletePostApi = "${BASE_URL}app/v1/deletePost";
  static final String editMyProfileApi = "${BASE_URL}app/v1/updatemyprofile";
  static final String editCoachProfileApi = "${BASE_URL}app/v1/coachProfile";
  static final String fitnessCategoryApi = "${BASE_URL}app/v1/getfitnesscategory";
  static final String coachListApi = "${BASE_URL}app/v1/getfitnesscategorycoach";

  static final String coachProfileApi = "${BASE_URL}app/v1/coachProfile";
  static final String languagesApi = "${BASE_URL}app/v1/getlanguages";
  static final String coachReviewsApi = "${BASE_URL}app/v1/coachReviews";
  static final String giveCoachReviewsApi = "${BASE_URL}app/v1/givecoachreview";
  static final String getCategoryPlanApi = "${BASE_URL}app/v1/categoryPlan";
  static final String setUserCoachEnrollmentApi ="${BASE_URL}app/v1/userCoachEnrollment";
  static final String coachRegister = "${BASE_URL}app/v1/coachregister";
  static final String sendChatInvitation = "${BASE_URL}app/v1/SendChatInvitation";
  static final String newChatUsersList = "${BASE_URL}app/v1/ChatUserList";
  static final String chatInvitationReceived ="${BASE_URL}app/v1/ChatInvitationReceived";
  static final String chatInvitationSent = "${BASE_URL}app/v1/ChatInvitationSent";

  static final String getExerciseMuscleTypeApi ="${BASE_URL}app/v1/getExerciseMuscleType";
  static final String getExerciseDataApi = "${BASE_URL}app/v1/getExerciseData";
  static final String addExercisesApi = "${BASE_URL}app/v1/exercises";
  static final String addNutritionsApi = "${BASE_URL}app/v1/nutritions";
  static final String getNutritionDataApi = "${BASE_URL}app/v1/getNutritionData";
  static final String scheduleActivityApi = "${BASE_URL}app/v1/scheduleActivity";
  static final String scheduleActivityDeleteApi ="${BASE_URL}app/v1/scheduleActivityDelete";
  static final String scheduleActivityCompleteApi ="${BASE_URL}app/v1/scheduleActivityComplete";
  static final String cancelChatInviteApi ="${BASE_URL}app/v1/CancelSentRequest";
  static final String acceptChatInviteApi = "${BASE_URL}app/v1/AcceptSentRequest";
  static final String chatRoomsApi = "${BASE_URL}app/v1/MyChatUser";
  static final String scheduleActivitycaloriesApi = "${BASE_URL}app/v1/scheduleActivitycalories";
  static final String scheduleActivityWaterApi = "${BASE_URL}app/v1/scheduleActivitywater";
  static final String calorieCalendarApi = "${BASE_URL}app/v1/userCalendarView";
  static final String chatDataApi = "${BASE_URL}app/v1/UserChatMessantList";
  static final String sendChatApi = "${BASE_URL}app/v1/SentChatMessant";

  static final String coachEnrollUserListApi = "${BASE_URL}app/v1/coachEnrollUserList";
  static final String postViewViewApi = "${BASE_URL}app/v1/postMediaView";
  static final String resetPasswordApi = "${BASE_URL}app/v1/resetpassword";
  static final String privacyApi = "${BASE_URL}app/v1/privacypolicy";
  static final String termsApi = "${BASE_URL}app/v1/termsconditions";
  static final String helpSupportApi = "${BASE_URL}app/v1/hrlpsupport";

  static final String deleteaccountApi = "${BASE_URL}app/v1/deleteaccount";
  static final String deactivateaccountApi = "${BASE_URL}app/v1/deactivateaccount";

  static final String updateQty = "${BASE_URL}app/v1/scheduleActivityQty";
  static final String waterProgress = "${BASE_URL}app/v1/progactivitytrack";
  static final String progressGraphApi = "${BASE_URL}app/v1/bodtweightprogtrack";
  static final String notificationApi = "${BASE_URL}app/v1/usernotificationlist/";
  static final String deletenotificationApi ="${BASE_URL}app/v1/clearusernotificationlist";
  static final String coachTrainedPople = "${BASE_URL}app/v1/coachTrainedPeople";

  static final String coachPaymentApi = "${BASE_URL}app/v1/coachPaymentData";

  static final String updateSpecification = "${BASE_URL}app/v1/scheduleActivitySpecifications";

  static final String fcmToken = "${BASE_URL}app/v1/updatefcmtoken";

  static final String countryApi = "http://ip-api.com/json";

  static final String getServings = "http://fitness-api.nsdcare.com/getServings";
}

enum ViewState { LOADING, SUCCESS, ERROR }
