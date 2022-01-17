import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/view_models/forgot_password_model.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/views/login/widgets/button_login.dart';
import 'package:provider/provider.dart';

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
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    _buildPhoneField(),
                  ],
                ),
                _buildButtonResetPass(size),
              ],
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

  _buildButtonResetPass(Size size) => Consumer<ForgotPasswordModel>(
        builder: (context, value, child) => Positioned(
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
        ),
      );

  _buildPhoneField() => Consumer<ForgotPasswordModel>(
        builder: (context, value, child) => Form(
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
        ),
      );
}
