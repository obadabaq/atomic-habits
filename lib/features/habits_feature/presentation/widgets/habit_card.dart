import 'package:atomic_habits/core/constants/colors.dart';
import 'package:atomic_habits/features/habits_feature/domain/models/habit_model.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:text_scroll/text_scroll.dart';

class HabitCard extends StatefulWidget {
  final HabitModel habitModel;
  final ThemeData theme;

  const HabitCard({
    Key? key,
    required this.theme,
    required this.habitModel,
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
            color: widget.habitModel.value!
                ? CustomColors.accentColor
                : CustomColors.neutralColor,
            borderRadius: BorderRadius.circular(12.sp),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextScroll(
                widget.habitModel.name,
                style: widget.theme.textTheme.headlineLarge?.copyWith(
                  color: CustomColors.whiteColor,
                ),
              ),
              Text(
                widget.habitModel.question,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: widget.theme.textTheme.bodySmall?.copyWith(
                  color: CustomColors.whiteColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleColor() {
    setState(() {
      widget.habitModel.value = !widget.habitModel.value!;
    });
  }
}
