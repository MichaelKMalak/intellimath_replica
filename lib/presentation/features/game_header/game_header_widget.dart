import 'package:intellimath_replica/presentation/core_flutter_packages.dart';
import 'package:provider/provider.dart';
import 'package:intellimath_replica/application/providers/game_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../widgets/arc_timer_widget/arc_timer_widget.dart';

class GameHeaderWidget extends StatelessWidget {
  const GameHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GameProvider>();
    final textTheme = Theme.of(context).textTheme;
    final locals = AppLocalizations.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          flex: 5,
          child: buildHighScore(locals!, provider, textTheme),
        ),
        const Spacer(),
        Expanded(
          flex: 6,
          child: buildTimerAndTargetSum(locals, textTheme, context, provider),
        ),
        const Spacer(),
        Flexible(
          flex: 5,
          child: buildCurrentScore(locals, provider, textTheme),
        ),
      ],
    );
  }

  Text buildCurrentScore(
      AppLocalizations locals, GameProvider provider, TextTheme textTheme) {
    return Text(
      locals.currentScore + '\n' + provider.currentScore.toString(),
      style: textTheme.headline6,
      textAlign: TextAlign.center,
    );
  }

  SizedBox buildTimerAndTargetSum(AppLocalizations locals, TextTheme textTheme,
      BuildContext context, GameProvider provider) {
    return SizedBox(
      height: 150,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              locals.target,
              style: textTheme.headline6?.copyWith(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
          ArcTimerWidget(
            onTimerFinished: () => context.read<GameProvider>().gameOver(),
            shouldStartTimer: provider.startTimerTrigger,
            countDownDurationInSeconds: GameProvider.ROUND_TIME_IN_SECONDS,
            onCurrentTimeChange: (currentTime) {
              context.read<GameProvider>().currentTime = currentTime;
            },
            child: Text(
              provider.targetSum.toString(),
              style: textTheme.headline6,
            ),
          ),
        ],
      ),
    );
  }

  Text buildHighScore(
      AppLocalizations locals, GameProvider provider, TextTheme textTheme) {
    return Text(
      locals.highScore + '\n' + provider.highScore.toString(),
      style: textTheme.headline6,
      textAlign: TextAlign.center,
    );
  }
}
