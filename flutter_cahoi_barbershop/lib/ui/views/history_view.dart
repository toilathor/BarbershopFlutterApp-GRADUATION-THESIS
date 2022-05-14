import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/services/auth_service.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/history_model.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/colors.dart';
import 'package:flutter_cahoi_barbershop/ui/views/_base.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/box_info.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/components/list_history.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  Size size = Size.zero;
  final user = locator<AuthenticationService>().user;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return BaseView<HistoryModel>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(size.height * 0.06),
                  child: Image.network(
                    '${user.avatar}',
                    errorBuilder: (context, error, stackTrace) => const Center(
                      child: Icon(
                        Icons.error,
                      ),
                    ),
                    fit: BoxFit.cover,
                    height: size.height * 0.06,
                  ),
                ),
              ],
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(top: 30, right: 10, left: 10),
                height: size.height,
                width: size.width,
                child: Column(
                  children: [
                    BoxInfo(
                      height: size.height * 0.1,
                      title: "Name",
                      content: "${user.name}",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BoxInfo(
                      height: size.height * 0.1,
                      title: "Email",
                      content: "${user.email}",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BoxInfo(
                      height: size.height * 0.1,
                      title: "Phone Number",
                      content: "${user.phoneNumber}",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: size.height * 0.5,
                      child: const ListHistory(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
