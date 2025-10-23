// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:elmohtaref/core/extensions/app_extention.dart';
import 'package:elmohtaref/core/theme/app_colors.dart';
import 'package:elmohtaref/core/utils/app_logs.dart';
import 'package:flutter/material.dart';

import '../../../../../core/routes/routes.dart';
import '../../../data/language_enum.dart';

class LanguageOption extends StatelessWidget {
  final String languageName;
  final LanguageEnum languageEnum;
  final Object value;
  final Object? groupValue;
  final Locale locale;

  const LanguageOption({
    super.key,
    required this.languageName,
    required this.languageEnum,
    required this.value,
    required this.groupValue,
    required this.locale,
  });

  Future<void> _changeLanguage(BuildContext context) async {
    AppLogs.errorLog("Language changed to $languageEnum");
    await EasyLocalization.of(context)?.setLocale(locale);
    if (context.mounted) {
      context.pushNamedAndRemoveUntil(Routes.mainNavigation,
          predicate: (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    return ListTile(
      tileColor: appColors.labelColor,
      title: Text(
        languageName,
        style: Theme.of(context)
            .textTheme
            .titleSmall!
            .copyWith(fontWeight: FontWeight.w700),
      ),
      trailing: Radio(
        activeColor: appColors.primaryColor,
        value: value,
        groupValue: groupValue,
        onChanged: (_) => _changeLanguage(context),
      ),
      onTap: () => _changeLanguage(context),
    );
  }
}
