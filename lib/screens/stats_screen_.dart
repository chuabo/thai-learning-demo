import 'package:flutter/material.dart';
//import 'package:charts_flutter/flutter.dart' as charts;
//import 'package:hive_flutter/hive_flutter.dart';
import 'package:thai_learning/models/word.dart';
import 'package:thai_learning/models/learning_stats.dart';
import 'package:thai_learning/services/api_service.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({Key? key}) : super(key: key);

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  late Future<void> _syncFuture;
  //late List<charts.Series<LearningDataPoint, DateTime>> _seriesList;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _syncFuture = _syncLearningData();
    //_loadChartData();
  }

  Future<void> _syncLearningData() async {
    setState(() => _isLoading = true);
    
    /*try {
      final box = Hive.box<Word>('vocabulary');
      final words = box.values.toList();
      
      // 计算学习统计
      final knownWords = words.where((word) => word.proficiency >= 3).length;
      final totalWords = words.length;
      final today = DateTime.now();
      
      // 保存统计数据
      //final statsBox = Hive.box<LearningStats>('learningStats');
      final todayStats = LearningStats(
        date: today,
        knownWords: knownWords,
        totalWords: totalWords,
      );
      
      // 检查今天是否已经有统计数据
      final existingStats = statsBox.values
          .where((s) => s.date.year == today.year && 
                        s.date.month == today.month && 
                        s.date.day == today.day)
          .toList();
      
      if (existingStats.isEmpty) {
        statsBox.add(todayStats);
      } else {
        existingStats.first.knownWords = knownWords;
        existingStats.first.totalWords = totalWords;
        existingStats.first.save();
      }
      
      // 同步到后端
      await ApiService().syncLearningData(words, todayStats);
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('学习数据已同步'))
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('同步失败: $e'))
      );
    } finally {
      setState(() => _isLoading = false);
    }*/
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //throw UnimplementedError();
    return Scaffold(
      appBar: AppBar(title: const Text('统计')),
      body: const Center(child: Text('统计内容')),
    );
  }

  /*void _loadChartData() {
    final statsBox = Hive.box<LearningStats>('learningStats');
    final stats = statsBox.values.toList()
      ..sort((a, b) => a.date.compareTo(b.date));
    
    final data = stats.map((stat) => LearningDataPoint(
      date: stat.date,
      knownWords: stat.knownWords,
    )).toList();
    
    _seriesList = [
      charts.Series<LearningDataPoint, DateTime>(
        id: 'Known Words',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LearningDataPoint point, _) => point.date,
        measureFn: (LearningDataPoint point, _) => point.knownWords,
        data: data,
      )
    ];
  }*/

  /*@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('学习统计'),
      ),
      body: FutureBuilder(
        future: _syncFuture,
    builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting || _isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          
          return ValueListenableBuilder<Box<Word>>(
            valueListenable: Hive.box<Word>('vocabulary').listenable(),
            builder: (context, box, _) {
              final words = box.values.toList();
              final knownWords = words.where((word) => word.proficiency >= 3).length;
              
              //_loadChartData();
              
              return ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '词汇量统计',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  const Text('已学习单词'),
                                  const SizedBox(height: 8),
                                  Text(
                                    '${words.length}',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  const Text('已掌握单词'),
                                  const SizedBox(height: 8),
                                  Text(
                                    '$knownWords',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          if (words.isNotEmpty)
                            LinearProgressIndicator(
                              value: knownWords / words.length,
                              backgroundColor: Colors.grey[200],
                              color: Colors.green,
                            ),
                          const SizedBox(height: 8),
                          Text(
                            '掌握进度: ${((knownWords / words.length) * 100).toStringAsFixed(1)}%',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '学习曲线',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            height: 250,
                            child: charts.TimeSeriesChart(
                              _seriesList,
                              animate: true,
                              primaryMeasureAxis: const charts.NumericAxisSpec(
                                renderSpec: charts.GridlineRendererSpec(
                                  labelStyle: charts.TextStyleSpec(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              domainAxis: const charts.DateTimeAxisSpec(
                                renderSpec: charts.GridlineRendererSpec(
                                  labelStyle: charts.TextStyleSpec(
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                              behaviors: [
                                charts.ChartTitle(
                                  '已掌握单词数量',
                                  behaviorPosition: charts.BehaviorPosition.start,
                                  titleOutsideJustification: charts.OutsideJustification.middleDrawArea,
                                ),
                                charts.ChartTitle(
                                  '日期',
                                  behaviorPosition: charts.BehaviorPosition.bottom,
                                  titleOutsideJustification: charts.OutsideJustification.middleDrawArea,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _syncLearningData,
                    child: const Text('同步学习数据'),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }*/
}

class LearningDataPoint {
  final DateTime date;
  final int knownWords;
  
  LearningDataPoint({
    required this.date,
    required this.knownWords,
  });
}    