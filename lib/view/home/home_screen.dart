import 'package:assignment_5/routes/routes_name.dart';
import 'package:assignment_5/view/home/user_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../resources/resources.dart';
import '../../services/services.dart';
import '../../widget/widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    getUpdates();
  }

  void getUpdates() async {
    await UserGlobalVariables.getUserData();
    ref.read(userList.notifier).getUserData();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    final data = ref.watch(userList);
    final loading = ref.read(userList.notifier).loading;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.h,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    StringManager.helloTxt,
                    style: TextStyle(
                      fontSize: screenWidth < 600 ? 15.sp: 7.sp,
                      fontFamily: "DancingScript",
                    ),
                  ),
                  loading ? Card(
                    elevation: 1.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const SizedBox(height: 10),
                  ):Text(
                    data[0].userName!,
                    style: TextStyle(
                      fontSize: screenWidth < 600 ? 17.sp: 7.sp,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: ref.read(userList.notifier).getUserData,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              children: <Widget>[
                loading
                    ? Expanded(
                        child: ShimmerLoading(
                          height: 40.h,
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: data.length - 1,
                          padding: EdgeInsets.symmetric(vertical: 15.w),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                context.push(RoutesName.chatScreen, extra: data[index + 1]);
                              },
                              child: Card(
                                child: Container(
                                  padding: EdgeInsets.all(15.r),
                                  child: Row(
                                    children: [
                                      Text(
                                        data[index + 1].userName!,
                                        style: TextStyle(fontSize: screenWidth < 600 ? 12.sp: 7.sp),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
