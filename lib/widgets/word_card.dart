import 'package:flutter/material.dart';
import 'package:thai_learning/models/word.dart';
import 'package:thai_learning/services/audio_service.dart';

class WordCard extends StatelessWidget {
  final Word word;
  final bool showActions;

  const WordCard({
    Key? key,
    required this.word,
    this.showActions = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  word.thai,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (showActions)
                  IconButton(
                    icon: Icon(
                      word.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: word.isFavorite ? Colors.red : null,
                    ),
                    onPressed: () {
                      word.isFavorite = !word.isFavorite;
                      //word.save();
                    },
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              word.pronunciation,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '词性: ${word.partOfSpeech}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '英文释义: ${word.englishMeaning}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              '中文释义: ${word.chineseMeaning}',
              style: const TextStyle(fontSize: 18),
            ),
            if (showActions)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: ElevatedButton.icon(
                  onPressed: () => AudioService().playWordPronunciation(word.thai),
                  icon: const Icon(Icons.volume_up),
                  label: const Text('播放发音'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}    