import 'package:flutter/material.dart';
import 'package:thai_learning/screens/dictionary_screen.dart';
import 'package:thai_learning/screens/sentence_translate_screen.dart';
import 'package:thai_learning/screens/vocabulary_screen.dart';
import 'package:thai_learning/screens/learn_screen.dart';
import 'package:thai_learning/screens/stats_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('泰语学习助手'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16.0),
        mainAxisSpacing: 16.0,
        crossAxisSpacing: 16.0,
        children: [
          _buildFeatureCard(
            context,
            '词典查询',
            Icons.search,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DictionaryScreen()),
            ),
          ),
          _buildFeatureCard(
            context,
            '句子翻译',
            Icons.translate,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SentenceTranslateScreen()),
            ),
          ),
          _buildFeatureCard(
            context,
            '我的词库',
            Icons.book,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const VocabularyScreen()),
            ),
          ),
          _buildFeatureCard(
            context,
            '单词学习',
            Icons.school,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LearnScreen()),
            ),
          ),
          _buildFeatureCard(
            context,
            '学习统计',
            Icons.show_chart,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const StatsScreen()),
            ),
          ),
        ],
      ),
      /*bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        // 设置未选中时图标的颜色
        unselectedItemColor: Colors.grey,
        //unselectedItemColor: Colors.red,
        showUnselectedLabels: true,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: '词典'),
          BottomNavigationBarItem(icon: Icon(Icons.play_arrow), label: '学习'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: '社区'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '我的', backgroundColor: Colors.red),
        ],
      )*/
    );
  }

  Widget _buildFeatureCard(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 60,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}    