//import 'package:hive/hive.dart';

//part 'word.g.dart';

//@HiveType(typeId: 0)
//class Word extends HiveObject {
class Word {
  //@HiveField(0)
  late final String thai;
  
  //@HiveField(1)
  late final String pronunciation;
  
  //@HiveField(2)
  late final String englishMeaning;
  
  //@HiveField(3)
  late final String chineseMeaning;
  
  //@HiveField(4)
  late final String partOfSpeech;
  
  //@HiveField(5)
  late final String example;
  
  //@HiveField(6)
  late String exampleTranslation;
  
  //@HiveField(7)
  late bool isFavorite;
  
  //@HiveField(8)
  late int proficiency; // 0-5 scale
  
  //@HiveField(9)
  late DateTime lastReviewed;
  
  Word({
    required this.thai,
    required this.pronunciation,
    required this.englishMeaning,
    required this.chineseMeaning,
    required this.partOfSpeech,
    required this.example,
    required this.exampleTranslation,
    this.isFavorite = false,
    this.proficiency = 0,
    //this.lastReviewed = const DateTime.fromMillisecondsSinceEpoch(0),
  });

  toJson() {}

}    