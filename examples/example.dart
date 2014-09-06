/**
 * Copyright (C) 2014 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
import 'package:duengine/duengine.dart';
import 'package:gorgon/gorgon.dart';
import 'dart:html';
import 'dart:async';
import 'bg.dart';

main() {
  Display display = new Display(query("#display"), width: 320, height: 240);

  Spritepack sp = new Spritepack.fromTileSheet("resources/mario_tilesheet.png", 16, 16);
  Spritepack chico_sp = new Spritepack.fromJSON("resources/chico/chico.json");
  Animationpack chico_ap = new Animationpack.fromJSON("resources/chico/chico_animationpack.json");

  Future.wait([sp.onLoad, chico_sp.onLoad, chico_ap.onLoad]).then((_) {
    GameObject chico = new GameObject(chico_sp, chico_ap, new Point2D(200, 85));
    GameObject chico22 = new GameObject(chico_sp, chico_ap, new Point2D(20, 95));
    chico.animator.changeAnimation("walk");

    Background background = getBG(sp);
    background.layers.last.addObject(chico);
    background.layers.last.addObject(chico22);
    
    //Point transition example    
//    TransitionCamera camera = new TransitionCameraBuilder
//        .from(chico22.position, initialZoom: 2.0)
//        .to(chico.position, finalZoom: 1.5)
//        .withInterpolator(Interpolator.LINEAR["point"], zoomInterpolator: Interpolator.LINEAR["number"])
//        .during(300)
//        .build();
    
    //Following camera example
    FollowerCamera cam = new FollowerCamera(new Point2D(Display.target.width, Display.target.height));
    cam.follow([chico, chico22]);
    cam.zoomFactor = 2.0;

    Timer timer = new Timer.periodic(const Duration(milliseconds: 1000 ~/ 60), (_) {
      display.clear();
      background.drawFromCamera(cam);
//      background.drawFromCamera(camera);
      background.update();
//      camera.update();
      cam.update();

      if (chico.mirroring == Mirroring.None) chico.position += new Point2D(1, 0);
      if (chico.mirroring & Mirroring.H == Mirroring.H) chico.position -= new Point2D(1, 0);
      if (chico.position.x >= 520 || chico.position.x <= 10) chico.mirroring ^= Mirroring.H;
    });
  });

}
