import 'package:flutter/cupertino.dart';

class BookingModel extends ChangeNotifier {
  late GlobalKey<NavigatorState> materialKey = GlobalKey<NavigatorState>();

  StepBooking currentStep = StepBooking.selectService;

  changeCurrentStep(StepBooking stepBooking) {
    currentStep = stepBooking;
    notifyListeners();
  }
}

enum StepBooking { selectService, selectDateTime, selectStylist }
