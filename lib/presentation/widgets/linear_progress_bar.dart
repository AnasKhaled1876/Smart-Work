
import 'package:flutter/material.dart';

class LinearProgressBar extends StatefulWidget {
  final double progress;
  final double borderRadius;
  final double height;
  final Color backgroundColor;
  final Color progressColor;

  const LinearProgressBar({
    super.key,
    this.progress = 0.0,
    this.borderRadius = 0.0,
    this.height = 10.0,
    this.backgroundColor = Colors.grey,
    this.progressColor = Colors.blue,
  });

  @override
  State<LinearProgressBar> createState() => _LinearProgressBarState();
}

class _LinearProgressBarState extends State<LinearProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  double progress = 0.0;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..forward();
    updateProgress();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void updateProgress() {
    setState(() {
      progress = widget.progress;
    });
    _animationController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      child: FractionallySizedBox(
        alignment: "en" == "en" ? Alignment.centerLeft : Alignment.centerRight,
        widthFactor: progress,
        child: AnimatedContainer(
          decoration: BoxDecoration(
            color: widget.progressColor,
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          duration: const Duration(seconds: 3),
        ),
      ),
    );
  }
}
