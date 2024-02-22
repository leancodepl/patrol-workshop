import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:patrol_challenge/main.dart';
import 'package:patrol_challenge/pages/quiz/form_page.dart';
import 'package:patrol_challenge/ui/style/colors.dart';

void main() {
  patrolTest(
    'test',
    framePolicy: LiveTestWidgetsFlutterBindingFramePolicy.fullyLive,
    ($) async {
      await initApp();
      await $.pumpWidgetAndSettle(const MyApp());

      if (await $.native.isPermissionDialogVisible()) {
        await $.native.grantPermissionWhenInUse();
      }

      await $('Go to the quiz').tap();

      await $('Start').tap();

      await $(TextField).enterText('text');

      final colors = [PTColors.lcYellow, PTColors.lcBlack, PTColors.lcWhite];

      for (final color in colors) {
        await $(SelectableBox)
            .which<SelectableBox>((box) => box.color == color)
            .scrollTo()
            .tap();
      }

      await $(RegExp('Question')).scrollTo(
        view: $(Icons.arrow_right_alt),
        step: -300,
        scrollDirection: AxisDirection.right,
      );

      await $(ElevatedButton).$(Center).$('Fluttercon').tap();

      await $(ListTile).containing(Icons.flutter_dash).$('click').tap();

      await $(ElevatedButton)
          .which<ElevatedButton>(
            (widget) => widget.enabled,
          )
          .at(2)
          .scrollTo()
          .tap();

      if (await $.native.isPermissionDialogVisible()) {
        await $.native.grantPermissionWhenInUse();
      }

      await $.native.openNotifications();

      await $.native.openNotifications();

      await $.native.tapOnNotificationBySelector(Selector(textContains: 'Tap'));

      await $(RegExp('Your location')).waitUntilVisible();

      await $('Start again').waitUntilVisible();
    },
  );
}
