import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/models/stylist/stylist.dart';
import 'package:flutter_cahoi_barbershop/core/view_models/booking_model.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/colors.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:flutter_cahoi_barbershop/ui/views/booking/select_barbershop_view.dart';
import 'package:flutter_cahoi_barbershop/ui/views/booking/select_service_view.dart';
import 'package:flutter_cahoi_barbershop/ui/views/booking/service_tab.dart';
import 'package:flutter_cahoi_barbershop/ui/views/booking/widgets/select_stylist.dart';
import 'package:flutter_cahoi_barbershop/ui/views/booking/widgets/toggle_time.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class BookingView extends StatefulWidget {
  const BookingView({Key? key}) : super(key: key);

  @override
  _BookingViewState createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    controller =
        TabController(length: model.categoryServices.length, vsync: this);
    super.initState();
  }

  final model = locator<BookingModel>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ChangeNotifierProvider<BookingModel>(
      create: (context) => model,
      child: WillPopScope(
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
              )
            ],
          ),
          body: Consumer<BookingModel>(
            builder: (context, value, child) => Theme(
              data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                      primary: Theme.of(context).secondaryHeaderColor)),
              child: SizedBox(
                height: size.height,
                child: Stepper(
                  currentStep: model.currentStep.index,
                  onStepTapped: (value) =>
                      model.changeCurrentStep(StepBooking.values[value]),
                  controlsBuilder: (context, details) {
                    return Container();
                  },
                  steps: [
                    Step(
                        isActive:
                            model.currentStep == StepBooking.selectService,
                        title: Text(
                          "Select Barbershop",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        content: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const SelectBarbershopView(),
                                ),
                              );
                            },
                            child: const Text('Select Barbershop'))),
                    Step(
                      isActive: model.currentStep == StepBooking.selectDateTime,
                      title: Text(
                        "Select Service",
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      content: TextButton(
                          child: const Text('Select Service'),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const SelectServiceView(),
                              ),
                            );
                          }),
                    ),
                    Step(
                        isActive:
                            model.currentStep == StepBooking.selectStylist,
                        title: Text(
                          "Select Stylist",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        content: _buildStepSelectDateAndStylist(size)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildDescriptionStylist({required Stylist stylist}) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          RichText(
            text: TextSpan(
              text: 'Stylist: ',
              style: Theme.of(context).textTheme.headline3,
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
                    rating: double.parse(stylist.skill) / 5,
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
              text: '${stylist.communicate} ',
              style: Theme.of(context).textTheme.headline3,
              children: [
                WidgetSpan(
                  child: RatingBarIndicator(
                    rating: double.parse(stylist.communicate) / 5,
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
                      fontFamily:
                          Theme.of(context).textTheme.headline1!.fontFamily,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ],
      );

  Widget _buildSelectDateTime(Size size) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DatePicker(
                DateTime.now(),
                dateTextStyle: Theme.of(context).textTheme.headline2!,
                monthTextStyle: Theme.of(context).textTheme.bodyText1!,
                dayTextStyle: Theme.of(context).textTheme.bodyText1!,
                daysCount: 7,
                height: size.height * 0.112,
                width: size.width * 0.2,
                selectionColor: Theme.of(context)
                    .floatingActionButtonTheme
                    .backgroundColor!,
                onDateChange: (selectedDate) {},
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4,
              child: ToggleTime(
                timeStart: timeStart,
                timeEnd: timeEnd,
                duration: 45,
                currentIndex: model.currentIndexTime,
                onPressed: (time, index) {
                  model.changeCurrentTime(index, time);
                },
              ),
            ),
          ],
        ),
      );

  _buildStepSelectDateAndStylist(Size size) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.only(bottom: 8.0),
                width: size.width,
                // height: size.width * 0.26,
                child: model.currentStylist == 0
                    ? Center(
                        child: Text(
                          "We will select help you the stylist the best",
                          style: TextStyle(
                              fontFamily: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .fontFamily,
                              fontWeight: FontWeight.w400),
                        ),
                      )
                    : _buildDescriptionStylist(
                        stylist: model.stylists[model.currentStylist - 1]),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              SelectStylist(
                currentIndex: model.currentStylist,
                stylists: model.stylists,
                onTap: (index) {
                  model.changeCurrentStylist(index);
                },
              ),
              _buildSelectDateTime(size),
            ] +
            _buildOptionMore(size, context),
      );

  _buildOptionMore(Size size, BuildContext context) {
    return [
      SizedBox(
        width: size.width,
        child: Text(
          "Notes",
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
      TextField(
        maxLines: 3,
        style: const TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
          hintText:
              "EX: You go with 2 children, You go with you, Wash your hands and so on...etc",
          hintStyle: TextStyle(
            color: Colors.grey.withOpacity(0.5),
          ),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Advice",
            style: Theme.of(context).textTheme.headline3,
          ),
          Switch(
            activeColor: primaryColor2,
            value: model.isAdvice,
            onChanged: (value) {
              model.changeAdvice(value);
            },
          )
        ],
      ),
      Text(
        "You allow us to recommend the best promotion, service for you",
        style: Theme.of(context).textTheme.subtitle2,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Take a photo after haircut",
            style: Theme.of(context).textTheme.headline3,
          ),
          Switch(
            activeColor: primaryColor2,
            value: model.isTakeAPhoto,
            onChanged: (value) {
              model.changeTakeAPhoto(value);
            },
          )
        ],
      ),
      Text(
        "You allow us to take photos to save the hairstyle, so that next time you don't have to describe it to another stylist"
            .toUpperCase(),
        style: Theme.of(context).textTheme.subtitle2,
      ),
    ];
  }
}
