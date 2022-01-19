import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

const hostLine = "0973271208";
// const localhost = 'http://192.168.31.236:8000/api/v1';
const localHost = 'http://192.168.1.168:8000/api/v1';
const baseLinkAPIYT = 'https://www.googleapis.com/youtube/v3';

final timeStart = DateTime(2021, 1, 1, 9, 0);
final timeEnd = DateTime(2021, 1, 1, 19, 0);
final formatDate = [yyyy, '-', mm, '-', dd];
final fullFormatDatetime = [yyyy, '-', mm, '-', dd, ' ', hh, ':', mm, ':', ss];
final formatTime = [hh, ':', mm];
final fullFormatTime = [hh, ':', mm, ':', ss];

final countryCode = WidgetsBinding.instance!.window.locale.countryCode;

const apiKey = 'AIzaSyA8wTEYb57gCtFs2bu41CKoTrXZm6f7LnI';
const playlistId = 'PLbplMzmYtClBFL_513hKHQNGS1nmvM3Zj';
