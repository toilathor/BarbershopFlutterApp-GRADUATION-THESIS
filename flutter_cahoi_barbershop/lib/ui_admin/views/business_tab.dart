import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/services/user_service.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';

class BusinessTab extends StatefulWidget {
  const BusinessTab({Key? key}) : super(key: key);

  @override
  State<BusinessTab> createState() => _BusinessTabState();
}

class _BusinessTabState extends State<BusinessTab> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          locator<UserService>().signCalender();
        },
        child: const Text('Đăng kí lịch làm việc cho toàn bộ nhân viên'),
      ),
    );
  }
}
