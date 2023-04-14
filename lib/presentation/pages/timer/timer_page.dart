import 'package:flutter/material.dart';

import 'components/components.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CounterLabel(),
    );
  }
}
