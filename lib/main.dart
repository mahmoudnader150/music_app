import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/constants.dart';
import 'package:music_app/modules/home_screen/cubit/cubit.dart';
import 'package:music_app/modules/home_screen/cubit/states.dart';
import 'package:music_app/modules/home_screen/home_screen.dart';
import 'package:music_app/modules/onboarding_screen.dart';
import 'package:music_app/themes.dart';


void main() {
  bool isDark =false;
  runApp( MyApp(isDark: isDark));
}

class MyApp extends StatefulWidget {
  final bool isDark;
  MyApp({
    required this.isDark,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 // const MyApp({super.key});


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
              theme:lightTheme,
              darkTheme: darkTheme,
              themeMode: HomeCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
              debugShowCheckedModeBanner: false,
              home: OnBoardingScreen(),
            );
          },
        )
    );
  }


}

