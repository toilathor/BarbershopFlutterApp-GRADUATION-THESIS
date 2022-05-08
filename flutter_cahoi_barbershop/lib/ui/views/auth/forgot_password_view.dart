import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/login_model.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/colors.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:flutter_cahoi_barbershop/ui/views/_base.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/button_login.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/dialogs/loading_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  _ForgotPasswordViewState createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
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
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    _buildPhoneField(
                      onFieldSubmitted: () async {
                        await model.sendOTPForgotPassword(
                            phoneNumber: currentPhone);
                      },
                    ),
                  ],
                ),
                _buildButtonResetPass(
                  onSentOTP: () async {
                    LoadingDialog.show(context);
                    currentPhone = PhoneNumber.fromIsoCode(
                            countryCode, phoneEditingController.text)
                        .international;

                    var res = await model.checkUserExisted(
                      phoneNumber: currentPhone,
                    );

                    ///nếu đã tồn tại thì nhập pass, ngược lại thì đằng kí
                    if (!res) {
                      LoadingDialog.dismiss(context);
                      Fluttertoast.showToast(msg: 'User not found!');
                    } else {
                      await model.sendOTPForgotPassword(
                        phoneNumber: currentPhone,
                      );
                      LoadingDialog.dismiss(context);
                    }
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
        'Forgot Password?',
        style: TextStyle(
          fontSize: 36,
          fontFamily: fontBold,
          color: headerColor1,
        ),
        textAlign: TextAlign.left,
      );

  Widget _buildButtonResetPass({required Function() onSentOTP}) => Positioned(
        bottom: size.height * 0.02,
        child: BaseButton(
            height: size.height * 0.06,
            width: size.width * 0.9,
            onPressed: isValidatePhoneNumber ? onSentOTP : null,
            title: 'Reset Password'),
      );

  Widget _buildPhoneField({required Function() onFieldSubmitted}) => Form(
        key: formGlobalKey,
        child: TextFormField(
          style: const TextStyle(
            color: Colors.black,
            fontSize: 36,
          ),
          // autofillHints: const [AutofillHints.],
          textInputAction: TextInputAction.done,
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
          cursorColor: Colors.black,
          controller: phoneEditingController,
          keyboardType: TextInputType.visiblePassword,
          onChanged: (value) {
            setState(() {
              currentPhone = PhoneNumber.fromIsoCode(
                      countryCode, phoneEditingController.text)
                  .international;
            });
            formGlobalKey.currentState?.validate();
          },
          onFieldSubmitted: (_) async {
            if (isValidatePhoneNumber) {
              onFieldSubmitted();
            }
          },
          maxLength: 250,
          autocorrect: true,
          decoration: InputDecoration(
            labelText: "Please enter a phone number",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelStyle: TextStyle(
              color: Colors.black.withOpacity(0.5),
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
            hintText: "Phone number",
            counterText: "",
            hintStyle: TextStyle(
              fontSize: 36,
              color: Colors.grey.withOpacity(0.5),
            ),
          ),
        ),
      );
}
