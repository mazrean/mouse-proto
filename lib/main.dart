import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mouse_proto/app.dart';

void main() {
  runApp(const ProviderScope(
      child: MouseProto(),
  ));
}
