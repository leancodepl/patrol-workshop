import 'package:flutter/material.dart';
import 'package:patrol/patrol.dart';
import 'package:patrol_challenge/main.dart';
import 'package:patrol_challenge/pages/quiz/form_page.dart';
import 'package:patrol_challenge/ui/style/colors.dart';

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

      // write your code here

      await $('Start again').waitUntilVisible();
    },
  );
}
