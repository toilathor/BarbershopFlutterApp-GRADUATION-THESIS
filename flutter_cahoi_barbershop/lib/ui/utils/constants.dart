import 'package:date_format/date_format.dart';

const hostLine = "0973271208";
const localHost = 'http://192.168.1.12:8000/api';
const baseLinkAPIYT = 'https://www.googleapis.com/youtube/v3';

final timeStart = DateTime(2021, 1, 1, 9, 0);
final timeEnd = DateTime(2021, 1, 1, 19, 0);
final formatDate = [yyyy, '-', mm, '-', dd];
final fullFormatDatetime = [yyyy, '-', mm, '-', dd, ' ', hh, ':', mm, ':', ss];
final formatTime = [hh, ':', mm];
final fullFormatTime = [hh, ':', mm, ':', ss];

const countryCode = 'vn'; //WidgetsBinding.instance.windoshplocale.countryCode;

const apiKeyFirebase = 'AIzaSyA8wTEYb57gCtFs2bu41CKoTrXZm6f7LnI';
const playlistId = 'PLbplMzmYtClBFL_513hKHQNGS1nmvM3Zj';
const apiKeyMap = 'AIzaSyDVr-0LtOAAbSRRbgQHNuQcWtxw0MeUlvs';

const fontLight = 'sf-ui-display-light';
const fontBold = 'sf-ui-display-bold';
