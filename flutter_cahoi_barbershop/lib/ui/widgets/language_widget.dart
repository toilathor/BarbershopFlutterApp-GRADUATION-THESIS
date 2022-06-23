import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/services/locale_service.dart';
import 'package:flutter_cahoi_barbershop/l10n/l10n.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/helper.dart';

class LanguageWidget extends StatefulWidget {
  const LanguageWidget({Key? key}) : super(key: key);

  @override
  State<LanguageWidget> createState() => _LanguageWidgetState();
}

class _LanguageWidgetState extends State<LanguageWidget> {
  late Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    Locale value = locator<LocaleService>().locale;

    return Container(
      height: size.height * 0.1,
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      width: size.width,
      child: Material(
        elevation: 8.0,
        borderRadius: BorderRadius.circular(12.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.language,
                    color: Colors.blueAccent,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      appLang(context)!.language,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 35,
                child: AnimatedToggleSwitch<Locale>.size(
                  current: value,
                  values: L10n.all,
                  iconOpacity: 0.0,
                  indicatorSize: const Size.fromWidth(
                    30,
                  ),
                  iconBuilder: (value, size) {
                    return Image.asset(
                      value == L10n.all.first
                          ? "assets/icon/england.jpg"
                          : "assets/icon/vietnam.jpg",
                    );
                  },
                  borderColor: Colors.grey.withOpacity(0.5),
                  colorBuilder: (i) => Colors.transparent,
                  onChanged: (i) {
                    locator<LocaleService>().changeLanguage();
                    setState(() {
                      value = i;
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
