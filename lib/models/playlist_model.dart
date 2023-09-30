import 'package:music_app/models/music_model.dart';

class Playlist{
  final String name;
  List<Music> songs = [];

  Playlist({required this.name});

  static List<Playlist> playlists = [];
}