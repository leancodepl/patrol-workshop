import 'dart:async';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:patrol_challenge/keys.dart';

class LocationConfetti extends StatefulWidget {
  const LocationConfetti({super.key});

  @override
  State<LocationConfetti> createState() => _LocationConfettiState();
}

class _LocationConfettiState extends State<LocationConfetti> {
  late ConfettiController _confettiController;
  late final StreamSubscription<Position> _locationStream;
  String _location = '';

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 10),
    );
    _locationStream = Geolocator.getPositionStream().listen(_onPositionUpdated);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          key: K.yourLocationText,
          _location,
        ),
        Center(
          child: ConfettiWidget(
            confettiController: _confettiController..play(),
            blastDirectionality: BlastDirectionality.explosive,
            gravity: 0.05,
            shouldLoop: true,
            colors: const [
              Colors.green,
              Colors.blue,
              Colors.pink,
              Colors.orange,
              Colors.purple,
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _locationStream.cancel();
    super.dispose();
  }

  Future<void> _onPositionUpdated(Position pos) async {
    final placemarks =
        await placemarkFromCoordinates(pos.latitude, pos.longitude);
    setState(() {
      _location = 'Your location: ${placemarks.firstOrNull?.street ?? ''}';
    });
  }
}
