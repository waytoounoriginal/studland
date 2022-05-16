import 'package:flutter/material.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:studland/colors.dart';

import 'package:animations/animations.dart';
import 'package:studland/pages/coupon_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:intro_slider/intro_slider.dart';

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

  final PageController _pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.carGreen,
      body: Listener(
        behavior: HitTestBehavior.translucent,
        onPointerUp: (_) => setState(() {
          ok = false;
          print(2);
        }),
        child: NotificationListener<ScrollUpdateNotification>(
          onNotification: (v) {
            if (v is ScrollNotification && ok) {
              setState(() {
                top1 = top1 - v.scrollDelta! / 2;
                top2 = top2 - v.scrollDelta! / 1;

              });
            }
            return true;
          },
          child: LayoutBuilder(
          builder: (ctx, constraints) {
            double tempHeight = constraints.maxHeight + 300;

            actualHeight = tempHeight;

            if(top2 <= 100){
              top2 = 100;
            }
            else if(top2 >= 430){
              top2 = 430;
            }








            return Stack(
              children: [
                Positioned(
                  top: top1,
                  child: Container(
                    color: Palette.carGreen,
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                        //Image.asset('assets/logo_png.png', height: 200, width: 200,)
                      ],
                    ),
                  ),
                ),
                Container(
                  height: actualHeight,
                  color: Colors.transparent,
                ),
                Positioned(
                  top: top2,
                  right: 0,
                  left: 0,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                    height: actualHeight,
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
                        Listener(
                          behavior: HitTestBehavior.translucent,
                          onPointerDown: (_) =>
                              setState(() {
                                ok = true;
                                print(1);
                              }),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 5),
                            child: Container(
                              height: 7.5,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: ListView(
                                children: [
                                  Container(
                                    height: actualHeight,
                                    color: Colors.transparent,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
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
                          height: 200,
                          child: Center(
                            child: PageView(
                              controller: _pageController,
                              children: [
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
                                                    'Universities',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      color: Palette.raisinBlack,
                                                      fontWeight: FontWeight.w700,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Get the best deals from the best universities.',
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
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SmoothPageIndicator(
                              controller: _pageController,
                              count: 4,
                              effect: WormEffect(
                                activeDotColor: Palette.carGreen,
                                dotColor: Palette.carGreen.withOpacity(0.25),
                                dotHeight: 10,
                                dotWidth: 10,
                              ),
                              onDotClicked: (index) {
                                _pageController.animateToPage(index,
                                    duration: Duration(milliseconds: 300), curve: Curves.ease);
                              },
                            ),
                          ],
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
                                      backgroundColor: Palette.ghostWhite,
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



                                  )
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
                        )
                      ],
                    ),
                  )
                ),
              ],
            );
          }


          ),
        ),
      )
    );
  }
}
