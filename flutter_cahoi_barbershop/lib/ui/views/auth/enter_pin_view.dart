import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/enter_pin_model.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/colors.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

enum TypeOTP {
  resetPassword,
  register,
  verifyEmail,
}

class EnterPinView extends StatefulWidget {
  final String phoneNumber;
  final String verificationId;
  final TypeOTP typeOTP;

  const EnterPinView({
    Key? key,
    required this.phoneNumber,
    required this.verificationId,
    required this.typeOTP,
  }) : super(key: key);

  @override
  _EnterPinViewState createState() => _EnterPinViewState();
}

class _EnterPinViewState extends State<EnterPinView> {
  final model = locator<EnterPinModel>();

  @override
  void initState() {
    super.initState();
    model.initModel(
      widget.phoneNumber,
      widget.verificationId,
    );
    model.countDown();
  }

  @override
  void dispose() {
    model.errorController.close();
    model.timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<EnterPinModel>(
      create: (context) => model,
      builder: (context, child) => Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        key: model.scaffoldKey,
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 30),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Phone Number Verification',
                  style: TextStyle(
                    fontSize: 36,
                    fontFamily: fontBold,
                    color: headerColor1,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                width: size.width,
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                  text: TextSpan(
                    text: "Enter the code sent to ",
                    children: [
                      TextSpan(
                        text: widget.phoneNumber,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 18,
                      fontFamily:
                          Theme.of(context).textTheme.subtitle1!.fontFamily,
                    ),
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: model.formKey,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 30),
                    child: PinCodeTextField(
                      hintCharacter: "0",
                      enablePinAutofill: true,
                      textInputAction: TextInputAction.send,
                      hintStyle: TextStyle(
                        color: Colors.black.withOpacity(0.1),
                      ),
                      appContext: context,
                      pastedTextStyle: TextStyle(
                        color: Colors.green.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                      length: 6,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      validator: (v) {
                        if (v!.length < 6) {
                          return "Enter 6 characters";
                        } else {
                          return null;
                        }
                      },
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.underline,
                        fieldHeight: 60,
                        fieldWidth: 50,
                      ),
                      cursorColor: Colors.black,
                      animationDuration: const Duration(milliseconds: 300),
                      textStyle: const TextStyle(fontSize: 20, height: 1.6),
                      errorAnimationController: model.errorController,
                      controller: model.textEditingController,
                      keyboardType: TextInputType.number,
                      onCompleted: (v) {
                        debugPrint("Completed");
                        model.verifyOTPRegiter(widget.typeOTP);
                      },
                      onChanged: (_) {
                        model.changeCurrentPin();
                      },
                      beforeTextPaste: (text) {
                        debugPrint("Allowing to paste $text");
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
                      },
                    )),
              ),
              Consumer<EnterPinModel>(
                builder: (context, value, child) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    model.messageValidate ?? "",
                    style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Consumer<EnterPinModel>(
                builder: (context, value, child) => GestureDetector(
                  onTap: model.timeOut == 0
                      ? () {
                          model.resendOTP();
                        }
                      : null,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: "Didn't receive the code? ",
                        style: const TextStyle(
                            color: Colors.black54, fontSize: 15),
                        children: [
                          TextSpan(
                              text: " RESEND",
                              style: TextStyle(
                                  color: model.timeOut == 0
                                      ? const Color(0xFF91D3B3)
                                      : Colors.grey.withOpacity(0.5),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)),
                          TextSpan(
                              text: model.timeOut != 0
                                  ? " (${model.timeOut}) "
                                  : '',
                              style: TextStyle(
                                  color: model.timeOut == 0
                                      ? const Color(0xFF91D3B3)
                                      : Colors.grey.withOpacity(0.5),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16))
                        ]),
                  ),
                ),
              ),
              // const SizedBox(
              //   height: 14,
              // ),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: unused_element
  Widget _buildButtonVerify() => Container(
        margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
        child: ButtonTheme(
          height: 50,
          child: Consumer<EnterPinModel>(
            builder: (context, value, child) => TextButton(
              onPressed: model.isEnableButtonVerify
                  ? () {
                      model.verifyOTPRegiter(widget.typeOTP);
                    }
                  : null,
              child: Center(
                  child: Text(
                "VERIFY".toUpperCase(),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              )),
            ),
          ),
        ),
        decoration: BoxDecoration(
            color: model.isEnableButtonVerify
                ? Colors.green.shade300
                : Colors.grey.withOpacity(0.5),
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                  color: Colors.green.shade200,
                  offset: const Offset(1, -2),
                  blurRadius: 5),
              BoxShadow(
                  color: Colors.green.shade200,
                  offset: const Offset(-1, 2),
                  blurRadius: 5)
            ]),
      );
}
