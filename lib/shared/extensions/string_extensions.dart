import 'package:flutter/material.dart';

extension StringExtensions on String {
  String get tr => this.tr;
}

extension StringNumberOfCharacters on String {
  int get charactersNum => this.length;
}

//
// String parseHtmlString(String htmlString) {
//   final document = parse(htmlString);
//   final String parsedString = parse(document.body!.text).documentElement!.text;
//
//   return parsedString;
// }

String getDeviceType() {
  final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);

  if (data.size.shortestSide < 800) {
    return "phone";
  } else {
    return "desktop";
  }
}
