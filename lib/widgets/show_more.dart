import 'package:flutter/material.dart';

class ShowMore extends StatelessWidget {
  final String heading;
  final VoidCallback onTap;
  const ShowMore({super.key, required this.heading, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 8, 8, 8),
          child: Text(
            heading,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            "See all",
          ),
        ),
      ],
    );
  }
}
