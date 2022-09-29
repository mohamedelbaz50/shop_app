import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Layouts/app_cubit/app_cubit.dart';
import 'package:shop_app/Layouts/app_cubit/app_states.dart';
import 'package:shop_app/Models/favorites_model.dart';
import 'package:shop_app/Shared/Component/component.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(listener: (context, state) {
      if (state is ChangeFavoritesSuccesState) {
        if (!state.model!.status!) {
          showToast(message: state.model!.message!, states: ToastStates.error);
        } else {
          showToast(
              message: state.model!.message!, states: ToastStates.sucsess);
        }
      }
    }, builder: (context, state) {
      return ConditionalBuilder(
          condition: state is! GetFavoritesLoadingState,
          builder: (context) => ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildProductList(
                  AppCubit()
                      .get(context)
                      .favoritesModel!
                      .data!
                      .data![index]
                      .product,
                  context),
              separatorBuilder: (context, index) => Container(
                    color: Colors.grey,
                    width: 1,
                    height: 1,
                  ),
              itemCount:
                  AppCubit().get(context).favoritesModel!.data!.data!.length),
          fallback: (context) => Center(
                child: CircularProgressIndicator(),
              ));
    });
  }
}
