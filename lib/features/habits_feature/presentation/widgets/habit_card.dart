import 'package:atomic_habits/core/constants/colors.dart';
import 'package:atomic_habits/features/habits_feature/domain/models/habit_model.dart';
import 'package:atomic_habits/features/habits_feature/domain/models/submission_model.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:text_scroll/text_scroll.dart';

class HabitCard extends StatefulWidget {
  final HabitModel habitModel;
  final SubmissionModel submissionModel;
  final ThemeData theme;
  final VoidCallback onDelete;

  const HabitCard({
    Key? key,
    required this.theme,
    required this.habitModel,
    required this.submissionModel,
    required this.onDelete,
  }) : super(key: key);

  @override
  State<HabitCard> createState() => _HabitCardState();
}

class _HabitCardState extends State<HabitCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _toggleColor,
      child: Card(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.w),
          decoration: BoxDecoration(
            color: widget.submissionModel.value
                ? CustomColors.accentColor
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12.sp),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              _buildQuestionText(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TextScroll(
            widget.habitModel.name,
            style: widget.theme.textTheme.headlineLarge?.copyWith(
              color: widget.submissionModel.value
                  ? CustomColors.whiteColor
                  : CustomColors.blackColor,
            ),
          ),
        ),
        InkWell(
          onTap: widget.onDelete,
          child: const Icon(
            Icons.cancel_outlined,
            color: CustomColors.redColor,
          ),
        )
      ],
    );
  }

  Widget _buildQuestionText() {
    return Text(
      widget.habitModel.question,
      overflow: TextOverflow.ellipsis,
      maxLines: 3,
      style: widget.theme.textTheme.bodySmall?.copyWith(
        color: widget.submissionModel.value
            ? CustomColors.whiteColor
            : CustomColors.blackColor,
      ),
    );
  }

  void _toggleColor() {
    setState(() {
      widget.submissionModel.value = !widget.submissionModel.value;
    });
  }
}
