import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/auth_model.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/colors.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/helper.dart';
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

    return BaseView<AuthModel>(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(),
        backgroundColor: backgroundColor,
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
                        //TODO update api
                        // await model.sendOTPForgotPassword(
                        //     phoneNumber: currentPhone);
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

                    if (res == null) {
                      LoadingDialog.dismiss(context);
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.ERROR,
                        btnOkOnPress: () {},
                        title: 'Error server!',
                      ).show();
                    } else if (!res) {
                      ///nếu đã tồn tại thì nhập pass, ngược lại thì đằng kí
                      LoadingDialog.dismiss(context);
                      Fluttertoast.cancel();
                      Fluttertoast.showToast(
                          msg: appLang(context)!.user_not_find);
                    } else {
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

  Widget _buildHeader() => Text(
        appLang(context)!.forgot_pass,
        style: const TextStyle(
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
          title: appLang(context)!.reset_password,
        ),
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
              return appLang(context)!.warning_enter_phoneNum;
            } else {
              isValidatePhoneNumber = false;
              return appLang(context)!.warning_pass_invalid;
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
            labelText: appLang(context)!.warning_enter_phoneNum,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelStyle: TextStyle(
              color: Colors.black.withOpacity(0.5),
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
            hintText: appLang(context)!.phone_number,
            counterText: "",
            hintStyle: TextStyle(
              fontSize: 36,
              color: Colors.grey.withOpacity(0.5),
            ),
          ),
        ),
      );
}
