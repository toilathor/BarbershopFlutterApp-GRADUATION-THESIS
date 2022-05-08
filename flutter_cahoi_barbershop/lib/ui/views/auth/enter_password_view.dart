import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/auth_model.dart';
import 'package:flutter_cahoi_barbershop/home_view.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/colors.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:flutter_cahoi_barbershop/ui/views/_base.dart';
import 'package:flutter_cahoi_barbershop/ui/views/auth/forgot_password_view.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/button_login.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/dialogs/loading_dialog.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/text_regex.dart';

class EnterPasswordView extends StatefulWidget {
  final String phoneNumber;

  const EnterPasswordView({Key? key, required this.phoneNumber})
      : super(key: key);

  @override
  _EnterPasswordViewState createState() => _EnterPasswordViewState();
}

class _EnterPasswordViewState extends State<EnterPasswordView> {
  final formPassKey = GlobalKey<FormState>();
  final passEditingController = TextEditingController();

  String currentPassword = '';
  String currentName = '';

  String? messageValidatePassword;
  bool isUppercase = false;
  bool isNumeric = false;
  bool isLength = false;
  bool isHidePassword = true;

  Size size = Size.zero;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return BaseView<AuthModel>(
      builder: (context, model, child) => Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text(
                            "Enter Password",
                            style: TextStyle(
                              fontSize: 36,
                              fontFamily: fontBold,
                              color: headerColor1,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: RichText(
                            text: TextSpan(
                              text: "Please enter password of phone number ",
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
                                fontFamily: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .fontFamily,
                              ),
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        _buildPasswordField(
                          onFieldSubmitted: (_) async {
                            if (isUppercase && isNumeric && isLength) {
                              await _login(model: model);
                            }
                          },
                        ),
                        _buildRegex(
                          isLength: isLength,
                          isNumeric: isNumeric,
                          isUppercase: isUppercase,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              _buildBottomLogin(
                onLogin: () async {
                  if (isUppercase && isNumeric && isLength) {
                    await _login(model: model);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({required Function(String) onFieldSubmitted}) =>
      Form(
        key: formPassKey,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextFormField(
            style: const TextStyle(
              color: Colors.black,
              fontSize: 24,
            ),
            textInputAction: TextInputAction.done,
            validator: (_) {
              RegExp regex = RegExp(
                  r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$');
              if (currentPassword.isEmpty) {
                return 'Please enter password';
              } else {
                if (!regex.hasMatch(currentPassword)) {
                  return 'Enter valid password';
                } else {
                  return null;
                }
              }
            },
            cursorColor: Colors.black,
            controller: passEditingController,
            keyboardType: TextInputType.visiblePassword,
            obscureText: isHidePassword,
            obscuringCharacter: '●',
            onChanged: (value) {
              setState(() {
                currentPassword = passEditingController.text;

                validateUppercase();
                validateNumeric();
                validateLength();
              });
              formPassKey.currentState!.validate();
            },
            maxLength: 250,
            autocorrect: true,
            onFieldSubmitted: onFieldSubmitted,
            decoration: InputDecoration(
              hintText: "Password",
              counterText: "",
              hintStyle: TextStyle(
                fontSize: 24,
                color: Colors.grey.withOpacity(0.5),
              ),
              suffix: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  currentPassword.isNotEmpty
                      ? IconButton(
                          splashColor: Colors.transparent,
                          onPressed: () {
                            setState(() {
                              passEditingController.text = '';
                            });
                          },
                          icon: const Icon(
                            Icons.cancel,
                            size: 24,
                            color: Colors.red,
                          ),
                        )
                      : Container(),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isHidePassword = !isHidePassword;
                      });
                    },
                    style: const ButtonStyle(
                        splashFactory: NoSplash.splashFactory),
                    child: Text(isHidePassword ? 'Show' : 'Hide'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Widget _buildBottomLogin({required Function() onLogin}) => Positioned(
        bottom: size.height * 0.02,
        child: SizedBox(
          width: size.width,
          child: Column(
            children: [
              Center(
                child: BaseButton(
                  height: size.height * 0.06,
                  width: size.width * 0.9,
                  onPressed: onLogin,
                  // isLength && isUppercase && isNumeric ? onLogin : null,
                  title: "Login",
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ForgotPasswordView(),
                          ),
                        );
                      },
                      child: const Text("Forgot password?"),
                      style: const ButtonStyle(
                        splashFactory: NoSplash.splashFactory,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );

  Widget _buildRegex({
    required bool isUppercase,
    required bool isNumeric,
    required bool isLength,
  }) =>
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TextRegex(
            title: "• contains 1 uppercase character",
            validated: isUppercase,
          ),
          TextRegex(
            title: "• contains 1 numeric character",
            validated: isNumeric,
          ),
          TextRegex(
            title: "• length must be greater than or equal to 8 characters",
            validated: isLength,
          ),
        ]),
      );

  validateUppercase() {
    RegExp regex = RegExp(r'(?=.*[A-Z])');
    if (!regex.hasMatch(currentPassword)) {
      isUppercase = false;
    } else {
      isUppercase = true;
    }
  }

  validateNumeric() {
    RegExp regex = RegExp(r'(?=.*?[0-9])');
    if (!regex.hasMatch(currentPassword)) {
      isNumeric = false;
    } else {
      isNumeric = true;
    }
  }

  validateLength() {
    RegExp regex = RegExp(r'.{8,}');
    if (!regex.hasMatch(currentPassword)) {
      isLength = false;
    } else {
      isLength = true;
    }
  }

  Future _login({required AuthModel model}) async {
    LoadingDialog.show(context);
    if (await model.loginWithPhoneNumber(
      phoneNumber: widget.phoneNumber,
      currentPassword: passEditingController.text,
    )) {
      LoadingDialog.dismiss(context);
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const HomeView(),
        ),
        (route) => false,
      );
    } else {
      LoadingDialog.dismiss(context);
    }
  }
}
