import 'package:elmohtaref/core/extensions/translation_extensions.dart';
import 'package:flutter/widgets.dart';

enum VisitEnumStatus { pending, cancelled, completed, reservation }

extension VisitEnumStatusExtension on VisitEnumStatus {
  String name({required BuildContext context}) {
    switch (this) {
      case VisitEnumStatus.pending:
        return context.pending;
      case VisitEnumStatus.cancelled:
        return context.cancelled;
      case VisitEnumStatus.completed:
        return context.completed;
      case VisitEnumStatus.reservation:
        return context.reservation;
    }
  }
}
