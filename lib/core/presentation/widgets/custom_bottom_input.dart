import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../../theme/app_theme.dart';

class CustomBottomInput extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final bool enabled;
  final String hintText;

  const CustomBottomInput({
    super.key,
    required this.controller,
    required this.onSend,
    this.enabled = true,
    this.hintText = 'Ask anything...',
  });

  @override
  State<CustomBottomInput> createState() => _CustomBottomInputState();
}

class _CustomBottomInputState extends State<CustomBottomInput>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      constraints: const BoxConstraints(
        minHeight: 55,
        maxHeight: 120,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.transparent,
        boxShadow: isDark? []: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            spreadRadius: 4,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Container(
            // height: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(26),
              gradient: SweepGradient(
                center: Alignment.center,
                startAngle: 0,
                endAngle: math.pi * 2,
                transform: GradientRotation(
                  _animationController.value * math.pi * 2,
                ),
                colors: const [
                  Color(0xFF6A9BFE),
                  Color(0xFF9B6AFE),
                  Color(0xFF4A80F0),
                  Color(0xFF6A9BFE),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Container(
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppTheme.darkInputField
                        : AppTheme.lightInputField,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: const EdgeInsets.all(4),
                  child: Row(
                    children: [
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextField(
                          controller: widget.controller,
                          enabled: widget.enabled,
                          maxLines: null,
                          minLines: 1,
                          keyboardType: TextInputType.multiline,
                          style: TextStyle(
                            color: isDark
                                ? AppTheme.darkText
                                : AppTheme.lightText,
                            fontSize: 15,
                          ),
                          decoration: InputDecoration(
                            hintText: widget.hintText,
                            hintStyle: TextStyle(
                              color: isDark
                                  ? AppTheme.darkSubText
                                  : AppTheme.lightSubText,
                            ),
                            isDense: true,
                            border: InputBorder.none,
                            contentPadding:
                            const EdgeInsets.symmetric(vertical: 0),
                          ),
                          onSubmitted: (_) =>
                          widget.enabled ? widget.onSend() : null,
                        ),
                      ),
                      const SizedBox(width: 5,),
                      GestureDetector(
                        onTap: widget.enabled ? widget.onSend : null,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF6A9BFE), Color(0xFF4A80F0)],
                            ),
                            shape: BoxShape.circle
                          ),
                          child: Icon(
                            Icons.arrow_forward_rounded,
                            color: widget.enabled
                                ? Colors.white
                                : Colors.white38,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
