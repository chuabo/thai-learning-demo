import 'package:flutter/material.dart';
//import 'package:hive_flutter/hive_flutter.dart';
import 'package:thai_learning/models/word.dart';
import 'package:thai_learning/widgets/word_list_item.dart';

class VocabularyScreen extends StatelessWidget {
  const VocabularyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的词库'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddWordDialog(context),
        child: const Icon(Icons.add),
      ),
      /*body: ValueListenableBuilder<Box<Word>>(
      //body: Padding(
        valueListenable: Hive.box<Word>('vocabulary').listenable(),
        builder: (context, box, _) {
          final words = box.values.toList();
          
          if (words.isEmpty) {
            return const Center(
              child: Text('词库为空，请添加新单词'),
            );
          }
          
          return ListView.builder(
            itemCount: words.length,
            itemBuilder: (context, index) {
              final word = words[index];
              return WordListItem(
                word: word,
                onTap: () => Navigator.pushNamed(
                  context, 
                  '/word', 
                  arguments: word
                ),
                onDelete: () => _deleteWord(context, word),
              );
            },
          );
        },
      ),*/

      body: const Center(
        child: Text('您的词库为空，请先添加单词'),
      ),
    );
  }

  Future<void> _showAddWordDialog(BuildContext context) async {
    final TextEditingController thaiController = TextEditingController();
    final TextEditingController pronunciationController = TextEditingController();
    final TextEditingController englishController = TextEditingController();
    final TextEditingController chineseController = TextEditingController();
    final TextEditingController posController = TextEditingController();
    final TextEditingController exampleController = TextEditingController();
    final TextEditingController exampleTransController = TextEditingController();
    
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('添加新单词'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: thaiController,
                decoration: const InputDecoration(labelText: '泰语单词'),
              ),
              TextField(
                controller: pronunciationController,
                decoration: const InputDecoration(labelText: '发音'),
              ),
              TextField(
                controller: englishController,
                decoration: const InputDecoration(labelText: '英文释义'),
              ),
              TextField(
                controller: chineseController,
                decoration: const InputDecoration(labelText: '中文释义'),
              ),
              TextField(
                controller: posController,
                decoration: const InputDecoration(labelText: '词性'),
              ),
              TextField(
                controller: exampleController,
                decoration: const InputDecoration(labelText: '例句'),
              ),
              TextField(
                controller: exampleTransController,
                decoration: const InputDecoration(labelText: '例句翻译'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () {
              if (thaiController.text.isNotEmpty) {
                _addWord(
                  context,
                  Word(
                    thai: thaiController.text,
                    pronunciation: pronunciationController.text,
                    englishMeaning: englishController.text,
                    chineseMeaning: chineseController.text,
                    partOfSpeech: posController.text,
                    example: exampleController.text,
                    exampleTranslation: exampleTransController.text,
                  ),
                );
                Navigator.pop(context);
              }
            },
            child: const Text('添加'),
          ),
        ],
      ),
    );
  }

  void _addWord(BuildContext context, Word word) {
    //final box = Hive.box<Word>('vocabulary');
    //box.add(word);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('单词已添加到词库'))
    );
  }

  void _deleteWord(BuildContext context, Word word) {
    //word.delete();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('单词已从词库中删除'))
    );
  }
}    