import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Layouts/app_cubit/app_cubit.dart';
import 'package:shop_app/Layouts/app_cubit/app_states.dart';
import 'package:shop_app/Layouts/home_layout.dart';
import 'package:shop_app/Modules/Login/login_screen.dart';
import 'package:shop_app/Shared/Network/Local/cache_helper.dart';

import 'Modules/on_boarding/on_boarding.dart';
import 'Shared/Network/Remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;

  bool? onBoarding = CacheHelper.getData(key: "OnBoarding");
  String? token = CacheHelper.getData(key: "token");
  print(token);

  if (onBoarding != null) {
    if (token != null) {
      widget = const HomeLayout();
    } else {
      widget = LoginScreen();
    }
  } else {
    onBoarding = false;
    widget = const OnBoardinScreen();
  }
  runApp(MyApp(
    startwidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget? startwidget;
  MyApp({this.startwidget});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()
        ..getHomeData()
        ..getUserData()
        ..getCategoriesData()
        ..getFavoritesData(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.teal,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                backgroundColor: Colors.white,
                elevation: 0.0,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
              ),
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: Colors.teal,
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.teal,
                elevation: 20.0,
              ),
            ),
            darkTheme: ThemeData(
              scaffoldBackgroundColor: Colors.black26,
            ),
            themeMode: ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: startwidget,
          );
        },
      ),
    );
  }
}
