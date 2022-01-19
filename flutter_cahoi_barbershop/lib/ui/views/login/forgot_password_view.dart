import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/view_models/forgot_password_model.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/views/login/widgets/button_login.dart';
import 'package:provider/provider.dart';

import 'enter_pin_view.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  _ForgotPasswordViewState createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final model = locator<ForgotPasswordModel>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ChangeNotifierProvider<ForgotPasswordModel>(
      create: (context) => model,
      child: Scaffold(
        key: model.scaffoldKey,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Consumer<ForgotPasswordModel>(
              builder: (context, value, child) => Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(),
                      model.isSendOTP ? _buildNotifi(size) : _buildPhoneField(),
                    ],
                  ),
                  model.isSendOTP
                      ? goToEnterOTP(size)
                      : _buildButtonResetPass(size),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildHeader() => Text(
        'Forgot Password?',
        style: Theme.of(context).textTheme.headline1,
        textAlign: TextAlign.left,
      );

  _buildButtonResetPass(Size size) => Positioned(
        bottom: size.height * 0.02,
        child: ButtonLogin(
            height: size.height * 0.06,
            width: size.width * 0.9,
            onPressed: model.isValidatePhoneNumber
                ? () async {
                    await model.sendOTP();
                  }
                : null,
            title: 'Reset Password'),
      );

  _buildPhoneField() => Form(
        key: model.formKey,
        child: TextFormField(
          style: const TextStyle(
            color: Colors.black,
            fontSize: 36,
          ),
          // autofillHints: const [AutofillHints.],
          textInputAction: TextInputAction.done,
          validator: (_) {
            return model.validatePhoneNumber();
          },
          cursorColor: Colors.black,
          controller: model.phoneEditingController,
          keyboardType: TextInputType.visiblePassword,
          onChanged: (value) {
            model.changeCurrentPhone();
          },
          onFieldSubmitted: (_) async {
            await model.sendOTP();
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

  _buildNotifi(Size size) => Expanded(
          child: Center(
        child: Column(children: [
          const Icon(
            Icons.check_circle,
            color: Colors.green,
          ),
          Container(
            width: size.width,
            padding: const EdgeInsets.all(8.0),
            child: RichText(
              text: TextSpan(
                text:
                    "The OTP code used to recover the password has been sent to ",
                children: [
                  TextSpan(
                    text: model.currrentPhoneNumber,
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
                  fontFamily: Theme.of(context).textTheme.subtitle1!.fontFamily,
                ),
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ]),
      ));
  goToEnterOTP(Size size) => Positioned(
        bottom: size.height * 0.02,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => EnterPinView(
                      phoneNumber: model.currrentPhoneNumber,
                      verificationId: model.verificationId,
                      typeOTP: TypeOTP.resetPassword),
                ),
                (route) => route.isFirst);
          },
          child: Container(
            padding: const EdgeInsets.all(4.0),
            height: size.height * 0.06,
            width: size.width * 0.89,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(
                  color: Theme.of(context).textTheme.headline2!.color!),
            ),
            child: Center(
              child: Text(
                'Close',
                style: TextStyle(
                  fontFamily: Theme.of(context).textTheme.subtitle2!.fontFamily,
                  color: Theme.of(context).textTheme.headline2?.color,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
      );
}
