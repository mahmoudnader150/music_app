import 'package:flutter/material.dart';
import 'package:music_app/components.dart';
import 'package:music_app/constants.dart';
import 'package:music_app/modules/home_screen/home_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class BoardingModel{
  late final String image;
  late final String title;
  late final String body;

  BoardingModel({
    required this.title,
    required this.image,
    required this.body
  });
}

class OnBoardingScreen extends StatefulWidget {


  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool isLast = false;

  var boardController = PageController();

  List<BoardingModel> boarding=[
    BoardingModel(title: "Listen to music", image: "assets/onboardingOne.jpg", body: "Listen to music"),
    BoardingModel(title: "Enjoy music", image: "assets/onboardingTwo.jpg", body: "Enjoy music"),
    BoardingModel(title: "Feel music", image: "assets/onboardingThree.jpg", body: "Feel music")
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: [
          defaultTextButton(
              function:(){
                navigateAndFinish(context, HomeScreen());
              },
              text: 'skip',
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: (index){
                  if(index==boarding.length-1){
                    setState(() {
                      isLast = true;
                    });
                  }else{
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context,index)=>buildBoardingItem(boarding[index]),
                itemCount: 3,
              ),
            ),
            SizedBox(height: 40.0,),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardController,
                    effect: ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        activeDotColor: Colors.pinkAccent,
                        dotHeight: 10.0,
                        expansionFactor: 4,
                        dotWidth: 10.0,
                        spacing: 5.0
                    ),
                    count: boarding.length
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: (){
                    if(isLast){
                      navigateAndFinish(context, HomeScreen());
                    }else{
                      boardController.nextPage(duration: Duration(milliseconds: 750), curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  backgroundColor: defaultColor,
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],
            )
          ],
        ),
      ) ,
    );
  }

  Widget buildBoardingItem(BoardingModel model) =>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
          image:  AssetImage('${model.image}'),
        ),
      ),
      //  SizedBox(height: 30.0,),
      Text(
        '${model.title}',
        style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold
        ),
      ),
      SizedBox(height: 15.0,),
      Text(
        '${model.body}',
        style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold
        ),
      ),
    ],
  );


}
