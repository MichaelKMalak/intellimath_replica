import 'package:intellimath_replica/presentation/core_flutter_packages.dart';
import 'package:intellimath_replica/application/providers/game_provider.dart';
import 'package:provider/provider.dart';

class GameOverWidget extends StatelessWidget {
  const GameOverWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final locals = AppLocalizations.of(context);

    return Container(
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          Text(
            locals!.gameOver,
            style: textTheme.headline3,
            textAlign: TextAlign.center,
          ),
          IconButton(
            alignment: Alignment.center,
            iconSize: 50,
            tooltip: 'Restart Game',
            icon: const Icon(
              Icons.refresh,
            ),
            padding: const EdgeInsets.all(25),
            color: Colors.white,
            onPressed: () {
              context.read<GameProvider>().startGame();
            },
          ),
        ],
      ),
    );
  }
}
