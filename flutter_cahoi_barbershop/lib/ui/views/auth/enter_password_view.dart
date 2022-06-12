import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/models/user.dart';
import 'package:flutter_cahoi_barbershop/core/services/auth_service.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/auth_model.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/colors.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/helper.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/router_login.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/server_config.dart';
import 'package:flutter_cahoi_barbershop/ui/views/_base.dart';
import 'package:flutter_cahoi_barbershop/ui/views/auth/forgot_password_view.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/button_login.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/dialogs/loading_dialog.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/text_regex.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EnterPasswordView extends StatefulWidget {
  final String phoneNumber;

  const EnterPasswordView({Key? key, required this.phoneNumber})
      : super(key: key);

  @override
  _EnterPasswordViewState createState() => _EnterPasswordViewState();
}

class _EnterPasswordViewState extends State<EnterPasswordView> {
  final formPassKey = GlobalKey<FormState>();
  final passController = TextEditingController();

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
        appBar: AppBar(),
        backgroundColor: backgroundColor,
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text(
                            appLang(context)!.login,
                            style: const TextStyle(
                              fontSize: 36,
                              fontFamily: fontBold,
                              color: headerColor1,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: RichText(
                            text: TextSpan(
                              text: appLang(context)!.please_enter_pass,
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
              if (!regex.hasMatch(currentPassword)) {
                return appLang(context)!.warning_pass_invalid;
              } else {
                return null;
              }
            },
            cursorColor: Colors.black,
            controller: passController,
            keyboardType: TextInputType.visiblePassword,
            obscureText: isHidePassword,
            obscuringCharacter: '●',
            onChanged: (value) {
              setState(() {
                currentPassword = passController.text;

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
              hintText: appLang(context)!.password,
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
                              passController.text = '';
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
                    child: Text(
                      isHidePassword
                          ? appLang(context)!.show
                          : appLang(context)!.hide,
                    ),
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
                  title: appLang(context)!.login,
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
                      child: Text(appLang(context)!.forgot_pass),
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
            title: appLang(context)!.warning_upcase,
            validated: isUppercase,
          ),
          TextRegex(
            title: appLang(context)!.warning_numeric,
            validated: isNumeric,
          ),
          TextRegex(
            title: appLang(context)!.warning_length,
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
      currentPassword: passController.text,
    )) {
      LoadingDialog.dismiss(context);
      MUser user = locator<AuthenticationService>().user;

      Role role = Role.values[user.roles?.first.id ?? 1];

      RouterLogin.navigation(
        context,
        role: role,
      );
    } else {
      Fluttertoast.cancel();
      Fluttertoast.showToast(msg: appLang(context)!.wrong_password);
      formPassKey.currentState!.validate();
      setState(() {
        passController.text = "";
        validateUppercase();
        validateLength();
        validateNumeric();
      });
      LoadingDialog.dismiss(context);
    }
  }
}
