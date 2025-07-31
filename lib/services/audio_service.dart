import 'package:audioplayers/audioplayers.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  final AudioPlayer _audioPlayer = AudioPlayer();
  
  factory AudioService() => _instance;
  
  AudioService._internal();
  
  // 播放单词发音
  Future<void> playWordPronunciation(String thaiWord) async {
    // 在实际应用中，这里应该是获取真实的发音音频URL
    //final url = 'http://192.168.1.5:8082/audio/$thaiWord.mp3';
    //final url = 'http://localhost:8080/public/audio/$thaiWord.mp3';
    final url = 'http://192.168.43.75:8082/audio/$thaiWord.mp3';
    await _audioPlayer.play(UrlSource(url));
  }
  
  // 停止播放
  Future<void> stopPronunciation() async {
    await _audioPlayer.stop();
  }
}    