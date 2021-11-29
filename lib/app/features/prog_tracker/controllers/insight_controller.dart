import 'package:fit_beat/app/common_widgets/fl_chart/src/chart/base/axis_chart/axis_chart_data.dart';
import 'package:fit_beat/app/data/model/progress_graph_response.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

class InsightController extends GetxController {
  final ApiRepository repository;

  InsightController({@required this.repository}) : assert(repository != null);

  // List<WaterModel> waterLevelList = [];

  bool isLoading = true;
  DateTime selectedDate;
  final requestDobFormat = new DateFormat("yyyy-MM-dd");
  bool isDateChange = false;

  var userScheduleId;
  List<Bodyweight> bodyWeight = [];
  List<Bodyweight> water = [];
  List<FlSpot> waterSpot = [];
  List<FlSpot> weightSpot = [];

  @override
  void onInit() {
    super.onInit();
    selectedDate = DateTime.now();
    getGraphData();
  }

  void getGraphData() async {
    try {
      isLoading = true;
      var response = await repository.getProgressGraph(
        month: selectedDate.month.toString(),
        year: selectedDate.year.toString(),
      );
      isLoading = false;

      if (response.status) {
        bodyWeight = response.data.bodyweight;
        water = response.data.water;
        setSpotData();
      }

      update();
    } catch (e) {
      print("water error : ${e.toString()}");
      isLoading = false;
    }
  }

  resetAll() {
    bodyWeight.clear();
    water.clear();
    waterSpot.clear();
    weightSpot.clear();
  }

  setCalenderDate(DateTime dateTime) async {
    selectedDate = dateTime;
    isDateChange = true;
    resetAll();
    update();
    try {
      var response = await repository.getProgressGraph(
        month: selectedDate.month.toString(),
        year: selectedDate.year.toString(),
      );
      isDateChange = false;
      if (response.status) {
        bodyWeight = response.data.bodyweight;
        water = response.data.water;
        setSpotData();
      }
      update();
    } catch (e) {
      print("water error : ${e.toString()}");

      isDateChange = false;
      update();
    }
  }

  setSpotData() {
    for (int i = 0; i < water.length; i++) {
      if (i == 0) {
        waterSpot.add(FlSpot(0.0, double.parse(water[i].avg)));
      } else {
        waterSpot.add(FlSpot(i.toDouble(), double.parse(water[i].avg)));
      }
    }

    /* weightSpot.add(FlSpot(0.0, double.parse("80") / 30));
    weightSpot.add(FlSpot(1.0, double.parse("95") / 30));
    weightSpot.add(FlSpot(2.0, double.parse("100") / 30));
    weightSpot.add(FlSpot(3.0, double.parse("120") / 30));*/

    for (int i = 0; i < bodyWeight.length; i++) {
      if (i == 0) {
        weightSpot.add(FlSpot(0.0, double.parse(bodyWeight[i].avg) / 30));
      } else {
        weightSpot
            .add(FlSpot(i.toDouble(), double.parse(bodyWeight[i].avg) / 30));
      }
    }
  }
}
