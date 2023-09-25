import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/modules/home_screen/cubit/cubit.dart';
import 'package:music_app/modules/home_screen/cubit/states.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
        listener: (context,state){

        },

        builder:(context,state) {
        return Scaffold(
          body: Text("fasdf"),
        );
      }
    );
  }
}
