import 'package:atomic_habits/core/constants/colors.dart';
import 'package:atomic_habits/features/habits_feature/domain/models/habit_model.dart';
import 'package:atomic_habits/features/habits_feature/domain/models/submission_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class CalendarWidget extends StatefulWidget {
  final HabitModel habit;
  final bool isWeekView;

  const CalendarWidget({
    Key? key,
    required this.habit,
    required this.isWeekView,
  }) : super(key: key);

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  late ThemeData theme;
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    final days = widget.isWeekView
        ? _getDaysInWeek(_selectedDate)
        : _getDaysInMonth(_selectedDate);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GridView.builder(
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 1.0,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: days.length,
          itemBuilder: (context, index) {
            final dayDate = widget.isWeekView
                ? _selectedDate
                    .add(Duration(days: index - _selectedDate.weekday + 1))
                : DateTime(_selectedDate.year, _selectedDate.month, index + 1);
            final submission = _getSubmissionForDate(dayDate);

            return Card(
              margin: const EdgeInsets.all(2.0),
              color: _getCardColor(submission),
              child: Center(
                child: Text(
                  days[index],
                  style: theme.textTheme.labelLarge
                      ?.copyWith(color: CustomColors.whiteColor),
                ),
              ),
            );
          },
        ),
        SizedBox(
          height: 3.h,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back,
                    color: CustomColors.blackColor),
                onPressed: _prevMonth,
              ),
              Text(
                DateFormat('MMMM yyyy').format(_selectedDate),
                style: theme.textTheme.titleMedium?.copyWith(
                  color: CustomColors.blackColor,
                  fontSize: 18.sp,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward,
                    color: CustomColors.blackColor),
                onPressed: _nextMonth,
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<String> _getDaysInMonth(DateTime month) {
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    return List.generate(
        daysInMonth,
        (i) =>
            DateFormat('EEE').format(DateTime(month.year, month.month, i + 1)));
  }

  List<String> _getDaysInWeek(DateTime date) {
    final startOfWeek = date.subtract(Duration(days: date.weekday - 1));
    return List.generate(
        7, (i) => DateFormat('EEE').format(startOfWeek.add(Duration(days: i))));
  }

  SubmissionModel _getSubmissionForDate(DateTime date) {
    final formattedDate = DateFormat('yMMMMd').format(date);
    return widget.habit.submissions.firstWhere(
      (submission) => submission.date == formattedDate,
      orElse: () => SubmissionModel(value: false, date: date.toString()),
    );
  }

  Color _getCardColor(SubmissionModel submission) {
    return submission.value
        ? CustomColors.accentColor
        : CustomColors.neutralColor;
  }

  void _prevMonth() {
    setState(() =>
        _selectedDate = DateTime(_selectedDate.year, _selectedDate.month - 1));
  }

  void _nextMonth() {
    setState(() =>
        _selectedDate = DateTime(_selectedDate.year, _selectedDate.month + 1));
  }
}
