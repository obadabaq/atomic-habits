import 'package:atomic_habits/core/constants/colors.dart';
import 'package:atomic_habits/core/dependency_injection/locator.dart';
import 'package:atomic_habits/features/habits_feature/domain/models/habit_model.dart';
import 'package:atomic_habits/features/habits_feature/domain/usecases/habit_use_case.dart';
import 'package:atomic_habits/features/habits_feature/presentation/bloc/habit_bloc.dart';
import 'package:atomic_habits/features/habits_feature/presentation/widgets/habit_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class HabitsScreen extends StatefulWidget {
  const HabitsScreen({Key? key}) : super(key: key);

  @override
  State<HabitsScreen> createState() => _HabitsScreenState();
}

class _HabitsScreenState extends State<HabitsScreen> {
  late ThemeData theme;
  late String date;

  final HabitBloc _habitBloc = HabitBloc(habitUseCase: sl<HabitUseCase>());
  List<HabitModel> habits = [];

  @override
  void initState() {
    getHabits();
    date = DateFormat('yMMMMd').format(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 3.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Today's Progress",
                      style: theme.textTheme.headlineLarge,
                    ),
                    Text(
                      date,
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {},
                  child: Icon(
                    Icons.add_circle,
                    size: 24.sp,
                    color: CustomColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 3.h),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.4,
              ),
              shrinkWrap: true,
              itemCount: habits.length,
              itemBuilder: (_, index) {
                return HabitCard(
                  theme: theme,
                  habitModel: habits[index],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.done,
          size: 24.sp,
        ),
      ),
    );
  }

  getHabits() {
    _habitBloc.add(const OnGettingHabitsEvent());
  }
}
