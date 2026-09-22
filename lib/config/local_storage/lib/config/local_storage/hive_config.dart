import 'package:hive_ce_flutter/hive_ce_flutter.dart';

class HiveConfig {
  static Future<void> init() async {
    await Hive.initFlutter();
  }
}