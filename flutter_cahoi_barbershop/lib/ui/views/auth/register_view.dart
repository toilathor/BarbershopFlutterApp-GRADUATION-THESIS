import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/login_model.dart';
import 'package:flutter_cahoi_barbershop/home_view.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/colors.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:flutter_cahoi_barbershop/ui/views/_base.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/button_login.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/dialogs/loading_dialog.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/text_regex.dart';

class RegisterView extends StatefulWidget {
  final String phoneNumber;

  const RegisterView({
    Key? key,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final formPassKey = GlobalKey<FormState>();
  final formNameKey = GlobalKey<FormState>();
  final nameEditingController = TextEditingController();
  final passEditingController = TextEditingController();

  String currentPassword = '';
  String currentName = '';

  String? messageValidatePassword;
  String? messageValidateName;
  bool isUppercase = false;
  bool isNumeric = false;
  bool isLength = false;
  bool isValidatedName = false;
  bool isHidePassword = true;

  Size size = Size.zero;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return BaseView<LoginModel>(
      builder: (context, model, child) => Scaffold(
        key: model.scaffoldKey,
        backgroundColor: Theme.of(context).backgroundColor,
        body: SafeArea(
          child: Stack(
            children: [
              ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text(
                              "Register",
                              style: TextStyle(
                                fontSize: 36,
                                fontFamily: fontBold,
                                color: headerColor1,
                              ),
                            ),
                          ),
                          _buildNameField(),
                          _buildPasswordField(),
                          _buildRegex(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              _buildButtonRegister(
                onRegister: () async {
                  LoadingDialog.show(context);
                  if (await model.register(
                    phoneNumber: widget.phoneNumber,
                    currentPassword: currentPassword,
                    currentName: currentName,
                  )) {
                    LoadingDialog.dismiss(context);
                    if (await model.login(
                      phoneNumber: widget.phoneNumber,
                      currentPassword: currentPassword,
                    )) {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const HomeView(),
                        ),
                        (route) => false,
                      );
                    } else {
                      Navigator.pushNamedAndRemoveUntil(
                          context, 'login', (route) => false);
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNameField() => Form(
        key: formNameKey,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextFormField(
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
            textInputAction: TextInputAction.done,
            validator: (_) {
              if (currentName.length > 30 || currentName.isEmpty) {
                isValidatedName = false;
                return 'Name is too long';
              } else if (currentName.split(" ").length < 2) {
                isValidatedName = false;
                return 'Name must have at least 2 words';
              } else {
                isValidatedName = true;
                return null;
              }
            },
            cursorColor: Colors.black,
            controller: nameEditingController,
            keyboardType: TextInputType.name,
            onChanged: (value) {
              setState(() {
                currentName = nameEditingController.text;
              });

              formNameKey.currentState!.validate();
            },
            maxLength: 30,
            autocorrect: true,
            decoration: InputDecoration(
              labelText: "Please indicate your name",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelStyle: TextStyle(
                color: Colors.black.withOpacity(0.5),
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
              hintText: "Name: Contains at least 2 words",
              counterText: "",
              hintStyle: TextStyle(
                fontSize: 18,
                color: Colors.grey.withOpacity(0.5),
              ),
            ),
          ),
        ),
      );

  Widget _buildPasswordField() => Form(
        key: formPassKey,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextFormField(
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
            // autofillHints: const [AutofillHints.],
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
            obscuringCharacter: '*',
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
            decoration: InputDecoration(
                labelText: "Please enter a password",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelStyle: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
                hintText: "Password",
                counterText: "",
                hintStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.grey.withOpacity(0.5),
                ),
                suffix: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    currentPassword.isNotEmpty
                        ? IconButton(
                            splashColor: Colors.transparent,
                            onPressed: () {
                              passEditingController.text = '';
                            },
                            icon: const Icon(
                              Icons.cancel,
                              size: 16,
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
                )),
          ),
        ),
      );

  Widget _buildRegex() => Padding(
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

  Widget _buildButtonRegister({required Function() onRegister}) => Positioned(
        bottom: size.height * 0.02,
        child: SizedBox(
          width: size.width,
          child: Column(
            children: [
              Center(
                child: BaseButton(
                  height: size.height * 0.06,
                  width: size.width * 0.9,
                  onPressed:
                      isLength && isUppercase && isValidatedName && isNumeric
                          ? onRegister
                          : null,
                  title: "Register",
                ),
              ),
            ],
          ),
        ),
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
}
