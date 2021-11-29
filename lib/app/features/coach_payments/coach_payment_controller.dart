import 'package:fit_beat/app/common_widgets/fl_chart/src/chart/base/axis_chart/axis_chart_data.dart';
import 'package:fit_beat/app/data/model/coach_payment_resoponse.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

class CoachPaymentController extends GetxController {
  final ApiRepository repository;

  CoachPaymentController({@required this.repository})
      : assert(repository != null);

  // List<WaterModel> waterLevelList = [];
  TextEditingController searchController = TextEditingController();

  bool isLoading = true;
  DateTime selectedDate;
  final requestDobFormat = new DateFormat("yyyy-MM-dd");
  bool isDateChange = false;

  var userScheduleId;
  List<BarDatum> paymentGraph = [];
  List<FlSpot> paymentSpot = [];
  List<RawDatum> userList = [];

  String totalAmount = "";
  @override
  void onInit() {
    super.onInit();
    selectedDate = DateTime.now();
    getGraphData();
  }

  void getGraphData() async {
    try {
      isLoading = true;
      var response = await repository.getCoachPayments(
        month: selectedDate.month.toString(),
        year: selectedDate.year.toString(),
      );
      isLoading = false;

      if (response.status) {
        paymentGraph = response.data.barData;
        userList = response.data.rawData;
        setSpotData();
      }

      update();
    } catch (e) {
      print("water error : ${e.toString()}");
      isLoading = false;
    }
  }

  resetAll() {
    paymentGraph.clear();
    paymentSpot.clear();
    userList.clear();
    totalAmount = "";
  }

  setCalenderDate(DateTime dateTime) async {
    print("month ${dateTime.month}");
    selectedDate = dateTime;
    isDateChange = true;
    resetAll();
    update();
    try {
      var response = await repository.getCoachPayments(
        month: selectedDate.month.toString(),
        year: selectedDate.year.toString(),
      );
      isDateChange = false;
      if (response.status) {
        paymentGraph = response.data.barData;
        userList = response.data.rawData;
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
    for (int i = 0; i < paymentGraph.length; i++) {
      if (i == 0) {
        paymentSpot.add(FlSpot(0.0,
            double.parse(paymentGraph[i].totalPackagePrice.toString()) / 30));
      } else {
        paymentSpot.add(FlSpot(i.toDouble(),
            double.parse(paymentGraph[i].totalPackagePrice.toString()) / 30));
      }
    }

    var amount = 0;
    for (RawDatum data in userList) {
      amount = amount + data.packagePrice;
    }
    totalAmount = amount.toString();
  }
}
