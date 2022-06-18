import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/models/facility.dart';
import 'package:flutter_cahoi_barbershop/core/models/product.dart';
import 'package:flutter_cahoi_barbershop/core/models/stylist.dart';
import 'package:flutter_cahoi_barbershop/core/services/auth_service.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/booking_model.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/colors.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/helper.dart';
import 'package:flutter_cahoi_barbershop/ui/views/_base.dart';
import 'package:flutter_cahoi_barbershop/ui/views/booking/select_facility_view.dart';
import 'package:flutter_cahoi_barbershop/ui/views/booking/select_product_view.dart';
import 'package:flutter_cahoi_barbershop/ui/views/booking/widgets/select_stylist.dart';
import 'package:flutter_cahoi_barbershop/ui/views/booking/widgets/time_slots.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/elevated_button_icon.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/my_date_picker_timeline.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/text_tag.dart';
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
      onModelReady: (model) async {
        model.initTimeSlots();
      },
      onModelDisposed: (model) {
        model.changeDisposed();
      },
      builder: (context, model, child) => WillPopScope(
        onWillPop: () async {
          Fluttertoast.cancel();
          Fluttertoast.showToast(
            msg: appLang(context)!.warning_back_booking,
          );
          return false;
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            title: Text(
              appLang(context)!.schedule_haircut,
            ),
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
                  _buildStepSelectFacility(
                    currentStep: model.currentStep,
                    currentFacility: model.selectedFacility,
                    onPressSelect: () async {
                      var result = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SelectFacilityView(),
                        ),
                      );

                      if (result != null && result.containsKey('selection')) {
                        Facility facility = result['selection'];
                        await model.changeSelectedFacility(facility);
                      }
                    },
                  ),
                  _buildStepSelectProduct(
                    currentStep: model.currentStep,
                    selectedProducts: model.selectedProducts,
                    onPressSelectProduct: () async {
                      var result = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SelectProductView(
                            model: model,
                          ),
                        ),
                      );

                      if (result != null && result['services'] != null) {
                        model.updateSelectedProduct(result['services']);
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

  Widget _buildControl(
      BuildContext context, ControlsDetails details, BookingModel model) {
    if (details.currentStep == StepBooking.selectFacility.index) {
      return ElevatedButtonIcon(
        title: appLang(context)!.next_step,
        onPressed:
            model.selectedFacility == null ? null : details.onStepContinue,
      );
    } else if (details.currentStep == StepBooking.selectStylistAndDate.index) {
      return Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: details.onStepCancel,
              child: Text(
                appLang(context)!.back_step,
              ),
            ),
          ),
          Expanded(
            child: ElevatedButtonIcon(
              title: appLang(context)!.complete,
              onPressed: model.checkCompleted()
                  ? () async {
                      var res =
                          await model.complete(notes: notesController.text);
                      if (res) {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.SUCCES,
                          title: appLang(context)!.success,
                          btnOkOnPress: () {
                            Navigator.pop(context);
                          },
                        ).show();
                      } else {
                        AwesomeDialog(
                          context: context,
                          title: appLang(context)!.has_error,
                          dialogType: DialogType.ERROR,
                          btnOkOnPress: () {},
                        ).show();
                      }
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
              child: Text(
                appLang(context)!.back_step,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: ElevatedButtonIcon(
              title: appLang(context)!.next_step,
              onPressed: model.selectedProducts.isEmpty
                  ? null
                  : details.onStepContinue,
            ),
          ),
        ],
      );
    }
  }

  Step _buildStepSelectFacility({
    required StepBooking currentStep,
    required Facility? currentFacility,
    required Function() onPressSelect,
  }) =>
      Step(
        isActive: currentStep == StepBooking.selectFacility ||
            currentFacility != null,
        title: Text(
          appLang(context)!.select_facility,
          style: const TextStyle(
            color: textColorLight2,
            fontSize: 24,
            fontWeight: FontWeight.w500,
            fontFamily: fontBold,
          ),
        ),
        state: currentFacility == null ? StepState.indexed : StepState.complete,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (currentFacility == null)
              Container()
            else
              Container(
                height: size.width * 0.3,
                width: size.width * 0.8,
                margin: const EdgeInsets.only(bottom: 20.0),
                child: Card(
                  color: backgroundColor,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4.0),
                          child: Image.network(
                            '$localHost${currentFacility.image}',
                            fit: BoxFit.cover,
                            height: double.infinity,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "${currentFacility.address}",
                            // overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: onPressSelect,
                child: Text(
                  appLang(context)!.select_facility,
                ),
              ),
            ),
          ],
        ),
      );

  Step _buildStepSelectProduct({
    required StepBooking currentStep,
    required List<Product> selectedProducts,
    required Function() onPressSelectProduct,
  }) =>
      Step(
        isActive: currentStep == StepBooking.selectProduct ||
            selectedProducts.isNotEmpty,
        state:
            selectedProducts.isEmpty ? StepState.indexed : StepState.complete,
        title: Text(
          appLang(context)!.select_product,
          style: const TextStyle(
            color: textColorLight2,
            fontSize: 24,
            fontWeight: FontWeight.w500,
            fontFamily: fontBold,
          ),
        ),
        content: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 20.0),
              child: Wrap(
                children: _buildSelectedProduct(
                  selectedProducts: selectedProducts,
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                child: Text(
                  appLang(context)!.select_product,
                ),
                onPressed: onPressSelectProduct,
              ),
            ),
          ],
        ),
      );

  Step _buildStepSelectDateAndStylist(BookingModel model) => Step(
    isActive: model.currentStep == StepBooking.selectStylistAndDate,
        title: Text(
          appLang(context)!.select_stylist,
          style: const TextStyle(
            color: textColorLight2,
            fontSize: 24,
            fontWeight: FontWeight.w500,
            fontFamily: fontBold,
          ),
        ),
        state: model.checkCompleted() ? StepState.complete : StepState.editing,
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
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                width: size.width,
                height: 100,
                child: _buildDescriptionStylist(
                  stylist: model.selectedStylist,
                ),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              SelectStylist(
                onSelected: (stylist) {
                  model.changeSelectedStylist(stylist);
                },
                current: model.selectedStylist,
                stylists: model.stylists ?? [],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: size.width,
                  height: size.height * 0.15,
                  child: TimeSlots(
                    currentTimeSlot: model.currentTimeSlot,
                    onPressed: (timeSlot) {
                      model.changeCurrentTimeSlot(timeSlot: timeSlot);
                    },
                    timeSlots: model.timeSlotsDefault,
                    selectedDate: model.selectedDate,
                  ),
                ),
              ),
              SizedBox(
                width: size.width,
                child: Text(
                  appLang(context)!.note,
                  style: const TextStyle(
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
                decoration: InputDecoration(
                  hintText: appLang(context)!.example_note_booking,
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildDescriptionStylist({
    required StylistRate? stylist,
  }) {
    return stylist == null
        ? Center(
            child: Text(
              appLang(context)!.desc_random_select,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Text(
                  "Stylist: ${stylist.name ?? ""}",
                  style: TextStyle(
                    fontFamily: fontBold,
                    shadows: [
                      Shadow(
                        color: Colors.grey.shade500,
                        offset: const Offset(0, 0),
                        blurRadius: 5,
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Text(
                      "${appLang(context)!.communicate}: "
                      "${stylist.communication ?? '5'}",
                    ),
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Text(
                      "${appLang(context)!.skill}:"
                      " ${stylist.skill ?? '5'}",
                    ),
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                  ],
                ),
              ),
            ],
          );
  }

  List<Widget> _buildSelectedProduct(
      {required List<Product> selectedProducts}) {
    final user = locator<AuthenticationService>().user;
    int discountRank = 0;

    if (user.rank!.id == 1) {
      discountRank = 10;
    } else if (user.rank!.id == 2) {
      discountRank = 15;
    }

    List<Widget> items = [];
    double price = 0;
    for (int i = 0; i < selectedProducts.length; i++) {
      price += selectedProducts[i].price;

      items.add(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextTag(
            product: selectedProducts[i],
          ),
        ),
      );
    }

    ///Add discount
    items.add(
      Container(
        height: 40,
        padding: const EdgeInsets.all(4.0),
        margin: const EdgeInsets.all(4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${appLang(context)!.discount_rank} ${user.rank?.rankName}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: primaryColor,
                fontSize: 16,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.0),
                color: Colors.red.shade200,
              ),
              child: Text(
                "-$discountRank%",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: primaryColor,
                ),
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: Colors.black26,
          ),
        ),
      ),
    );

    ///Add item total
    items.add(
      Container(
        height: 40,
        padding: const EdgeInsets.all(4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${appLang(context)!.total}: ",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: primaryColor,
                fontSize: 20,
                fontFamily: fontBold,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.0),
                color: Colors.yellow,
              ),
              child: Text(
                "${price - (price * discountRank / 100)}K",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: primaryColor,
                ),
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: Colors.black26,
          ),
        ),
      ),
    );
    return items;
  }
}
