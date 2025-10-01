import 'package:elmohtaref/core/extensions/translation_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_text_style.dart';
import 'widgets/report_problem_body.dart';

class ReportProblemView extends StatelessWidget {
  const ReportProblemView({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextStyles>()!;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          context.reportProblem,
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
      body: ReportProblemBody(id: id),
    );
  }
}
