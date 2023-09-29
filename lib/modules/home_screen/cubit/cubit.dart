import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:music_app/models/music_model.dart';
import 'package:music_app/modules/favourites_screen.dart';
import 'package:music_app/modules/home_screen/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/modules/main_screen.dart';
import 'package:music_app/modules/settings_screen.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() :super(HomeInitialState());
  bool isDark = false;
  void changeAppMode({bool? fromShared}){
    isDark = !isDark;
    emit(HomeChangeModeState());
  }
  static HomeCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
      MainScreen(),
    FavouritesScreen(),
    SettingsScreen()
  ];
  List<String> titles=[
    " Music",
    "Your Favourites",
    "Settings"
  ];
  int currentIndex = 0;
  void changeIndex(index){
    currentIndex = index;
    emit(HomeChangeBottomNavBarState());
  }
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home'
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.favorite),
        label: 'Favourites'
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: 'Settings'
    ),

  ];

  List<Music> favorites = [];
  void changeFavorites(Music music) {

    if(favorites.contains(music)) {
        favorites.remove(music);
      }
    else {
        favorites.add(music);
      }
    emit(HomeChangeFavoritesState());
  }

}