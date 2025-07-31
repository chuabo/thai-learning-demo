import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:thai_learning/models/word.dart';

import '../models/learning_stats.dart';

class ApiService {
  static const String baseUrl = 'https://api.example.com/thai';
  static final ApiService _instance = ApiService._internal();
  
  factory ApiService() => _instance;
  
  ApiService._internal();
  
  static void init() {
    // 初始化服务
  }
  
  // 查询单词
  Future<Word> lookupWord(String thaiWord) async {
    final response = await http.get(Uri.parse('$baseUrl/words/$thaiWord'));
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Word(
        thai: data['thai'],
        pronunciation: data['pronunciation'],
        englishMeaning: data['englishMeaning'],
        chineseMeaning: data['chineseMeaning'],
        partOfSpeech: data['partOfSpeech'],
        example: data['example'],
        exampleTranslation: data['exampleTranslation'],
      );
    } else {
      throw Exception('Failed to lookup word');
    }
  }
  
  // 翻译句子
  Future<Map<String, String>> translateSentence(String text, String targetLanguage) async {
    final response = await http.post(
      Uri.parse('$baseUrl/translate'),
      body: json.encode({
        'text': text,
        'targetLanguage': targetLanguage,
      }),
      headers: {'Content-Type': 'application/json'},
    );
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return {
        'translation': data['translation'],
        'explanation': data['explanation'],
      };
    } else {
      throw Exception('Failed to translate sentence');
    }
  }
  
  // 同步学习数据到后端
  Future<void> syncLearningData(List<Word> words, LearningStats stats) async {
    final response = await http.post(
      Uri.parse('$baseUrl/learning-data'),
      body: json.encode({
        'words': words.map((word) => word.toJson()).toList(),
        'stats': stats.toJson(),
      }),
      headers: {'Content-Type': 'application/json'},
    );
    
    if (response.statusCode != 200) {
      throw Exception('Failed to sync learning data');
    }
  }
  
  // 获取学习曲线数据
  Future<List<Map<String, dynamic>>> getLearningCurve() async {
    final response = await http.get(Uri.parse('$baseUrl/learning-curve'));
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List<dynamic>;
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to get learning curve');
    }
  }
}    