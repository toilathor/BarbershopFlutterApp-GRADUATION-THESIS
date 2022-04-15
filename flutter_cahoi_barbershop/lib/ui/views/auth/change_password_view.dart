import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/change_password_model.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/colors.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:flutter_cahoi_barbershop/ui/views/_base.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/button_login.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/text_regex.dart';
import 'package:provider/provider.dart';

class ChangePasswordView extends StatefulWidget {
  final String phoneNumber;

  const ChangePasswordView({Key? key, required this.phoneNumber})
      : super(key: key);

  @override
  _ChangePasswordViewState createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final formKey = GlobalKey<FormState>();
  bool isHidePassword = false;
  Size size = Size.zero;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return BaseView<ChangePasswordModel>(
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    _buildNewPasswordField(
                      onFieldSubmitted: (_) async {
                        if (await model.changePassword(widget.phoneNumber)) {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.SUCCES,
                            title: 'Successful',
                            btnOkOnPress: () {
                              Navigator.of(context)
                                  .popUntil((route) => route.isFirst);
                            },
                            dismissOnBackKeyPress: false,
                            dismissOnTouchOutside: false,
                          ).show();
                        } else {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.ERROR,
                            title: 'Fail',
                          ).show();
                        }
                      },
                      validator: (_) {
                        return model.validatePassword() ?? '';
                      },
                      onChange: (value) {
                        model.changeCurrentPassword();
                        formKey.currentState?.validate();
                      },
                      changeCurrentPassword: (value) {
                        model.changePassword(value);
                      },
                      passEditingController: model.passEditingController,
                      currentPassword: model.currentPassword,
                    ),
                    _buildRegex(
                      isLength: model.isLength,
                      isNumeric: model.isNumeric,
                      isUppercase: model.isUppercase,
                    ),
                  ],
                ),
                _buildButtonChangePass(
                  isAllReady: model.isAllReady,
                  onChangePassword: () async {
                    await model.changePassword(widget.phoneNumber);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() => const Text(
        'Create New Password',
        style: TextStyle(
          fontSize: 36,
          fontFamily: fontBold,
          color: headerColor1,
        ),
        textAlign: TextAlign.left,
      );

  Widget _buildNewPasswordField({
    required Function(String) onFieldSubmitted,
    required String Function(String?)? validator,
    required Function(String?) onChange,
    required Function(String) changeCurrentPassword,
    required TextEditingController passEditingController,
    required String currentPassword,
  }) =>
      Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextFormField(
            style: const TextStyle(
              color: Colors.black,
              fontSize: 24,
            ),
            // autofillHints: const [AutofillHints.],
            textInputAction: TextInputAction.done,
            validator: validator,
            cursorColor: Colors.black,
            controller: passEditingController,
            keyboardType: TextInputType.visiblePassword,
            obscureText: isHidePassword,
            obscuringCharacter: '*',
            onChanged: onChange,
            onFieldSubmitted: onFieldSubmitted,
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
                  currentPassword.isNotEmpty
                      ? IconButton(
                          splashColor: Colors.transparent,
                          onPressed: () {
                            changeCurrentPassword('');
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

  Widget _buildButtonChangePass(
          {required bool isAllReady, required Function() onChangePassword}) =>
      Consumer<ChangePasswordModel>(
        builder: (context, value, child) => Positioned(
          bottom: size.height * 0.02,
          child: BaseButton(
              height: size.height * 0.06,
              width: size.width * 0.9,
              onPressed: isAllReady ? onChangePassword : null,
              title: 'Change Password'),
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
}
