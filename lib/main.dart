import 'package:atomic_habits/core/constants/colors.dart';
import 'package:atomic_habits/core/dependency_injection/locator.dart';
import 'package:atomic_habits/core/router/app_router.dart';
import 'package:atomic_habits/core/router/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencyInjection();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (_, orientation, screenType) {
        return MaterialApp(
          title: 'Atomic Habits',
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: CustomColors.primaryColor),
            useMaterial3: true,
          ),
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: RoutesNames.home,
        );
      },
    );
  }
}

/// Dashboard:
/// Habits:
///   1- add habit (name, question, value)
///   2- show all added habits with today value
///   3- toggle habit on/off
/// Food:
