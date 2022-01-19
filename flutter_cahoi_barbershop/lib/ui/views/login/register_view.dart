import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/view_models/register_model.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/views/login/widgets/button_login.dart';
import 'package:flutter_cahoi_barbershop/ui/views/login/widgets/text_regex.dart';
import 'package:provider/provider.dart';

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
  final model = locator<RegisterModel>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ChangeNotifierProvider<RegisterModel>(
      create: (context) => model,
      child: Scaffold(
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
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text(
                              "Register",
                              style: Theme.of(context).textTheme.headline1,
                            ),
                          ),
                          _buildNameField(),
                          _buildPasswordField(),
                          _buildRegex(size, context),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              _buildButtonLogin(size),
            ],
          ),
        ),
      ),
    );
  }

  _buildNameField() => Consumer<RegisterModel>(
        builder: (context, value, child) => Form(
          key: model.formNameKey,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextFormField(
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              textInputAction: TextInputAction.done,
              validator: (_) {
                return model.validateName();
              },
              cursorColor: Colors.black,
              controller: model.nameEditingController,
              keyboardType: TextInputType.name,
              onChanged: (value) {
                model.changeCurrentName();
                model.formNameKey.currentState!.validate();
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
        ),
      );

  _buildPasswordField() => Consumer<RegisterModel>(
        builder: (context, value, child) => Form(
          key: model.formPassKey,
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
                return model.validatePassword();
              },
              cursorColor: Colors.black,
              controller: model.passEditingController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: model.isHidePassword,
              obscuringCharacter: '*',
              onChanged: (value) {
                model.changeCurrentPassword();
                model.formPassKey.currentState!.validate();
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
                      model.currentPassword.isNotEmpty
                          ? IconButton(
                              splashColor: Colors.transparent,
                              onPressed: () {
                                model.changeCurrentPassword(value: '');
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
                            model.changeHidePassword();
                          },
                          style: const ButtonStyle(
                              splashFactory: NoSplash.splashFactory),
                          child: Text(model.isHidePassword ? 'Show' : 'Hide')),
                    ],
                  )),
            ),
          ),
        ),
      );

  _buildRegex(Size size, BuildContext context) => Consumer<RegisterModel>(
        builder: (context, value, child) => Padding(
          padding: const EdgeInsets.all(12.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            TextRegex(
              title: "• contains 1 uppercase character",
              validated: model.isUppercase,
            ),
            TextRegex(
              title: "• contains 1 numeric character",
              validated: model.isNumeric,
            ),
            TextRegex(
              title: "• length must be greater than or equal to 8 characters",
              validated: model.isLength,
            ),
          ]),
        ),
      );

  _buildButtonLogin(Size size) => Consumer<RegisterModel>(
        builder: (context, value, child) => Positioned(
          bottom: size.height * 0.02,
          child: SizedBox(
            width: size.width,
            child: Column(
              children: [
                Center(
                  child: ButtonLogin(
                      height: size.height * 0.06,
                      width: size.width * 0.9,
                      onPressed: model.isAllReady
                          ? () {
                              model.register(widget.phoneNumber);
                            }
                          : null,
                      title: "Register"),
                ),
              ],
            ),
          ),
        ),
      );
}
