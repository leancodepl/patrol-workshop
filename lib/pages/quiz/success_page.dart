import 'package:flutter/material.dart';
import 'package:patrol_challenge/ui/components/button/elevated_button.dart';
import 'package:patrol_challenge/ui/components/scaffold.dart';
import 'package:patrol_challenge/ui/widgets/location_confetti.dart';

Route<void> get successRoute =>
    MaterialPageRoute(builder: (_) => const _SuccessPage());

class _SuccessPage extends StatelessWidget {
  const _SuccessPage();

  @override
  Widget build(BuildContext context) {
    return PTScaffold(
      body: Column(
        children: [
          const Spacer(),
          const Center(
            child: LocationConfetti(),
          ),
          const Spacer(
            flex: 2,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: PTElevatedButton(
              onPressed: () => Navigator.of(context).popUntil(
                (route) => route.isFirst,
              ),
              caption: 'Start again',
            ),
          ),
        ],
      ),
    );
  }
}
