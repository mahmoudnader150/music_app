import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/constants.dart';
import 'package:music_app/modules/home_screen/cubit/cubit.dart';
import 'package:music_app/modules/home_screen/cubit/states.dart';
import 'package:music_app/modules/home_screen/home_screen.dart';
import 'package:music_app/modules/onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context)=>HomeCubit()
          )
        ],
        child: BlocConsumer<HomeCubit,HomeStates>(
          listener: (context,state){},
          builder: (context,state){
            return MaterialApp(
              theme: ThemeData(
                primaryColor: defaultColor,

              ),
              debugShowCheckedModeBanner: false,
              home: OnBoardingScreen(),
            );
          },
        )
    );
  }
}

