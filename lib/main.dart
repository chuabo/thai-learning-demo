import 'package:flutter/material.dart';
//import 'package:hive/hive.dart';
//import 'package:hive_flutter/hive_flutter.dart';
import 'package:thai_learning/models/word.dart';
import 'package:thai_learning/models/learning_stats.dart';
import 'package:thai_learning/screens/dictionary_screen.dart';
import 'package:thai_learning/screens/home_screen.dart';
import 'package:thai_learning/screens/word_detail_screen.dart';
import 'package:thai_learning/screens/translate_screen.dart';
import 'package:thai_learning/screens/vocabulary_screen.dart';
import 'package:thai_learning/screens/learn_screen.dart';
import 'package:thai_learning/screens/stats_screen.dart';
import 'package:thai_learning/services/api_service.dart';
import 'package:thai_learning/services/audio_service.dart';
import 'package:thai_learning/widgets/bottom_navigation.dart';

void main() async {
  // 初始化Hive
  //await Hive.initFlutter();
  
  // 注册适配器
  //Hive.registerAdapter(WordAdapter());
  //Hive.registerAdapter(LearningStatsAdapter());
  
  // 打开盒子
  //await Hive.openBox<Word>('vocabulary');
  //await Hive.openBox<LearningStats>('learningStats');
  
  // 初始化API服务
  ApiService.init();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '泰语学习助手',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'SukhumvitSet',
        useMaterial3: true
      ),
      //home: const HomeScreen(),
      home: MainHomePage(),
      //initialRoute: '/',
      //initialRoute: '/home',
      routes: {
        //'/': (context) => const HomeScreen(),
        '/home': (context) => const HomeScreen(),
        //'/home': (context) => MainHomePage(),
        '/word': (context) => const WordDetailScreen(),
        '/translate': (context) => const TranslateScreen(),
        '/vocabulary': (context) => const VocabularyScreen(),
        '/learn': (context) => const LearnScreen(),
        '/stats': (context) => const StatsScreen(),
      },
      /*builder: (context, child) {
        return Scaffold(
          body: child,
          //bottomNavigationBar: const BottomNavigation(),
          bottomNavigationBar: BottomNavigationBar(
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
          )
        );
      },*/
    );
  }
}

class MainHomePage extends StatefulWidget {
  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    HomeScreen(),
    //WordDetailScreen(),
    DictionaryScreen(),
    VocabularyScreen(),
    TranslateScreen(),
    LearnScreen(),
    //StatsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      /*body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),*/
      /*bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '首页',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '个人资料',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '设置',
          ),
        ],
      ),*/
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        // 设置未选中时图标的颜色
        unselectedItemColor: Colors.grey,
        //unselectedItemColor: Colors.red,
        showUnselectedLabels: true,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: '词典'),
          BottomNavigationBarItem(icon: Icon(Icons.play_arrow), label: '词库'),
          //BottomNavigationBarItem(icon: Icon(Icons.people), label: '社区'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: '翻译'),
          //BottomNavigationBarItem(icon: Icon(Icons.person), label: '我的'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '学习'),
        ],
      )
    );
  }
}
