import 'package:patrol/patrol.dart';
import 'package:patrol_challenge/main.dart';

void main() {
  patrolTest(
    'test',
    ($) async {
      await initApp();
      await $.pumpWidgetAndSettle(const MyApp());

      if (await $.native.isPermissionDialogVisible()) {
        await $.native.grantPermissionOnlyThisTime();
      }

      // write your code here

      //await $('Start again').waitUntilVisible();
    },
  );
}
