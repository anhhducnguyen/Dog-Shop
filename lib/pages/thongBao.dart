import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:home/models/theme_manager.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../models/dog_model.dart';

class ThongBao extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ThongBao> {
  Color getLogoutButtonColor(BuildContext context, bool isDarkMode) {
  // return isDarkMode ? Colors.blue.shade400 : Theme.of(context).primaryColor;
   return isDarkMode ? Colors.grey.shade900 : Colors.white;;
  }
  int _currentIndex = 0;
  List<String> images = [
    "assets/images/banner_1.jpg", 
    "assets/images/banner_2.jpg", 
    "assets/images/banner_3.jpg",
    "assets/images/banner_4.jpg",
    "assets/images/banner_2.jpg",
  ];

  List<Dog> _dogs = [];
  bool _loading = true;
  bool _isSearching = false;

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
      'golden retriever',
      'labrador',
      'german shepherd',
      'beagle',
      'bulldog',
      'poodle',
      'siberian husky',
      'dachshund',
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
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Thông báo"),
            // Text(
            //   "Hôm nay bạn cảm thấy thế nào?",
            //   style: Theme.of(context).textTheme.bodySmall,
            // ),
          ],
        ),    
        
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(7),
          child: _loading
              ? const CircularProgressIndicator()
              : ListView(
                  children: [
                  //  SafeArea(
                  //     child: BannerSlider(
                  //       images: images,
                  //       onPageChanged: (index) {
                  //         setState(() {
                  //           _currentIndex = index;
                  //         });
                  //       },
                  //     ),
                  //   ),

                    // SizedBox(height: 3),
                    // Text(
                    //   "Main feature",
                    //   style: Theme.of(context).textTheme.titleLarge,
                    // ),
                    // SizedBox(height: 10),
                    // const HealthNeeds(),
                    // SizedBox(height: 10),
                    // Text(
                    //   "Outstanding",
                    //   style: Theme.of(context).textTheme.titleLarge,
                    // ),
                    // SizedBox(height: 10),
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
        offset: Offset(0, 2), // Điều chỉnh vị trí của đổ bóng
      ),
    ],
  ),
  // padding: EdgeInsets.all(10), // Điều chỉnh padding để làm cho nội dung không nằm sát mép
  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),

child: Stack(
  alignment: Alignment.bottomRight, // Đặt căn chỉnh của Stack
  children: [
    Row(
      children: [
        CircleAvatar(
          radius: 44,
          backgroundImage: NetworkImage(dog.imageUrl),
          backgroundColor: Colors.grey,
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    dog.name,
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[800],
                    ),
                  ),
                  const Icon(Icons.more_vert), // Dấu ba chấm ở góc phải phía trên
                ],
              ),
              const SizedBox(height: 3),
              Text('Min Lifespan: ${dog.minLifeExpectancy} year', 
                style: TextStyle(
                  fontSize: fontSize,
                ),
              ),
              const SizedBox(height: 3),
              Text('Max Life Expectancy: ${dog.maxLifeExpectancy} year',
                style: TextStyle(
                  fontSize: fontSize,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
    Container(
      margin: const EdgeInsets.only(right: 260, bottom: 2), // Khoảng cách từ biểu tượng trái tim đến cạnh phải và đáy
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue,
      ),
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(
          Icons.thumb_up_alt_outlined,
          color: Colors.white,
          size: 17,
        ),
      ),
    ),
  ],
),

// child: Row(
//   children: [
//     CircleAvatar(
//       radius: 44,
//       backgroundImage: NetworkImage(dog.imageUrl),
//       backgroundColor: Colors.grey,
//     ),
//     SizedBox(width: 20),
//     Expanded(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 dog.name,
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.green[800],
//                 ),
//               ),
//               Icon(Icons.more_vert), // Dấu ba chấm ở góc phải phía trên
//             ],
//           ),
//           SizedBox(height: 3),
//           Text('Min Lifespan: ${dog.minLifeExpectancy} year'),
//           SizedBox(height: 3),
//           Text('Max Life Expectancy: ${dog.maxLifeExpectancy} year'),
//         ],
//       ),
//     ),
//   ],
// ),

),

                      );
                    }).toList(),
                  ],
                ),
        ),
      ),
    );
  }
}
