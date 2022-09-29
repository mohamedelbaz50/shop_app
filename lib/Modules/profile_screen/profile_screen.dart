import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Layouts/app_cubit/app_cubit.dart';
import 'package:shop_app/Layouts/app_cubit/app_states.dart';
import 'package:shop_app/Modules/Login/login_screen.dart';
import 'package:shop_app/Modules/edit_profile/edit_profile.dart';
import 'package:shop_app/Modules/products_screen/products_screen.dart';
import 'package:shop_app/Shared/Component/component.dart';
import 'package:shop_app/Shared/Network/Local/cache_helper.dart';
import 'package:shop_app/Shared/styles/icon_broken.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit().get(context);

          return Padding(
              padding: const EdgeInsets.all(20),
              child: ConditionalBuilder(
                condition: cubit.loginModel != null,
                builder: (context) => SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Center(
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://img.freepik.com/free-vector/hand-drawn-hajj-illustration-with-people-praying_23-2149478373.jpg"),
                          radius: 50,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "${cubit.loginModel!.data!.name}",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height / 1.9,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            color: Colors.white),
                        child: Column(
                          children: [
                            buildInProfilrItem(
                                onTap: () {
                                  navigateTo(context, EditProfile());
                                },
                                icon: IconBroken.Edit_Square,
                                text: "Edit Personal info"),
                            myDivider(),
                            buildInProfilrItem(
                                icon: Icons.shopping_cart_checkout_outlined,
                                text: "Orders"),
                            myDivider(),
                            buildInProfilrItem(
                                icon: Icons.restore, text: "Orders Returns"),
                            myDivider(),
                            buildInProfilrItem(
                                icon: IconBroken.Location, text: "Addresses"),
                            myDivider(),
                            buildInProfilrItem(
                                icon: Icons.payment_outlined, text: "Payments"),
                            myDivider(),
                            buildInProfilrItem(
                                icon: IconBroken.Wallet, text: "Wallet"),
                          ],
                        ),
                      )

                      // defaultFormField(
                      //     controller: nameController,
                      //     type: TextInputType.name,
                      //     validate: (String value) {
                      //       if (value.isEmpty) {
                      //         return "Name Must be Not Empty";
                      //       }
                      //     },
                      //     label: "Name",
                      //     prefix: Icons.person),
                      // const SizedBox(
                      //   height: 15,
                      // ),
                      // defaultFormField(
                      //     controller: emailController,
                      //     type: TextInputType.emailAddress,
                      //     validate: (String value) {
                      //       if (value.isEmpty) {
                      //         return "Email Must be Not Empty";
                      //       }
                      //     },
                      //     label: "Email",
                      //     prefix: Icons.email),
                      // const SizedBox(
                      //   height: 15,
                      // ),
                      // defaultFormField(
                      //     controller: phoneController,
                      //     type: TextInputType.phone,
                      //     validate: (String value) {
                      //       if (value.isEmpty) {
                      //         return "Phone Must be Not Empty";
                      //       }
                      //     },
                      //     label: "Phone",
                      //     prefix: Icons.phone),
                      // const SizedBox(
                      //   height: 15,
                      // ),
                      // defaultButton(
                      //     function: () {
                      //       if (formKey.currentState!.validate()) {
                      //         AppCubit().get(context).updateUserData(
                      //               name: nameController.text,
                      //               email: emailController.text,
                      //               phone: phoneController.text,
                      //             );
                      //       }
                      //     },
                      //     text: "Save Updates"),
                      // const SizedBox(
                      //   height: 15,
                      // ),
                      // defaultButton(
                      //     function: () {
                      //       CacheHelper.removeData(key: "token").then(
                      //           (value) => navigateAndFinish(
                      //               context, LoginScreen()));
                      //     },
                      //     text: "Logout"),
                    ],
                  ),
                ),
                fallback: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              ));
        });
  }
}
