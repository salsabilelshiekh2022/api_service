import 'package:elmohtaref/core/extensions/translation_extensions.dart';
import 'package:flutter/material.dart';

enum ReportTypeEnum {
  buy_and_sell,
  ettamen,
}

extension ReportTypeEnumExtension on ReportTypeEnum {
  String translatedName(BuildContext context) {
    switch (this) {
      case ReportTypeEnum.buy_and_sell:
        return context.buyAndSell;
      case ReportTypeEnum.ettamen:
        return context.ettamen;
    }
  }

  String get name {
    switch (this) {
      case ReportTypeEnum.buy_and_sell:
        return 'buy_and_sell';
      case ReportTypeEnum.ettamen:
        return 'ettamen';
    }
  }
}
