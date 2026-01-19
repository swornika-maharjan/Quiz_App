import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:quizzie/features/questions/screens/result_screen.dart';
import 'package:quizzie/utils/colors.dart';
import 'package:quizzie/utils/styles.dart';
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
                  child: Column(
                    children: [
                      ListTile(
                          title: Text(
                            '${StringCasingExtension(item['quizType'].toString()).capitalizeFirst()} Quiz',
                            style: header6.copyWith(
                                color: QZColor.headerColor,
                                fontWeight: FontWeight.w700),
                          ),
                          subtitle: Text(formattedDate,
                              style: header7.copyWith(color: Colors.grey)),
                          trailing: Icon(
                            Icons.keyboard_arrow_right,
                            size: 24,
                          )),
                      Divider()
                    ],
                  ),
                );
              },
            ),
    );
  }
}
