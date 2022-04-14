import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/enter_password_model.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/colors.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:flutter_cahoi_barbershop/ui/views/login/widgets/button_login.dart';
import 'package:flutter_cahoi_barbershop/ui/views/login/widgets/text_regex.dart';
import 'package:provider/provider.dart';

class EnterPasswordView extends StatefulWidget {
  final String phoneNumber;

  const EnterPasswordView({Key? key, required this.phoneNumber})
      : super(key: key);

  @override
  _EnterPasswordViewState createState() => _EnterPasswordViewState();
}

class _EnterPasswordViewState extends State<EnterPasswordView> {
  final model = locator<EnterPasswordModel>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ChangeNotifierProvider<EnterPasswordModel>(
      create: (context) => model,
      child: Scaffold(
        key: model.scaffoldKey,
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
                        _buildPasswordField(),
                        _buildRegex(size),
                      ],
                    ),
                  ),
                ],
              ),
              _buildBottomLogin(size),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField() => Consumer<EnterPasswordModel>(
        builder: (context, value, child) => Form(
          key: model.formGlobalKey,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextFormField(
              style: const TextStyle(
                color: Colors.black,
                fontSize: 24,
              ),
              // autofillHints: const [AutofillHints.],
              textInputAction: TextInputAction.done,
              validator: (_) {
                return model.validatePassword();
              },
              cursorColor: Colors.black,
              controller: model.textEditingController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: model.isHidePassword,
              obscuringCharacter: '*',
              onChanged: (value) {
                model.changeCurrentPassword();
                model.formGlobalKey.currentState?.validate();
              },
              maxLength: 250,
              autocorrect: true,
              onFieldSubmitted: (_) async {
                await model.login(widget.phoneNumber);
              },
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
                      model.currentPassword.isNotEmpty
                          ? IconButton(
                              splashColor: Colors.transparent,
                              onPressed: () {
                                model.changeCurrentPassword(value: '');
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

  Widget _buildBottomLogin(Size size) => Consumer<EnterPasswordModel>(
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
                          ? () async {
                              await model.login(widget.phoneNumber);
                            }
                          : null,
                      title: "Login"),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          model.forgotPassword();
                        },
                        child: const Text("Forgot password?"),
                        style: const ButtonStyle(
                            splashFactory: NoSplash.splashFactory),
                      ),
                      TextButton(
                        onPressed: () async {},
                        child: const Text("Login by SMS"),
                        style: const ButtonStyle(
                            splashFactory: NoSplash.splashFactory),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );

  Widget _buildRegex(Size size) => Consumer<EnterPasswordModel>(
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
}
