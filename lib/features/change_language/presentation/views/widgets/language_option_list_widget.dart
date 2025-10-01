import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/language_enum.dart';
import 'language_option_widget.dart';

class LanguageOptionsList extends StatelessWidget {
  const LanguageOptionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LanguageOption(
          languageName: "العربية",
          languageEnum: LanguageEnum.arabic,
          value: LanguageEnum.arabic,
          groupValue: EasyLocalization.of(context)?.locale == const Locale("ar")
              ? LanguageEnum.arabic
              : LanguageEnum.english,
          locale: const Locale("ar"),
        ),
        16.verticalSpace,
        LanguageOption(
          languageName: "English",
          languageEnum: LanguageEnum.english,
          value: LanguageEnum.english,
          groupValue: EasyLocalization.of(context)?.locale == const Locale("en")
              ? LanguageEnum.english
              : LanguageEnum.arabic,
          locale: const Locale("en"),
        ),
      ],
    );
  }
}
