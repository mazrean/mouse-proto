import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mouse_proto/view_model/mouse_state.dart';
import 'package:mouse_proto/model/mouse_state.dart';

class DemoPage extends HookConsumerWidget {
  const DemoPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mouseViewModel = ref.watch(mouseStateViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: GestureDetector(
        onScaleUpdate: (details) {
          if (details.pointerCount == 2) {
            mouseViewModel.moveWheel(details.focalPointDelta.dy.toInt() ~/ 5);
          } else {
            mouseViewModel.movePointer(details.focalPointDelta.dx.toInt(), details.focalPointDelta.dy.toInt());
          }
        },
        child: Column(
          children: [
            Expanded(child: Row(
              children: [
                Expanded(child: GestureDetector(
                  onTapDown: (_) => mouseViewModel.setButtonState(MouseButton.left, true),
                  onTapUp: (_) => mouseViewModel.setButtonState(MouseButton.left, false),
                  child: Container(
                    color: Colors.red,
                  ),
                )),
                Expanded(child: GestureDetector(
                  onTapDown: (_) => mouseViewModel.setButtonState(MouseButton.right, true),
                  onTapUp: (_) => mouseViewModel.setButtonState(MouseButton.right, false),
                  child: Container(
                    color: Colors.green,
                  ),
                )),
              ],
            )),
            Expanded(child: Container(
              color: Colors.blue,
            )),
          ],
        ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            mouseViewModel.movePointer(127, 127),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
