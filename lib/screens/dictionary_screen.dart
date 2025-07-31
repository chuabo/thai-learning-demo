import 'package:flutter/material.dart';
import 'package:thai_learning/models/word.dart';
import 'package:thai_learning/services/api_service.dart';
import 'package:thai_learning/widgets/word_card.dart';

class DictionaryScreen extends StatefulWidget {
  const DictionaryScreen({Key? key}) : super(key: key);

  @override
  State<DictionaryScreen> createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  final TextEditingController _searchController = TextEditingController();
  Word? _searchedWord;
  bool _isLoading = false;
  String? _error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('泰语词典'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: '输入泰语单词...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _searchWord,
                ),
                border: const OutlineInputBorder(),
              ),
              onSubmitted: (_) => _searchWord(),
            ),
            const SizedBox(height: 20),
            if (_isLoading)
              const CircularProgressIndicator()
            else if (_error != null)
              Text(
                _error!,
                style: const TextStyle(color: Colors.red),
              )
            else if (_searchedWord != null)
              WordCard(word: _searchedWord!),
          ],
        ),
      ),
    );
  }

  Future<void> _searchWord() async {
    final searchTerm = _searchController.text.trim();
    if (searchTerm.isEmpty) return;
    
    setState(() {
      _isLoading = true;
      _error = null;
      _searchedWord = null;
    });
    
    try {
      final word = await ApiService().lookupWord(searchTerm);
      setState(() => _searchedWord = word);
    } catch (e) {
      setState(() => _error = '查询失败: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }
}    