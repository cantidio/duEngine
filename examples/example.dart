/**
 * Copyright (C) 2014 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
import 'package:duengine/duengine.dart';
import 'package:gorgon/gorgon.dart';
import 'dart:html';
import 'dart:async';

main() {
  Display display = new Display(query("#display"), width: 320, height: 240);

  Spritepack sp = new Spritepack.fromTileSheet("resources/mario_tilesheet.png", 16, 16);
  Spritepack chico_sp = new Spritepack.fromJSON("resources/chico/chico.json");
  Animationpack chico_ap = new Animationpack.fromJSON("resources/chico/chico_animationpack.json");

  Future.wait([sp.onLoad, chico_sp.onLoad, chico_ap.onLoad]).then((_) {
    GameObject chico = new GameObject(chico_sp, chico_ap, new Point2D(30, 85));
    GameObject chico22 = new GameObject(chico_sp, chico_ap, new Point2D(40, 95));
    chico.animator.changeAnimation("walk");

    num ang = -30;
    num scale = 1.0;
    int scale_mod = 1;
    List<Tile> tl = [];

    sp.groups.forEach((String group) => tl.add(new Tile(sp[group])));

    TileMap map1 = new TileMap.fromMatrix([[tl[0], tl[1], tl[2], tl[3], tl[4], tl[5]], [tl[1], tl[2], tl[3], tl[4], tl[5], tl[0]], [tl[2], tl[3], tl[4], tl[5], tl[0], tl[1]], [tl[3], tl[4], tl[5], tl[0], tl[1], tl[2]], [tl[4], tl[5], tl[0], tl[1], tl[2], tl[3]], [tl[5], tl[0], tl[1], tl[2], tl[3], tl[4]]], new Point2D(16, 16));
    TileMap map2 = new TileMap.fromMatrix([[tl[5], tl[5], tl[5], tl[5], tl[5], tl[5]], [], [], [], [], [tl[5], tl[5], tl[5], tl[5], tl[5], tl[5]]], new Point2D(16, 16));

    Layer layer = new Layer(map1, [chico]);


    Layer layer2 = new Layer(map2, [chico22]);
    layer2.scrollspeed.x = 0.5;

    Background background = new Background(layers:[layer,layer2]);
//    SimpleCamera cam = new SimpleCamera(new Point2D(Display.target.width,Display.target.height));    
    FollowerCamera cam = new FollowerCamera(new Point2D(Display.target.width,Display.target.height));    
    cam.follow([chico, chico22]);
    cam.zoomFactor = 2.0;

    Timer timer = new Timer.periodic(const Duration(milliseconds: 1000 ~/ 60), (_) {
      display.clear();
      background.drawFromCamera(cam);
      background.update();
      cam.update();

      if (chico.mirroring == Mirroring.None) chico.position += new Point2D(1, -1);
      if (chico.mirroring & Mirroring.H == Mirroring.H) chico.position -= new Point2D(1, -1);
      if (chico.position.x >= 90 || chico.position.x <= 10) chico.mirroring ^= Mirroring.HV;
    });
  });


}
