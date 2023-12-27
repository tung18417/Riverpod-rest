import 'package:flutter_riverpod/flutter_riverpod.dart';

final showHello = StateProvider<String>((ref) => "HelloWorld!");
final showTitle = StateProvider<String>((ref) => "This is title");
final countNumber = StateProvider<int>((ref) => 0);
