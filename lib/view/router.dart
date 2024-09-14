import 'package:go_router/go_router.dart';
import 'package:mouse_proto/view/pages/demo.dart';

final router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/demo',
  routes: [
    GoRoute(
        name: 'demo',
        path: '/demo',
        builder: (context, state) => const DemoPage(title: 'Flutter Demo Home Page'),
    ),
  ],
);
