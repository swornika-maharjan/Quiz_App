import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:quizzie/features/screens/result_screen.dart';
import 'package:quizzie/utils/utils.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('quiz_results');
    final results = box.get('results', defaultValue: []) as List;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quiz History',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(),
        ),
      ),
      body: results.isEmpty
          ? Center(child: Text('No quiz history available.'))
          : ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                final item = results[index];
                final formattedDate = DateFormat.yMMMd().add_jm().format(
                  DateTime.parse(item['timestamp']),
                );
                return GestureDetector(
                  onTap: () => Get.to(
                    () => ResultScreen(result: Map<String, dynamic>.from(item)),
                  ),
                  child: ListTile(
                    title: Text(
                      '${StringCasingExtension(item['quizType'].toString()).capitalizeFirst()} Quiz',
                    ),
                    subtitle: Text(
                      'Score: ${item['score']} / ${item['total']}',
                    ),
                    trailing: Text(formattedDate),
                  ),
                );
              },
            ),
    );
  }
}
