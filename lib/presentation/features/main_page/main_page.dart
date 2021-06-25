import 'package:intellimath_replica/presentation/core_flutter_packages.dart';
import 'package:intellimath_replica/application/providers/game_provider.dart';
import 'package:intellimath_replica/presentation/features/game_key_grid/game_key_grid_widget.dart';
import 'package:intellimath_replica/presentation/features/game_over/game_over_widget.dart';
import 'package:provider/provider.dart';

import '../game_header/game_header_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read<GameProvider>().startGame();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GameProvider>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(),
            const Flexible(
              flex: 5,
              child: GameHeaderWidget(),
            ),
            const Spacer(),
            Expanded(
              flex: 30,
              child: provider.isGameOver
                  ? const GameOverWidget()
                  : const GameKeyGridWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
