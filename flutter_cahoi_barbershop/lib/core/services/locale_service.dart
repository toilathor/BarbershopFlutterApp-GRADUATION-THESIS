import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/l10n/l10n.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/store_secure.dart';

class LocaleService {
  StreamController<Locale> localeController = StreamController<Locale>();

  final _localeResponse = StreamController<Locale>.broadcast();

  Stream<Locale> get localeResponse => _localeResponse.stream;

  Function(Locale) get addLocaleResponse => _localeResponse.sink.add;

  Locale locale = const Locale("en");

  LocaleService() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final l = await StoreSecure().getLanguage() ?? "en";
      locale = Locale(l);
      addLocaleResponse(locale);
    });
  }

  void changeLanguage() {
    if (L10n.all.first == locale) {
      locale = L10n.all.last;
    } else {
      locale = L10n.all.first;
    }

    StoreSecure().setLanguage(locale.languageCode);

    addLocaleResponse(locale);
  }
}
