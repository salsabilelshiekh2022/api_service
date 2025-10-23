import 'package:elmohtaref/core/extensions/translation_extensions.dart';
import 'package:elmohtaref/core/utils/app_logs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/components/widgets/main_button.dart';
import '../../../cubit/visits_cubit.dart';
import '../../../data/models/rate_request_model.dart' show RateRequestModel;
import 'dialog_content.dart';
import 'dialog_header.dart';

class ServiceRatingDialog extends StatefulWidget {
  const ServiceRatingDialog({
    super.key,
    required this.visitId,
  });

  final int visitId;

  @override
  State<ServiceRatingDialog> createState() => _ServiceRatingDialogState();
}

class _ServiceRatingDialogState extends State<ServiceRatingDialog> {
  int selectedRating = 0;
  final TextEditingController commentController = TextEditingController();

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Dialog(
      clipBehavior: Clip.none,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24.0),
      backgroundColor: Colors.transparent,
      child: Container(
        width: screenSize.width * 0.95,
        constraints: BoxConstraints(
          maxHeight: screenSize.height * 0.85,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const DialogHeader(),
              DialogContent(
                selectedRating: selectedRating,
                onRatingChanged: (rating) {
                  setState(() {
                    selectedRating = rating;
                  });
                },
                commentController: commentController,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: MainButton(
                  onTap: () {
                    AppLogs.debugLog('Selected Rating: $selectedRating');
                    AppLogs.debugLog(
                        'Comment: ${commentController.text.trim()}');
                    context.read<VisitsCubit>().rateVisit(
                          visitId: widget.visitId,
                          rateRequestModel: RateRequestModel(
                            rate: selectedRating,
                            comment: commentController.text.trim(),
                          ),
                        );
                    Navigator.of(context).pop();
                  },
                  title: context.bookingRating,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
