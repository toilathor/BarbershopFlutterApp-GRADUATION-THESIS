import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/auth_model.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/colors.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/helper.dart';
import 'package:flutter_cahoi_barbershop/ui/views/_base.dart';
import 'package:flutter_cahoi_barbershop/ui/views/auth/change_password_view.dart';
import 'package:flutter_cahoi_barbershop/ui/views/auth/register_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

enum TypeOTP {
  resetPassword,
  register,
  verifyEmail,
}

class EnterPinView extends StatefulWidget {
  final String phoneNumber;
  final String verifyId;
  final TypeOTP typeOTP;

  const EnterPinView({
    Key? key,
    required this.phoneNumber,
    required this.verifyId,
    required this.typeOTP,
  }) : super(key: key);

  @override
  _EnterPinViewState createState() => _EnterPinViewState();
}

class _EnterPinViewState extends State<EnterPinView> {
  TextEditingController pinController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? messageValidate;
  bool hasError = false;
  String _verifyId = '';

  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BaseView<AuthModel>(
      onModelReady: (model) {
        _verifyId = widget.verifyId;
        model.countDown();
      },
      onModelDisposed: (model) {
        errorController.close();
        model.timer.cancel();
      },
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(),
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  appLang(context)!.verify_phone_num,
                  style: const TextStyle(
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
                    text: appLang(context)!.code_send_to,
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
                key: formKey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
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
                        return appLang(context)!.enter_6_num;
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
                    errorAnimationController: errorController,
                    controller: pinController,
                    keyboardType: TextInputType.number,
                    onCompleted: (v) {
                      model.verifyOTPRegister(
                        currentPin: pinController.text,
                        verifyId: _verifyId,
                        changeMessageValidate: (value) {
                          pinController.text = '';
                          errorController.add(ErrorAnimationType.shake);
                          setState(() {
                            messageValidate = value;
                          });
                        },
                        gotoRegister: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                if (widget.typeOTP == TypeOTP.register) {
                                  return RegisterView(
                                    phoneNumber: widget.phoneNumber,
                                  );
                                } else {
                                  //TODO change password
                                  return ChangePasswordView(
                                    phoneNumber: widget.phoneNumber,
                                  );
                                }
                              },
                            ),
                            (Route<dynamic> route) => route.isFirst,
                          );
                        },
                      );
                    },
                    onChanged: (_) {
                      setState(() {
                        formKey.currentState?.validate();
                      });
                    },
                    beforeTextPaste: (text) {
                      logger.d("Allowing to paste $text");
                      return true;
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  messageValidate ?? "",
                  style: const TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: model.timeOut == 0
                    ? () {
                        model.sendOTPRegister(
                          phoneNumber: widget.phoneNumber,
                          gotoVerifyOTP: (verifyId) {
                            pinController.text = '';
                            setState(() {
                              _verifyId = verifyId;
                            });
                          },
                        );
                      }
                    : null,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: appLang(context)!.do_not_receive,
                    style: const TextStyle(color: Colors.black54, fontSize: 15),
                    children: [
                      TextSpan(
                          text: appLang(context)!.resend,
                          style: TextStyle(
                              color: model.timeOut == 0
                                  ? const Color(0xFF91D3B3)
                                  : Colors.grey.withOpacity(0.5),
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                      TextSpan(
                        text: model.timeOut != 0 ? " (${model.timeOut}) " : '',
                        style: TextStyle(
                            color: model.timeOut == 0
                                ? const Color(0xFF91D3B3)
                                : Colors.grey.withOpacity(0.5),
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  changeHasError() {
    formKey.currentState?.validate();
    // conditions for validating
    if (pinController.text.length != 6 || messageValidate != null) {
      errorController
          .add(ErrorAnimationType.shake); // Triggering error shake animation
      pinController.text = '';
      setState(() {
        hasError = true;
      });
    } else {
      setState(() {
        hasError = false;
      });
      Fluttertoast.showToast(msg: "Aye!!");
    }
  }
}
