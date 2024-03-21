import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/dog_model.dart';
import '../models/theme_manager.dart';
import '../widgets/components/myBottom.dart';
import 'dog_infor.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  Color getLogoutButtonColor(BuildContext context, bool isDarkMode) {
    return isDarkMode ? Colors.grey.shade900 : Colors.white;
  }

  late CollectionReference _userRef;
  String? userId;

  @override
  void initState() {
    super.initState();
    _userRef = FirebaseFirestore.instance.collection('users');
    _checkUserId();
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

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    final isDarkMode = themeManager.themeMode == ThemeMode.dark;
    final fontSize = themeManager.fontSize;

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Dogs'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: _userRef.doc(userId).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(
              child: Text('No favorite dogs yet!'),
            );
          }
          Map<String, dynamic>? data = snapshot.data!.data() as Map<String, dynamic>?;

          if (data == null) {
            return Center(
              child: Text('No favorite dogs yet!'),
            );
          }

          // Truy cập vào collection 'likedDogs' của tài liệu người dùng
          return StreamBuilder<QuerySnapshot>(
            stream: _userRef.doc(userId).collection('likedDogs').snapshots(),
            builder: (context, likedDogsSnapshot) {
              if (likedDogsSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (likedDogsSnapshot.hasError) {
                return Center(
                  child: Text('Error loading data'),
                );
              }

              // Kiểm tra xem collection 'likedDogs' có dữ liệu hay không
              if (likedDogsSnapshot.data == null || likedDogsSnapshot.data!.docs.isEmpty) {
                return Center(
                  child: Text('No favorite dogs yet!'),
                );
              }

              // Hiển thị tên của các con chó đã được thích
              return ListView.builder(
                itemCount: likedDogsSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  // Lấy tài liệu của mỗi con chó từ collection 'likedDogs'
                  final dogSnapshot = likedDogsSnapshot.data!.docs[index];
                  final dogData = dogSnapshot.data() as Map<String, dynamic>;

                  // Tạo đối tượng Dog từ dữ liệu của con chó
                  Dog dog = Dog(
                    name: dogData['name'] ?? '',
                    imageUrl: dogData['imageUrl'] ?? '',
                    minLifeExpectancy: (dogData['minLifeExpectancy'] ?? 0).toDouble(),
                    maxLifeExpectancy: (dogData['maxLifeExpectancy'] ?? 0).toDouble(),
                    trainability: (dogData['trainability'] ?? 0.0).toDouble(),
                    maxHeighMale: (dogData['maxHeighMale'] ?? 0).toDouble(),
                    minHeightMale: (dogData['minHeightMale'] ?? 0).toDouble(),
                    maxHeightFemale: (dogData['maxHeightFemale'] ?? 0).toDouble(),
                    minHeightFemale: (dogData['minHeightFemale'] ?? 0).toDouble(),
                    energy: (dogData['energy'] ?? 0.0).toDouble(),
                    goodWithChildren: (dogData['goodWithChildren'] ?? 0.0).toDouble(),
                    goodWithOtherDog: (dogData['goodWithOtherDog'] ?? 0.0).toDouble(),
                    maxWeightFemale: (dogData['maxWeightFemale'] ?? 0.0).toDouble(),
                    maxWeightMale: (dogData['maxWeightMale'] ?? 0.0).toDouble(),
                    minWeightFemale: (dogData['minWeightFemale'] ?? 0.0).toDouble(),
                    minWeightMale: (dogData['minWeightMale'] ?? 0.0).toDouble(),
                    playfulness: (dogData['playfulness'] ?? 0.0).toDouble(),
                  );

                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child: InkWell(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsPage(dog: dog))),
                      child: Container(
                        decoration: BoxDecoration(
                          color: getLogoutButtonColor(context, isDarkMode),
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(dog.imageUrl),
                                  fit: BoxFit.cover,
                                ),
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  dog.name,
                                  style: TextStyle(
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green[800],
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text('Life span: ${dog.minLifeExpectancy} - ${dog.maxLifeExpectancy} years',
                                  style: TextStyle(
                                    fontSize: fontSize,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text('Trainability: ${dog.trainability} / 5.0',
                                  style: TextStyle(
                                    fontSize: fontSize,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigation(
        currentIndex: 0,
        onTabTapped: (int index) {
          if (index == 0) {
            Navigator.pushNamed(context, "/homePage"); // Navigate to the home page
          } else if (index == 2) {
            Navigator.pushNamed(context, "/profile"); // Navigate to the profile page
          }
        },
      ),
    );
  }
}