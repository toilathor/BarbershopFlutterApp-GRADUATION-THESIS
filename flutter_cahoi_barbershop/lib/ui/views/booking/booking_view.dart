import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/view_models/booking_model.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/colors.dart';
import 'package:flutter_cahoi_barbershop/ui/views/booking/service_tab.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class BookingView extends StatefulWidget {
  BookingView({Key? key}) : super(key: key);

  @override
  _BookingViewState createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    controller = TabController(length: 4, vsync: this);
    super.initState();
  }

  final model = locator<BookingModel>();

  @override
  Widget build(BuildContext context) {
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
                  tooltip: 'Wallet',
                ),
              )
            ],
          ),
          body: Consumer<BookingModel>(
            builder: (context, value, child) => Theme(
              data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.light(primary: headerColor1)),
              child: Stepper(
                currentStep: model.currentStep.index,
                onStepTapped: (value) =>
                    model.changeCurrentStep(StepBooking.values[value]),
                controlsBuilder: (context, details) {
                  return Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text("Next"),
                        ),
                      )
                    ],
                  );
                },
                steps: [
                  Step(
                      isActive: model.currentStep == StepBooking.selectService,
                      title: Text(
                        "Select Service",
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      content: _buildStepSelectService()),
                  Step(
                    isActive: model.currentStep == StepBooking.selectDateTime,
                    title: Text(
                      "Select Date/Time",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    content: Container(),
                  ),
                  Step(
                    isActive: model.currentStep == StepBooking.selectStylist,
                    title: Text(
                      "Select Stylist",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    content: Container(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepSelectService() {
    return DefaultTabController(
        length: 4,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TabBar(
              controller: controller,
              indicatorColor: textColorLight2,
              // indicatorWeight: 4,
              tabs: [
                Tab(
                  child: Text("Hair cut/styling",
                      style: Theme.of(context).textTheme.headline3),
                ),
                Tab(
                  child: Text("Hair dying",
                      style: Theme.of(context).textTheme.headline3),
                ),
                Tab(
                  child: Text("Curling hair",
                      style: Theme.of(context).textTheme.headline3),
                ),
                Tab(
                  child: Text("More",
                      style: Theme.of(context).textTheme.headline3),
                ),
              ],
              isScrollable: true,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey,
              child: TabBarView(
                controller: controller,
                children: [
                  ServiceTab(),
                  Container(color: Colors.pink),
                  Container(color: Colors.blue),
                  Container(color: Colors.red),
                ],
              ),
            ),
          ],
        ));
  }
}
