import 'package:elmohtaref/core/extensions/translation_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_text_style.dart';
import 'widgets/tickets_list_view.dart';

class TicketsListView extends StatelessWidget {
  const TicketsListView({super.key});

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextStyles>()!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.addComplaint,
          style: appTextTheme.font16BoldPrimaryColor,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
      ),
      body: const TicketsListBody(),
    );
  }
}
