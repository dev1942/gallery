import 'package:flutter/material.dart';

class CustomBottomSheet extends StatefulWidget {
  final Widget child;

  const CustomBottomSheet({Key? key, required this.child}) : super(key: key);

  @override
  _CustomBottomSheetState createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: widget.child,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
    );
  }
}
