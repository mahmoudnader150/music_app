import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/components.dart';
import 'package:music_app/constants.dart';
import 'package:music_app/models/music_model.dart';
import 'package:music_app/modules/choose_playlist_screen.dart';
import 'package:music_app/modules/home_screen/cubit/cubit.dart';
import 'package:music_app/modules/home_screen/cubit/states.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/modules/play_music_screen.dart';

class PositionData{
  const PositionData(
      this.position,
      this.bufferedPosition,
      this.duration
      );
  final Duration  position;
  final Duration  bufferedPosition;
  final Duration  duration;

}




class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer()..setAsset("assets/audio.mp3");

    _audioPlayer.positionStream;
    _audioPlayer.bufferedPositionStream;
    _audioPlayer.durationStream;
  }

  @override
  void dispose(){
    _audioPlayer.dispose();
    super.dispose();
  }

  List<Music> myList = Music.songs;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
        listener: (context,state){},

        builder:(context,state) {
          print(myList);
        return Scaffold(
          body:  ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildMusicItem(myList[index],context,index,myList),
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
            itemCount: (myList.length),
          ),
          );
      }
    );
  }


  Widget buildMusicItem(Music model,context,int index, List<Music> myList){

    return InkWell(
      onTap: (){
     //   print ("we pressed on "+model.name);
        navigateTo(context, PlayMusicScreen( music: model,index: index,list:myList));
      },
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                 radius: 30.0,
                 backgroundImage: AssetImage(model!.image) ,
              ),
              SizedBox(width: 15.0,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    style:Theme.of(context).textTheme.headline6?.copyWith(
                      color: (HomeCubit.get(context).isDark)?(Colors.white):Colors.black
                    ) ,

                  ),
                  SizedBox(height: 5.0,),
                  Text(
                    model.artist,
                    style: TextStyle(
                      color: Colors.grey[500],
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
              Spacer(),
              IconButton(
                  onPressed: (){
                      navigateTo(context, ChoosePlaylistScreen( music: model,));
                  },
                  icon: CircleAvatar(
                    radius: 15.0,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.add,
                      size: 18.0,
                      color: Colors.black,
                    ),
                  )
              ),
              IconButton(
                  onPressed: (){
                    HomeCubit.get(context).changeFavorites(model);
                    if(HomeCubit.get(context).favorites.contains(model)){
                      showToast(text: "Added to favourites");
                    }else{
                      showToast(text: "Removed from favourites");
                    }
                  },
                  icon: CircleAvatar(
                    radius: 15.0,
                    backgroundColor:
                    ( HomeCubit.get(context).favorites.contains(model))?
                    defaultColor:
                    Colors.white,
                    child: Icon(
                      Icons.favorite_border,
                      size: 18.0,
                      color: Colors.black,
                    ),
                  )
              ),



            ],
          ),
        ),
      ),
    );
  }

}




