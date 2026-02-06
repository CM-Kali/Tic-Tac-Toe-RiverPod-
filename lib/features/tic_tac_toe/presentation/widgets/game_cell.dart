import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/player.dart';
import 'dart:math' as math;

class GameCell extends StatefulWidget {
  final Player player;
  final VoidCallback onTap;
  final bool isWinningCell;
  final int index;
  final bool isGameOver;

  const GameCell({
    super.key,
    required this.player,
    required this.onTap,
    this.isWinningCell = false,
    required this.index,
    this.isGameOver = false,
  });

  @override
  State<GameCell> createState() => _GameCellState();
}

class _GameCellState extends State<GameCell>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _rotationController;
  late AnimationController _glowController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _glowAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();

    // Scale animation for symbol appearance
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _scaleAnimation = CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    );

    // Rotation animation
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _rotationController,
        curve: Curves.easeInOut,
      ),
    );

    // Glow animation for winning cells
    _glowController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _glowAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _glowController,
        curve: Curves.easeInOut,
      ),
    );

    if (widget.player != Player.none) {
      _scaleController.forward();
      _rotationController.forward();
    }

    if (widget.isWinningCell) {
      _glowController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(GameCell oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.player != oldWidget.player && widget.player != Player.none) {
      _scaleController.forward(from: 0);
      _rotationController.forward(from: 0);
    }

    if (widget.isWinningCell && !oldWidget.isWinningCell) {
      _glowController.repeat(reverse: true);
    } else if (!widget.isWinningCell && oldWidget.isWinningCell) {
      _glowController.stop();
    }
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _rotationController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.player == Player.none && !widget.isGameOver
            ? widget.onTap
            : null,
        child: AnimatedBuilder(
          animation: Listenable.merge([_glowAnimation]),
          builder: (context, child) {
            return Container(
              decoration: BoxDecoration(
                color: widget.isWinningCell
                    ? AppColors.success.withOpacity(0.15 * _glowAnimation.value)
                    : _isHovered && widget.player == Player.none
                    ? AppColors.cellHover
                    : AppColors.cellBackground,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: widget.isWinningCell
                      ? AppColors.success.withOpacity(_glowAnimation.value)
                      : AppColors.cellBorder,
                  width: widget.isWinningCell ? 2.5 : 1.5,
                ),
                boxShadow: widget.isWinningCell
                    ? [
                  BoxShadow(
                    color: AppColors.success.withOpacity(0.4 * _glowAnimation.value),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                  BoxShadow(
                    color: AppColors.success.withOpacity(0.2 * _glowAnimation.value),
                    blurRadius: 40,
                    spreadRadius: 4,
                  ),
                ]
                    : [
                  BoxShadow(
                    color: AppColors.shadowDark.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Background gradient overlay
                  if (_isHovered && widget.player == Player.none)
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: RadialGradient(
                          colors: [
                            AppColors.primaryStart.withOpacity(0.1),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),

                  // Player symbol
                  Center(
                    child: widget.player != Player.none
                        ? AnimatedBuilder(
                      animation: Listenable.merge([
                        _scaleAnimation,
                        _rotationAnimation,
                      ]),
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _scaleAnimation.value,
                          child: Transform.rotate(
                            angle: _rotationAnimation.value * math.pi * 0.25,
                            child: _buildPlayerSymbol(),
                          ),
                        );
                      },
                    )
                        : _buildHoverIndicator(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPlayerSymbol() {
    if (widget.player == Player.x) {
      return ShaderMask(
        shaderCallback: (bounds) => AppColors.playerXGradient.createShader(
          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
        ),
        child: Icon(
          Icons.close_rounded,
          size: 64,
          color: Colors.white,
          shadows: [
            Shadow(
              color: AppColors.playerXDark.withOpacity(0.5),
              blurRadius: 10,
            ),
          ],
        ),
      );
    } else if (widget.player == Player.o) {
      return Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: AppColors.playerOGradient,
          boxShadow: [
            BoxShadow(
              color: AppColors.playerOMid.withOpacity(0.5),
              blurRadius: 10,
            ),
          ],
        ),
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.cellBackground,
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildHoverIndicator() {
    if (!_isHovered) return const SizedBox.shrink();

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 200),
      builder: (context, value, child) {
        return Opacity(
          opacity: value * 0.5,
          child: Icon(
            Icons.add_rounded,
            size: 40,
            color: AppColors.textMuted,
          ),
        );
      },
    );
  }
}