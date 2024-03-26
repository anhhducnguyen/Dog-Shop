
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  DetailsPage({Key? key, required this.dog}) : super(key: key);

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


  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    final isDarkMode = themeManager.themeMode == ThemeMode.dark;
    final fontSize = themeManager.fontSize;
    var containerWidth = MediaQuery.of(context).size.width *0.4;
    var containerHeight = MediaQuery.of(context).size.height*0.1;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          backgroundColor: isDarkMode ? Colors.black : Colors.white,
          title: Text(widget.dog.name),
        ),
      ),

      body: Stack(
        children: [
          // chứa ảnh của chó
          Container(
            height: MediaQuery.of(context).size.height*0.35,
            decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(widget.dog.imageUrl)
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
                color: !isDarkMode ? Colors.white : Colors.black
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height:60 ,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: !isDarkMode? Color.fromARGB(255, 243, 220, 105) : Color(0xFF001F3F)
                      ),
                      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),

                      // Phần thêm vào mục yêu thích
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 5),
                            child:BigText(text: 'Add to your favourite?'),
                          ),
                          LikeButton(
                            size: 50,
                            isLiked: isLiked,
                            onTap: _toggleFavorite,
                            // onTap: (isLiked) {

                            // },
                          )
                        ],
                      ),
                    ),
                    // Chứa thông tin của chó
                    Wrap(
                          direction: Axis.horizontal,
                          children: <Widget> [
                            Container(
                                margin: EdgeInsets.all(10),
                                height: containerHeight,
                                width: containerWidth,
                                decoration: BoxDecoration(
                                  color: !isDarkMode ? Color(0xFFFFDAC1) : Color(0xFF001F3F) ,
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text( 
                                      "Life expectancy", 
                                      style: TextStyle(
                                        fontSize: fontSize,
                                        fontWeight: FontWeight.bold
                                      ),),
                                    Text( 
                                      '${widget.dog.minLifeExpectancy}' ' - ' '${widget.dog.maxLifeExpectancy}' ' years',
                                      style: TextStyle(
                                        fontSize: fontSize
                                      ),
                                      )
                                  ],
                                ),
                            ),
                            Container(
                                margin: EdgeInsets.all(10),
                                height: containerHeight,
                                width: containerWidth,
                                decoration: BoxDecoration(
                                  color: !isDarkMode ? Color(0xFFFFDAC1) : Color(0xFF001F3F) ,
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Trainability",
                                      style:TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: fontSize
                                      ) ,),
                                    SmallText(text: '${widget.dog.trainability}' ' /5.0')
                                  ],
                                ),
                              ),
                            Container(
                                margin: EdgeInsets.all(10),
                                height: containerHeight,
                                width: containerWidth,
                                decoration: BoxDecoration(
                                  color: !isDarkMode ? Color(0xFFFFDAC1) : Color(0xFF001F3F) ,
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text( "Height male", style: TextStyle(
                                      fontSize: fontSize,
                                      fontWeight: FontWeight.bold
                                    ),),
                                    Text(
                                      '${widget.dog.minHeightMale}' ' - ' '${widget.dog.maxHeighMale}' ' fts',
                                      style: TextStyle(
                                        fontSize: fontSize
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                height: containerHeight,
                                width: containerWidth,
                                decoration: BoxDecoration(
                                  color: !isDarkMode ? Color(0xFFFFDAC1) : Color(0xFF001F3F) ,
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                 child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Height female",
                                     style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: fontSize
                                     ) ,),
                                    Text('${widget.dog.minHeightFemale}' ' - ' '${widget.dog.maxHeightFemale}' ' fts',
                                      style: TextStyle(
                                        fontSize: fontSize
                                      ) ,)
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                height: containerHeight,
                                width: containerWidth,
                                decoration: BoxDecoration(
                                  color: !isDarkMode ? Color(0xFFFFDAC1) : Color(0xFF001F3F) ,
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Weight male",
                                       style: TextStyle(
                                        fontSize: fontSize,
                                        fontWeight: FontWeight.bold
                                       ) ,),
                                    Text(
                                      '${widget.dog.minWeightMale}' ' - ' '${widget.dog.maxWeightMale}' ' kgs',
                                      style: TextStyle(
                                        fontSize: fontSize
                                      ),)
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                height: containerHeight,
                                width: containerWidth,
                                decoration: BoxDecoration(
                                  color: !isDarkMode ? Color(0xFFFFDAC1) : Color(0xFF001F3F) ,
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Weight female",
                                      style: TextStyle(
                                        fontSize: fontSize,
                                        fontWeight: FontWeight.bold
                                      ),),
                                    Text(
                                      '${widget.dog.minWeightFemale}' ' - ' '${widget.dog.maxWeightFemale}' ' kgs',
                                      style: TextStyle(
                                        fontSize: fontSize
                                      ),)
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                height: containerHeight,
                                width: containerWidth,
                                decoration: BoxDecoration(
                                  color: !isDarkMode ? Color(0xFFFFDAC1) : Color(0xFF001F3F) ,
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Good with children",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: fontSize
                                      ),),
                                    Text(
                                      '${widget.dog.goodWithChildren}' ' /5.0',
                                      style: TextStyle(
                                        fontSize: fontSize
                                      ),)
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                height: containerHeight,
                                width: containerWidth,
                                decoration: BoxDecoration(
                                  color: !isDarkMode ? Color(0xFFFFDAC1) : Color(0xFF001F3F) ,
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Good with other dog",
                                      style: TextStyle(
                                        fontSize: fontSize,
                                        fontWeight: FontWeight.bold
                                      ),),
                                    Text(
                                      '${widget.dog.goodWithOtherDog}' ' /5.0',
                                      style: TextStyle(
                                        fontSize: fontSize
                                      ),)
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                height: containerHeight,
                                width: containerWidth,
                                decoration: BoxDecoration(
                                  color: !isDarkMode ? Color(0xFFFFDAC1) : Color(0xFF001F3F) ,
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Playfulness",
                                      style: TextStyle(
                                        fontSize: fontSize,
                                        fontWeight: FontWeight.bold
                                      ),),
                                    Text(
                                      '${widget.dog.playfulness}' ' /5.0',
                                      style: TextStyle(
                                        fontSize: fontSize
                                      ),)
                                  ],
                                ),
                              ),

                              Container(
                                margin: EdgeInsets.all(10),
                                height: containerHeight,
                                width: containerWidth,
                                decoration: BoxDecoration(
                                  color: !isDarkMode ? Color(0xFFFFDAC1) : Color(0xFF001F3F) ,
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Energy",
                                      style: TextStyle(
                                        fontSize: fontSize,
                                        fontWeight: FontWeight.bold
                                      ),),
                                    Text(
                                      '${widget.dog.energy}' ' /5.0',
                                      style: TextStyle(
                                        fontSize: fontSize
                                      ),)
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