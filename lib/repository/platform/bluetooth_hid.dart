import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/repository/platform/bluetooth_hid.g.dart',
  kotlinOut: 'android/app/src/main/kotlin/com/mazrean/mouse_proto/platform/BluetoothHIDApi.kt',
  kotlinOptions: KotlinOptions(
    package: 'com.mazrean.mouse_proto.platform',
  ),
))

class MouseMessage {
  MouseMessage({
    required this.left,
    required this.right,
    required this.middle,
    required this.x,
    required this.y,
    required this.wheel,
  });

  bool left;
  bool right;
  bool middle;
  int x;
  int y;
  int wheel;
}

@HostApi()
abstract class BluetoothHIDApi {
  @async
  void sendMouseMessage(MouseMessage message);
}
