import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mouse_proto/view_model/mouse_state.dart';
import 'package:mouse_proto/model/mouse_state.dart';

class DemoPage extends HookConsumerWidget {
  static const fps = 60;
  static const deceleration = 1;

  const DemoPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mouseViewModel = ref.watch(mouseStateViewModelProvider.notifier);
    final movePointerState = useState(Pointer(0, 0));
    final wheelState = useState(0.0);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: GestureDetector(
        onScaleUpdate: (details) {
          switch (details.pointerCount) {
            case 1:
              final (newPointer, dx, dy) = movePointerState.value.getMove(
                  details.focalPointDelta.dx,
                  details.focalPointDelta.dy,
              );

              movePointerState.value = newPointer;
              mouseViewModel.movePointer(dx, dy);

              break;
            case 2:
              final sumWheel = wheelState.value + details.focalPointDelta.dy/5;

              wheelState.value = sumWheel % 1;
              mouseViewModel.moveWheel(sumWheel.toInt());

              break;
          }
        },
        onScaleEnd: (_) {
          mouseViewModel.clearButtonState();
          movePointerState.value = Pointer(0, 0);
          wheelState.value = 0;
        },
        child: Column(
          children: [
            Expanded(child: Row(
              children: [
                Expanded(child: GestureDetector(
                  onTapDown: (_) => mouseViewModel.setButtonState(MouseButton.left, true),
                  onTapUp: (_) => mouseViewModel.clearButtonState(),
                  child: Container(
                    color: Colors.red,
                  ),
                )),
                Expanded(child: GestureDetector(
                  onTapDown: (_) => mouseViewModel.setButtonState(MouseButton.right, true),
                  onTapUp: (_) => mouseViewModel.clearButtonState(),
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
    );
  }
}

class Pointer {
  Pointer(this._x, this._y);

  final double _x;
  final double _y;

  (Pointer, int, int) getMove(double x, double y) {
    final dx = x + _x;
    final dy = y + _y;

    return (Pointer(dx % 1, dy % 1), dx.toInt(), dy.toInt());
  }
}
