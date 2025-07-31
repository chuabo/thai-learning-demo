import 'package:flutter/material.dart';
import 'package:thai_learning/services/api_service.dart';

class SentenceTranslateScreen extends StatefulWidget {
  const SentenceTranslateScreen({Key? key}) : super(key: key);

  @override
  State<SentenceTranslateScreen> createState() => _SentenceTranslateScreenState();
}

class _SentenceTranslateScreenState extends State<SentenceTranslateScreen> {
  final TextEditingController _sourceController = TextEditingController();
  String _targetLanguage = 'zh'; // 'zh' 或 'en'
  String _translation = '';
  String _explanation = '';
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('句子翻译'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _sourceController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: '输入要翻译的泰语句子...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => setState(() => _targetLanguage = 'zh'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _targetLanguage == 'zh' ? Colors.blue : Colors.grey,
                  ),
                  child: const Text('中文'),
                ),
                ElevatedButton(
                  onPressed: () => setState(() => _targetLanguage = 'en'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _targetLanguage == 'en' ? Colors.blue : Colors.grey,
                  ),
                  child: const Text('英文'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading ? null : _translate,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('翻译'),
            ),
            const SizedBox(height: 24),
            if (_translation.isNotEmpty) ...[
              Text(
                _targetLanguage == 'zh' ? '中文翻译' : '英文翻译',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    _translation,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (_explanation.isNotEmpty) ...[
                Text(
                  '解释',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(_explanation),
                  ),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _translate() async {
    if (_sourceController.text.isEmpty) return;
    
    setState(() {
      _isLoading = true;
      _translation = '';
      _explanation = '';
    });
    
    try {
      final result = await ApiService().translateSentence(
        _sourceController.text, 
        _targetLanguage
      );
      
      setState(() {
        _translation = result['translation'] ?? '';
        _explanation = result['explanation'] ?? '';
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('翻译失败: $e'))
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }
}    