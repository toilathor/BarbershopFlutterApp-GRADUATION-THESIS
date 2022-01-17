import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/ui/views/login/login_view.dart';

class AccountPageView extends StatefulWidget {
  const AccountPageView({Key? key}) : super(key: key);

  @override
  _AccountPageViewState createState() => _AccountPageViewState();
}

class _AccountPageViewState extends State<AccountPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          child: const Text("Logout!"),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const LoginView(),
                ),
                (route) => false);
          },
        ),
      ),
    );
  }
}
