import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:patrol_challenge/keys.dart';
import 'package:patrol_challenge/main.dart';

class ResourceIds {
  static const emailTextField = 'identifierId';
  static const emailScreenNextButton = 'identifierNext';
  static const passwordTextField = 'password';
  static const passwordScreenNextButton = 'passwordNext';
  static const acceptTermsOfService = 'signinconsentNext';
  static const backupSwitch = 'com.google.android.gms:id/sud_items_switch';
}

class Strings {
  static const acceptButtonText = 'ACCEPT';
  static const email =
      'testconference212@gmail.com'; //String.fromEnvironment('EMAIL');
  static const password =
      'testConference1234'; //String.fromEnvironment('PASSWORD');
  static const username =
      'test conference'; //String.fromEnvironment('USERNAME');
  static const appsPackageName = 'com.example.patrol_challenge';
  static const passwordsAndAccounts = 'Passwords & accounts';
  static const removeAccountText = 'Remove account';
}

void main() {
  patrolTest(
    'sign up',
    framePolicy: LiveTestWidgetsFlutterBindingFramePolicy.fullyLive,
    nativeAutomatorConfig: const NativeAutomatorConfig(
      keyboardBehavior: KeyboardBehavior.alternative,
    ),
    ($) async {
      await setUp($.native);

      await initApp();

      await $.pumpWidgetAndSettle(const MyApp());

      await $.native.grantPermissionWhenInUse();

      await $(K.signInWithGoogleButton)
          .tap(settlePolicy: SettlePolicy.noSettle);

      await $.native.tap(
        Selector(
          resourceId: 'com.google.android.gms:id/account_display_name',
          text: Strings.username,
        ),
      );

      await $(K.usernameText).waitUntilVisible();
      expect($(K.usernameText).text, 'Welcome ${Strings.username}!');

      await $(K.notifyMeButton).tap();

      await $.native.grantPermissionWhenInUse();

      await $.native.openNotifications();
      await $.native.tapOnNotificationBySelector(
        Selector(textContains: 'Congratulations'),
      );

      await $(K.yourLocationText).waitUntilVisible();

      await $(K.goBackButton).tap();

      await $(K.signOutButton).tap();

      await tearDown($.native);
    },
  );
}

Future<void> setUp(NativeAutomator automator) async {
  await automator.openApp(appId: 'com.android.settings');
  await swipeUntilVisible(
    automator: automator,
    elementSelector: Selector(
      text: Strings.passwordsAndAccounts,
    ),
  );
  await automator.tap(Selector(text: Strings.passwordsAndAccounts));

  await automator.tap(Selector(text: 'Add account'));
  await automator.tap(Selector(text: 'Google'));

  await automator.enterText(
    Selector(resourceId: ResourceIds.emailTextField),
    text: Strings.email,
  );

  await Future<void>.delayed(const Duration(milliseconds: 2000));

  await automator.tap(
    Selector(
      resourceId: ResourceIds.emailScreenNextButton,
    ),
  );

  await automator.enterText(
    Selector(resourceId: ResourceIds.passwordTextField),
    text: Strings.password,
  );

  await automator.tap(
    Selector(
      resourceId: ResourceIds.passwordScreenNextButton,
    ),
  );

  await automator.tap(
    Selector(
      resourceId: ResourceIds.acceptTermsOfService,
    ),
  );

  await automator.tap(
    Selector(
      resourceId: ResourceIds.backupSwitch,
    ),
  );

  await swipeUntilVisible(
    automator: automator,
    elementSelector: Selector(text: Strings.acceptButtonText),
  );

  await automator.tap(Selector(text: Strings.acceptButtonText));
}

Future<void> tearDown(NativeAutomator automator) async {
  await automator.openApp(appId: 'com.android.settings');
  await swipeUntilVisible(
    automator: automator,
    elementSelector: Selector(
      text: Strings.passwordsAndAccounts,
    ),
  );
  await automator.tap(Selector(text: Strings.passwordsAndAccounts));
  await swipeUntilVisible(
    automator: automator,
    elementSelector: Selector(text: Strings.email),
  );
  await automator.tap(Selector(text: Strings.email));
  await automator.tap(Selector(text: Strings.removeAccountText));
  await automator.tap(Selector(text: Strings.removeAccountText));
}

Future<void> swipeUntilVisible({
  required NativeAutomator automator,
  required Selector elementSelector,
}) async {
  var i = 0;
  while ((await automator.getNativeViews(elementSelector)).isEmpty && i < 10) {
    await automator.swipe(
      from: const Offset(0.5, 0.7),
      to: const Offset(0.5, 0.3),
    );
    i++;
  }
}
