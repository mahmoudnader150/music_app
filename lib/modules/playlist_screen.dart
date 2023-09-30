import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/components.dart';
import 'package:music_app/constants.dart';
import 'package:music_app/models/music_model.dart';
import 'package:music_app/models/playlist_model.dart';
import 'package:music_app/modules/home_screen/cubit/cubit.dart';
import 'package:music_app/modules/home_screen/cubit/states.dart';
import 'package:music_app/modules/play_music_screen.dart';

class PlaylistScreen extends StatefulWidget {

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  var formKey = GlobalKey<FormState>();

  var scaffoldKey = GlobalKey<ScaffoldState>();

  var nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
        listener: (context,state){},

        builder:(context,state) {
          print(HomeCubit.get(context).favorites);
          return  Scaffold(
            key:  scaffoldKey,
            body: ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildPlaylistItem(HomeCubit.get(context).myPlaylists[index],context),
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
            ),
            floatingActionButton: FloatingActionButton(
              child :Icon(
                 HomeCubit.get(context).fabIcon
              ),
              backgroundColor: defaultColor,
              onPressed:  (){
                if(HomeCubit.get(context).isBottomSheetShown){
                  if(formKey.currentState!.validate()){
                    HomeCubit.get(context).addPlaylist(nameController.text);
                    showToast(text: "Added Successfully");
                  }
                }else{
                  scaffoldKey.currentState?.showBottomSheet((context)=>
                      Container(
                        color: Colors.grey[400],
                        padding: EdgeInsets.all(20.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              defaultFormField(
                                  controller: nameController,
                                  type: TextInputType.text,
                                  validate: (value){
                                    if(value!.isEmpty){
                                      return 'Name must not be empty';
                                    }
                                    return null;
                                  },
                                  label: 'Playlist Name',
                                  prefix: Icons.title
                              ),
                              SizedBox(height: 15.0),

                            ],
                          ),
                        ),
                      ),
                    elevation: 15.0,
                    backgroundColor: Colors.black
                  ).closed.then((value){
                    HomeCubit.get(context).changeButtomSheetState(isShow: false, icon: Icons.add);
                  });
                  HomeCubit.get(context).changeButtomSheetState(isShow: true, icon: Icons.add);
                }

              },
            ),
          );
        }
    );
  }

  Widget buildPlaylistItem(Playlist playlist,context){

    return InkWell(
      onTap: (){

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
                    style:Theme.of(context).textTheme.headline6 ,
                  ),
                  SizedBox(height: 5.0,),
                ],
              ),
              Spacer(),
              IconButton(
                  onPressed: (){
                    HomeCubit.get(context
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
