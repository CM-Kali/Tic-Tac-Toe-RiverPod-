import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

enum ButtonVariant { primary, secondary, outline, ghost }

class AppButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonVariant variant;
  final IconData? icon;
  final double? width;
  final bool isLoading;
  final bool isDisabled;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.variant = ButtonVariant.primary,
    this.icon,
    this.width,
    this.isLoading = false,
    this.isDisabled = false,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (!widget.isDisabled && !widget.isLoading) {
      setState(() => _isPressed = true);
      _controller.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (!widget.isDisabled && !widget.isLoading) {
      setState(() => _isPressed = false);
      _controller.reverse();
      widget.onPressed();
    }
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: widget.width,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
              decoration: _getDecoration(),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.isLoading)
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          _getTextColor(),
                        ),
                      ),
                    )
                  else if (widget.icon != null) ...[
                    Icon(
                      widget.icon,
                      color: _getTextColor(),
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                  ],
                  if (!widget.isLoading)
                    Text(
                      widget.text,
                      style: TextStyle(
                        color: _getTextColor(),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  BoxDecoration _getDecoration() {
    final isDisabledOrLoading = widget.isDisabled || widget.isLoading;

    switch (widget.variant) {
      case ButtonVariant.primary:
        return BoxDecoration(
          gradient: isDisabledOrLoading
              ? LinearGradient(
            colors: [
              AppColors.surfaceMid.withOpacity(0.5),
              AppColors.surfaceLight.withOpacity(0.5),
            ],
          )
              : AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(16),
          boxShadow: isDisabledOrLoading
              ? null
              : [
            BoxShadow(
              color: AppColors.primaryStart.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
            BoxShadow(
              color: AppColors.glowPurple.withOpacity(0.2),
              blurRadius: 40,
              offset: const Offset(0, 20),
            ),
          ],
        );

      case ButtonVariant.secondary:
        return BoxDecoration(
          gradient: isDisabledOrLoading
              ? LinearGradient(
            colors: [
              AppColors.surfaceMid.withOpacity(0.5),
              AppColors.surfaceLight.withOpacity(0.5),
            ],
          )
              : AppColors.secondaryGradient,
          borderRadius: BorderRadius.circular(16),
          boxShadow: isDisabledOrLoading
              ? null
              : [
            BoxShadow(
              color: AppColors.secondaryStart.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        );

      case ButtonVariant.outline:
        return BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDisabledOrLoading
                ? AppColors.cellBorder.withOpacity(0.3)
                : AppColors.primaryStart,
            width: 2,
          ),
        );

      case ButtonVariant.ghost:
        return BoxDecoration(
          color: _isPressed
              ? AppColors.surfaceLight.withOpacity(0.3)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        );
    }
  }

  Color _getTextColor() {
    final isDisabledOrLoading = widget.isDisabled || widget.isLoading;

    if (isDisabledOrLoading) {
      return AppColors.textMuted;
    }

    switch (widget.variant) {
      case ButtonVariant.primary:
      case ButtonVariant.secondary:
        return AppColors.textPrimary;
      case ButtonVariant.outline:
      case ButtonVariant.ghost:
        return AppColors.textPrimary;
    }
  }
}