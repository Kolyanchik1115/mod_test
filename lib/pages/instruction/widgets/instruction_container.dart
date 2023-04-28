import 'package:flutter/material.dart';

class InstructionContainer extends StatelessWidget {
  final Image image;
  const InstructionContainer({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: image,
      ),
    );
  }
}
