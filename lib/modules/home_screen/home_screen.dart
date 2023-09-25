import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/constants.dart';
import 'package:music_app/modules/home_screen/cubit/cubit.dart';
import 'package:music_app/modules/home_screen/cubit/states.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
         var  cubit = HomeCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: defaultColor,
             title:  Center(child: Text(cubit.titles[cubit.currentIndex]))
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              elevation: 0.0,
              selectedItemColor: defaultColor,
              onTap: (index) {
               cubit.changeIndex(index);
              },
              items:cubit.bottomItems
            ),
          );
        }
    );
  }
}
