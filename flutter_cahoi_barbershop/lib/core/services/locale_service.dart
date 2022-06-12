import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/l10n/l10n.dart';

class LocaleService {
  StreamController<Locale> localeController = StreamController<Locale>();

  final _localeResponse = StreamController<Locale>.broadcast();

  Stream<Locale> get localeResponse => _localeResponse.stream;

  Function(Locale) get addLocaleResponse => _localeResponse.sink.add;

  Locale locale = const Locale("en");

  void changeLanguage() {
    if (L10n.all.first == locale) {
      locale = L10n.all.last;
    } else {
      locale = L10n.all.first;
    }

    addLocaleResponse(locale);
  }
}
