import 'dart:developer';
import 'package:assignment_5/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../resources/resources.dart';
import '../../../services/firebase_services.dart';
import '../../../widget/widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

void requiredAllFilled(BuildContext context) {
  final bar = WarningBar();

  final notExist = bar.snack("Required All Filed", ColorManager.redColor);
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(notExist);
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final bar = WarningBar();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passController.dispose();

  }

  @override
  Widget build(BuildContext context) {
    log("repeat");
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    print("SizeWidth:$screenWidth ");
    print("SizeHeight:$screenHeight ");
    return GestureDetector(
      onTap: () {
        WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth < 600 ? 15.w: 100.w),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "TeamUp APP",
                          style: TextStyle(
                            fontSize:  screenWidth < 600 ? 34.sp: 15.sp,
                            fontFamily: "DancingScript",
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 12.r),
                          child: Text(
                            "Login to the web app",
                            style: TextStyle(fontSize: screenWidth < 600 ? 12.sp: 7.sp),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 15.r),
                          child: PrimaryTextFilled(
                            controller: _emailController,
                            hintText: "Enter Email",
                            labelText: "Email",
                            prefixIcon: const Icon(
                              Icons.mail_rounded,
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.0.r),
                          child: PrimaryPassField(
                            textPassCtrl: _passController,
                            hintText: "Enter Password",
                            labelText: "Password",
                            prefixIcon: const Icon(
                              Icons.password_rounded,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                            if (_emailController.text.trim() == "" ||
                                _emailController.text.trim().isEmpty ||
                                _passController.text.trim() == "" ||
                                _passController.text.trim().isEmpty) {
                              requiredAllFilled(context); // through scaffold snackbar
                            } else {
                              // Sign in Function
                              await FireBaseServices().signIN(
                                context,
                                textEmail: _emailController.text.trim(),
                                textPass: _passController.text.trim(),
                              );
                            }
                          },
                          child: const Text("Login"),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 12.0.r),
                          child: GestureDetector(
                            onTap: () {
                              context.goNamed(RoutesName.signupName); // navigate to the signup screen
                            },
                            child:   TextRich(
                              firstText: "Don't have an account?",
                              secText: "Sign up",
                              screenWidth: screenWidth,
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
