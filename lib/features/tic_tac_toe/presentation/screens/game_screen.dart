import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text.dart';
import '../../domain/entities/player.dart';
import '../providers/game_provider.dart';
import '../widgets/game_board.dart';
import '../widgets/game_status.dart';

class GameScreen extends ConsumerWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      _buildHeader(),
                      const SizedBox(height: 32),
                      _buildScoreBoard(ref),
                      const Spacer(),
                      const GameStatus(),
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 450),
                          child: const GameBoard(),
                        ),
                      ),
                      const Spacer(),
                      _buildActionButtons(context, ref),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppColors.primaryGradient,
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryStart.withOpacity(0.4),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: const Icon(
            Icons.grid_3x3_rounded,
            size: 48,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 20),
        const GradientText(
          text: AppStrings.appTitle,
          fontSize: 40,
          fontWeight: FontWeight.bold,
          gradient: AppColors.primaryGradient,
        ),
        const SizedBox(height: 8),
        const AppText(
          text: AppStrings.appSubtitle,
          fontSize: 14,
          color: AppColors.textMuted,
          letterSpacing: 1.5,
        ),
      ],
    );
  }

  Widget _buildScoreBoard(WidgetRef ref) {
    final state = ref.watch(gameProvider);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.surfaceDark.withOpacity(0.6),
            AppColors.surfaceMid.withOpacity(0.4),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.cellBorder.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowDark.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildScoreItem(
            'Player X',
            state.xWins,
            AppColors.playerXGradient,
            Icons.close_rounded,
          ),
          Container(
            width: 1,
            height: 70,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  AppColors.cellBorder.withOpacity(0.5),
                  Colors.transparent,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          _buildScoreItem(
            'Draws',
            state.draws,
            AppColors.secondaryGradient,
            Icons.handshake_rounded,
          ),
          Container(
            width: 1,
            height: 70,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  AppColors.cellBorder.withOpacity(0.5),
                  Colors.transparent,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          _buildScoreItem(
            'Player O',
            state.oWins,
            AppColors.playerOGradient,
            Icons.radio_button_unchecked_rounded,
          ),
        ],
      ),
    );
  }

  Widget _buildScoreItem(
      String label,
      int score,
      Gradient gradient,
      IconData icon,
      ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: gradient,
            boxShadow: [
              BoxShadow(
                color: gradient.colors.first.withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Icon(
            icon,
            size: 28,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        GradientText(
          text: score.toString(),
          fontSize: 32,
          fontWeight: FontWeight.bold,
          gradient: gradient,
        ),
        const SizedBox(height: 6),
        AppText(
          text: label,
          fontSize: 11,
          color: AppColors.textMuted,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context, WidgetRef ref) {
    final state = ref.watch(gameProvider);

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: AppButton(
                text: AppStrings.newGame,
                onPressed: () => ref.read(gameProvider.notifier).newGame(),
                icon: Icons.refresh_rounded,
                variant: ButtonVariant.primary,
              ),
            ),
            const SizedBox(width: 12),
            Container(
              decoration: BoxDecoration(
                gradient: AppColors.secondaryGradient,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.secondaryStart.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => _showResetDialog(context, ref),
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    child: const Icon(
                      Icons.settings_backup_restore_rounded,
                      color: AppColors.textPrimary,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        if (state.totalGames > 0) ...[
          const SizedBox(height: 16),
          AppText(
            text: 'Total Games: ${state.totalGames}',
            fontSize: 13,
            color: AppColors.textMuted,
            fontWeight: FontWeight.w500,
          ),
        ],
      ],
    );
  }

  void _showResetDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      barrierColor: AppColors.shadowDark.withOpacity(0.7),
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.surfaceDark.withOpacity(0.98),
                AppColors.surfaceMid.withOpacity(0.95),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: AppColors.cellBorder.withOpacity(0.3),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowDark.withOpacity(0.5),
                blurRadius: 40,
                offset: const Offset(0, 20),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppColors.secondaryGradient,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.secondaryStart.withOpacity(0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.warning_amber_rounded,
                  size: 48,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 24),
              const GradientText(
                text: AppStrings.resetScoreTitle,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                gradient: AppColors.secondaryGradient,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const AppText(
                text: AppStrings.resetScoreMessage,
                fontSize: 14,
                color: AppColors.textTertiary,
                textAlign: TextAlign.center,
                height: 1.5,
              ),
              const SizedBox(height: 28),
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      text: AppStrings.cancel,
                      onPressed: () => Navigator.pop(context),
                      variant: ButtonVariant.outline,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppButton(
                      text: AppStrings.reset,
                      onPressed: () {
                        ref.read(gameProvider.notifier).resetAll();
                        Navigator.pop(context);
                      },
                      icon: Icons.restart_alt_rounded,
                      variant: ButtonVariant.secondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}