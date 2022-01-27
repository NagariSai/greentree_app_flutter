import 'package:fit_beat/app/common_widgets/common_webview.dart';
import 'package:fit_beat/app/common_widgets/image_view.dart';
import 'package:fit_beat/app/data/model/schedule_activity_list_model.dart';
import 'package:fit_beat/app/features/account_settings/view/account_settings.dart';
import 'package:fit_beat/app/features/add_post/views/add_post_page.dart';
import 'package:fit_beat/app/features/add_post/views/add_recipe_page.dart';
import 'package:fit_beat/app/features/add_post/views/add_transformation_page.dart';
import 'package:fit_beat/app/features/auth/change_password/bindings/change_password_binding.dart';
import 'package:fit_beat/app/features/auth/change_password/views/change_password_page.dart';
import 'package:fit_beat/app/features/auth/coach_login/bindings/coach_login_binding.dart';
import 'package:fit_beat/app/features/auth/coach_login/views/coach_login_page.dart';
import 'package:fit_beat/app/features/auth/coach_register/bindings/coach_register_binding.dart';
import 'package:fit_beat/app/features/auth/coach_register/bindings/coach_register_sucess_binding.dart';
import 'package:fit_beat/app/features/auth/coach_register/view/coach_register_page.dart';
import 'package:fit_beat/app/features/auth/coach_register/view/coach_register_success.dart';
import 'package:fit_beat/app/features/auth/forgot_password/bindings/forgot_password_binding.dart';
import 'package:fit_beat/app/features/auth/forgot_password/bindings/reset_password_binding.dart';
import 'package:fit_beat/app/features/auth/forgot_password/views/forgot_password_page.dart';
import 'package:fit_beat/app/features/auth/forgot_password/views/reset_password_page.dart';
import 'package:fit_beat/app/features/auth/login/bindings/login_binding.dart';
import 'package:fit_beat/app/features/auth/login/views/login_page.dart';
import 'package:fit_beat/app/features/auth/signup/bindings/signup_binding.dart';
import 'package:fit_beat/app/features/auth/signup/views/signup_page.dart';
import 'package:fit_beat/app/features/auth/verify_otp/bindings/verify_otp_binding.dart';
import 'package:fit_beat/app/features/auth/verify_otp/views/verify_otp_page.dart';
import 'package:fit_beat/app/features/blockUnblockUser/view/block_user_list.dart';
import 'package:fit_beat/app/features/bmr/view/calculator_bmr.dart';
import 'package:fit_beat/app/features/body_fat/view/calculator_body_fat.dart';
import 'package:fit_beat/app/features/bookmark/view/bookmark_page.dart';
import 'package:fit_beat/app/features/challenge/view/challenge_detail_page.dart';
import 'package:fit_beat/app/features/chat/views/chat_page.dart';
import 'package:fit_beat/app/features/chat/views/chat_request_page.dart';
import 'package:fit_beat/app/features/chat/views/chat_rooms_page.dart';
import 'package:fit_beat/app/features/chat/views/invite_user_to_chat_page.dart';
import 'package:fit_beat/app/features/coach/bindings/coach_enroll_request_bindings.dart';
import 'package:fit_beat/app/features/coach/bindings/coach_list_bindings.dart';
import 'package:fit_beat/app/features/coach/view/coach_detail_page.dart';
import 'package:fit_beat/app/features/coach/view/coach_filter_page.dart';
import 'package:fit_beat/app/features/coach/view/coach_list.dart';
import 'package:fit_beat/app/features/coach/view/coach_rating_page.dart';
import 'package:fit_beat/app/features/coach/view/coach_review_page.dart';
import 'package:fit_beat/app/features/coach/view/enroll_pay.dart';
import 'package:fit_beat/app/features/coach/view/enroll_proceed.dart';
import 'package:fit_beat/app/features/coach/view/enroll_user.dart';
import 'package:fit_beat/app/features/coach_add/view/coach_add_page.dart';
import 'package:fit_beat/app/features/coach_main/bindings/coach_main_binding.dart';
import 'package:fit_beat/app/features/coach_main/view/coach_main_page.dart';
import 'package:fit_beat/app/features/coach_payments/view/coach_payment_page.dart';
import 'package:fit_beat/app/features/coach_profile/view/coach_profile_page.dart';
import 'package:fit_beat/app/features/coach_trained_pople/bindings/coach_trained_people_binding.dart';
import 'package:fit_beat/app/features/coach_trained_pople/view/coach_trained_people.dart';
import 'package:fit_beat/app/features/comming_soon/view/comming_soon_page.dart';
import 'package:fit_beat/app/features/discussion/view/discussion_detail_page.dart';
import 'package:fit_beat/app/features/followers/view/follower.dart';
import 'package:fit_beat/app/features/following/view/following.dart';
import 'package:fit_beat/app/features/home/bindings/home_binding.dart';
import 'package:fit_beat/app/features/home/views/home_page.dart';
import 'package:fit_beat/app/features/home/views/other_feed_page.dart';
import 'package:fit_beat/app/features/home/views/social_share.dart';
import 'package:fit_beat/app/features/intro/views/intro_page.dart';
import 'package:fit_beat/app/features/kcal_cal/view/calculator_kcal.dart';
import 'package:fit_beat/app/features/main/bindings/main_binding.dart';
import 'package:fit_beat/app/features/main/views/main_page.dart';
import 'package:fit_beat/app/features/menu/views/community_page.dart';
import 'package:fit_beat/app/features/menu/views/help_support_page.dart';
import 'package:fit_beat/app/features/menu/views/insta_details.dart';
import 'package:fit_beat/app/features/menu/views/water_reminder.dart';
import 'package:fit_beat/app/features/my_plan_coach/my_plan_coach.dart';
import 'package:fit_beat/app/features/my_plan_coach/my_plan_coach_details.dart';
import 'package:fit_beat/app/features/my_plan_coach/switch_coach.dart';
import 'package:fit_beat/app/features/my_profile/bindings/my_profile_binding.dart';
import 'package:fit_beat/app/features/my_profile/view/my_profile.dart';
import 'package:fit_beat/app/features/notification/view/notification_page.dart';
import 'package:fit_beat/app/features/post_update/view/post_update_detail_page.dart';
import 'package:fit_beat/app/features/prog_tracker/views/progress_tracker_page.dart';
import 'package:fit_beat/app/features/recipe/views/recipe_detail_page.dart';
import 'package:fit_beat/app/features/refer_earn/refer_earn.dart';
import 'package:fit_beat/app/features/report_user/view/report_user_page.dart';
import 'package:fit_beat/app/features/search/view/search_details.dart';
import 'package:fit_beat/app/features/search/view/search_page.dart';
import 'package:fit_beat/app/features/todaySchedule/bindings/nutrition_schedule_bindings.dart';
import 'package:fit_beat/app/features/todaySchedule/view/add_exercise.dart';
import 'package:fit_beat/app/features/todaySchedule/view/add_food_nutrition_page.dart';
import 'package:fit_beat/app/features/todaySchedule/view/calorie_calendar_page.dart';
import 'package:fit_beat/app/features/todaySchedule/view/nutrition_food_schedule.dart';
import 'package:fit_beat/app/features/todaySchedule/view/select_exercise.dart';
import 'package:fit_beat/app/features/todaySchedule/view/select_food.dart';
import 'package:fit_beat/app/features/todaySchedule/view/today_schdule.dart';
import 'package:fit_beat/app/features/transformation/view/transformation_detail_page.dart';
import 'package:fit_beat/app/features/user_detail/bindings/user_detail_binding.dart';
import 'package:fit_beat/app/features/user_detail/views/dob_selection_view.dart';
import 'package:fit_beat/app/features/user_detail/views/fitness_level_selection_view.dart';
import 'package:fit_beat/app/features/user_detail/views/food_pref_selection_view.dart';
import 'package:fit_beat/app/features/user_detail/views/gender_selection_view.dart';
import 'package:fit_beat/app/features/user_detail/views/height_selection_view.dart';
import 'package:fit_beat/app/features/user_detail/views/interest_selection_view.dart';
import 'package:fit_beat/app/features/user_detail/views/motive_selection_view.dart';
import 'package:fit_beat/app/features/user_detail/views/user_detail_page.dart';
import 'package:fit_beat/app/features/user_detail/views/weight_selection_view.dart';
import 'package:fit_beat/app/features/user_profile/view/user_profile_page.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.intro;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.ADD_RECIPE,
      page: () => AddRecipePage(),
    ),
    GetPage(
      name: Routes.USER_DETAIL,
      page: () => UserDetailPage(),
      binding: UserDetailBinding(),
    ),
    GetPage(
      name: Routes.GENDER_SELECTION,
      page: () => GenderSelectionView(),
      binding: UserDetailBinding(),
    ),
    GetPage(
      name: Routes.DOB_SELECTION,
      page: () => DobSelectionView(),
      binding: UserDetailBinding(),
    ),
    GetPage(
      name: Routes.HEIGHT_SELECTION,
      page: () => HeightSelectionView(),
      binding: UserDetailBinding(),
    ),
    GetPage(
      name: Routes.WEIGHT_SELECTION,
      page: () => WeightSelectionView(),
      binding: UserDetailBinding(),
    ),
    GetPage(
      name: Routes.MOTIVE_SELECTION,
      page: () => MotiveSelectionView(),
      binding: UserDetailBinding(),
    ),
    GetPage(
      name: Routes.FOOD_PREF_SELECTION,
      page: () => FoodPrefSelectionView(),
      binding: UserDetailBinding(),
    ),
    GetPage(
      name: Routes.FITNESS_LEVEL_SELECTION,
      page: () => FitnessLevelSelectionView(),
      binding: UserDetailBinding(),
    ),
    GetPage(
      name: Routes.INTEREST_SELECTION,
      page: () => InterestSelectionView(),
      binding: UserDetailBinding(),
    ),
    GetPage(
      name: Routes.login,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.signup,
      page: () => SignUpPage(),
      binding: SignUpBinding(),
    ),
    GetPage(
        name: Routes.forgotPassword,
        page: () => ForgotPasswordPage(),
        binding: ForgotPasswordBinding()),
    GetPage(
      name: Routes.resetPassword,
      page: () => ResetPasswordPage(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
        name: Routes.verifyOtp,
        page: () => VerifyOtpPage(),
        binding: VerifyOtpBinding()),
    GetPage(
      name: Routes.intro,
      page: () => IntroPage(),
    ),
    GetPage(
      name: Routes.main,
      page: () => MainPage(),
      binding: MainBinding(),
    ),
    GetPage(
      name: Routes.addPost,
      page: () => AddPostPage(),
    ),
    GetPage(
      name: Routes.addTransformationPost,
      page: () => AddTransformationPage(),
    ),
    GetPage(
        name: Routes.myProfile,
        page: () => MyProfilePage(),
        binding: MyProfileBinding()),
    GetPage(
      name: Routes.userProfile,
      page: () => UserProfilePage(),
    ),
    GetPage(
      name: Routes.follower,
      page: () => FollowerPage(),
    ),
    GetPage(
      name: Routes.following,
      page: () => FollowingPage(),
    ),
    GetPage(
      name: Routes.report_user,
      page: () => ReportUserPage(),
    ),
    GetPage(
      name: Routes.receipe_detail_page,
      page: () => RecipeDetailPage(),
    ),
    GetPage(
      name: Routes.challenge_detail_page,
      page: () => ChallengeDetailPage(),
    ),
    GetPage(
      name: Routes.post_update_detail_page,
      page: () => PostUpdateDetailPage(),
    ),
    GetPage(
      name: Routes.discussion_detail_page,
      page: () => DiscussionDetailPage(),
    ),
    GetPage(
      name: Routes.transformation_detail_page,
      page: () => TransformationDetailPage(),
    ),
    GetPage(
      name: Routes.chatRoomsPage,
      page: () => ChatRoomsPage(),
    ),
    GetPage(
      name: Routes.chatPage,
      page: () => ChatPage(),
    ),
    GetPage(
      name: Routes.searchPage,
      page: () => SearchPage(),
    ),

    GetPage(
      name: Routes.searchDetailsPage,
      page: () => SearchDetailsPage(),
    ),
    GetPage(
      name: Routes.bookmarkPage,
      page: () => BookmarkPage(),
    ),
    GetPage(
      name: Routes.blockUserListPage,
      page: () => BlockUserListPage(),
    ),
    GetPage(
      name: Routes.otherFeedPage,
      page: () => OtherFeedPage(),
    ),
    GetPage(
      name: Routes.coachLoginPage,
      page: () => CoachLoginPage(),
      binding: CoachLoginBinding(),
    ),
    GetPage(
      name: Routes.coachRegisterPage,
      page: () => CoachRegisterPage(),
      binding: CoachRegisterBinding(),
    ),
    GetPage(
      name: Routes.coachListUserPage,
      page: () => CoachList(),
      binding: CoachListBinding(),
    ),
    GetPage(
      name: Routes.coachFilterUserPage,
      page: () => CoachFilterPage(),
    ),
    GetPage(
      name: Routes.coachDetailPage,
      page: () => CoachDetailPage(),
      binding: CoachListBinding(),
    ),
    GetPage(
        name: Routes.userEnrollPage,
        page: () => EnrollUser(),
        binding: CoachEnrollRequestBinding()),
    GetPage(
        name: Routes.userEnrollProccedPage,
        page: () => EnrollProceed(),
        binding: CoachEnrollRequestBinding()),
    GetPage(
        name: Routes.userEnrollPayPage,
        page: () => EnrollPay(),
        binding: CoachEnrollRequestBinding()),
    GetPage(
      name: Routes.userCoachRatingPage,
      page: () => CoachRatingPage(),
    ),
    GetPage(
      name: Routes.userCoachReviewPage,
      page: () => CoachReviewPage(),
    ),
    GetPage(
      name: Routes.todaySchedulePage,
      page: () => TodaySchedulePage(),
    ),
    GetPage(
      name: Routes.selectExercisePage,
      page: () => SelectExercise(),
    ),
    GetPage(
      name: Routes.addExercisePage,
      page: () => AddExercise(),
    ),
    GetPage(
      name: Routes.addFoodNutritionPage,
      page: () => AddFoodNutritionPage(),
    ),
    GetPage(
      name: Routes.selectFoodPage,
      page: () => SelectFood(),
    ),

    GetPage(
      name: Routes.selectFoodSchedulePage,
      page: () => NutritionFoodSchedulePage(),
      binding: NutritionScheduleBinding(),
    ),

    GetPage(
      name: Routes.calorieCalendarPage,
      page: () => CalorieCalendarPage(),

    ),
    GetPage(
      name: Routes.calBMRPage,
      page: () => CalculatorBMRPage(),
    ),
    GetPage(
      name: Routes.calBodyFatPage,
      page: () => CalculatorBodyFatPage(),
    ),
    GetPage(
      name: Routes.inviteUserToChatPage,
      page: () => InviteUserToChatPage(),
    ),
    GetPage(
      name: Routes.chatRequestPage,
      page: () => ChatRequestPage(),
    ),
    GetPage(
      name: Routes.myPlanCoachPage,
      page: () => MyPlanCoach(),
    ),
    GetPage(
      name: Routes.myPlanDetailsPage,
      page: () => MyPlanCoachDetailPage(),
    ),
    GetPage(
      name: Routes.switchAccountPage,
      page: () => SwitchCoachPage(),
    ),
    GetPage(
      name: Routes.waterReminderPage,
      page: () => WaterReminder(),
    ),
    GetPage(
        name: Routes.coachMain,
        page: () => CoachMainPage(),
        binding: CoachMainBinding()),
    GetPage(
      name: Routes.coachAddPage,
      page: () => CoachAddPage(),
    ),
    GetPage(
      name: Routes.changePasswordPage,
      page: () => ChangePasswordPage(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: Routes.communityPage,
      page: () => CommunityPage(),
    ),
    GetPage(
      name: Routes.comingSoonPage,
      page: () => ComingSoonPage(),
    ),
    GetPage(
      name: Routes.coachProfilePage,
      page: () => CoachProfilePage(),
    ),
    GetPage(
      name: Routes.coachPaymentPage,
      page: () => CoachPaymentPage(),
    ),
    GetPage(
      name: Routes.referEarn,
      page: () => ReferEarn(),
    ),
    GetPage(
      name: Routes.commonWebPage,
      page: () => CommonWebView(),
    ),
    GetPage(
      name: Routes.imagePage,
      page: () => ImageView(),
    ),
    GetPage(
      name: Routes.supportPage,
      page: () => HelpSupportPage(),
    ),
    GetPage(
      name: Routes.accountSettingPage,
      page: () => AccountSettings(),
    ),
    GetPage(
      name: Routes.notificationPage,
      page: () => NotificationPage(),
    ),
    GetPage(
      name: Routes.kKalPage,
      page: () => CalculatorKKalPage(),
    ),
    GetPage(
      name: Routes.progressTrackPage,
      page: () => ProgressTrackerPage(),
    ),
    GetPage(
        name: Routes.coachTrainedPepople,
        page: () => CoachTrainedPeoplePage(),
        binding: CoachTrainedPeopleBinding()),
    GetPage(
        name: Routes.coachRegisterSuccess,
        page: () => CoachRegisterSuccessPage(),
        binding: CoachRegisterSuccessBinding()),

    GetPage(
      name: Routes.ssharePage,
      page: () => SocialShare(),
    ),
    GetPage(
      name: Routes.instaDetailPage,
      page: () => InstaDetailsScreen(),
    ),
  ];
}
