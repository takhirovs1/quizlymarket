import 'package:flutter/material.dart';

import '../../../../common/extension/context_extension.dart';
import '../state/home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends HomeState {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('QuizlyMarket', style: context.textTheme.nunitoW500s24.copyWith(color: context.color.primary)),
      centerTitle: true,
      backgroundColor: context.color.transparent,
    ),
    body: const SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('Home'),
        ],
      ),
    ),
  );
}