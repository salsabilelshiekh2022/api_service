import 'package:elmohtaref/core/extensions/app_extention.dart';
import 'package:elmohtaref/core/extensions/translation_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../../core/components/widgets/main_button.dart';
import '../../../../../core/routes/routes.dart';

class BookServiceButton extends StatelessWidget {
  const BookServiceButton({
    super.key,
    required this.title,
    required this.serviceId,
  });
  final String title;
  final int serviceId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 16.0),
      child: MainButton(
          title: context.bookServiceNow,
          onTap: () {
            context.pushNamed(Routes.bookServiceView,
                arguments: {"title": title, "serviceId": serviceId});
          }),
    );
  }
}
