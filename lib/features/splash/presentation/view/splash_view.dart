import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:guide_go/features/splash/presentation/view_model/splash_cubit.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      context.read<SplashCubit>().init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2C3E50),
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF2196F3), Color(0xFF9C27B0)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated App Name
                SizedBox(
                  height: 100,
                  child: DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'Guide Go',
                          speed: const Duration(milliseconds: 350),
                        ),
                      ],
                      totalRepeatCount: 1,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Hire Your Guide. Experience the Unseen',
                  style: TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.normal,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                // Progress indicator
                const CircularProgressIndicator(
                  color: Colors.lightBlueAccent,
                  strokeWidth: 3,
                ),
              ],
            ),
          ),
          // Footer slogan
          Positioned(
            bottom: 20,
            width: MediaQuery.of(context).size.width,
            child: const Text(
              'Nepal awaits you! With Guide Go.',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF9FAFA),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
