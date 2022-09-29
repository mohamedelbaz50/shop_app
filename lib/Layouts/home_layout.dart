import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Layouts/app_cubit/app_cubit.dart';
import 'package:shop_app/Layouts/app_cubit/app_states.dart';
import 'package:shop_app/Modules/search_screen/search_screen.dart';
import 'package:shop_app/Shared/Component/component.dart';
import 'package:shop_app/Shared/styles/icon_broken.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit().get(context);
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      navigateTo(context, SearchScreen());
                    },
                    icon: const Icon(Icons.search)),
              ],
              title: Text(cubit.titles[cubit.currentIndex]),
            ),
            body: cubit.bottomNavScreens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(IconBroken.Home), label: "Home"),
                  BottomNavigationBarItem(
                      icon: Icon(IconBroken.Category), label: "Categories"),
                  BottomNavigationBarItem(
                      icon: Icon(IconBroken.Heart), label: "Favorites"),
                  BottomNavigationBarItem(
                      icon: Icon(IconBroken.Profile), label: "Profile")
                ],
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeBottomNav(index);
                }),
          );
        });
  }
}
