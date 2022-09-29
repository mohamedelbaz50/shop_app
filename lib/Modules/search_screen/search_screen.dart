import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Models/favorites_model.dart';
import 'package:shop_app/Models/search_model.dart';
import 'package:shop_app/Modules/search_screen/search_cubit.dart';
import 'package:shop_app/Modules/search_screen/search_states.dart';
import 'package:shop_app/Shared/Component/component.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    defaultFormField(
                        controller: searchController,
                        type: TextInputType.name,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return "Enter Text to Search";
                          }
                          return null;
                        },
                        label: "Search",
                        prefix: Icons.search,
                        onChange: (String text) {
                          SearchCubit().get(context).search(text: text);
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    if (state is SearchLoadinglState) LinearProgressIndicator(),
                    const SizedBox(
                      height: 10,
                    ),
                    if (state is SearchSuccesslState)
                      Expanded(
                        child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) => buildProductList(
                                SearchCubit()
                                    .get(context)
                                    .searchModel!
                                    .data!
                                    .data![index],
                                context,
                                isOldPrice: false),
                            separatorBuilder: (context, index) => Container(
                                  color: Colors.grey,
                                  width: 1,
                                  height: 1,
                                ),
                            itemCount: SearchCubit()
                                .get(context)
                                .searchModel!
                                .data!
                                .data!
                                .length),
                      )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
