import 'dart:async';

import 'package:flutter/material.dart';

class LocaleService {
  StreamController<Locale> localeController = StreamController<Locale>();

  final _localeResponse = StreamController<Locale>.broadcast();

  Stream<Locale> get localeResponse => _localeResponse.stream;

  Function(Locale) get addLocaleResponse => _localeResponse.sink.add;

  Locale locale = const Locale("vi");
}
