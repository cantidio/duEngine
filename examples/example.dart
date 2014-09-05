/**
 * Copyright (C) 2014 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
import 'package:duengine/duengine.dart';
import 'package:gorgon/gorgon.dart';
import 'dart:html';
import 'dart:async';
import 'bg.dart';

class Chico extends GameObject {
  Chico() : super(null, null, new Point2D.zero()) {
  }
  Future load() {
    Completer completer = new Completer();
    Spritepack sp = new Spritepack.fromJSON("resources/chico/chico.json");
    Animationpack ap = new Animationpack.fromJSON("resources/chico/chico_animationpack.json");

    Future.wait([sp.onLoad, ap.onLoad]).then((_) {
      this.animator = new Animator(sp, ap);
      completer.complete(this);
    });
    return completer.future;
  }

  void update() {
    super.update();
    if (animator.animationOn == "walk") {
      if (mirroring == Mirroring.None) position += new Point2D(3, 0);
      else if (mirroring & Mirroring.H == Mirroring.H) position -= new Point2D(3, 0);
      if (position.x >= 400.0 || position.x <= 0.0) mirroring ^= Mirroring.H;
    }
  }
}

main() {
  Display display = new Display(query("#display"), width: 400, height: 400);
  Spritepack sp = new Spritepack.fromTileSheet("resources/mario_tilesheet.png", 16, 16);
  Chico chico1 = new Chico();
  Chico chico2 = new Chico();

  chico1.position = new Point2D(200,200);
  chico2.position = new Point2D(200,200);
  chico2.mirroring = Mirroring.H;

  Future.wait([sp.onLoad, chico1.load(), chico2.load()]).then((_) {
    chico1.animator.changeAnimation("walk");
    chico2.animator.changeAnimation("walk");

    Background background = getBG(sp);
    background.layers.last.addObject(chico1);
    background.layers.last.addObject(chico2);

    FollowerCamera cam = new FollowerCamera(new Point2D(Display.target.width, Display.target.height));
    cam.follow([chico1,chico2]);
    cam.zoomFactor  = 1.0;

    Timer timer = new Timer.periodic(const Duration(milliseconds: 1000 ~/ 120), (_) {
      display.clear();
      background.drawFromCamera(cam);
      background.update();
      cam.update();
    });
  });

}
