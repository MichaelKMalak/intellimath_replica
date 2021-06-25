import 'package:provider/provider.dart';

import 'game_provider.dart';

List<ChangeNotifierProvider<GameProvider>> getProviders() {
  return [
    ChangeNotifierProvider(create: (_) => GameProvider()),
  ];
}
