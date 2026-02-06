import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../domain/entities/player.dart';
import '../providers/game_provider.dart';

class GameStatus extends ConsumerStatefulWidget {
  const GameStatus({super.key});

  @override
  ConsumerState<GameStatus> createState() => _GameStatusState();
}

class _GameStatusState extends ConsumerState<GameStatus>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(gameProvider);

    // Animate when game is over
    if (state.isGameOver && !_pulseController.isAnimating) {
      _pulseController.repeat(reverse: true);
    } else if (!state.isGameOver && _pulseController.isAnimating) {
      _pulseController.stop();
      _pulseController.reset();
    }

    String statusText;
    IconData? statusIcon;
    Gradient? gradient;
    Color? solidColor;

    if (state.winner != null) {
      statusText = state.statusMessage;
      statusIcon = Icons.emoji_events_rounded;
      gradient = state.winner == Player.x
          ? AppColors.playerXGradient
          : AppColors.playerOGradient;
    } else if (state.isDraw) {
      statusText = state.statusMessage;
      statusIcon = Icons.handshake_rounded;
      solidColor = AppColors.warning;
    } else {
      statusText = state.statusMessage;
      statusIcon = Icons.play_circle_outline_rounded;
      gradient = state.currentPlayer == Player.x
          ? AppColors.playerXGradient
          : AppColors.playerOGradient;
    }

    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: state.isGameOver ? _pulseAnimation.value : 1.0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
            decoration: BoxDecoration(
              gradient: state.isGameOver
                  ? LinearGradient(
                colors: [
                  (gradient != null
                      ? (gradient.colors.first)
                      : solidColor ?? AppColors.warning)
                      .withOpacity(0.15),
                  (gradient != null
                      ? (gradient.colors.last)
                      : solidColor ?? AppColors.warning)
                      .withOpacity(0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
                  : LinearGradient(
                colors: [
                  AppColors.surfaceDark.withOpacity(0.6),
                  AppColors.surfaceMid.withOpacity(0.4),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: state.isGameOver
                    ? (gradient != null
                    ? gradient.colors.first
                    : solidColor ?? AppColors.warning)
                    .withOpacity(0.4)
                    : AppColors.cellBorder.withOpacity(0.3),
                width: 1.5,
              ),
              boxShadow: [
                if (state.isGameOver)
                  BoxShadow(
                    color: (gradient != null
                        ? gradient.colors.first
                        : solidColor ?? AppColors.warning)
                        .withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                BoxShadow(
                  color: AppColors.shadowDark.withOpacity(0.2),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (statusIcon != null) ...[
                  gradient != null
                      ? ShaderMask(
                    shaderCallback: (bounds) => gradient!.createShader(
                      Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                    ),
                    child: Icon(
                      statusIcon,
                      size: 32,
                      color: Colors.white,
                    ),
                  )
                      : Icon(
                    statusIcon,
                    size: 32,
                    color: solidColor,
                  ),
                  const SizedBox(width: 14),
                ],
                Flexible(
                  child: gradient != null
                      ? GradientText(
                    text: statusText,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    gradient: gradient,
                    textAlign: TextAlign.center,
                  )
                      : AppText(
                    text: statusText,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: solidColor ?? AppColors.textPrimary,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}