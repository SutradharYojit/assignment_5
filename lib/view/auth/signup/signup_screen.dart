import 'package:assignment_5/resources/string_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../resources/resources.dart';
import '../../../routes/routes_name.dart';
import '../../../services/firebase_services.dart';
import '../../../widget/widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

void requiredAllFilled(BuildContext context) {
  final bar = WarningBar();
  final notExist = bar.snack(StringManager.requiredWarningTxt, ColorManager.redColor);
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(notExist);
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final bar = WarningBar();

  @override
  void dispose() {
    super.dispose();
    _userController.dispose();
    _emailController.dispose();
    _passController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    print("SizeWidth:$screenWidth ");
    print("SizeHeight:$screenHeight ");

    return GestureDetector(
      onTap: () {
        WidgetsBinding.instance.focusManager.primaryFocus
            ?.unfocus(); // unfocus the text field on tapping gesture deatector
      },
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Padding(
                    padding:   EdgeInsets.symmetric(horizontal: screenWidth < 600 ? 15.w: 100.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "TeamUp App",
                          style: TextStyle(
                            fontSize: screenWidth < 600 ? 34.sp: 15.sp,
                            fontFamily: "DancingScript",
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 12.r),
                          child: Text(
                            StringManager.signupTitle,
                            style: TextStyle(
                              fontSize: screenWidth < 600 ? 14.sp: 7.sp,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 15.r),
                          child: PrimaryTextFilled(
                            controller: _userController,
                            hintText: StringManager.userHintTxt,
                            labelText: StringManager.userLabelTxt,
                            prefixIcon: const Icon(
                              Icons.supervised_user_circle_rounded,
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 15.r),
                          child: PrimaryTextFilled(
                            controller: _emailController,
                            hintText: StringManager.emailHintTxt,
                            labelText: StringManager.emailLabelTxt,
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
                            hintText: StringManager.passHintTxt,
                            labelText: StringManager.passLabelTxt,
                            prefixIcon: const Icon(
                              Icons.password_rounded,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (_emailController.text.trim() == "" ||
                                _emailController.text.trim().isEmpty ||
                                _userController.text.trim() == "" ||
                                _userController.text.trim().isEmpty ||
                                _passController.text.trim() == "" ||
                                _passController.text.trim().isEmpty) {
                              requiredAllFilled(context);
                            } else {
                              await FireBaseServices().signUP(context,
                                  textEmail: _emailController.text.trim(),
                                  textPass: _passController.text.trim(),
                                  userName: _userController.text.trim());
                            }
                          },
                          child: const Text("Signup"),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.0.r),
                          child: GestureDetector(
                            onTap: () {
                              context.go(RoutesName.loginScreen); //navgationto login screen
                            },
                            child:   TextRich(
                              firstText: StringManager.haveAccountTxt,
                              secText: StringManager.loginText,
                              screenWidth: screenWidth,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
