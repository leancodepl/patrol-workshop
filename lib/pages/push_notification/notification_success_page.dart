import 'package:flutter/material.dart';
import 'package:patrol_challenge/keys.dart';
import 'package:patrol_challenge/ui/components/scaffold.dart';
import 'package:patrol_challenge/ui/style/colors.dart';
import 'package:patrol_challenge/ui/widgets/location_confetti.dart';

Route<void> get notificationRoute =>
    MaterialPageRoute(builder: (_) => const _NotificationSuccessPage());

class _NotificationSuccessPage extends StatefulWidget {
  const _NotificationSuccessPage();

  @override
  State<_NotificationSuccessPage> createState() =>
      _NotificationSuccessPageState();
}

class _NotificationSuccessPageState extends State<_NotificationSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return PTScaffold(
      top: AppBar(
        backgroundColor: PTColors.textDark,
        elevation: 0,
        leading: IconButton(
          key: K.goBackButton,
          icon: const Icon(Icons.arrow_back, color: PTColors.lcWhite),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: const Column(
        children: [
          Spacer(),
          LocationConfetti(),
          Spacer(flex: 3),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
