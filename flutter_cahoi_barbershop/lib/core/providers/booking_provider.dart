import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/apis/category_service_api.dart';
import 'package:flutter_cahoi_barbershop/core/apis/db_service_api.dart';
import 'package:flutter_cahoi_barbershop/core/apis/employee_api.dart';
import 'package:flutter_cahoi_barbershop/core/models/category_service/category_service.dart';
import 'package:flutter_cahoi_barbershop/core/models/service_cut/service_cut.dart';
import 'package:flutter_cahoi_barbershop/core/models/stylist/stylist.dart';
import 'package:flutter_cahoi_barbershop/core/models/workplace/workplace.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BookingProvider extends ChangeNotifier {
  late GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final notesController = TextEditingController();
  final _dbServiceApi = locator<DBServiceAPI>();
  final _categoryServiceApi = locator<CategoryServiceAPI>();
  final _employeeApi = locator<EmployeeAPI>();

  StepBooking currentStep = StepBooking.selectBarbershop;

  int selectedStylist = 0;
  int currentIndexTime = 0;
  bool isAdvice = true;
  bool isTakeAPhoto = true;
  bool isDefaultStylist = true;
  bool _disposed = false;
  DateTime selectedDate = DateTime.now();
  DateTime selectedTime = timeStart;
  Workplace? workplace;
  String notes = '';
  int totalDuration = 30;

  List<CategoryService> categoryServices = [];
  List<ServiceCut> selectedServices = [];
  List<Stylist>? stylists = [];

  BookingProvider() {
    _disposed = false;
  }

  changeDefaultStylist() {
    if (!isDefaultStylist) {
      isDefaultStylist = !isDefaultStylist;
    }
    notifyListeners();
  }

  changeCategoryServices() async {
    final response = await _categoryServiceApi.getAll();

    if (response != null) {
      categoryServices =
          response.map((i) => CategoryService.fromJson(i)).toList();
      notifyListeners();
      changeServiceCuts();
    } else {
      Fluttertoast.showToast(msg: "Error connect!");
      return;
    }
  }

  changeServiceCuts() async {
    for (var i = 0; i < categoryServices.length; i++) {
      final response =
          await _dbServiceApi.getByCategoryServiceId(categoryServices[i].id);

      if (response != null) {
        List<ServiceCut> serviceCutsTemp =
            response.map((i) => ServiceCut.fromJson(i)).toList();

        categoryServices[i].serviceCuts = serviceCutsTemp;
      } else {
        Fluttertoast.showToast(msg: "Error connect!");
      }
    }

    notifyListeners();
  }

  changeWorkplace(Workplace workplace) async {
    this.workplace = workplace;

    stylists = await _employeeApi.getStylist(workplace.id);

    notifyListeners();
  }

  changeCurrentStep(StepBooking stepBooking) {
    currentStep = stepBooking;
    notifyListeners();
  }

  changeSelectedStylist(int stylist) {
    isDefaultStylist = false;
    selectedStylist = stylist;
    //change time
    notifyListeners();
  }

  changeAdvice(bool advice) {
    isAdvice = advice;
    notifyListeners();
  }

  changeTakeAPhoto(bool takeAPhoto) {
    isTakeAPhoto = !isTakeAPhoto;
    notifyListeners();
  }

  nextStep() {
    currentStep = StepBooking.values[currentStep.index + 1];
    notifyListeners();
  }

  backStep() {
    currentStep = StepBooking.values[currentStep.index - 1];
    notifyListeners();
  }

  checkSelectDateAndStylist() {
    return true;
  }

  checkCompleted() {
    return selectedServices.isNotEmpty && workplace != null;
  }

  changeSelectedDate(DateTime selectedDate) {
    this.selectedDate = selectedDate;
    //change stylists

    notifyListeners();
  }

  changeSelectedTime(int index, DateTime time) {
    currentIndexTime = index;
    selectedTime = time;
    notifyListeners();
  }

  void changeNotes() {
    notes = notesController.text;
    notifyListeners();
  }

  void setSelectedService(List<ServiceCut> selectedServices) {
    this.selectedServices = selectedServices;

    totalDuration = 0;
    for (int i = 0; i < selectedServices.length; i++) {
      totalDuration += selectedServices[i].duration;
    }

    notifyListeners();
  }

  void complete() {
    debugPrint('task: ');
  }

  void reset() {
    _disposed = true;
    currentStep = StepBooking.selectBarbershop;

    selectedStylist = 0;
    currentIndexTime = 0;
    isAdvice = true;
    isTakeAPhoto = true;
    isDefaultStylist = true;
    _disposed = false;
    workplace = null;

    categoryServices = [];
    selectedServices = [];
    stylists = [];
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }
}

enum StepBooking { selectBarbershop, selectService, selectStylistAndDate }
