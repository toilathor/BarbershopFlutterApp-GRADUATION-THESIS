import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BookingView extends StatefulWidget {
  BookingView({Key? key}) : super(key: key);

  @override
  _BookingViewState createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> {
  int _currentStep = 0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
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
        body: Stepper(
          currentStep: _currentStep,
          onStepTapped: (value) => setState(() {
            _currentStep = value;
          }),
          steps: [
            Step(
              isActive: _currentStep == 0,
              title: Text(
                "Select Service",
                style: Theme.of(context).textTheme.headline3,
              ),
              content: Container(),
            ),
            Step(
              isActive: _currentStep == 1,
              title: Text(
                "Select Date/Time",
                style: Theme.of(context).textTheme.headline3,
              ),
              content: Container(),
            ),
            Step(
              isActive: _currentStep == 2,
              title: Text(
                "Select Stylist",
                style: Theme.of(context).textTheme.headline3,
              ),
              content: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
