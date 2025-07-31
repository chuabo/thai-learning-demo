import 'package:flutter/material.dart';
//import 'package:hive_flutter/hive_flutter.dart';
import 'package:thai_learning/models/word.dart';
import 'package:thai_learning/services/audio_service.dart';
import 'package:thai_learning/widgets/word_card.dart';

class LearnScreen extends StatefulWidget {
  const LearnScreen({Key? key}) : super(key: key);

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  late List<Word> _wordsToLearn;
  int _currentIndex = 0;
  bool _showMeaning = false;

  @override
  void initState() {
    super.initState();
    _loadWords();
  }

  void _loadWords() {
    //final box = Hive.box<Word>('vocabulary');
    //_wordsToLearn = box.values.toList();
    
    // 按熟练度排序，优先学习熟练度低的单词
    //_wordsToLearn.sort((a, b) => a.proficiency.compareTo(b.proficiency));
    
    // 如果没有单词，添加一些示例单词
    //if (_wordsToLearn.isEmpty) {
      _wordsToLearn = [
        Word(
          thai: 'สวัสดี',
          pronunciation: 'sà-wàt-dii',
          englishMeaning: 'Hello',
          chineseMeaning: '你好',
          partOfSpeech: '感叹词',
          example: 'สวัสดี! ยินดีต้อนรับสู่ประเทศไทย',
          exampleTranslation: '你好！欢迎来到泰国',
        ),
        Word(
          thai: 'ขอบคุณ',
          pronunciation: 'kŏr-khun',
          englishMeaning: 'Thank you',
          chineseMeaning: '谢谢',
          partOfSpeech: '动词',
          example: 'ขอบคุณสำหรับความช่วยเหลือ',
          exampleTranslation: '感谢您的帮助',
        ),
      ];
      
      // 将示例单词添加到词库
      //final box = Hive.box<Word>('vocabulary');
      //for (var word in _wordsToLearn) {
      //  box.add(word);
      //}
    //}
    
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_wordsToLearn.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('单词学习'),
        ),
        body: const Center(
          child: Text('您的词库为空，请先添加单词'),
        ),
      );
    }
    
    final currentWord = _wordsToLearn[_currentIndex];
    
    return Scaffold(
      appBar: AppBar(
        title: Text('单词学习 (${_currentIndex + 1}/${_wordsToLearn.length})'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: () => setState(() => _showMeaning = !_showMeaning),
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        currentWord.thai,
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        currentWord.pronunciation,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey[700],
                        ),
                      ),
                      if (_showMeaning) ...[
                        const SizedBox(height: 20),
                        Text(
                          '英文: ${currentWord.englishMeaning}',
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '中文: ${currentWord.chineseMeaning}',
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          '词性: ${currentWord.partOfSpeech}',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ] else ...[
                        const SizedBox(height: 20),
                        const Text(
                          '点击显示释义',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              //onPressed: () => AudioService().playWordPronunciation(currentWord.thai),
              onPressed: () => AudioService().playWordPronunciation('letter-A'),
              icon: const Icon(Icons.volume_up),
              label: const Text('播放发音'),
            ),
            const SizedBox(height: 20),
            if (_showMeaning) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => _updateProficiency(currentWord, -1),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text('不熟悉'),
                  ),
                  ElevatedButton(
                    onPressed: () => _updateProficiency(currentWord, 0),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow[700],
                    ),
                    child: const Text('一般'),
                  ),
                  ElevatedButton(
                    onPressed: () => _updateProficiency(currentWord, 1),
                    child: const Text('熟悉'),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _updateProficiency(Word word, int change) {
    // 更新单词熟练度
    word.proficiency = (word.proficiency + change).clamp(0, 5);
    word.lastReviewed = DateTime.now();
    //word.save();
    
    // 移动到下一个单词
    _currentIndex = (_currentIndex + 1) % _wordsToLearn.length;
    _showMeaning = false;
    
    setState(() {});
  }
}    