import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_shoper_master/shared/constants/colors.dart';

import '../shared/generic_cubit/generic_cubit.dart';
import '../view_models/splash_view_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashViewModel splashViewModel = SplashViewModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GenericCubit, GenericCubitState>(
      bloc: splashViewModel.splashCubit,
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: kVerticalGradiant,
            ),
            child: Center(
                child: DefaultTextStyle(
              style: GoogleFonts.allan(
                fontSize: 50,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              child: AnimatedTextKit(
                animatedTexts: [
                  WavyAnimatedText("CODELY"),
                ],
                isRepeatingAnimation: false,
                onTap: () {
                  print("Tap Event");
                },
              ),
            )),
          ),
        );
      },
    );
  }
}
