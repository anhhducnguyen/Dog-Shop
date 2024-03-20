class Dog {
  final String name;
  final String imageUrl;
  final double minLifeExpectancy;
  final double maxLifeExpectancy;
  final double trainability;
  final double maxHeighMale;
  final double minHeightMale;
  final double maxHeightFemale;
  final double minHeightFemale;
  final double maxWeightMale;
  final double minWeightMale;
  final double minWeightFemale;
  final double maxWeightFemale;
  final double energy;
  final double goodWithChildren;
  final double goodWithOtherDog;
  final double playfulness;

  Dog({
    required this.name,
    required this.imageUrl,
    required this.minLifeExpectancy,
    required this.maxLifeExpectancy,
    required this.trainability,
    required this.maxHeighMale,
    required this.minHeightMale,
    required this.maxHeightFemale,
    required this.minHeightFemale,
    required this.energy,
    required this.goodWithChildren,
    required this.goodWithOtherDog,
    required this.maxWeightFemale,
    required this.maxWeightMale,
    required this.minWeightFemale,
    required this.minWeightMale,
    required this.playfulness
  });

  factory Dog.fromJson(Map<String, dynamic> json) {
    return Dog(
      name: json['name'],
      imageUrl: json['imageUrl'],
      minLifeExpectancy: json['minLifeExpectancy'].toDouble(),
      maxLifeExpectancy: json['maxLifeExpectancy'].toDouble(),
      trainability: json['trainability'].toDouble(),
      maxHeighMale: json['maxHeighMale'].toDouble(),
      minHeightMale: json['minHeightMale'].toDouble(),
      maxHeightFemale: json['maxHeightFemale'].toDouble(),
      minHeightFemale: json['minHeightFemale'].toDouble(),
      energy: json['energy'].toDouble(),
      goodWithChildren: json['goodWithChildren'].toDouble(),
      goodWithOtherDog: json['goodWithOtherDog'].toDouble(),
      maxWeightFemale: json['maxWeightFemale'].toDouble(),
      maxWeightMale: json['maxWeightMale'].toDouble(),
      minWeightFemale: json['minWeightFemale'].toDouble(),
      minWeightMale: json['minWeightMale'].toDouble(),
      playfulness: json['playfulness'].toDouble(),
    );
  }

}