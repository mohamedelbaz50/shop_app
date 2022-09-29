import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Layouts/app_cubit/app_cubit.dart';
import 'package:shop_app/Layouts/app_cubit/app_states.dart';
import 'package:shop_app/Models/categories_model.dart';

import 'package:shop_app/Models/home_model.dart';
import 'package:shop_app/Shared/Component/component.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is ChangeFavoritesSuccesState) {
          if (!state.model!.status!) {
            showToast(
                message: state.model!.message!, states: ToastStates.error);
          } else {
            showToast(
                message: state.model!.message!, states: ToastStates.sucsess);
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
            condition: AppCubit().get(context).homeModel != null &&
                AppCubit().get(context).categoriesModel != null,
            builder: (context) => widgetBuild(AppCubit().get(context).homeModel,
                AppCubit().get(context).categoriesModel, context),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget widgetBuild(
    HomeModel? model,
    CategoriesModel? categoriesModel,
    context,
  ) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items: model!.data!.banners
                  .map((e) => Image(
                        width: double.infinity,
                        height: 200,
                        image: NetworkImage('${e.image}'),
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                  height: 200,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  viewportFraction: 1,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                  scrollDirection: Axis.horizontal,
                  autoPlayCurve: Curves.easeInExpo)),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Categories",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 100,
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          buildCategories(categoriesModel!.data!.data[index]),
                      separatorBuilder: (context, index) => const SizedBox(
                            width: 10,
                          ),
                      itemCount: categoriesModel!.data!.data.length),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "New Products",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          Container(
              color: Colors.grey[200],
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 3,
                crossAxisSpacing: 3,
                childAspectRatio: 1 / 1.4,
                children: List.generate(
                  model.data!.products.length,
                  (index) => buildProduct(model.data!.products[index], context),
                ),
              ))
        ],
      ),
    );
  }

  Widget buildProduct(ProductModel productModel, context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                  height: 150,
                  width: double.infinity,
                  image: NetworkImage("${productModel.image}")),
              if (productModel.discount != 0)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red),
                  child: const Text(
                    "DISCOUNT",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                )
            ],
          ),
          Text(
            productModel.name.toString(),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          Row(
            children: [
              Text(
                productModel.price.toString(),
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal),
              ),
              const SizedBox(
                width: 7,
              ),
              if (productModel.discount != 0)
                Text(
                  productModel.oldPrice.toString(),
                  style: const TextStyle(
                      decoration: TextDecoration.lineThrough,
                      decorationColor: Colors.red),
                ),
              const Spacer(),
              CircleAvatar(
                radius: 20,
                backgroundColor:
                    AppCubit().get(context).favorites![productModel.id]!
                        ? Colors.redAccent
                        : Colors.grey,
                child: Center(
                  child: IconButton(
                      onPressed: () {
                        AppCubit()
                            .get(context)
                            .changeFavorites(productModel.id!.toInt());
                      },
                      icon: const Icon(
                        Icons.favorite_border,
                        size: 20,
                        color: Colors.white,
                      )),
                ),
              )
            ],
          ),
          Center(
            child: CircleAvatar(
              child: Icon(Icons.shopping_cart),
            ),
          )
        ],
      ),
    );
  }

  Widget buildCategories(DataModel? dataModel) {
    return Container(
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Image(
              height: 100,
              width: 100,
              fit: BoxFit.cover,
              image: NetworkImage("${dataModel!.image}")),
          Container(
            width: 100,
            color: Colors.black.withOpacity(0.8),
            child: Text(
              "${dataModel.name}",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }
}
