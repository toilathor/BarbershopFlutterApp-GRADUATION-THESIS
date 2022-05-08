import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/login_model.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/colors.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:flutter_cahoi_barbershop/ui/views/_base.dart';
import 'package:flutter_cahoi_barbershop/ui/views/auth/enter_password_view.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/base_text_form_field.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/button_login.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/dialogs/loading_dialog.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  Size size = Size.zero;
  final TextEditingController phoneEditingController = TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();
  bool isValidatePhoneNumber = false;
  String currentPhone = '';

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return BaseView<LoginModel>(
      builder: (context, model, child) => Scaffold(
        key: model.scaffoldKey,
        backgroundColor: backgroundColor,
        body: Stack(
          children: [
            Column(
              children: [
                Image.asset(
                  'assets/bg_login.png',
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          "Hello,",
                          style: TextStyle(
                            color: headerColor1,
                            fontSize: 36,
                            fontFamily: fontBold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          "Login or Register",
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 18,
                          ),
                        ),
                      ),
                      _buildPhoneField(
                        onChanged: (value) {
                          setState(() {
                            currentPhone = PhoneNumber.fromIsoCode(
                                    countryCode, phoneEditingController.text)
                                .international;
                          });
                          formGlobalKey.currentState?.validate();
                        },
                        validator: (_) {
                          if (PhoneNumber.fromIsoCode(
                                  countryCode, phoneEditingController.text)
                              .validate()) {
                            isValidatePhoneNumber = true;
                            return null;
                          } else if (phoneEditingController.text.isEmpty) {
                            isValidatePhoneNumber = false;
                            return "Please enter mobile number";
                          } else {
                            isValidatePhoneNumber = false;
                            return "Please enter valid mobile number";
                          }
                        },
                        onFieldSubmitted: (_) async {
                          LoadingDialog.show(context);
                          currentPhone = PhoneNumber.fromIsoCode(
                                  countryCode, phoneEditingController.text)
                              .international;

                          var res = await model.checkUserExisted(
                            phoneNumber: currentPhone,
                          );

                          ///nếu đã tồn tại thì nhập pass, ngược lại thì đằng kí
                          if (res) {
                            LoadingDialog.dismiss(context);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => EnterPasswordView(
                                    phoneNumber: currentPhone),
                              ),
                            );
                          } else {
                            await model.sendOTP(
                              phoneNumber: currentPhone,
                            );
                            LoadingDialog.dismiss(context);
                          }
                        },
                      ),
                    ],
                  ),
                ),
                MediaQuery.of(context).viewInsets.bottom == 0
                    ? _buildButtonContinue(
                        onCheckUserExisted: () async {
                          LoadingDialog.show(context);
                          currentPhone = PhoneNumber.fromIsoCode(
                                  countryCode, phoneEditingController.text)
                              .international;

                          var res = await model.checkUserExisted(
                            phoneNumber: currentPhone,
                          );

                          ///nếu đã tồn tại thì nhập pass, ngược lại thì đằng kí
                          if (res) {
                            LoadingDialog.dismiss(context);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => EnterPasswordView(
                                    phoneNumber: currentPhone),
                              ),
                            );
                          } else {
                            await model.sendOTP(
                              phoneNumber: currentPhone,
                            );
                            LoadingDialog.dismiss(context);
                          }
                        },
                      )
                    : Container()
              ],
            ),
            MediaQuery.of(context).viewInsets.bottom != 0
                ? Positioned(
                    bottom: size.height * 0.02,
                    child: SizedBox(
                      width: size.width,
                      child: Center(
                        child: _buildButtonContinue(
                          onCheckUserExisted: () async {
                            LoadingDialog.show(context);
                            currentPhone = PhoneNumber.fromIsoCode(
                                    countryCode, phoneEditingController.text)
                                .international;

                            var res = await model.checkUserExisted(
                              phoneNumber: currentPhone,
                            );

                            ///nếu đã tồn tại thì nhập pass, ngược lại thì đằng kí
                            if (res) {
                              LoadingDialog.dismiss(context);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => EnterPasswordView(
                                      phoneNumber: currentPhone),
                                ),
                              );
                            } else {
                              await model.sendOTP(
                                phoneNumber: currentPhone,
                              );
                              LoadingDialog.dismiss(context);
                            }
                          },
                        ),
                      ),
                    ),
                  )
                : Container(),
            Positioned(
              bottom: size.height * 0.07,
              left: 0,
              right: 0,
              child: MediaQuery.of(context).viewInsets.bottom == 0
                  ? Column(
                      children: [
                        Text(
                          "Or continue with",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black.withOpacity(0.5),
                            fontFamily: fontBold,
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        _buildSocials(onLoginGoogle: () async {
                          await model.loginWithGoogle();
                        }, onLoginFacebook: () async {
                          final status = await Permission.storage.request();
                          if (status != PermissionStatus.denied) {
                            await model.loginWithFacebook();
                          }
                        }),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black.withOpacity(0.5),
                                  fontFamily: fontBold,
                                ),
                                text: 'By continuing, you have accepted',
                              ),
                              TextSpan(
                                style: const TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                    fontStyle: FontStyle.italic),
                                text: ' terms of use',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    var url =
                                        'https://hotro.tiki.vn/s/article/dieu-khoan-su-dung';
                                    if (await canLaunch(url)) {
                                      await launch(
                                        url,
                                        forceSafariVC: false,
                                      );
                                    }
                                  },
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonContinue({required Function() onCheckUserExisted}) =>
      BaseButton(
        height: 50,
        width: size.width * 0.9,
        onPressed: isValidatePhoneNumber ? onCheckUserExisted : null,
        title: "Continue",
      );

  Widget _buildSocials({
    required Function() onLoginGoogle,
    required Function() onLoginFacebook,
  }) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            heroTag: "facebook",
            onPressed: onLoginFacebook,
            backgroundColor: Colors.transparent,
            child: Image.asset("assets/ic_facebook.png"),
          ),
          SizedBox(
            width: size.width * 0.03,
          ),
          FloatingActionButton(
            heroTag: "google",
            backgroundColor: Colors.transparent,
            onPressed: onLoginGoogle,
            child: Image.asset("assets/ic_google.png"),
          ),
        ],
      );

  Widget _buildPhoneField({
    Function(String? value)? onChanged,
    Function(String? value)? onFieldSubmitted,
    FormFieldValidator<String>? validator,
  }) =>
      Form(
        key: formGlobalKey,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: BaseTextFormField(
            textInputFormatter: r'^([0-9]+([.][0-9]*)?|[.][0-9]+)',
            maxLength: 15,
            controller: phoneEditingController,
            textInputAction: TextInputAction.send,
            hintText: "Phone number",
            onChanged: onChanged,
            onFieldSubmitted: onFieldSubmitted,
            validator: validator,
          ),
        ),
      );
}
