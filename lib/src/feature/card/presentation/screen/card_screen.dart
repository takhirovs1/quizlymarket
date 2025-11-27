import 'package:flutter/material.dart';

import '../state/card_state.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends CardState {
  @override
  Widget build(BuildContext context) => const Scaffold(
    body: Column(
      children: [
        Text('Card'),
      ],
    ),
  );
}