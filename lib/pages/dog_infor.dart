import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:home/main.dart';
import 'package:home/models/dog_model.dart';
import 'package:home/models/bigText.dart';
import 'package:home/models/smallText.dart';
import 'package:home/models/theme_manager.dart';
import 'package:ionicons/ionicons.dart';
import 'package:like_button/like_button.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  final Dog dog;
  const DetailsPage({Key? key, required this.dog}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late CollectionReference _userRef;
  String? userId;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    _userRef = FirebaseFirestore.instance.collection('users');
    _checkUserId();
    _checkIfDogIsLiked();
  }

  Future<void> _checkUserId() async {
    // Lấy userId từ Firebase Authentication
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userId = user.uid;
      });
    }
  }

  Future<void> _checkIfDogIsLiked() async {
    if (userId != null) {
      var userDoc = _userRef.doc(userId);
      var querySnapshot = await userDoc.collection('likedDogs').where('name', isEqualTo: widget.dog.name).get();
      setState(() {
        isLiked = querySnapshot.docs.isNotEmpty;
      });
    }
  }

  Future<bool?> _toggleFavorite(bool isLiked) async {
    try {
      if (userId != null) {
        var userDoc = _userRef.doc(userId);
        var likedDogsRef = userDoc.collection('likedDogs');

        if (isLiked) {
          // Xóa con chó khỏi danh sách yêu thích
          await likedDogsRef.where('name', isEqualTo: widget.dog.name).get().then((snapshot) {
            for (DocumentSnapshot doc in snapshot.docs) {
              doc.reference.delete();
            }
          });
        } else {
          // Thêm con chó vào danh sách yêu thích
          await likedDogsRef.doc(widget.dog.name).set({
            'name': widget.dog.name,
            'imageUrl': widget.dog.imageUrl,
            'minLifeExpectancy': widget.dog.minLifeExpectancy,
            'maxLifeExpectancy': widget.dog.maxLifeExpectancy,
            'trainability': widget.dog.trainability,
            'maxHeighMale': widget.dog.maxHeighMale,
            'minHeightMale': widget.dog.minHeightMale,
            'maxHeightFemale': widget.dog.maxHeightFemale,
            'minHeightFemale': widget.dog.minHeightFemale,
            'maxWeightMale': widget.dog.maxWeightMale,
            'minWeightMale': widget.dog.minWeightMale,
            'minWeightFemale': widget.dog.minWeightFemale,
            'maxWeightFemale': widget.dog.maxWeightFemale,
            'energy': widget.dog.energy,
            'goodWithChildren': widget.dog.goodWithChildren,
            'goodWithOtherDog': widget.dog.goodWithOtherDog,
            'playfulness': widget.dog.playfulness,
          });
        }
        final String message = isLiked ? 'Đã xóa ${widget.dog.name} khỏi mục yêu thích' : 'Đã thêm ${widget.dog.name} vào mục yêu thích';
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: Duration(seconds: 2), // Thời gian hiển thị của SnackBar
        ),
      );
      }
      return !isLiked;
    } catch (error) {
      return isLiked;
    }
  }

  String dog_des = '';

  void dog_description(){
    if(widget.dog.playfulness > 3){
      dog_des = 'A playful dog';
    } else{
      dog_des = 'A lazy dog';
    }
  }

  String good_w_child = '';
  void goodWithChild(){
    
    if(widget.dog.goodWithChildren > 3){
      good_w_child = 'You can comfortably let your child play with ${widget.dog.name}, as they are very gentle.';
    } else{
      good_w_child = 'You should be careful when letting your child play with ${widget.dog.name}, as they may not be gentle. ';
    }
  }

  String good_w_dog = '';
  void goodWithDog(){
    
    if(widget.dog.goodWithOtherDog > 3){
      good_w_dog = "It's very friendly with other dogs so you don't need to worry if you keep it with them. ";
    } else{
      good_w_dog = 'Though it may not be friendly with other dogs, you should be concerned if you keep it with other dogs.';
    }
  }

  void dog_review(){

  }

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    final isDarkMode = themeManager.themeMode == ThemeMode.dark;
    final fontSize = themeManager.fontSize;
    var containerWidth = MediaQuery.of(context).size.width *0.9;
    var containerHeight = MediaQuery.of(context).size.height*0.15;
    dog_description();
    goodWithChild();
    goodWithDog();

    return Scaffold(
      appBar: AppBar(
        title: Text("Dog Information"),
      ),

      body: Stack(
        children: <Widget> [
          
          // chứa ảnh của chó
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height*0.45,
              decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(widget.dog.imageUrl)
                )
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(top: 20),
              height: MediaQuery.of(context).size.height*0.55,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                color: !isDarkMode ? Colors.white : Colors.black,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3)
                  )
                ]
              ),
              child: Container(
                margin: EdgeInsets.only(top: 70, left: 30, right: 30, bottom: 10),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Column(
                            children: [
                              const Text(
                                'Weight',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                                ),
                              ),
                              Container(
                                height: 50,
                                width: 100,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 3,
                                      offset: Offset(3, 3)
                                    )
                                  ]
                                ),
                                child:  Text(
                                  '${widget.dog.minWeightMale} - ${widget.dog.maxWeightMale}',
                                  style: const TextStyle(
                                    color: Colors.orange,
                                    fontSize: 16
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Column(
                            children: [
                              Text(
                                'Height',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                                ),
                              ),
                              Container(
                                height: 50,
                                width: 100,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 3,
                                      offset: Offset(3, 3)
                                    )
                                  ]
                                ),
                                child: Text(
                                  '${widget.dog.minHeightMale} - ${widget.dog.maxHeighMale}',
                                  style: TextStyle(
                                    color: Colors.orange,
                                    fontSize: 16
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Column(
                            children: [
                              Text(
                                'Life',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                                ),
                              ),
                              Container(
                                height: 50,
                                width: 100,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 3,
                                      offset: Offset(3, 3)
                                    )
                                  ]
                                ),
                                child: Text(
                                  '${widget.dog.minLifeExpectancy} - ${widget.dog.maxLifeExpectancy}',
                                  style: TextStyle(
                                    color: Colors.orange,
                                    fontSize: 16
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.red,
                    ),
                    Text(
                      'Description',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      '$good_w_child',
                      style: TextStyle(
                        fontSize: 16
                      ),
                    ),
                    Text(
                      '$good_w_dog',
                      style: TextStyle(
                        fontSize: 16
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: containerWidth,
              height: containerHeight,
              margin: EdgeInsets.only(left: 15, right: 15, bottom: 130),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), 
                ),
                ]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10, top: 20, bottom: 20),
                    width: containerWidth - 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.dog.name}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '$dog_des',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 10, top: 20, bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LikeButton(
                              size: 50,
                              isLiked: isLiked,
                              onTap: _toggleFavorite,
                             ),
                      ],
                    ) ,
                  )
                ], 
              ),
            ),
          )
        ],
      ),
    );
  }
}