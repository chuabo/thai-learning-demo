import 'package:flutter/material.dart';
import 'package:thai_learning/models/word.dart';
import 'package:thai_learning/services/audio_service.dart';
import 'package:thai_learning/widgets/word_card.dart';

class WordDetailScreen extends StatelessWidget {
  const WordDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Word word = ModalRoute.of(context)?.settings.arguments as Word;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(word.thai),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WordCard(word: word),
            const SizedBox(height: 20),
            Text(
              '例句',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      word.example,
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      word.exampleTranslation,
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => AudioService().playWordPronunciation(word.thai),
              icon: const Icon(Icons.volume_up),
              label: const Text('播放发音'),
            ),
          ],
        ),
      ),
    );
  }
}    