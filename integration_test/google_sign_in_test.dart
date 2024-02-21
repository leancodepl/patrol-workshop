import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:patrol_challenge/keys.dart';
import 'package:patrol_challenge/main.dart';

void main() {
  patrolTest(
    'sign in',
    framePolicy: LiveTestWidgetsFlutterBindingFramePolicy.fullyLive,
    nativeAutomatorConfig: const NativeAutomatorConfig(
      keyboardBehavior: KeyboardBehavior.alternative,
    ),
    ($) async {
      await initApp();

      await $.pumpWidgetAndSettle(const MyApp());

      //...

      await $(K.yourLocationText).waitUntilVisible();
    },
  );
}
