import 'package:atomic_habits/core/constants/colors.dart';
import 'package:atomic_habits/core/dependency_injection/locator.dart';
import 'package:atomic_habits/core/widgets/custom_text_field.dart';
import 'package:atomic_habits/features/habits_feature/domain/models/habit_model.dart';
import 'package:atomic_habits/features/habits_feature/domain/models/submission_model.dart';
import 'package:atomic_habits/features/habits_feature/domain/usecases/habit_use_case.dart';
import 'package:atomic_habits/features/habits_feature/presentation/bloc/habit_bloc.dart';
import 'package:atomic_habits/features/habits_feature/presentation/widgets/habit_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _questionController = TextEditingController();

  @override
  void initState() {
    date = DateFormat('yMMMMd').format(DateTime.now());
    getHabits();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return BlocBuilder<HabitBloc, HabitState>(
      bloc: _habitBloc,
      builder: (_, state) {
        if (state is SuccessGetHabitsState) {
          habits = state.habits;
          return Scaffold(
            body: ListView(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 10.h),
              children: [
                _buildHeader(),
                _buildHabitGrid(),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: openSubmitPopup,
              child: Icon(Icons.done, size: 24.sp),
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Today's Progress", style: theme.textTheme.headlineLarge),
            Text(date, style: theme.textTheme.bodySmall),
          ],
        ),
        InkWell(
          onTap: openAddHabitPopup,
          child: Icon(Icons.add_circle,
              size: 24.sp, color: CustomColors.primaryColor),
        ),
      ],
    );
  }

  Widget _buildHabitGrid() {
    return GridView.builder(
      padding: EdgeInsets.only(top: 4.h),
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
          submissionModel: getTodaySubmission(habits[index]),
          onDelete: () => deleteHabit(habits[index]),
        );
      },
    );
  }

  void openAddHabitPopup() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Habit'),
          content: _buildHabitForm(),
          actions: [
            TextButton(
              child: const Text('Close'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              onPressed: addHabit,
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildHabitForm() {
    return Form(
      key: _formKey,
      child: SizedBox(
        height: 15.h,
        width: 80.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              controller: _nameController,
              label: "Habit name",
              hint: "e.g. Exercise",
            ),
            SizedBox(height: 1.h),
            CustomTextField(
              controller: _questionController,
              label: "Habit question",
              hint: "e.g. Did you exercise today?",
            ),
          ],
        ),
      ),
    );
  }

  void openSubmitPopup() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Submit Habits'),
          content:
              const Text('Are you sure you want to submit today\'s progress?'),
          actions: [
            TextButton(
              child: const Text('Close'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              onPressed: submitHabits,
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  void getHabits() {
    _habitBloc.add(const OnGettingHabitsEvent());
  }

  void addHabit() {
    HabitModel habitModel = HabitModel(
      name: _nameController.text,
      question: _questionController.text,
      submissions: [],
    );
    _habitBloc.add(OnAddingHabitEvent(habitModel));
    Navigator.of(context).pop();
  }

  void deleteHabit(HabitModel habitModel) {
    _habitBloc.add(OnDeletingHabitEvent(habitModel));
  }

  void submitHabits() {
    _habitBloc.add(OnSubmittingHabitsEvent(habits));
    Navigator.of(context).pop();
  }

  SubmissionModel getTodaySubmission(HabitModel habit) {
    return habit.submissions.firstWhere(
      (submission) => submission.date == date,
      orElse: () {
        SubmissionModel sub = SubmissionModel(value: false, date: date);
        habit.submissions.add(sub);
        return sub;
      },
    );
  }
}
