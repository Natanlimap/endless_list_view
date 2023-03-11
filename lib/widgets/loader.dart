import 'package:flutter/material.dart';

/// A widget that displays a circular progress indicator if [isLoading] is `true`,
/// and an empty `SizedBox` if `false`.
class Loader extends StatelessWidget {
  /// Indicates whether the widget should display the progress indicator or not.
  final bool isLoading;

  /// Creates a new [Loader] widget.
  ///
  /// The [isLoading] parameter is required and should indicate whether the widget
  /// should display the progress indicator or not.
  const Loader({Key? key, required this.isLoading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : const SizedBox();
  }
}
