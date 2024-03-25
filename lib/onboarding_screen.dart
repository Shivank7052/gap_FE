import 'package:flutter/material.dart';
import 'package:gap/main.dart';

class onBoardingScreen extends StatefulWidget {
  const onBoardingScreen({super.key});

  @override
  State<onBoardingScreen> createState() => _onBoardingScreenState();
}

class _onBoardingScreenState extends State<onBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'images/onboarding.png',
                height: 190.83,
                width: 308,
              ),
              const SizedBox(
                height: 77,
              ),
              const Text(
                'Get The Generic \n Alternative Medicine For You',
                style: TextStyle(
                    color: Color(0xFF051613),
                    fontFamily: 'Poppins Bold',
                    fontSize: 18,
                    decoration: TextDecoration.none),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'Receive intelligent insight for alternative medicines \n based on your scanned prescription.',
                style: TextStyle(
                    color: Color(0xFF051613),
                    fontFamily: 'Poppins Light',
                    fontSize: 12,
                    decoration: TextDecoration.none),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 61,
              ),
              InkWell(
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => HomeScreen()))
                },
                child: Container(
                  width: 320,
                  height: 43,
                  decoration: BoxDecoration(
                      color: const Color(0xFF209F85),
                      borderRadius: BorderRadius.circular(12)),
                  child: const Center(
                      child: Text(
                    'Get Started',
                    style: TextStyle(color: Color(0xFFF6F8F7)),
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
