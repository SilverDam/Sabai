import 'package:flutter/material.dart';
import 'package:sabai/view/sign.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'test.dart';

// Onboarding screen pageview
class Onboarding extends StatefulWidget {
  const Onboarding();

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final _controller = PageController(
    initialPage: 0,
  );
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Stack(
      alignment: Alignment.center,
      children: [
        PageView(controller: _controller, children: [
          onboardWidget1(height, width, context),
          onboardWidget2(height, width, context),
          onboardWidget3(height, width, context),
        ]),
        Positioned(
            bottom: 0,
            child: Container(
              height: height * 0.25,
              width: width,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.white,
                      blurRadius: 20,
                      spreadRadius: 50,
                      offset: Offset(0, -60)),
                ],
              ),
            )),
        Positioned(
            bottom: height * 0.1,
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignScreen()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: button(context, height, width * 0.8, 'Get started'),
                ))),
        Positioned(
            bottom: height * 0.25,
            child: SmoothPageIndicator(
                controller: _controller, // PageController
                count: 3,
                effect: ExpandingDotsEffect(
                    spacing: 4,
                    radius: 30,
                    dotWidth: 14.0,
                    dotHeight: 10.0,
                    paintStyle: PaintingStyle.fill,
                    strokeWidth: 1.5,
                    dotColor: Theme.of(context).colorScheme.surface,
                    activeDotColor: Theme.of(context)
                        .colorScheme
                        .secondary), // your preferred effect
                onDotClicked: (index) {}))
      ],
    );
  }
}

// Onboarding screens tab widgets

Widget onboardWidget1(height, width, context) {
  return Scaffold(
    body: Container(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 60),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hi there',
                    style: Theme.of(context).textTheme.titleSmall!),
                const SizedBox(
                  height: 20,
                ),
                Text('Kimiko',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: width * 0.7,
                  child: Text(
                      'A platform that lets you unlock the world of books with ease - wherever, whenever',
                      style: Theme.of(context).textTheme.bodyMedium),
                )
              ],
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Image.asset(
              'asset/images/onboardimg1.png',
              width: width * 0.8,
            )
          ],
        ),
      ),
    ),
  );
}

Widget onboardWidget2(height, width, context) {
  return Scaffold(
    body: Container(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 60),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Explore and Learn',
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: width * 0.5,
                  child: Text(
                    'Get access to a huge library of books from all genres.',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Image.asset(
              'asset/images/onboardimg2.png',
              width: width * 0.8,
            )
          ],
        ),
      ),
    ),
  );
}

Widget onboardWidget3(height, width, context) {
  return Scaffold(
    body: Container(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 60),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Read with Ease',
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: width * 0.5,
                  child: Text(
                    'Built-in dictionary and translation tools to enhance your reading experience.',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Image.asset(
              'asset/images/onboardimg3.png',
              width: width * 0.8,
            )
          ],
        ),
      ),
    ),
  );
}

// Onboarding screen Get started button
Widget button(context, height, width, String btn) {
  return Container(
    height: height * 0.055,
    width: width,
    decoration: BoxDecoration(
      gradient: const LinearGradient(colors: [
        Color.fromARGB(255, 255, 126, 90),
        Color.fromARGB(255, 255, 80, 121)
      ]),
      borderRadius: BorderRadius.circular(30),
    ),
    child: Center(
        child: Text(
      btn,
      style: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(color: Theme.of(context).colorScheme.primary),
    )),
  );
}
