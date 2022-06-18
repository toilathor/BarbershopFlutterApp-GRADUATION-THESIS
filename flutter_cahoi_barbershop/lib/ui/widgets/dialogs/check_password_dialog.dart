import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/auth_model.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/helper.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/style.dart';
import 'package:flutter_cahoi_barbershop/ui/views/_base.dart';

class CheckPasswordDialog {
  static Future<bool?> show(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (_) => const _CheckPasswordBody(),
    );
  }

  static dismiss(BuildContext context) {
    Navigator.pop(context);
  }
}

class _CheckPasswordBody extends StatefulWidget {
  const _CheckPasswordBody({Key? key}) : super(key: key);

  @override
  State<_CheckPasswordBody> createState() => _CheckPasswordBodyState();
}

class _CheckPasswordBodyState extends State<_CheckPasswordBody> {
  final formKey = GlobalKey<FormState>();
  final controller = TextEditingController();

  bool isHintPass = true;
  bool isError = false;

  @override
  Widget build(BuildContext context) {
    return BaseView<AuthModel>(
      builder: (context, model, child) => AlertDialog(
        title: Text(
          appLang(context)!.password,
        ),
        shape: RoundedRectangleBorder(borderRadius: borderRadius12),
        content: Form(
          key: formKey,
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: "Abcd1234",
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isHintPass = !isHintPass;
                  });
                },
                icon: Icon(
                  isHintPass
                      ? Icons.remove_red_eye_outlined
                      : Icons.remove_red_eye,
                  color: isHintPass ? Colors.grey : Colors.blue,
                ),
              ),
            ),
            obscureText: isHintPass,
            validator: (_) {
              if (controller.text.isEmpty || controller.text.length < 8) {
                return appLang(context)!.warning_length;
              }

              if (validateNumeric(controller.text)) {
                return appLang(context)!.warning_numeric;
              }

              if (validateUppercase(controller.text)) {
                return appLang(context)!.warning_upcase;
              }

              if (isError) {
                return appLang(context)!.wrong_password;
              }

              return null;
            },
            onChanged: (_) {
              isError = false;
              formKey.currentState!.validate();
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              appLang(context)!.cancel,
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              if (!formKey.currentState!.validate()) {
                return;
              }

              var res = await model.checkPassword(
                oldPassword: controller.text.trim(),
              );

              if (!res) {
                isError = true;
                formKey.currentState!.validate();
              } else {
                Navigator.pop(context, true);
              }
            },
            child: const Text("Ok"),
          ),
        ],
      ),
    );
  }
}
