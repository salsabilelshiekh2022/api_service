import 'package:elmohtaref/core/extensions/translation_extensions.dart';
import 'package:elmohtaref/features/book_service/presentaion/cubit/book_service_cubit.dart';
import 'package:elmohtaref/features/book_service/presentaion/views/widgets/form_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/components/widgets/main_button.dart';
import '../../../../../core/theme/app_text_style.dart';
import '../../../../../generated/app_assets.dart';

class TimePickerField extends StatefulWidget {
  final String title;
  final String? selectedTime;
  final ValueChanged<String> onTimeSelected;

  const TimePickerField({
    super.key,
    required this.title,
    required this.selectedTime,
    required this.onTimeSelected,
  });

  @override
  State<TimePickerField> createState() => _TimePickerFieldState();
}

class _TimePickerFieldState extends State<TimePickerField> {
  int selectedTimeIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormTitle(
          title: widget.title,
          imagePath: AppAssets.iconsTimer,
          isRequired: true,
        ),
        6.verticalSpace,
        _buildTimePickerContainer(),
      ],
    );
  }

  Widget _buildTimePickerContainer() {
    return GestureDetector(
      onTap: () => _selectTime(context, context.read<BookServiceCubit>()),
      child: Container(
        width: double.infinity,
        height: 30,
        constraints: const BoxConstraints(minHeight: 44),
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.selectedTime ?? "الوقت",
              style: TextStyle(
                fontSize: 14,
                color: widget.selectedTime != null
                    ? Colors.black87
                    : Colors.grey.shade600,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            const Icon(
              Icons.calendar_today_outlined,
              color: Colors.grey,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectTime(BuildContext context, BookServiceCubit cubit) async {
    final AppTextStyles appTextStyles =
        Theme.of(context).extension<AppTextStyles>()!;

    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      elevation: 0,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(50.r)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return BlocProvider.value(
              value: cubit,
              child: BlocBuilder<BookServiceCubit, BookServiceState>(
                builder: (context, state) {
                  return _buildBottomSheetContent(
                    context,
                    state,
                    appTextStyles,
                    setModalState,
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildBottomSheetContent(
    BuildContext context,
    BookServiceState state,
    AppTextStyles appTextStyles,
    StateSetter setModalState,
  ) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        width: 1.sw,
        height: MediaQuery.of(context).size.height * 0.5,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Column(
            children: [
              _buildSheetTitle(appTextStyles),
              16.verticalSpace,
              Divider(color: Colors.grey.shade200),
              24.verticalSpace,
              _buildTimeSlotsList(state, appTextStyles, setModalState),
              _buildSaveButton(state),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSheetTitle(AppTextStyles appTextStyles) {
    return Text(
      widget.title,
      style: appTextStyles.font18BoldPrimaryColor.copyWith(
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildTimeSlotsList(
    BookServiceState state,
    AppTextStyles appTextStyles,
    StateSetter setModalState,
  ) {
    final timeSlots = state.timeSlotsResponse?.data ?? [];

    if (timeSlots.isEmpty) {
      return Expanded(
        child: Center(
          child: Text(context.noTimesAvailable),
        ),
      );
    }

    return Expanded(
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 12,
        children: List.generate(timeSlots.length, (index) {
          final timeSlot = timeSlots[index].time;
          final isSelected = selectedTimeIndex == index;
          final isReseved = timeSlots[index].reserved;
          return _buildTimeSlotChip(
            timeSlot: timeSlot,
            isSelected: isSelected,
            isReseved: isReseved,
            appTextStyles: appTextStyles,
            onTap: () {
              setModalState(() {
                selectedTimeIndex = index;
              });
            },
          );
        }),
      ),
    );
  }

  Widget _buildTimeSlotChip(
      {required String timeSlot,
      required bool isSelected,
      required AppTextStyles appTextStyles,
      required VoidCallback onTap,
      required bool isReseved}) {
    const primaryColor = Color(0xff09131b);

    return InkWell(
      onTap: isReseved ? null : onTap,
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.white,
          border: Border.all(
              color: isReseved ? Colors.grey : primaryColor, width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          timeSlot,
          style: appTextStyles.font16RegularPrimaryColor.copyWith(
            color: isSelected
                ? Colors.white
                : isReseved
                    ? Colors.grey
                    : primaryColor,
          ),
        ),
      ),
    );
  }

  Widget _buildSaveButton(BookServiceState state) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: MainButton(
        title: "حفظ",
        onTap: () {
          if (selectedTimeIndex >= 0 &&
              state.timeSlotsResponse != null &&
              selectedTimeIndex < state.timeSlotsResponse!.data.length) {
            // Get the actual selected time from the API response
            final selectedTime =
                state.timeSlotsResponse!.data[selectedTimeIndex].time;
            widget.onTimeSelected(selectedTime);
            context.read<BookServiceCubit>().dateTimeoFBooking = state
                .timeSlotsResponse!.data[selectedTimeIndex].dateTime
                .toString();
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }
}
