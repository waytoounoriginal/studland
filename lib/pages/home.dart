import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:studland/colors.dart';

import 'package:animations/animations.dart';
import 'package:studland/pages/coupon_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:intro_slider/intro_slider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var subtitle = const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w300,
    color: Palette.ghostWhite,
  );


  double top1 = 220;
  double top2 = 430;
  double opacity = 1;



  double actualHeight = 0;


  bool ok = false;

  @override
  void initState() {
    opacity = 1.0;


    super.initState();
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.carGreen,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50,),
                  Text(
                    'Welcome back!',
                    style: TextStyle(
                      fontSize: 40,
                      color: Palette.ghostWhite,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'We\'re delighted to have you back!',
                    style: subtitle,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
              height: MediaQuery.of(context).size.height - 50,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Palette.ghostWhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'What would you like to do?',
                    style: TextStyle(
                      fontSize: 20,
                      color: Palette.raisinBlack,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 80),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    child: CarouselSlider(
                      items: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: OpenContainer(
                            transitionDuration: const Duration(milliseconds: 500),
                            closedElevation: 0,
                            closedShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            closedBuilder: (_, openContainer) =>
                                Container(
                                  clipBehavior: Clip.hardEdge,
                                  height: 200,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Stack(
                                    children: [
                                      SizedBox(
                                        height: 200,
                                        width: MediaQuery.of(context).size.width,
                                        child: FittedBox(
                                          fit: BoxFit.cover,
                                          child: Image.asset(
                                            'assets/coupons.jpg',
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        child: Container(
                                          width: MediaQuery.of(context).size.width,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.25),
                                                blurRadius: 10,
                                                spreadRadius: 7.5,
                                                offset: Offset(0, -5),
                                              ),
                                            ],
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(30),
                                              bottomRight: Radius.circular(30),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: const [
                                                Text(
                                                  'Offers',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Palette.raisinBlack,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                Text(
                                                  'Find the best deals.',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Palette.raisinBlack,
                                                    fontWeight: FontWeight.w200,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          splashColor: Colors.white.withOpacity(0.25),
                                          onTap: () {
                                            openContainer();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            openBuilder: (_, closeContainer) =>
                                Coupons(),
                          ),
                        ),// Offers one

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Stack(
                              children: [
                                SizedBox(
                                  height: 200,
                                  width: MediaQuery.of(context).size.width,
                                  child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: Image.asset(
                                      'assets/jobs.jpg',
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.25),
                                          blurRadius: 10,
                                          spreadRadius: 7.5,
                                          offset: Offset(0, -5),
                                        ),
                                      ],
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(30),
                                        bottomRight: Radius.circular(30),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                            'Jobs/Internships',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Palette.raisinBlack,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Text(
                                            'Get the best jobs and internships.',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Palette.raisinBlack,
                                              fontWeight: FontWeight.w200,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    splashColor: Colors.white.withOpacity(0.25),
                                    onTap: () {
                                      print(1);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Stack(
                              children: [
                                SizedBox(
                                  height: 200,
                                  width: MediaQuery.of(context).size.width,
                                  child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: Image.asset(
                                      'assets/events.jpg',
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.25),
                                          blurRadius: 10,
                                          spreadRadius: 7.5,
                                          offset: Offset(0, -5),
                                        ),
                                      ],
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(30),
                                        bottomRight: Radius.circular(30),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                            'Local events',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Palette.raisinBlack,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Text(
                                            'See all the events happening in your area.',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Palette.raisinBlack,
                                              fontWeight: FontWeight.w200,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    splashColor: Colors.white.withOpacity(0.25),
                                    onTap: () {
                                      print(1);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Stack(
                              children: [
                                SizedBox(
                                  height: 200,
                                  width: MediaQuery.of(context).size.width,
                                  child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: Image.asset(
                                      'assets/uni.jpg',
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.25),
                                          blurRadius: 10,
                                          spreadRadius: 7.5,
                                          offset: Offset(0, -5),
                                        ),
                                      ],
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(30),
                                        bottomRight: Radius.circular(30),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                            'My school/university',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Palette.raisinBlack,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Text(
                                            'Access your school/university\'s page',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Palette.raisinBlack,
                                              fontWeight: FontWeight.w200,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    splashColor: Colors.white.withOpacity(0.25),
                                    onTap: () {
                                      print(1);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                      options: CarouselOptions(
                        initialPage: 0,
                        viewportFraction: 0.7,
                        enableInfiniteScroll: true,
                        autoPlay: false,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.vertical,

                      ),
                    )
                  ),

                  const SizedBox(height: 50),
                  Text(
                      'This app is still being worked on, we can\'t wait to show you the full version! 🚀🚀🚀 ',
                      style: TextStyle(
                        fontSize: 14,
                        color: Palette.raisinBlack.withOpacity(0.5),
                        fontWeight: FontWeight.w400,
                      )
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: Palette.carGreen,
                            width: 1,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>
                              IntroSlider(
                                onDonePress: () {
                                  Navigator.pop(context);
                                },
                                hideStatusBar: true,
                                skipButtonStyle: TextButton.styleFrom(
                                  backgroundColor: Palette.raisinBlack,
                                ),
                                nextButtonStyle: TextButton.styleFrom(
                                  backgroundColor: Palette.raisinBlack,
                                ),
                                doneButtonStyle: TextButton.styleFrom(
                                  backgroundColor: Palette.raisinBlack,
                                ),
                                slides: [
                                  Slide(
                                      title: 'The first application dedicated entirely to students!',
                                      description: 'This is the first application dedicated entirely to students!',
                                      pathImage: 'assets/school.png',
                                      backgroundColor: Colors.indigo


                                  ),
                                  Slide(
                                    title: 'Discounts! Discounts everywhere!',
                                    description: 'You can find discounts on everything you need!',
                                    pathImage: 'assets/discounts.png',
                                    backgroundColor: Color(0xFFE76F51),
                                    styleDescription: TextStyle(
                                      color: Palette.raisinBlack.withOpacity(0.5),
                                      fontSize: 18,
                                    ),
                                    styleTitle: TextStyle(
                                      color: Palette.raisinBlack.withOpacity(0.5),
                                      fontSize: 24,
                                    ),


                                  ),
                                  Slide(
                                    title: 'Jobs!',
                                    description: 'You have access to the hottest jobs, local events and universities.',
                                    pathImage: 'assets/jobs.png',
                                    backgroundColor: Colors.white,

                                    styleDescription: TextStyle(
                                      color: Palette.raisinBlack.withOpacity(0.5),
                                      fontSize: 18,
                                    ),
                                    styleTitle: TextStyle(
                                      color: Palette.raisinBlack.withOpacity(0.5),
                                      fontSize: 24,
                                    ),




                                  ),
                                  Slide(
                                    title: 'Universities!',
                                    description: 'We want to integrate schools and universities into the application to meet all the needs of students',
                                    pathImage: 'assets/uni_page.png',
                                    backgroundColor: Colors.lightBlueAccent,
                                    styleDescription: TextStyle(
                                      color: Palette.raisinBlack.withOpacity(0.5),
                                      fontSize: 18,
                                    ),
                                    styleTitle: TextStyle(
                                      color: Palette.raisinBlack.withOpacity(0.5),
                                      fontSize: 24,
                                    ),


                                  ),
                                ],

                              )
                          ));
                        },
                        child: const Text(
                          'About us',
                          style: TextStyle(
                            fontSize: 14,
                            color: Palette.carGreen,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: Colors.red,
                            width: 1,
                          ),
                        ),
                        onPressed: () async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.remove('email');
                          prefs.remove('password');


                          Navigator.popAndPushNamed(context, '/login');

                        },
                        child: const Text(
                          'Log out',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.red,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ]
        ),
      )
    );
  }
}
