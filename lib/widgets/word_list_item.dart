import 'package:flutter/material.dart';
import 'package:thai_learning/models/word.dart';

class WordListItem extends StatelessWidget {
  final Word word;
  final VoidCallback onTap;
  final VoidCallback? onDelete;

  const WordListItem({
    Key? key,
    required this.word,
    required this.onTap,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        word.thai,
        style: const TextStyle(fontSize: 18),
      ),
      subtitle: Text(word.chineseMeaning),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            word.isFavorite ? Icons.favorite : Icons.favorite_border,
            color: word.isFavorite ? Colors.red : null,
          ),
          if (onDelete != null)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onDelete,
            ),
        ],
      ),
      onTap: onTap,
    );
  }
}    