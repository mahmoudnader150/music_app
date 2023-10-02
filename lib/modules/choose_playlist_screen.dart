import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/components.dart';
import 'package:music_app/constants.dart';
import 'package:music_app/models/music_model.dart';
import 'package:music_app/models/playlist_model.dart';
import 'package:music_app/modules/home_screen/cubit/cubit.dart';
import 'package:music_app/modules/home_screen/cubit/states.dart';
import 'package:music_app/modules/play_music_screen.dart';
import 'package:music_app/modules/playlist_songs_screen.dart';

class ChoosePlaylistScreen extends StatelessWidget {

 final Music music;
 ChoosePlaylistScreen({required this.music});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
        listener: (context,state){},

        builder:(context,state) {

          return Scaffold(
            appBar: AppBar(
              title: Text("Playlist available"),
            ),
            body: (HomeCubit.get(context).myPlaylists.length>0)?ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildPlaylistItem(HomeCubit.get(context).myPlaylists[index],music,index,context),
              separatorBuilder: (context, index) =>
                  Padding
                    (
                    padding: const EdgeInsetsDirectional.only(
                        start: 20.0
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 1.0,
                      color: Colors.grey[300],
                    ),
                  ),
              itemCount: (HomeCubit.get(context).myPlaylists.length),
            ): Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    color:  Colors.grey[600],
                    size: 100,
                  ),
                  Text(
                    "No Playlists added yet",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.grey[600]
                    ),
                  )
                ],
              ),
            ),

          );
        }
    );
  }

  Widget buildPlaylistItem(Playlist playlist,Music music,int playlistIndex,context){
    return InkWell(
      onTap: (){
         playlist.songs.add(music);
         showToast(text: "${music.name} added to ${playlist.name}");
      },
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: AssetImage( "assets/music.png") ,
              ),
              SizedBox(width: 15.0,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    playlist.name,
                    style:Theme.of(context).textTheme.headline6?.copyWith(
                        color: (HomeCubit.get(context).isDark)?(Colors.white):Colors.black
                    ) ,
                  ),
                  SizedBox(height: 5.0,),
                ],
              ),
              Spacer(),
              IconButton(
                  onPressed: (){
                    HomeCubit.get(context).deletePlaylist(playlist);
                    showToast(text:"Deleted Successfully");
                  },
                  icon: CircleAvatar(
                    radius: 15.0,
                    backgroundColor:
                    (false)?
                    defaultColor:
                    Colors.white,
                    child: Icon(
                      Icons.delete_outline_outlined,
                      size: 18.0,
                      color: Colors.black,
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
