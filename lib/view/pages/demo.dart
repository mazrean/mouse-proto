import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mouse_proto/view_model/mouse_state.dart';
import 'package:mouse_proto/model/mouse_state.dart';

class DemoPage extends ConsumerWidget {
  const DemoPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mouseStateViewModelProvider);
    final mouseViewModel = ref.watch(mouseStateViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'State: ${state.leftButton}',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            mouseViewModel.setPointerPosition(127, 127),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
