import 'dart:convert';

import 'package:fit_beat/app/constant/api_endpoint.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:meta/meta.dart';

class ServingsController extends GetxController {
  final ApiRepository repository;

  ServingsController({@required this.repository}) : assert(repository != null);


  var kCal = 0;
  var kCalIntake = 0;
  var totalProteins = 0.0;
  var totalCarbs = 0.0;
  var totalFats = 0.0;

  int categoryType;


  var userScheduleId;
  bool isLoading = true;

  int currentIndex = 0;

  @override
  void onInit() {
    super.onInit();
    _fetchServings();
  }


  void _fetchServings() async {
    var header = new Map<String, String>();
    var body = new Map<String, Object>();
    body["food_id"] = "4881229";
    header["secret"] = "c78facccdc8f4aa6bb0ffef7ff0d7d42";
    header["token"] = "e7f48371c00549f1ab1248c09071f167";
    final response =
    await repository.apiClient.post(
      ApiEndpoint.getServings,
      headers: header,
      body: body,
    );
    var data = jsonDecode(response.body);
    print(data["code"]);
    print(data["message"]);
    if (data["code"] == 200) {
      List jsonResponse = data["serving"] as List;
      // List jsonResponse = json.decode(response.body);
      print(jsonResponse);


    }
  }
  /*void getNutritionData() async {
    try {
      kCal = 0;
      kCalIntake = 0;
      asNutritions = [];
      nutritions = [];
      isLoading = true;
      var response = await repository.getScheduleActivityListForNutrition(
          startDate: selectedDate, endDate: selectedDate);
      isLoading = false;
      if (response.status &&
          response.data != null &&
          response.data.length > 0) {
        userScheduleId = response.data[0].userScheduleId;
        asNutritions = response.data[0].asNutritions;
        kCalIntake = response.data[0].completeKcal ?? 0;
        kCal = response.data[0].setKcal ?? 0;
        totalProteins = response.data[0].protein ?? 0;
        totalCarbs = response.data[0].carbs ?? 0;
        totalFats = response.data[0].fat ?? 0;

      }
      print("userScheduleId 1: ${userScheduleId}");
      update();
    } catch (e) {
      isLoading = false;

      update();
      print("mayday ${e.toString()}");
    }
  }*/


}