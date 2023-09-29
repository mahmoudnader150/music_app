import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/components.dart';
import 'package:music_app/constants.dart';
import 'package:music_app/models/music_model.dart';
import 'package:music_app/modules/home_screen/cubit/cubit.dart';
import 'package:music_app/modules/home_screen/cubit/states.dart';
import 'package:music_app/modules/home_screen/home_screen.dart';
import 'package:music_app/modules/main_screen.dart';
import 'package:rxdart/rxdart.dart';


class PositionData{
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  const PositionData(
      this.position,
      this.bufferedPosition,
      this.duration
      );
}



class PlayMusicScreen extends StatefulWidget {
  final Music music;
  final int index;
  final  List<Music> list;
  const PlayMusicScreen({super.key,required this.music,required this.index,required this.list});

  @override
  State<PlayMusicScreen> createState() => _PlayMusicScreenState();
}

class _PlayMusicScreenState extends State<PlayMusicScreen> {

  late AudioPlayer _audioPlayer;

  Stream<PositionData> get _positionDataStream=>
      Rx.combineLatest3<Duration,Duration,Duration?,PositionData>(
          _audioPlayer.positionStream,
          _audioPlayer.bufferedPositionStream,
          _audioPlayer.durationStream,
              (position,bufferedPosition,duration)=>PositionData(
                  position,
                  bufferedPosition,
                  duration??Duration.zero
              )
      );




  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _audioPlayer = AudioPlayer()..setAsset(widget.music.path);

    _audioPlayer.positionStream;
    _audioPlayer.bufferedPositionStream;
    _audioPlayer.durationStream;
  }
  @override
  void dispose(){
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
        listener: (context,state){},

    builder:(context,state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: (){
                navigateAndFinish(context, HomeScreen());
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
            title:  Text(widget.music.name,style: TextStyle(color: Colors.white),),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                  width: MediaQuery.of(context).size.width,
                  height: 350 ,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: AssetImage(widget.music.image),
                      fit: BoxFit.cover
                    )
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  widget.music.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: defaultColor,
                    fontSize: 25.0
                  ),
                ),
                SizedBox(height: 15,),
                Text(
                  widget.music.artist,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                    color: Colors.grey[500],
                  ),
                ),
                SizedBox(height: 55,),
                Row(
                  children: [
                    IconButton(
                        onPressed: (){
                          HomeCubit.get(context).changeFavorites(widget.music);
                          if(HomeCubit.get(context).favorites.contains(widget.music)){
                            showToast(text: "Added to favourites");
                          }else{
                            showToast(text: "Removed from favourites");
                          }
                        },
                        icon: CircleAvatar(
                          radius: 15.0,
                          backgroundColor:
                          ( HomeCubit.get(context).favorites.contains(widget.music))?
                          defaultColor:
                          Colors.white,
                          child: Icon(
                            Icons.favorite_border,
                            size: 18.0,
                            color: Colors.black,
                          ),
                        )
                    ),
                    Spacer(),
                    IconButton(
                        onPressed: (){},
                        icon: Icon(
                          Icons.add,
                        ),
                    ),
                  ],
                ),

                StreamBuilder<PositionData>(
                    stream: _positionDataStream,
                    builder: (context,snapshot){
                      final positionData = snapshot.data;
                      return ProgressBar(
                        barHeight: 6,
                        baseBarColor: Colors.grey[600],
                          bufferedBarColor: Colors.grey,
                          progressBarColor: defaultColor,
                          thumbColor: defaultColor,
                          timeLabelTextStyle: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontWeight: FontWeight.w600
                          ),
                          progress: positionData?.position??Duration.zero,
                          buffered: positionData?.bufferedPosition??Duration.zero,
                          total: positionData?.duration??Duration.zero,
                          onSeek: _audioPlayer.seek,
                      );
                    },
                ),
              //  SizedBox(height: 10.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    IconButton(
                        onPressed: (){
                          if(widget.index==0){
                            showToast(text: "First Song in the list");
                          }else{
                            navigateAndFinish(context, PlayMusicScreen(music: widget.list[widget.index-1],index: widget.index-1,list:widget.list));
                          }
                        },
                        icon: Icon(Icons.keyboard_arrow_left,size:28,)
                    ),
                    SizedBox(width: 15,),
                    Controls(audioPlayer: _audioPlayer),
                    SizedBox(width: 15,),
                    IconButton(
                        onPressed: (){
                          if(widget.index==widget.list.length-1){
                            showToast(text: "Last Song in the list");
                          }else{
                            navigateAndFinish(context, PlayMusicScreen(music: widget.list[widget.index+1],index: widget.index+1,list:widget.list));
                          }
                        },
                        icon: Icon(Icons.keyboard_arrow_right,size:28,)
                    ),
                  ],
                )
              ],
            ),
          ),
        );
    }
    );
  }


}


class Controls extends StatelessWidget {
  final AudioPlayer audioPlayer;

  const Controls({super.key, required this.audioPlayer});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
        stream: audioPlayer.playerStateStream,
        builder: (context, snapshot) {
          final playerState = snapshot.data;
          final processingState = playerState?.processingState;
          final playing = playerState?.playing;
          if (!(playing ?? false)) {
            return IconButton(
              onPressed: audioPlayer.play,
              iconSize: 80,
              color: defaultColor,
              icon: const Icon(Icons.play_arrow_rounded),
            );
          } else if (processingState != ProcessingState.completed) {
            return IconButton(
              onPressed: audioPlayer.pause,
              iconSize: 80,
              color: defaultColor,
              icon: const Icon(Icons.pause_rounded),
            );
          }
          return const Icon(
              Icons.play_arrow_rounded,
              size: 80,
              color: defaultColor
          );
        }
    );
  }


}

