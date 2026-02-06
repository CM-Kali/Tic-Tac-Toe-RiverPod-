import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../providers/game_provider.dart';
import 'game_cell.dart';

class GameBoard extends ConsumerWidget {
  const GameBoard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(gameProvider);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: LinearGradient(
          colors: [
            AppColors.surfaceDark.withOpacity(0.6),
            AppColors.surfaceMid.withOpacity(0.4),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: AppColors.cellBorder.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowDark.withOpacity(0.3),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
          BoxShadow(
            color: AppColors.primaryStart.withOpacity(0.05),
            blurRadius: 50,
            spreadRadius: -10,
          ),
        ],
      ),
      child: AspectRatio(
        aspectRatio: 1,
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: 9,
          itemBuilder: (context, index) {
            final isWinningCell = state.winningLine?.contains(index) ?? false;

            return GameCell(
              player: state.board[index],
              onTap: () => ref.read(gameProvider.notifier).makeMove(index),
              isWinningCell: isWinningCell,
              index: index,
              isGameOver: state.isGameOver,
            );
          },
        ),
      ),
    );
  }
}