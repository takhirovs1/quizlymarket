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
  Widget build(BuildContext context) {
    final titleStyle = context.textTheme.nunitoW600s20.copyWith(color: context.color.primary);

    return Scaffold(
      // backgroundColor: context.color.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: SafeArea(
          bottom: false,
          child: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            titleSpacing: 0,
            title: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text('QuizlyMarket', style: titleStyle),
            ),
          ),
        ),
      ),
      body: const SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Home'),
          ],
        ),
      ),
    );
  }
}