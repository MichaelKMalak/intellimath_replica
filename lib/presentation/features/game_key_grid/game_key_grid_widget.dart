import 'package:intellimath_replica/presentation/core_flutter_packages.dart';
import 'package:intellimath_replica/application/providers/game_provider.dart';
import 'package:provider/provider.dart';

import 'widgets/key_widget.dart';

class GameKeyGridWidget extends StatelessWidget {
  const GameKeyGridWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GameProvider>();
    return GridView.count(
      crossAxisCount: (GameProvider.KEYS_COUNT / 3).truncate(),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 1,
      children: provider.keyNumbers
          .asMap()
          .entries
          .map(
            (entry) => KeyWidget(
              text: entry.value.toString(),
              isPressed: provider.isKeyPressed(entry.key),
              onPressed: () => provider.onKeyPressed(entry.key),
            ),
          )
          .toList(),
    );
  }
}
