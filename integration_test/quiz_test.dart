import 'package:patrol/patrol.dart';
import 'package:patrol_challenge/main.dart';

void main() {
  patrolTest(
    'test',
    ($) async {
      await initApp();
      await $.pumpWidgetAndSettle(const MyApp());

      await $.native.grantPermissionWhenInUse();

      await $('Go to the quiz').tap();

      await $('Start').tap();

      await $(TextField).enterText('text');

      // write your code here

      await $('Start again').waitUntilVisible();
    },
  );
}
