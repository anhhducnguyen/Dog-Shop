import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home/models/dog_model.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
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
              child: Text('No favorites yet!'),
            );
          }
          Map<String, dynamic>? data = snapshot.data!.data() as Map<String, dynamic>?;
          if (data == null || !data.containsKey('likedDogs')) {
            return Center(
              child: Text('No favorites yet!'),
            );
          }
          List<dynamic> likedDogs = data['likedDogs'];
          if (likedDogs.isEmpty) {
            return Center(
              child: Text('No favorites yet!'),
            );
          }

          // Tạo danh sách các đối tượng Dog từ dữ liệu Firestore
          List<Dog> favoriteDogs = likedDogs.map((dogData) => Dog.fromJson(dogData)).toList();

          return ListView.builder(
            itemCount: favoriteDogs.length,
            itemBuilder: (context, index) {
              Dog dog = favoriteDogs[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 2,
                  child: ListTile(
                    leading: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(dog.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(
                      dog.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[800],
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Life span: ${dog.minLifeExpectancy} - ${dog.maxLifeExpectancy} years',
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          'Trainability: ${dog.trainability} / 5.0',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
