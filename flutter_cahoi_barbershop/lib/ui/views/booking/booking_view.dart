import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/models/service_cut/service_cut.dart';
import 'package:flutter_cahoi_barbershop/core/models/stylist/stylist.dart';
import 'package:flutter_cahoi_barbershop/core/models/workplace/workplace.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/booking_model.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/colors.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:flutter_cahoi_barbershop/ui/views/_base.dart';
import 'package:flutter_cahoi_barbershop/ui/views/booking/select_barbershop_view.dart';
import 'package:flutter_cahoi_barbershop/ui/views/booking/select_service_view.dart';
import 'package:flutter_cahoi_barbershop/ui/views/booking/widgets/select_stylist.dart';
import 'package:flutter_cahoi_barbershop/ui/views/booking/widgets/toggle_time.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/elevated_button_icon.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/my_date_picker_timeline.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/text_tag.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BookingView extends StatefulWidget {
  const BookingView({Key? key}) : super(key: key);

  @override
  _BookingViewState createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView>
    with SingleTickerProviderStateMixin {
  final notesController = TextEditingController();
  Size size = Size.zero;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return BaseView<BookingModel>(
      onModelReady: (model) {},
      onModelDisposed: (model) {
        model.changeDisposed();
      },
      builder: (context, model, child) => WillPopScope(
        onWillPop: () async {
          Fluttertoast.showToast(
            msg: "Để tránh back nhầm. Hãy bấm nút back góc trên bên phải!",
          );
          return false;
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            title: const Text("Book a haircut"),
            automaticallyImplyLeading: false,
            actions: [
              Container(
                padding: const EdgeInsets.all(4.0),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.home,
                    size: Theme.of(context).iconTheme.size ?? 24,
                  ),
                  tooltip: 'Home',
                ),
              ),
            ],
          ),
          body: Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: Theme.of(context).secondaryHeaderColor,
              ),
            ),
            child: SizedBox(
              height: size.height,
              child: Stepper(
                currentStep: model.currentStep.index,
                onStepContinue: () {
                  model.nextStep();
                },
                onStepCancel: () {
                  model.backStep();
                },
                controlsBuilder: (context, details) =>
                    _buildControl(context, details, model),
                steps: [
                  _buildStepSelectBarbershop(
                    currentStep: model.currentStep,
                    workplace: model.workplace,
                    onPressSelectWorkplace: () async {
                      var result = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SelectBarbershopView(),
                        ),
                      );

                      if (result != null && result.containsKey('selection')) {
                        debugPrint(result['selection'].toString());
                        model.changeWorkplace(result['selection']);
                      }
                    },
                  ),
                  _buildStepSelectService(
                    currentStep: model.currentStep,
                    selectedServices: model.selectedServices,
                    onPressSelectService: () async {
                      var result = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SelectServiceView(
                            model: model,
                          ),
                        ),
                      );

                      if (result != null && result['services'] != null) {
                        model.setSelectedService(result['services']);
                      }
                    },
                  ),
                  _buildStepSelectDateAndStylist(model),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDescriptionStylist({required Stylist stylist}) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          RichText(
            text: TextSpan(
              text: 'Stylist: ',
              style: const TextStyle(
                color: textColorLight1,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              children: [
                TextSpan(
                  text: stylist.name,
                  style: TextStyle(
                      color: Theme.of(context).textTheme.headline6!.color,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              text: '${stylist.skill} ',
              style: Theme.of(context).textTheme.headline3,
              children: [
                WidgetSpan(
                  child: RatingBarIndicator(
                    rating: stylist.skill / 5,
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 1,
                    itemSize: 24.0,
                    direction: Axis.horizontal,
                  ),
                ),
                TextSpan(
                  text: " Skill",
                  style: TextStyle(
                      color: Theme.of(context).textTheme.headline6!.color,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              text: '${stylist.communication} ',
              style: Theme.of(context).textTheme.headline3,
              children: [
                WidgetSpan(
                  child: RatingBarIndicator(
                    rating: stylist.communication / 5,
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 1,
                    itemSize: 24.0,
                    direction: Axis.horizontal,
                  ),
                ),
                TextSpan(
                  text: " Communicate",
                  style: TextStyle(
                      color: Theme.of(context).textTheme.headline6!.color,
                      fontFamily: fontBold,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ],
      );

  Widget _buildSelectTime(
          {required int totalDuration,
          required int currentIndexTime,
          required Function(DateTime, int) changeSelectedTime}) =>
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 6,
          child: ToggleTime(
            timeStart: timeStart,
            timeEnd: timeEnd,
            duration: totalDuration,
            currentIndex: currentIndexTime,
            onPressed: changeSelectedTime,
          ),
        ),
      );

  List<Widget> _buildOptionMore({
    required bool isAdvice,
    Function(bool)? onChangedAdvice,
    required bool isTakeAPhoto,
    Function(bool)? changeTakeAPhoto,
  }) {
    return [
      SizedBox(
        width: size.width,
        child: const Text(
          "Notes",
          style: TextStyle(
            fontSize: 16,
            fontFamily: fontBold,
          ),
        ),
      ),
      TextField(
        maxLines: 3,
        maxLength: 250,
        controller: notesController,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        onChanged: (_) {},
        decoration: InputDecoration(
          hintText: "EX: You go with 2 children, You go with you,"
              " Wash your hands and so on...etc",
          hintStyle: TextStyle(
            fontSize: 14,
            color: Colors.grey.withOpacity(0.5),
          ),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Advice",
            style: TextStyle(
              fontSize: 16,
              fontFamily: fontBold,
            ),
          ),
          Switch(
              activeColor: primaryColor2,
              value: isAdvice,
              onChanged: onChangedAdvice)
        ],
      ),
      Text(
        "You allow us to recommend the best promotion, service for you",
        style: Theme.of(context).textTheme.subtitle2,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Take a photo after haircut",
            style: TextStyle(
              fontSize: 16,
              fontFamily: fontBold,
            ),
          ),
          Switch(
            activeColor: primaryColor2,
            value: isTakeAPhoto,
            onChanged: changeTakeAPhoto,
          )
        ],
      ),
      Text(
        "You allow us to take photos to save the hairstyle,"
        " so that next time you don't have to describe it to another stylist",
        style: Theme.of(context).textTheme.subtitle2,
      ),
    ];
  }

  Widget _buildControl(
      BuildContext context, ControlsDetails details, BookingModel model) {
    if (details.currentStep == StepBooking.selectBarbershop.index) {
      return ElevatedButtonIcon(
        title: 'Next step',
        onPressed: model.workplace == null ? null : details.onStepContinue,
      );
    } else if (details.currentStep == StepBooking.selectStylistAndDate.index) {
      return Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: details.onStepCancel,
              child: const Text('Back'),
            ),
          ),
          Expanded(
            child: ElevatedButtonIcon(
              title: 'Completed',
              onPressed: model.checkCompleted()
                  ? () {
                      //Call api
                      model.complete();
                    }
                  : null,
            ),
          )
        ],
      );
    } else {
      return Row(
        children: [
          Expanded(
            flex: 1,
            child: TextButton(
              onPressed: details.onStepCancel,
              child: const Text('Back'),
            ),
          ),
          Expanded(
            flex: 1,
            child: ElevatedButtonIcon(
              title: 'Next Step',
              onPressed: model.selectedServices.isEmpty
                  ? null
                  : details.onStepContinue,
            ),
          ),
        ],
      );
    }
  }

  Step _buildStepSelectBarbershop({
    required StepBooking currentStep,
    required Workplace? workplace,
    required Function() onPressSelectWorkplace,
  }) =>
      Step(
        isActive: currentStep == StepBooking.selectBarbershop,
        title: const Text(
          "Select Barbershop",
          style: TextStyle(
              color: textColorLight2,
              fontSize: 24,
              fontWeight: FontWeight.w500,
              fontFamily: fontBold),
        ),
        state: workplace == null ? StepState.indexed : StepState.complete,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            workplace == null
                ? Container()
                : Container(
                    margin: const EdgeInsets.only(bottom: 20.0),
                    child: TextTag(title: workplace.name),
                  ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: onPressSelectWorkplace,
                child: const Text('Select Barbershop'),
              ),
            ),
          ],
        ),
      );

  Step _buildStepSelectService({
    required StepBooking currentStep,
    required List<ServiceCut> selectedServices,
    required Function() onPressSelectService,
  }) =>
      Step(
        isActive: currentStep == StepBooking.selectService,
        state:
            selectedServices.isEmpty ? StepState.indexed : StepState.complete,
        title: const Text(
          "Select Service",
          style: TextStyle(
            color: textColorLight2,
            fontSize: 24,
            fontWeight: FontWeight.w500,
            fontFamily: fontBold,
          ),
        ),
        content: Column(
          children: [
            _buildSelectedService(
              selectedServices: selectedServices,
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                  child: const Text('Select Service'),
                  onPressed: onPressSelectService),
            ),
          ],
        ),
      );

  Step _buildStepSelectDateAndStylist(BookingModel model) => Step(
        isActive: model.currentStep == StepBooking.selectStylistAndDate,
        title: const Text(
          "Select Stylist & Datetime",
          style: TextStyle(
            color: textColorLight2,
            fontSize: 24,
            fontWeight: FontWeight.w500,
            fontFamily: fontBold,
          ),
        ),
        state: model.checkSelectDateAndStylist()
            ? StepState.indexed
            : StepState.complete,
        content: Container(
          margin: const EdgeInsets.only(bottom: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
                  MyDatePickerTimeline(
                    DateTime.now(),
                    initialSelectedDate: model.selectedDate,
                    daysCount: 7,
                    height: size.height * 0.117,
                    width: size.width * 0.17,
                    selectedTextColor: Colors.white,
                    selectionColor: secondaryColor,
                    dateTextStyle: const TextStyle(
                      fontSize: 12,
                    ),
                    dayTextStyle: const TextStyle(
                      fontSize: 12,
                    ),
                    onDateChange: (selectedDate) {
                      model.changeSelectedDate(selectedDate);
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.only(bottom: 8.0),
                    width: size.width,
                    // height: size.width * 0.26,
                    child: model.isDefaultStylist
                        ? const Center(
                            child: Text(
                              "We will select help you the stylist the best",
                              style: TextStyle(fontWeight: FontWeight.w400),
                            ),
                          )
                        : _buildDescriptionStylist(
                            stylist: model.stylists![model.selectedStylist]),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  const SelectStylist(),
                  _buildSelectTime(
                    changeSelectedTime: (index, time) {
                      model.changeSelectedTime(time, index);
                    },
                    totalDuration: model.totalDuration,
                    currentIndexTime: model.currentIndexTime,
                  ),
                ] +
                _buildOptionMore(
                  isAdvice: model.isAdvice,
                  onChangedAdvice: (value) {
                    model.changeAdvice(value);
                  },
                  isTakeAPhoto: model.isAdvice,
                  changeTakeAPhoto: (value) {
                    model.changeTakeAPhoto(value);
                  },
                ),
          ),
        ),
      );

  Widget _buildSelectedService({required List<ServiceCut> selectedServices}) {
    if (selectedServices.isEmpty) {
      return Container();
    } else {
      List<Widget> items = [];

      for (int i = 0; i < selectedServices.length; i++) {
        items.add(
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextTag(title: selectedServices[i].name),
          ),
        );
      }

      return Container(
        margin: const EdgeInsets.only(bottom: 20.0),
        child: Wrap(
          children: items,
        ),
      );
    }
  }
}
