/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
import 'package:unittest/html_config.dart';
import 'tile_test.dart'  as tile;
import 'layer_test.dart'  as layer;

main()
{
  useHtmlConfiguration();
  tile.main();
  layer.main();
}
