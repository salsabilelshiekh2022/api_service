import 'package:easy_localization/easy_localization.dart';
import 'package:elmohtaref/core/components/widgets/main_button.dart';
import 'package:elmohtaref/core/extensions/app_extention.dart';
import 'package:elmohtaref/core/extensions/translation_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wheel_chooser/wheel_chooser.dart';

import '../../../../../core/theme/app_text_style.dart';
import '../../../../../generated/app_assets.dart';
import '../../../../book_service/presentaion/views/widgets/form_title.dart';

class DatePickerField extends StatelessWidget {
  final String title;
  final DateTime? selectedDate;
  final ValueChanged<DateTime> onDateSelected;
  final DateTime? minDate;
  final DateTime? maxDate;

  const DatePickerField({
    super.key,
    required this.title,
    required this.selectedDate,
    required this.onDateSelected,
    this.minDate,
    this.maxDate,
  });

  @override
  Widget build(BuildContext context) {
    final AppTextStyles appTextStyles =
        Theme.of(context).extension<AppTextStyles>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormTitle(
          title: title,
          imagePath: AppAssets.iconsCalendar,
          isRequired: true,
        ),
        6.verticalSpace,
        _buildDateField(context, appTextStyles),
      ],
    );
  }

  Widget _buildDateField(BuildContext context, AppTextStyles appTextStyles) {
    return GestureDetector(
      onTap: () => _showDatePicker(context),
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: 44),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _getDisplayDate(),
              style: TextStyle(
                fontSize: 14,
                color: selectedDate != null
                    ? Colors.black87
                    : Colors.grey.shade600,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            Icon(
              Icons.calendar_today_outlined,
              color: Colors.grey,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }

  String _getDisplayDate() {
    final date = selectedDate ?? DateTime.now();
    return date.formatTime();
  }

  Future<void> _showDatePicker(BuildContext context) async {
    final currentDate = selectedDate ?? DateTime.now();
    final minYear = (minDate ?? DateTime.now()).year;
    final maxYear = (maxDate ?? DateTime(DateTime.now().year + 10)).year;

    final datePickerState = _DatePickerState(
      currentDate: currentDate,
      minYear: minYear,
      maxYear: maxYear,
    );

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) => _DatePickerBottomSheet(
        title: title,
        state: datePickerState,
        onDateSelected: onDateSelected,
      ),
    );
  }
}

class _DatePickerState {
  final DateTime currentDate;
  final int minYear;
  final int maxYear;

  late int selectedMonth;
  late int selectedDay;
  late int selectedYear;

  _DatePickerState({
    required this.currentDate,
    required this.minYear,
    required this.maxYear,
  }) {
    selectedMonth = currentDate.month - 1;
    selectedDay = currentDate.day - 1;
    selectedYear = currentDate.year - minYear;
  }

  DateTime get selectedDate => DateTime(
        minYear + selectedYear,
        selectedMonth + 1,
        selectedDay + 1,
      );

  List<int> get availableYears =>
      List.generate(maxYear - minYear + 1, (index) => minYear + index);

  int get daysInSelectedMonth =>
      DateTime(minYear + selectedYear, selectedMonth + 2, 0).day;
}

class _DatePickerBottomSheet extends StatefulWidget {
  final String title;
  final _DatePickerState state;
  final ValueChanged<DateTime> onDateSelected;

  const _DatePickerBottomSheet({
    required this.title,
    required this.state,
    required this.onDateSelected,
  });

  @override
  _DatePickerBottomSheetState createState() => _DatePickerBottomSheetState();
}

class _DatePickerBottomSheetState extends State<_DatePickerBottomSheet> {
  late _DatePickerState state;

  @override
  void initState() {
    super.initState();
    state = widget.state;
  }

  @override
  Widget build(BuildContext context) {
    final AppTextStyles appTextStyles =
        Theme.of(context).extension<AppTextStyles>()!;

    return Container(
      height: 400,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          _buildHeader(appTextStyles),
          Divider(color: Colors.grey.shade200),
          _buildDatePickers(appTextStyles),
          _buildSaveButton(),
        ],
      ),
    );
  }

  Widget _buildHeader(AppTextStyles appTextStyles) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: Text(
        widget.title,
        style: appTextStyles.font18BoldPrimaryColor.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildDatePickers(AppTextStyles appTextStyles) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            _buildMonthPicker(appTextStyles),
            _buildDayPicker(appTextStyles),
            _buildYearPicker(appTextStyles),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthPicker(AppTextStyles appTextStyles) {
    return Expanded(
      child: WheelChooser.custom(
        onValueChanged: (value) {
          setState(() {
            state.selectedMonth = value;
            // Adjust day if it's invalid for the new month
            _adjustDayForMonth();
          });
        },
        startPosition: state.selectedMonth,
        children: _buildMonthItems(appTextStyles),
      ),
    );
  }

  Widget _buildDayPicker(AppTextStyles appTextStyles) {
    return Expanded(
      child: WheelChooser.custom(
        onValueChanged: (value) {
          setState(() {
            state.selectedDay = value;
          });
        },
        startPosition:
            state.selectedDay.clamp(0, state.daysInSelectedMonth - 1),
        children: _buildDayItems(appTextStyles),
      ),
    );
  }

  Widget _buildYearPicker(AppTextStyles appTextStyles) {
    return Expanded(
      child: WheelChooser.custom(
        onValueChanged: (value) {
          setState(() {
            state.selectedYear = value;
            // Adjust day if it's invalid for the new year (leap year consideration)
            _adjustDayForMonth();
          });
        },
        startPosition: state.selectedYear,
        children: _buildYearItems(appTextStyles),
      ),
    );
  }

  List<Widget> _buildMonthItems(AppTextStyles appTextStyles) {
    return List.generate(12, (index) {
      final monthName = DateFormat.MMMM('ar').format(DateTime(0, index + 1));
      return _buildPickerItem(monthName, appTextStyles);
    });
  }

  List<Widget> _buildDayItems(AppTextStyles appTextStyles) {
    final daysCount = state.daysInSelectedMonth;
    return List.generate(daysCount, (index) {
      return _buildPickerItem('${index + 1}', appTextStyles);
    });
  }

  List<Widget> _buildYearItems(AppTextStyles appTextStyles) {
    return state.availableYears.map((year) {
      return _buildPickerItem('$year', appTextStyles);
    }).toList();
  }

  Widget _buildPickerItem(String text, AppTextStyles appTextStyles) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      child: Text(
        text,
        style: appTextStyles.font16RegularPrimaryColor,
      ),
    );
  }

  Widget _buildSaveButton() {
    return Container(
      margin: const EdgeInsets.all(20),
      child: MainButton(
        title: context.save,
        onTap: _handleSave,
      ),
    );
  }

  void _adjustDayForMonth() {
    final maxDaysInMonth = state.daysInSelectedMonth;
    if (state.selectedDay >= maxDaysInMonth) {
      state.selectedDay = maxDaysInMonth - 1;
    }
  }

  void _handleSave() {
    try {
      final selectedDate = state.selectedDate;
      widget.onDateSelected(selectedDate);
      Navigator.pop(context);
    } catch (e) {
      _showErrorSnackBar();
    }
  }

  void _showErrorSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.dateNotCorrect)),
    );
  }
}
