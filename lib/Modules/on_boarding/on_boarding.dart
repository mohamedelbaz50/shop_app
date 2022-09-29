import 'package:flutter/material.dart';
import 'package:shop_app/Modules/Login/login_screen.dart';
import 'package:shop_app/Shared/Component/component.dart';
import 'package:shop_app/Shared/Network/Local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingModel {
  String? image;
  String? title;
  String? body;
  OnBoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardinScreen extends StatefulWidget {
  const OnBoardinScreen({Key? key}) : super(key: key);

  @override
  _OnBoardinScreenState createState() => _OnBoardinScreenState();
}

class _OnBoardinScreenState extends State<OnBoardinScreen> {
  List<OnBoardingModel> Onboarding = [
    OnBoardingModel(
        image: "assets/images/onboard_1.jpg",
        title: "Hot Offers ",
        body: "Login to See Hot Offers"),
    OnBoardingModel(
        image: "assets/images/onboard_2.jpg",
        title: "Fast Deliver",
        body: "You Order will arrive in Time"),
    OnBoardingModel(
        image: "assets/images/onboard_1.jpg",
        title: "Screen title 3",
        body: "Screen Body 3")
  ];
  var boardController = PageController();
  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () {
                  CacheHelper.saveData(key: "OnBoarding", value: true)
                      .then((value) {
                    if (value) navigateAndFinish(context, LoginScreen());
                  });
                },
                child: Text("SKIP"))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: boardController,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      buildOnBoardingItem(Onboarding[index]),
                  itemCount: Onboarding.length,
                  onPageChanged: (int index) {
                    if (index == Onboarding.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardController,
                    count: Onboarding.length,
                    effect: ExpandingDotsEffect(
                        dotColor: Colors.grey, activeDotColor: Colors.teal),
                  ),
                  Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast) {
                        navigateTo(context, LoginScreen());
                      } else {
                        boardController.nextPage(
                            duration: Duration(microseconds: 700),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    child: Icon(Icons.arrow_forward_ios),
                  )
                ],
              )
            ],
          ),
        ));
  }

  Widget buildOnBoardingItem(OnBoardingModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Image(image: AssetImage("${model.image}"))),
        SizedBox(
          height: 30,
        ),
        Text(
          "${model.title}",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          "${model.body}",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
