/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
import 'package:unittest/html_config.dart';
import 'game_object_test.dart' as game_object;
import 'tile_test.dart'  as tile;
import 'layer_test.dart'  as layer;
import 'background_test.dart'  as background;

main()
{
  useHtmlConfiguration();
  game_object.main();
  tile.main();
  layer.main();
  background.main();
}
