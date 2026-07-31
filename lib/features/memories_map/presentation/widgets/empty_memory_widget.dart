import 'package:flutter/material.dart';

class EmptyMemoryWidget extends StatelessWidget {
  const EmptyMemoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'No memories found.',
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
