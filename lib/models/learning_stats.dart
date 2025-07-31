//import 'package:hive/hive.dart';

//part 'learning_stats.g.dart';

//@HiveType(typeId: 1)
//class LearningStats extends HiveObject {
class LearningStats  {
  //@HiveField(0)
  final DateTime date;
  
  //@HiveField(1)
  final int knownWords;
  
  //@HiveField(2)
  final int totalWords;
  
  LearningStats({
    required this.date,
    required this.knownWords,
    required this.totalWords,
  });
  
  Map<String, dynamic> toJson() => {
        'date': date.toIso8601String(),
        'knownWords': knownWords,
        'totalWords': totalWords,
      };
}    