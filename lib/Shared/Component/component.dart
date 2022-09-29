import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/Layouts/app_cubit/app_cubit.dart';

import '../styles/icon_broken.dart';

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.teal,
  bool isUpperCase = true,
  double radius = 3.0,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );
Widget buildInProfilrItem(
    {required IconData icon, required String text, Function? onTap}) {
  return Expanded(
    child: InkWell(
      onTap: () {
        onTap!();
      },
      child: Row(
        // ignore: prefer_const_constructors
        children: [
          Icon(icon),
          const SizedBox(
            width: 10,
          ),
          Text(text),
          const Spacer(),
          const Icon(IconBroken.Arrow___Right_Circle),
        ],
      ),
    ),
  );
}

Widget myDivider() {
  return Container(
    margin: const EdgeInsets.all(10),
    width: double.infinity - 40,
    height: 1,
    color: Colors.grey[400],
  );
}

Widget defaultFormField({
  required TextEditingController? controller,
  required TextInputType? type,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  bool isPassword = false,
  required Function validate,
  required String? label,
  required IconData? prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
  // ignore: use_function_type_syntax_for_parameters, non_constant_identifier_names
}) =>
    TextFormField(
      onTap: () {
        onTap!();
      },
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: (s) {
        onSubmit!(s);
      },
      onChanged: (s) {
        onChange!(s);
      },
      validator: (value) {
        return validate(value);
      },
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          /* borderSide: const BorderSide(
            color: MyColors.basColor,
            width: 2.0,
          ),*/
        ),
        labelText: label,
        labelStyle: const TextStyle(),
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  suffixPressed!();
                },
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );

void showToast({required String message, required ToastStates states}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: chooseToastColor(states),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastStates { sucsess, error, warnning }

Color chooseToastColor(ToastStates states) {
  Color color;
  switch (states) {
    case ToastStates.error:
      color = Colors.red;
      break;
    case ToastStates.sucsess:
      color = Colors.green;
      break;
    case ToastStates.warnning:
      color = Colors.orange;
      break;
  }
  return color;
}

void navigateAndFinish(
  context,
  widget,
) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) {
        return false;
      },
    );
Widget buildProductList(model, context, {bool isOldPrice = true}) {
  return Container(
    padding: const EdgeInsets.all(15),
    height: 120,
    child: Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
                height: 100,
                width: 100,
                fit: BoxFit.cover,
                image: NetworkImage(model.image.toString())),
            if (model.discount != 0 && isOldPrice)
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: Colors.red),
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
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model.name.toString(),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  model.price.toString(),
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal),
                ),
                const SizedBox(
                  width: 7,
                ),
                if (model.discount != 0 && isOldPrice)
                  Text(
                    model.oldPrice.toString(),
                    style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        decorationColor: Colors.red),
                  ),
                const Spacer(),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: AppCubit().get(context).favorites![model.id]!
                      ? Colors.redAccent
                      : Colors.grey,
                  child: Center(
                    child: IconButton(
                        onPressed: () {
                          AppCubit()
                              .get(context)
                              .changeFavorites(model.id!.toInt());
                        },
                        icon: const Icon(
                          Icons.favorite_border,
                          size: 20,
                          color: Colors.white,
                        )),
                  ),
                )
              ],
            )
          ],
        )),
      ],
    ),
  );
}
