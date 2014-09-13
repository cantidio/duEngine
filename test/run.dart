/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
import 'package:unittest/html_config.dart';
import 'game_object_test.dart' as game_object;
import 'tile_test.dart'  as tile;
import 'tilemap_test.dart'  as tilemap;
import 'layer_test.dart'  as layer;
import 'background_test.dart'  as background;

import 'input_command_test.dart' as input_command;
import 'input_buffer_test.dart' as input_buffer;
main()
{
  useHtmlConfiguration();
  game_object.main();
  tile.main();
  tilemap.main();
  layer.main();
  background.main();
  input_command.main();
  input_buffer.main();
}
