import 'package:atomic_habits/features/food_feature/data/repositories/food_repository_impl.dart';
import 'package:atomic_habits/features/food_feature/data/sources/local_data_source.dart';
import 'package:atomic_habits/features/food_feature/domain/repositories/abstract_food_repository.dart';
import 'package:atomic_habits/features/food_feature/domain/usecases/food_use_case.dart';
import 'package:atomic_habits/features/food_feature/presentation/bloc/food_bloc.dart';
import 'package:get_it/get_it.dart';

void initFoodFeature(GetIt getIt) {
  getIt.registerSingleton(FoodLocalDataSourceImpl(getIt()));
  getIt.registerSingleton(FoodRepositoryImpl(getIt()));
  getIt.registerSingleton<AbstractFoodRepository>(FoodRepositoryImpl(getIt()));
  getIt.registerSingleton(FoodUseCase(getIt()));
  getIt.registerSingleton(FoodBloc(foodUseCase: getIt()));
}
