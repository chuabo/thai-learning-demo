import 'package:flutter/material.dart';
import 'package:thai_learning/screens/dictionary_screen.dart';
import 'package:thai_learning/screens/sentence_translate_screen.dart';
import 'package:thai_learning/screens/vocabulary_screen.dart';
import 'package:thai_learning/screens/learn_screen.dart';
import 'package:thai_learning/screens/stats_screen.dart';

class ThaiLearningBottomNavigation extends StatefulWidget {
  const ThaiLearningBottomNavigation({Key? key}) : super(key: key);

  @override
  State<ThaiLearningBottomNavigation> createState() => _ThaiLearningBottomNavigationState();
}

class _ThaiLearningBottomNavigationState extends State<ThaiLearningBottomNavigation> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const DictionaryScreen(),
    const SentenceTranslateScreen(),
    const VocabularyScreen(),
    const LearnScreen(),
    const StatsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '词典',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.translate),
            label: '翻译',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: '词库',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: '学习',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: '统计',
          ),
        ],
      ),
    );
  }
}    