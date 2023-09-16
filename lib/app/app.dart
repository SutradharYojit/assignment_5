import 'package:flutter/material.dart';
import '../resources/resources.dart';
import '../routes/route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
            useMaterial3: true,
            cardTheme: const CardTheme(
              surfaceTintColor: ColorManager.whiteColor,
            ),
            scaffoldBackgroundColor: ColorManager.whiteColor,
          ),
          routerConfig: router,
        );
      },
    );
  }
}
