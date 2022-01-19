import 'package:flutter/cupertino.dart';
import 'package:flutter_cahoi_barbershop/core/models/category_service/category_service.dart';
import 'package:flutter_cahoi_barbershop/core/models/service_cut/service_cut.dart';
import 'package:flutter_cahoi_barbershop/core/models/stylist/stylist.dart';

class BookingModel extends ChangeNotifier {
  late GlobalKey<NavigatorState> materialKey = GlobalKey<NavigatorState>();

  StepBooking currentStep = StepBooking.selectService;
  int currentStylist = 0;
  int currentIndexTime = 0;
  bool isAdvice = true;
  bool isTakeAPhoto = true;

  List<ServiceCut> serviceCuts = [
    ServiceCut(
        id: "1",
        name: "Combo cat goi 100k nhe anh em",
        price: "100000",
        duration: "45",
        sortDescription: "Cat toc dep",
        fullDescription: "Kieu toc cuc ki dep",
        imagesDemo: "6",
        idCategory: "1"),
    ServiceCut(
        id: "1",
        name: "Combo cat goi 100k nhe anh em",
        price: "100000",
        duration: "45",
        sortDescription: "Cat toc dep",
        fullDescription: "Kieu toc cuc ki dep",
        imagesDemo: "6",
        idCategory: "1"),
    ServiceCut(
        id: "1",
        name: "Combo cat goi 100k nhe anh em",
        price: "100000",
        duration: "45",
        sortDescription: "Cat toc dep",
        fullDescription: "Kieu toc cuc ki dep",
        imagesDemo: "6",
        idCategory: "1"),
    ServiceCut(
        id: "1",
        name: "Combo cat goi 100k nhe anh em",
        price: "100000",
        duration: "45",
        sortDescription: "Cat toc dep",
        fullDescription: "Kieu toc cuc ki dep",
        imagesDemo: "6",
        idCategory: "1"),
    ServiceCut(
        id: "1",
        name: "Combo cat goi 100k nhe anh em",
        price: "100000",
        duration: "45",
        sortDescription: "Cat toc dep",
        fullDescription: "Kieu toc cuc ki dep",
        imagesDemo: "6",
        idCategory: "1"),
  ];

  List<CategorySevice> categoryServices = [
    CategorySevice(id: '1', name: "Hair cut/styling", serviceCuts: []),
    CategorySevice(id: '2', name: "Hair dying", serviceCuts: []),
    CategorySevice(id: '3', name: "Curling hair", serviceCuts: []),
    CategorySevice(id: '4', name: "More", serviceCuts: []),
  ];

  List<Stylist> stylists = [
    Stylist(
        id: "1",
        name: "Le Quang Tho",
        skill: "4.5",
        communicate: "3.5",
        avatar: "https://bit.ly/31r4hGC"),
    Stylist(
        id: "1",
        name: "Le Quang Tho",
        skill: "4",
        communicate: "3",
        avatar: "https://bit.ly/3zBD2WB"),
    Stylist(
        id: "1",
        name: "Le Quang Tho",
        skill: "4.6",
        communicate: "4",
        avatar: "https://bit.ly/332bwVC"),
    Stylist(
        id: "1",
        name: "Le Quang Tho",
        skill: "4.7",
        communicate: "5",
        avatar: "https://bit.ly/3JH8APa"),
  ];

  changeCurrentStep(StepBooking stepBooking) {
    currentStep = stepBooking;
    notifyListeners();
  }

  changeCurrentStylist(int stylist) {
    currentStylist = stylist;
    notifyListeners();
  }

  changeCurrentTime(int index, DateTime time) {
    currentIndexTime = index;
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
}

enum StepBooking { selectService, selectDateTime, selectStylist }
