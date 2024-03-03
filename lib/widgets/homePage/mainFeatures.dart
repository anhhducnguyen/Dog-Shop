// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class HealthNeeds extends StatelessWidget {
  const HealthNeeds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CustomIcon> customIcons = [
      CustomIcon(name: "Shopping", icon: 'assets/images/shopping-cart.png'),
      CustomIcon(name: "Favourite", icon: 'assets/images/heart-dog.png'),
      CustomIcon(name: "Dog care", icon: 'assets/images/pet-food.png'),
      CustomIcon(name: "More", icon: 'assets/images/menu.png'),
    ];
    List<CustomIcon> mainFeatures= [
      CustomIcon(name: "Shopping", icon: 'assets/images/shopping-cart.png'),
      CustomIcon(name: "Favourite", icon: 'assets/images/heart-dog.png'),
      CustomIcon(name: "Dog care", icon: 'assets/images/pet-food.png'),
      CustomIcon(name: "Blog", icon: 'assets/images/blogging.png'),
    ];
    List<CustomIcon> nearbyDogShop = [
      CustomIcon(name: "Position", icon: 'assets/images/position.png'),
      CustomIcon(name: "Employee", icon: 'assets/images/employee.png'),
      CustomIcon(name: "Dog", icon: 'assets/images/dog.png'),
      CustomIcon(name: "Settings", icon: 'assets/images/settings.png'),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(customIcons.length, (index) {
        return Column(
          children: [
            InkWell(
              onTap: () {
                if (index == customIcons.length - 1) {
                  showModalBottomSheet(
                    context: context,
                    showDragHandle: true,
                    builder: (context) {
                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        height: 350,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // HEALTH NEEDS SECTION
                            Text(
                              "My main features",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(
                                mainFeatures.length,
                                (index) {
                                  return Column(
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        borderRadius: BorderRadius.circular(90),
                                        child: Container(
                                          width: 60,
                                          height: 60,
                                          padding: const EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.4),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.asset(
                                            mainFeatures[index].icon,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(mainFeatures[index].name)
                                    ],
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 30),
                            // SPECIALISED CARE SECTION

                            Text(
                              "Manager",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(
                                nearbyDogShop.length,
                                (index) {
                                  return Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          if (index == customIcons.length - 1) {
                                            // Navigate to the "Settings" page
                                            Navigator.pushNamed(context, "/settings");
                                          } else if(index == customIcons.length - 2){
                                            Navigator.pushNamed(context, "/profile");
                                          } else if(index == customIcons.length - 3){
                                            Navigator.pushNamed(context, "/employee");
                                          } else if(index == customIcons.length - 4){
                                            Navigator.pushNamed(context, "/");
                                          } 
                                        }, 
                                        borderRadius: BorderRadius.circular(90),
                                        child: Container(
                                          width: 60,
                                          height: 60,
                                          padding: const EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.4),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.asset(
                                            nearbyDogShop[index].icon,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(nearbyDogShop[index].name)
                                    ],
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                }
              },
              borderRadius: BorderRadius.circular(90),
              child: Container(
                width: 60,
                height: 60,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.4),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  customIcons[index].icon,
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(customIcons[index].name)
          ],
        );
      }),
    );
  }
}

class CustomIcon {
  final String name;
  final String icon;

  CustomIcon({
    required this.name,
    required this.icon,
  });
}
