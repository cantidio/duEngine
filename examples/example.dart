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
  Spritepack chico_sp = new Spritepack.fromJSON("resources/chico/chico.json");
  Animationpack chico_ap = new Animationpack.fromJSON("resources/chico/chico_animationpack.json");

  Future.wait([sp.onLoad, chico_sp.onLoad, chico_ap.onLoad]).then((_){
    GameObject chico = new GameObject(chico_sp,chico_ap,new Point2D(30,85));
    chico.animator.changeAnimation("walk");

    num ang = -30;
    num scale = 1.0;
    int scale_mod = 1;
    List<Tile> tl = [];

    sp.groups.forEach((String group) => tl.add(new Tile(sp[group])) );

    TileMap map = new TileMap.fromMatrix([
      [tl[0],tl[1],tl[2],tl[3],tl[4],tl[5]],
      [tl[1],tl[2],tl[3],tl[4],tl[5],tl[0]],
      [tl[2],tl[3],tl[4],tl[5],tl[0],tl[1]],
      [tl[3],tl[4],tl[5],tl[0],tl[1],tl[2]],
      [tl[4],tl[5],tl[0],tl[1],tl[2],tl[3]],
      [tl[5],tl[0],tl[1],tl[2],tl[3],tl[4]]
    ], new Point2D(16,16));

    int tile = 0;
    Timer timer = new Timer.periodic( const Duration(milliseconds: 1000~/60), (_) {
       display.clear();
       map.draw(new Point2D(0, 0));
       map.logic();

       chico.draw(new Point2D(0,0), rotation:ang);
       chico.logic();
       if(chico.mirroring == Mirroring.None) chico.position += new Point2D(1,-1);
       if(chico.mirroring & Mirroring.H == Mirroring.H)    chico.position -= new Point2D(1,-1);
       if(chico.position.x >= 90 || chico.position.x <= 10 ) chico.mirroring ^= Mirroring.HV;
    });
  });


}
