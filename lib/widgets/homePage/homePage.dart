import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:home/models/search.dart';
import 'package:home/models/theme_manager.dart';
import 'package:home/pages/thongBao.dart';
import 'package:home/widgets/components/myBottom.dart';
import 'package:home/widgets/homePage/banner.dart';
import 'package:home/widgets/homePage/mainFeatures.dart';
import 'package:http/http.dart' as http;
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import '../../models/dog_model.dart';

class HomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  
  Color getLogoutButtonColor(BuildContext context, bool isDarkMode) {
   return isDarkMode ? Colors.grey.shade900 : Colors.white;;
  }
  int _currentIndex = 0;
  List<String> images = [
    "assets/images/banner_5.jpg", 
    "assets/images/banner_4.jpg", 
    "assets/images/banner_3.jpg",
    "assets/images/banner_2.jpg",
    "assets/images/banner_1.jpg", 
  ];

  List<Dog> _dogs = [];
  bool _loading = true;
  // bool _isSearching = false;
  

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  searchDog(String name,
              String imageUrl,
              double minLifeExpectancy,
              double maxLifeExpectancy,
              double trainability
              ){
      final newDog = Dog(
      name: name, 
      imageUrl: imageUrl, 
      minLifeExpectancy: minLifeExpectancy, 
      maxLifeExpectancy: maxLifeExpectancy,
      trainability: trainability
      );   
  }
  Future<void> fetchData() async {
  var dogNames = [
    'Samoyed',
    'American Eskimo',
    'Great Pyrenees',
    'Akita',
    'Husky',
    'Bolognese',
    'Kuvasz',
  ];
  var apiKey = 'v9XMgEjkmgj8pCnVDet9cw==qJ30WkgpWQjGvW2a';

  var client = http.Client();

  try {
    var requests = <Future>[];
    for (var name in dogNames) {
      var apiURL = 'https://api.api-ninjas.com/v1/dogs?name=$name';

      var headers = {
        'X-Api-Key': apiKey,
      };

      var request = client.get(Uri.parse(apiURL), headers: headers);
      requests.add(request);
    }

    var responses = await Future.wait(requests);

    for (var response in responses) {
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        var dog = Dog(
          name: jsonData[0]['name'],
          imageUrl: jsonData[0]['image_link'],
          minLifeExpectancy: double.parse(jsonData[0]['min_life_expectancy'].toString()),
          maxLifeExpectancy: double.parse(jsonData[0]['max_life_expectancy'].toString()),
          trainability: double.parse(jsonData[0]['trainability'].toString()),
        );
        setState(() {
          _dogs.add(dog);
        });
      } else {
        print('Error fetching data: ${response.statusCode}');
      }
    }
  } catch (e) {
    print('Error: $e');
  } finally {
    client.close();
    setState(() {
      _loading = false;
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
        backgroundColor: themeManager.appBarColor,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Hi, Đức Anh",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            Text(
              "How do you feel today?",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),    
        actions: [
          IconButton(
            onPressed: () {
              // Đặt mã xử lý để mở trang thông báo ở đây
              // Ví dụ:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ThongBao()),
              );
            },
            icon: Stack(
              children: [
                const Icon(Ionicons.notifications_outline, size: 27, color: Colors.black,),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: const Text(
                      '3',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),


          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Search()),
              );
            },
            icon: const Icon(Ionicons.search_outline, size: 27, color: Colors.black,),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: _loading
              ? const CircularProgressIndicator()
              : ListView(
                  children: [
                   SafeArea(
                      child: BannerSlider(
                        images: images,
                        onPageChanged: (index) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                      ),
                    ),
                    Text(
                      "Main feature",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 10),
                    const HealthNeeds(),
                    const SizedBox(height: 20),
                    Text(
                      "Outstanding",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 10),
                    ..._dogs.map((dog) {
                      return Padding(
                        // padding: EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(5),
                        child: Container(
                          decoration: BoxDecoration(
                            // color: Colors.white,
                            color: getLogoutButtonColor(context, isDarkMode),
                            borderRadius: BorderRadius.circular(6), // Điều chỉnh giá trị để làm tròn các góc
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 2), // Điều chỉnh vị trí của đổ bóng
                              ),
                            ],
                          ),
                          // padding: EdgeInsets.all(10),
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),

                          child: Row(
                            children: [
                              // CircleAvatar(
                              //   radius: 50,
                              //   backgroundImage: NetworkImage(dog.imageUrl),
                              //   backgroundColor: Colors.grey,
                              // ),
                              Container(
                                width: 100, // Chiều rộng mong muốn
                                height: 100, // Chiều cao mong muốn
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10), // Đặt bán kính bo tròn
                                  image: DecorationImage(
                                    image: NetworkImage(dog.imageUrl),
                                    fit: BoxFit.cover,
                                  ),
                                  color: Colors.grey, // Màu nền khi hình ảnh không có sẵn
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
                                  Text('Life span: ${dog.minLifeExpectancy} - ${dog.maxLifeExpectancy} year',
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
                        )
                      );
                    }).toList(),
                  ],
                ),
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        currentIndex: 0,
        onTabTapped: (int index) {
          if (index == 1) {
            Navigator.pushNamed(context, "/"); // Navigate to the home page
          } else if (index == 2) {
            Navigator.pushNamed(context, "/profile"); // Navigate to the profile page
          } 
        },
      ),
    );
  }
}
