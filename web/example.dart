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
  InputCommandController controller;
  bool walking=false;
  Chico() : super(null, null, new Point2D.zero()) {
    List<InputCommand> commands = [
      new InputCommand(["Down", "Down+Right", "Right+Button1"], () {
        print("super.");
        return true;
      }),
      new InputCommand(["Left"],() => mirroring = Mirroring.H),
      new InputCommand(["Right"],() => mirroring = Mirroring.None),
      new InputCommand(["Left/Right"],(){
        walking=true;
        animator.changeAnimation("walk");
        position += new Point2D((mirroring == Mirroring.None) ? 3 : -3, 0);
        return true;
      })
    ];
    controller = new InputCommandController(new InputKeyboard(), commands);
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
    controller.update();
    if(!walking) animator.changeAnimation("stand");
    walking=false;
  }
}







main() {
  Display display = new Display(querySelector("#display"), width: 320, height: 240);

  Spritepack sp = new Spritepack.fromTileSheet("resources/bg-tile.png", 8, 8, new Point2D.zero());
  Chico chico1 = new Chico();
  Chico chico2 = new Chico();

  chico1.position = new Point2D(200, 200);
  chico2.position = new Point2D(200, 200);
  chico2.mirroring = Mirroring.H;

  Future.wait([sp.onLoad, chico1.load(), chico2.load()]).then((_) {
//    chico1.animator.changeAnimation("walk");
//    chico2.animator.changeAnimation("walk");

    Background background = getBG(sp);
    background.layers.last.addObject(chico1);
    background.layers.last.addObject(chico2);

    FollowerCamera cam = new FollowerCamera(new Point2D(Display.target.width, Display.target.height));
    cam.follow([chico1]);
    cam.zoomFactor = 1.0;

    Timer timer = new Timer.periodic(const Duration(milliseconds: 1000 ~/ 60), (_) {
      display.clear();
      background.drawFromCamera(cam);
      background.update();
      cam.update();
    });
  });

}
