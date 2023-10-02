import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:music_app/models/music_model.dart';
import 'package:music_app/models/playlist_model.dart';
import 'package:music_app/modules/favourites_screen.dart';
import 'package:music_app/modules/home_screen/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/modules/main_screen.dart';
import 'package:music_app/modules/playlist_screen.dart';
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
    PlaylistScreen(),

  ];
  List<String> titles=[
    "Music",
    "Your Favourites",
    "Playlists",

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
        icon: Icon(Icons.list),
        label: 'Playlists'
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


   var myPlaylists = Playlist.playlists;
  void addPlaylist(String name){
     myPlaylists.add(Playlist(name: name));
     emit(HomeAddPlaylist());
  }
  void deletePlaylist(Playlist playlist){
    myPlaylists.remove(playlist);
    emit(HomeRemovePlaylist());
  }

  void removeSongFromPlaylist(Playlist playlist,Music song){
    playlist.songs.remove(song);
    emit(HomeRemovePlaylist());
  }

  IconData fabIcon = Icons.add;
  bool isBottomSheetShown = false;
  void changeButtomSheetState({
    required bool isShow,
    required IconData icon
  }){
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(HomeChangeBottomSheetState());
  }
}