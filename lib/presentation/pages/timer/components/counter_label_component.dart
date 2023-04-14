import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timer_app/presentation/providers/countdown_provider.dart';

class CounterLabel extends StatelessWidget {
  const CounterLabel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.timer_outlined, color: Colors.blue, size: 60),
          const SizedBox(width: 10),
          Text(
            context.select((CountdownProvider countDown)=>countDown.timeLeft),
            style: const TextStyle(fontSize: 50),
          ),
        ],
      ),
    );
  }
}