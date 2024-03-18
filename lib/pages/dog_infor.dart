import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:home/models/dog_model.dart';
import 'package:home/models/bigText.dart';
import 'package:home/models/smallText.dart';
import 'package:ionicons/ionicons.dart';
import 'package:like_button/like_button.dart';



class DetailsPage extends StatelessWidget {

  final Dog dog;

  const DetailsPage({super.key, required this.dog});
  
  

  @override
  Widget build(BuildContext context) {
     var containerWidth = MediaQuery.of(context).size.width *0.45;
     var containerHeight = MediaQuery.of(context).size.height*0.1;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.amber,
          
          title: Text(dog.name),
        ),
      ),

      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height*0.35,
            decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(dog.imageUrl)
              )
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(top: 20),
              height: MediaQuery.of(context).size.height*0.614,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                color: Colors.white
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height:60 ,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromARGB(255, 243, 220, 105)
                      ),
                      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                      
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 5),
                            child:BigText(text: 'Add to your favourite?'),
                          ),
                          LikeButton(
                            size: 50,
                            // onTap: (isLiked) {
                              
                            // },
                          )
                        ],
                      ),
                    ),
                    Wrap(
                          direction: Axis.horizontal,
                          children: <Widget> [
                            Container(
                                margin: EdgeInsets.all(10),
                                height: containerHeight,
                                width: containerWidth,
                                decoration: BoxDecoration(
                                  color: Color(0xFFFFDAC1),
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BigText(text: "Life expectancy"),
                                    SmallText(text: '${dog.minLifeExpectancy}' ' - ' '${dog.maxLifeExpectancy}' ' years')
                                  ],
                                ),
                            ),
                            Container(
                                margin: EdgeInsets.all(10),
                                height: containerHeight,
                                width: containerWidth,
                                decoration: BoxDecoration(
                                  color: Color(0xFFFFDAC1),
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BigText(text: "Trainability"),
                                    SmallText(text: '${dog.trainability}' ' /5.0')
                                  ],
                                ),
                              ),
                            Container(
                                margin: EdgeInsets.all(10),
                                height: containerHeight,
                                width: containerWidth,
                                decoration: BoxDecoration(
                                  color: Color(0xFFFFDAC1),
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BigText(text: "Height male"),
                                    SmallText(text: '${dog.minHeightMale}' ' - ' '${dog.maxHeighMale}' ' fts')
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                height: containerHeight,
                                width: containerWidth,
                                decoration: BoxDecoration(
                                  color: Color(0xFFFFDAC1),
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                 child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BigText(text: "Height female"),
                                    SmallText(text: '${dog.minHeightFemale}' ' - ' '${dog.maxHeightFemale}' ' fts')
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                height: containerHeight,
                                width: containerWidth,
                                decoration: BoxDecoration(
                                  color: Color(0xFFFFDAC1),
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BigText(text: "Weight male"),
                                    SmallText(text: '${dog.minWeightMale}' ' - ' '${dog.maxWeightMale}' ' kgs')
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                height: containerHeight,
                                width: containerWidth,
                                decoration: BoxDecoration(
                                  color: Color(0xFFFFDAC1),
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BigText(text: "Weight female"),
                                    SmallText(text: '${dog.minWeightFemale}' ' - ' '${dog.maxWeightFemale}' ' kgs')
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                height: containerHeight,
                                width: containerWidth,
                                decoration: BoxDecoration(
                                  color: Color(0xFFFFDAC1),
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BigText(text: "Good with children"),
                                    SmallText(text: '${dog.goodWithChildren}' ' /5.0')
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                height: containerHeight,
                                width: containerWidth,
                                decoration: BoxDecoration(
                                  color: Color(0xFFFFDAC1),
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BigText(text: "Good with other dog"),
                                    SmallText(text: '${dog.goodWithOtherDog}' ' /5.0')
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                height: containerHeight,
                                width: containerWidth,
                                decoration: BoxDecoration(
                                  color: Color(0xFFFFDAC1),
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BigText(text: "Playfulness"),
                                    SmallText(text: '${dog.playfulness}' ' /5.0')
                                  ],
                                ),
                              ),
                              
                              Container(
                                margin: EdgeInsets.all(10),
                                height: containerHeight,
                                width: containerWidth,
                                decoration: BoxDecoration(
                                  color: Color(0xFFFFDAC1),
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BigText(text: "Energy"),
                                    SmallText(text: '${dog.energy}' ' /5.0')
                                  ],
                                ),
                              ),
                          ],
                        )
                  ],
                ),
              )
            ),
          )
        ],
      ),
      
    );
  }
}