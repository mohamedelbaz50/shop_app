import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Layouts/app_cubit/app_cubit.dart';
import 'package:shop_app/Layouts/app_cubit/app_states.dart';
import 'package:shop_app/Models/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
            itemBuilder: (context, index) => buildCatItem(
                AppCubit().get(context).categoriesModel!.data!.data[index]),
            separatorBuilder: (context, index) => Container(
                  color: Colors.grey,
                  width: 1,
                  height: 1,
                ),
            itemCount:
                AppCubit().get(context).categoriesModel!.data!.data.length);
      },
    );
  }

  Widget buildCatItem(DataModel? model) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Image(
              height: 100,
              width: 100,
              fit: BoxFit.cover,
              image: NetworkImage("${model!.image}")),
          SizedBox(
            width: 10,
          ),
          Text(
            "${model.name}",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            size: 30,
          )
        ],
      ),
    );
  }
}
