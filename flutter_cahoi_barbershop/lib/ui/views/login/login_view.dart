import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/view_models/login_model.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/views/login/widgets/button_login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final model = locator<LoginModel>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ChangeNotifierProvider<LoginModel>(
      create: (context) => model,
      child: Scaffold(
        key: model.scaffoldKey,
        backgroundColor: Theme.of(context).backgroundColor,
        body: Stack(
          children: [
            Column(
              children: [
                Image.asset(
                  'assets/bg_login.png',
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          "Hello,",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          "Login or Register",
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 18,
                            fontFamily: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .fontFamily,
                          ),
                        ),
                      ),
                      _buildPhoneField(),
                    ],
                  ),
                ),
                MediaQuery.of(context).viewInsets.bottom == 0
                    ? _buildButtonContinue(size, context)
                    : Container()
              ],
            ),
            MediaQuery.of(context).viewInsets.bottom != 0
                ? Positioned(
                    bottom: size.height * 0.02,
                    child: SizedBox(
                      width: size.width,
                      child: Center(
                        child: _buildButtonContinue(size, context),
                      ),
                    ),
                  )
                : Container(),
            Positioned(
              bottom: size.height * 0.07,
              left: 0,
              right: 0,
              child: MediaQuery.of(context).viewInsets.bottom == 0
                  ? Column(
                      children: [
                        Text(
                          "Or continue with",
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        _buildSocials(size),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                style: Theme.of(context).textTheme.subtitle2,
                                text: 'By continuing, you have accepted',
                              ),
                              TextSpan(
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .fontSize,
                                    fontFamily: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .fontFamily,
                                    decoration: TextDecoration.underline,
                                    fontStyle: FontStyle.italic),
                                text: ' terms of use',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    var url =
                                        'https://hotro.tiki.vn/s/article/dieu-khoan-su-dung';
                                    if (await canLaunch(url)) {
                                      await launch(
                                        url,
                                        forceSafariVC: false,
                                      );
                                    }
                                  },
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonContinue(Size size, BuildContext context) =>
      Consumer<LoginModel>(
        builder: (context, value, child) => ButtonLogin(
            height: size.height * 0.06,
            width: size.width * 0.9,
            onPressed: model.isValidatePhoneNumber
                ? () async {
                    await model.checkUserExisted();
                  }
                : null,
            title: "Continue"),
      );

  Widget _buildSocials(Size size) => Consumer<LoginModel>(
        builder: (context, value, child) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
              heroTag: "facebook",
              onPressed: () async {
                await model.loginWithFacebook();
              },
              backgroundColor: Colors.transparent,
              child: Image.asset("assets/ic_facebook.png"),
            ),
            SizedBox(
              width: size.width * 0.03,
            ),
            FloatingActionButton(
              heroTag: "google",
              backgroundColor: Colors.transparent,
              onPressed: () async {
                await model.loginWithGoogle();
              },
              child: Image.asset("assets/ic_google.png"),
            ),
            SizedBox(
              width: size.width * 0.03,
            ),
            FloatingActionButton(
              heroTag: "zalo",
              backgroundColor: Colors.transparent,
              onPressed: () async {
                Fluttertoast.showToast(
                  msg: 'We will connect with Zalo soon in the future!',
                );
              },
              child: Image.asset("assets/ic_zalo.png"),
            ),
          ],
        ),
      );

  _buildPhoneField() => Consumer<LoginModel>(
        builder: (context, value, child) => Form(
          key: model.formGlobalKey,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextFormField(
              style: const TextStyle(
                color: Colors.black,
                fontSize: 36,
              ),
              // autofillHints: const [AutofillHints.],
              textInputAction: TextInputAction.send,
              validator: (value) {
                return model.validatePhoneNumber();
              },
              cursorColor: Colors.black,
              controller: model.textEditingController,
              keyboardType: TextInputType.phone,
              onChanged: (_) {
                model.changeCurrentPhone();
              },
              onFieldSubmitted: (value) async {
                await model.checkUserExisted();
              },
              maxLength: 15,
              autocorrect: true,
              decoration: InputDecoration(
                hintText: "Phone number",
                counterText: "",
                hintStyle: TextStyle(
                  fontSize: 36,
                  color: Colors.grey.withOpacity(0.5),
                ),
              ),
            ),
          ),
        ),
      );
}
