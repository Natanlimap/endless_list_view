import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  final bool isLoading;

  const Loader({Key? key, required this.isLoading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : const SizedBox();
  }
}
