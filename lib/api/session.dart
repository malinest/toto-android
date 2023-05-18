import 'dart:io';

import 'package:toto_android/globals.dart';

class DevHttpOverrides extends HttpOverrides {

  bool _certificateCheck(X509Certificate cert, String host, int port) => host == '${Globals.API_PROTOCOL}${Globals.API_URI}';

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (_certificateCheck);
  }
}