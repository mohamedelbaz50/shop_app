import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Layouts/app_cubit/app_cubit.dart';
import 'package:shop_app/Layouts/app_cubit/app_states.dart';
import 'package:shop_app/Shared/styles/icon_broken.dart';

import '../../Shared/Component/component.dart';
import '../../Shared/Network/Local/cache_helper.dart';
import '../Login/login_screen.dart';

class EditProfile extends StatelessWidget {
  EditProfile({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = AppCubit().get(context);
        nameController.text = cubit.loginModel!.data!.name.toString();
        emailController.text = cubit.loginModel!.data!.email.toString();
        phoneController.text = cubit.loginModel!.data!.phone.toString();
        return Scaffold(
          appBar: AppBar(
            title: const Text("Edit Profile"),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if (state is UpdateUserDataLoadingState)
                      const LinearProgressIndicator(),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          const CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://img.freepik.com/free-vector/hand-drawn-hajj-illustration-with-people-praying_23-2149478373.jpg"),
                            radius: 50,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.black.withOpacity(0.3),
                            child: const Icon(
                              IconBroken.Camera,
                              color: Colors.white,
                            ),
                          )
                        ],
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
                      height: 30,
                    ),
                    defaultFormField(
                        controller: nameController,
                        type: TextInputType.name,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return "Name Must be Not Empty";
                          }
                        },
                        label: "Name",
                        prefix: Icons.person),
                    const SizedBox(
                      height: 15,
                    ),
                    defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return "Email Must be Not Empty";
                          }
                        },
                        label: "Email",
                        prefix: Icons.email),
                    const SizedBox(
                      height: 15,
                    ),
                    defaultFormField(
                        controller: phoneController,
                        type: TextInputType.phone,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return "Phone Must be Not Empty";
                          }
                        },
                        label: "Phone",
                        prefix: Icons.phone),
                    const SizedBox(
                      height: 15,
                    ),
                    defaultButton(
                        function: () {
                          if (formKey.currentState!.validate()) {
                            AppCubit().get(context).updateUserData(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text,
                                );
                          }
                        },
                        text: "Save Updates"),
                    const SizedBox(
                      height: 15,
                    ),
                    defaultButton(
                        function: () {
                          CacheHelper.removeData(key: "token").then((value) =>
                              navigateAndFinish(context, LoginScreen()));
                        },
                        text: "Logout"),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
