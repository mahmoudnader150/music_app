import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/components.dart';
import 'package:music_app/constants.dart';
import 'package:music_app/models/music_model.dart';
import 'package:music_app/modules/home_screen/cubit/cubit.dart';
import 'package:music_app/modules/home_screen/cubit/states.dart';
import 'package:music_app/modules/play_music_screen.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
        listener: (context,state){},

        builder:(context,state) {
          print(HomeCubit.get(context).favorites);
          return (HomeCubit.get(context).favorites.length>0)?
                Scaffold(
              body:ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildMusicItem(HomeCubit.get(context).favorites[index],context,index,HomeCubit.get(context).favorites),
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
                itemCount: (HomeCubit.get(context).favorites.length),
              )
          ):
                Scaffold(
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                            Icons.error_outline,
                          color:  Colors.grey[600],
                          size: 100,
                        ),
                        Text(
                            "No Songs added to favourites yet",
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
