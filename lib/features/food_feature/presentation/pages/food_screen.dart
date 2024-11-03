import 'package:atomic_habits/core/constants/colors.dart';
import 'package:atomic_habits/core/dependency_injection/locator.dart';
import 'package:atomic_habits/core/widgets/custom_text_field.dart';
import 'package:atomic_habits/features/food_feature/domain/models/food_model.dart';
import 'package:atomic_habits/features/food_feature/domain/usecases/food_use_case.dart';
import 'package:atomic_habits/features/food_feature/presentation/bloc/food_bloc.dart';
import 'package:atomic_habits/features/food_feature/presentation/widgets/totals_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({Key? key}) : super(key: key);

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  late ThemeData theme;

  final FoodBloc _foodBloc = FoodBloc(foodUseCase: sl<FoodUseCase>());
  List<FoodModel> foods = [];
  int totalCal = 0;
  int totalPro = 0;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _foodNameController = TextEditingController();
  final TextEditingController _calController = TextEditingController();
  final TextEditingController _proController = TextEditingController();

  @override
  void initState() {
    getFoods();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return BlocBuilder(
      bloc: _foodBloc,
      builder: (_, state) {
        if (state is SuccessGetFoodsState) {
          foods = state.foods;
          totalCal = foods.fold(0, (sum, food) => sum + food.numOfCal);
          totalPro = foods.fold(0, (sum, food) => sum + food.numOfPro);
          return Scaffold(
            body: ListView(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 10.h),
              children: [
                _buildHeader(),
                SizedBox(
                  height: 4.h,
                ),
                _buildTotalsCards(),
                SizedBox(
                  height: 4.h,
                ),
                _buildFoodsTable(),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: openSubmitPopup,
              child: Icon(Icons.done, size: 24.sp),
            ),
          );
        }
        if (state is SuccessSubmitFoodsState) {
          foods = [];
          totalCal = 0;
          totalPro = 0;
          return Scaffold(
            body: ListView(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 10.h),
              children: [
                _buildHeader(),
                SizedBox(
                  height: 4.h,
                ),
                _buildTotalsCards(),
                SizedBox(
                  height: 4.h,
                ),
                _buildFoodsTable(),
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
            Text("Nutrition Calculator", style: theme.textTheme.headlineLarge),
            // Text(date, style: theme.textTheme.bodySmall),
          ],
        ),
        InkWell(
          onTap: openAddFoodPopup,
          child: Icon(Icons.add_circle,
              size: 24.sp, color: CustomColors.primaryColor),
        ),
      ],
    );
  }

  void openAddFoodPopup() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Food'),
          content: _buildFoodForm(),
          actions: [
            TextButton(
              child: const Text('Close'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              onPressed: addFood,
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFoodForm() {
    return Form(
      key: _formKey,
      child: SizedBox(
        height: 25.h,
        width: 80.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              controller: _foodNameController,
              label: "Food name",
              hint: "e.g. 250g chicken",
            ),
            SizedBox(height: 1.h),
            CustomTextField(
              controller: _calController,
              label: "Number of calories",
              hint: "e.g. 200",
              isNumber: true,
            ),
            SizedBox(height: 1.h),
            CustomTextField(
              controller: _proController,
              label: "Number of protein",
              hint: "e.g. 20",
              isNumber: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalsCards() {
    return Row(
      children: [
        TotalsCard(
          total: totalCal,
          title: "calories",
          theme: theme,
        ),
        TotalsCard(
          total: totalPro,
          title: "proteins",
          theme: theme,
        ),
      ],
    );
  }

  Widget _buildFoodsTable() {
    return Card(
      child: Container(
        height: 40.h,
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.w),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12.sp),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        "Food name",
                        style: theme.textTheme.titleMedium,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      SizedBox(
                        width: 30.w,
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: foods.length,
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 2),
                              child: Text(
                                foods[index].name,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Calories",
                        style: theme.textTheme.titleMedium,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      SizedBox(
                        width: 30.w,
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: foods.length,
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 2),
                              child: Text(
                                foods[index].numOfCal.toString(),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Proteins",
                        style: theme.textTheme.titleMedium,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      SizedBox(
                        width: 30.w,
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: foods.length,
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 2),
                              child: Text(
                                foods[index].numOfPro.toString(),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
          title: const Text('Submit Foods for Today'),
          content:
              const Text('Are you sure you want to submit today\'s progress?'),
          actions: [
            TextButton(
              child: const Text('Close'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              onPressed: submitFoods,
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  void getFoods() {
    _foodBloc.add(const OnGettingFoodsEvent());
  }

  void addFood() {
    FoodModel foodModel = FoodModel(
      name: _foodNameController.text,
      numOfCal: int.parse(_calController.text),
      numOfPro: int.parse(_proController.text),
    );
    _foodBloc.add(OnAddingFoodEvent(foodModel));
    Navigator.of(context).pop();
  }

  void submitFoods() {
    _foodBloc.add(OnSubmittingFoodsEvent(foods));
    Navigator.of(context).pop();
  }
}
