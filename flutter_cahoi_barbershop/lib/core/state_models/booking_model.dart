import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/models/service_cut/service_cut.dart';
import 'package:flutter_cahoi_barbershop/core/models/stylist/stylist.dart';
import 'package:flutter_cahoi_barbershop/core/models/workplace/workplace.dart';
import 'package:flutter_cahoi_barbershop/core/services/booking_service.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/base.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:geolocator/geolocator.dart';

class BookingModel extends BaseModel {
  late GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final BookingService _bookingService = locator<BookingService>();

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
  Position? position;

  List<Workplace>? workplaces;
  List<ServiceCut> selectedServices = [];
  List<List<ServiceCut>> services = [];
  List<Stylist>? stylists = [];

  changeDefaultStylist() {
    if (!isDefaultStylist) {
      isDefaultStylist = !isDefaultStylist;
    }
    notifyListeners();
  }

  //Step Select Barbershop
  changeWorkplaces() async {
    position = await _bookingService.getCurrentLocation();
    workplaces = await _bookingService.getWorkPlace();
    workplaces!.sort(
      (a, b) => Geolocator.distanceBetween(
              position!.latitude, position!.longitude, a.latitude, a.longitude)
          .compareTo(
        Geolocator.distanceBetween(
            position!.latitude, position!.longitude, b.latitude, b.longitude),
      ),
    );
    notifyListeners();
  }

  changeWorkplace(Workplace workplace) async {
    this.workplace = workplace;

    stylists = await _bookingService.getStylists(workplaceId: workplace.id);

    notifyListeners();
  }

  //Step Select Service
  changeServices() async {
    //Bug load
    services = [[], [], [], []];

    for (var i = 1; i < 5; i++) {
      final response = await _bookingService.getService(categoryServiceId: i);
      if (response != null) {
        services[i - 1] = response;
      }
    }

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

  changeSelectedServices(ServiceCut item) {
    if (!selectedServices.contains(item)) {
      selectedServices.removeWhere(
          (element) => item.categoryServiceId == element.categoryServiceId);
      selectedServices.add(item);
    } else {
      selectedServices.remove(item);
    }
    notifyListeners();
  }

  //Step Select Stylist & Datetime
  changeSelectedDate(DateTime selectedDate) {
    this.selectedDate = selectedDate;
    //change stylists
    // _employeeApi.getStylistByDate(workplaceId, DateTime.now());
    notifyListeners();
  }

  changeSelectedTime(int index, DateTime time) {
    currentIndexTime = index;
    selectedTime = time;
    notifyListeners();
  }

  //Booking
  changeCurrentStep(StepBooking stepBooking) {
    currentStep = stepBooking;
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

  checkSelectDateAndStylist() {
    return true;
  }

  checkCompleted() {
    return selectedServices.isNotEmpty && workplace != null;
  }

  void complete() {
    debugPrint('task: ');
  }

  void reset() {
    currentStep = StepBooking.selectBarbershop;

    selectedStylist = 0;
    currentIndexTime = 0;
    isAdvice = true;
    isTakeAPhoto = true;
    isDefaultStylist = true;
    _disposed = false;
    workplace = null;

    selectedServices = [];
    stylists = [];
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  changeDisposed() {
    _disposed = true;
  }
}

enum StepBooking { selectBarbershop, selectService, selectStylistAndDate }
