import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/view_models/reset_password_model.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/views/login/widgets/button_login.dart';
import 'package:flutter_cahoi_barbershop/ui/views/login/widgets/text_regex.dart';
import 'package:provider/provider.dart';

class ResetPasswordView extends StatefulWidget {
  final String phoneNumber;
  const ResetPasswordView({Key? key, required this.phoneNumber})
      : super(key: key);

  @override
  _ResetPasswordViewState createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final model = locator<ResetPasswordModel>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ChangeNotifierProvider<ResetPasswordModel>(
      create: (context) => model,
      child: Scaffold(
        key: model.scaffoldKey,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    _buildNewPasswordField(),
                    _buildRegex(size),
                  ],
                ),
                _buildButtonChangePass(size),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildHeader() => Text(
        'Create New Password',
        style: Theme.of(context).textTheme.headline1,
        textAlign: TextAlign.left,
      );

  _buildNewPasswordField() => Consumer<ResetPasswordModel>(
        builder: (context, value, child) => Form(
          key: model.formKey,
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
              controller: model.passEditingController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: model.isHidePassword,
              obscuringCharacter: '*',
              onChanged: (value) {
                model.changeCurrentPassword();
                model.formKey.currentState?.validate();
              },
              maxLength: 250,
              autocorrect: true,
              decoration: InputDecoration(
                  hintText: "Password",
                  counterText: "",
                  hintStyle: TextStyle(
                    fontSize: 24,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  labelText: "Please enter a new password",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelStyle: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
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

  _buildButtonChangePass(Size size) => Consumer<ResetPasswordModel>(
        builder: (context, value, child) => Positioned(
          bottom: size.height * 0.02,
          child: ButtonLogin(
              height: size.height * 0.06,
              width: size.width * 0.9,
              onPressed: model.isAllReady
                  ? () async {
                      await model.changePassword(widget.phoneNumber);
                    }
                  : null,
              title: 'Change Password'),
        ),
      );

  _buildRegex(
    Size size,
  ) =>
      Consumer<ResetPasswordModel>(
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
