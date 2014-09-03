/**
 * Copyright (C) 2014 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
import 'package:duengine/duengine.dart';
import 'package:gorgon/gorgon.dart';
import 'dart:html';
import 'dart:async';

main()
{
  Display display = new Display( query("#display"), width: 640, height: 480 );


  Spritepack sp = new Spritepack.fromTileSheet("resources/mario_tilesheet.png", 16,16 );
  sp.onLoad.then((_){
    num ang = 0.0;
    num scale = 1.0;
    int scale_mod = 1;

    Tile simpleTile = new Tile(sp["6"]);
    int tile = 0;
      Timer timer = new Timer.periodic( const Duration(milliseconds: 1000~/3), (_) {
         display.clear();
         simpleTile.draw(new Point2D(50, 50));
         simpleTile.logic();
      });
  });
}
