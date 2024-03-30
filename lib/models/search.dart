import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:models/theme_manager.dart;
import '../models/theme_manager.dart';
import 'package:http/http.dart' as http;
// import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import '../../models/dog_model.dart';
import '../pages/dog_infor.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Color getLogoutButtonColor(BuildContext context, bool isDarkMode) {
    return isDarkMode ? Colors.grey.shade900 : Colors.white;
  }

  List<Dog> _dogs = [];
  bool _loading = true;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
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
    var apiKey = 'v9XMgEjkmgj8pCnVDet9cw==qJ30WkgpWQjGvW2a'; // api-key
    var client = http.Client(); //  request to API
    
    try {
      var requests = <Future>[];
      for (var name in dogNames) { // create requests in list dogNames 
        var apiURL = 'https://api.api-ninjas.com/v1/dogs?name=$name';

        var headers = {
          'X-Api-Key': apiKey, // key api
        };

        var request = client.get(Uri.parse(apiURL), headers: headers);
        requests.add(request); // add requests enter list requests
      }

      var responses = await Future.wait(requests); // waiting requests completed

      for (var response in responses) { 
        if (response.statusCode == 200) {
          var jsonData = jsonDecode(response.body); // decryption json data
          var dog = Dog( //json data create class Dog
            name: jsonData[0]['name'],
            imageUrl: jsonData[0]['image_link'],
            minLifeExpectancy: double.parse(jsonData[0]['min_life_expectancy'].toString()),
            maxLifeExpectancy: double.parse(jsonData[0]['max_life_expectancy'].toString()),
            trainability: double.parse(jsonData[0]['trainability'].toString()),
            maxHeighMale: double.parse(jsonData[0]['max_height_male'].toString()),
            minHeightMale: double.parse(jsonData[0]['min_height_male'].toString()),
            maxHeightFemale: double.parse(jsonData[0]['max_height_female'].toString()),
            minHeightFemale: double.parse(jsonData[0]['min_height_female'].toString()),
            energy: double.parse(jsonData[0]['energy'].toString()),
            minWeightFemale: double.parse(jsonData[0]['min_weight_female'].toString()),
            maxWeightFemale: double.parse(jsonData[0]['max_weight_female'].toString()),
            minWeightMale: double.parse(jsonData[0]['min_weight_male'].toString()),
            maxWeightMale: double.parse(jsonData[0]['max_weight_male'].toString()),
            goodWithChildren: double.parse(jsonData[0]['good_with_children'].toString()),
            goodWithOtherDog: double.parse(jsonData[0]['good_with_other_dogs'].toString()),
            playfulness: double.parse(jsonData[0]['playfulness'].toString())
          );
          setState(() {
            _dogs.add(dog);  // add Dog enter list _dog
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

  Future<void> searchDog(String name) async {
    var apiKey = 'v9XMgEjkmgj8pCnVDet9cw==qJ30WkgpWQjGvW2a';
    var apiUrl = 'https://api.api-ninjas.com/v1/dogs?name=$name';
    

    var headers = {
      'X-Api-Key': apiKey,
    };

    var response = await http.get(Uri.parse(apiUrl), headers: headers);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      var dogs = jsonData.map<Dog>((dogData) => Dog(
        name: dogData['name'],
        imageUrl: dogData['image_link'],
        minLifeExpectancy: double.parse(dogData['min_life_expectancy'].toString()),
        maxLifeExpectancy: double.parse(dogData['max_life_expectancy'].toString()),
        trainability: double.parse(dogData['trainability'].toString()),
        maxHeighMale: double.parse(jsonData[0]['max_height_male'].toString()),
        minHeightMale: double.parse(jsonData[0]['min_height_male'].toString()),
        maxHeightFemale: double.parse(jsonData[0]['max_height_female'].toString()),
        minHeightFemale: double.parse(jsonData[0]['min_height_female'].toString()),
        energy: double.parse(jsonData[0]['energy'].toString()),
        minWeightFemale: double.parse(jsonData[0]['min_weight_female'].toString()),
        maxWeightFemale: double.parse(jsonData[0]['max_weight_female'].toString()),
        minWeightMale: double.parse(jsonData[0]['min_weight_male'].toString()),
        maxWeightMale: double.parse(jsonData[0]['max_weight_male'].toString()),
        goodWithChildren: double.parse(jsonData[0]['good_with_children'].toString()),
        goodWithOtherDog: double.parse(jsonData[0]['good_with_other_dogs'].toString()),
        playfulness: double.parse(jsonData[0]['playfulness'].toString())

      )).toList();
      setState(() {
        _dogs.clear();
        _dogs.addAll(dogs);
      });
    } else {
      print('Error fetching data: ${response.statusCode}');
    }
  }
  
  @override
  Widget build(BuildContext context) {
     final themeManager = Provider.of<ThemeManager>(context);
    final isDarkMode = themeManager.themeMode == ThemeMode.dark;
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search for a dog names...',
            border: InputBorder.none,
          ),
          onChanged: (value) {
            if (value.isNotEmpty) {
              searchDog(value);
            } else {
              setState(() {
                _dogs.clear();
                fetchData();
              });
            }
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(7),
          child: _loading
              ? const CircularProgressIndicator()
              : ListView(
                  children: _dogs.map((dog) {
                    return InkWell(
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsPage(dog: dog ,))),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
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
                                  width: 85, 
                                  height: 85,
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
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green[800],
                                          ),
                                        ),
                                        const Icon(Icons.more_vert),
                                      ],
                                    ),
                                    const SizedBox(height: 3),
                                    // Text('Min Lifespan: ${dog.minLifeExpectancy} year'),
                                    // SizedBox(height: 3),
                                    // Text('Max Life Expectancy: ${dog.maxLifeExpectancy} year'),
                                    Text('Life span: ${dog.minLifeExpectancy} - ${dog.maxLifeExpectancy} year',
                                      
                                    ),
                                    const SizedBox(height: 3),
                                    Text('Trainability: ${dog.trainability} / 5.0', 
                                      
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
        ),
      ),
    );
  }
}
