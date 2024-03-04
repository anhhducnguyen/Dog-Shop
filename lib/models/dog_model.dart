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
}