import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../routes/routes_name.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../services/services.dart';

// Splash Screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final userAuth = FirebaseAuth.instance.currentUser?.uid;
  final userPreferences = UserPreferences();

  @override
  void initState() {
    super.initState();
    userPreferences.getUserInfo();
    navigation();
  }

  void navigation() {
    Duration duration = const Duration(seconds: 3);
    Future.delayed(
      duration,
      () {
        if (userPreferences.email != null &&
            userPreferences.pass != null &&
            userPreferences.email!.isNotEmpty &&
            userPreferences.pass!.isNotEmpty) {
          // its yes move to dashboard screen
          context.go(RoutesName.homeScreen);
        } else {
          // its no move to login screen
          context.go(RoutesName.loginScreen);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get screen width and height using media query
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          // Use LayoutBuilder to adapt padding based on screen constraints
          padding: EdgeInsets.all(15.w),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Web App",
                    style: TextStyle(
                      fontSize: screenWidth < 600 ? 40.sp : 20.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: "DancingScript",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.r),
                    child: const Center(
                      child: SpinKitChasingDots(
                        color: Colors.black,
                        size: 45,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
