import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'provider.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MaterialApp(
        home: MyApp(),
      ),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(countNumber);

//error
    if (ref.watch(countNumber) == 5) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Halfway point"),
              content: Text("Number: ${ref.watch(countNumber)}"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("close"))
              ],
            );
          });
    }

    ref.listen(countNumber, (_, next) {
      if (next >= 10) {
        showDialog(
            barrierDismissible: false, //ไม่ให้แตะ grayout แล้ว alert ดับ
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("You reach the end."),
                content: const Text("press reset to start over."),
                actions: [
                  TextButton(
                      onPressed: () {
                        ref.read(countNumber.notifier).state = 0;
                        Navigator.pop(context);
                      },
                      child: const Text("reset"))
                ],
              );
            });
      }
    });
    return Scaffold(
      appBar: AppBar(
          title: Text(ref.read(showTitle)),
          backgroundColor: Colors.lightBlueAccent),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(ref.read(showHello)),
            Text(count.toString()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(countNumber.notifier).state++;
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
