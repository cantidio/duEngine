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
      if (position.x >= 4000.0 || position.x <= 0.0) mirroring ^= Mirroring.H;
    }
  }
}

//abstract class Input {
//  List<double> _entries = new List<double>(32);//whatever
//  List<double> get entries => _entries;
//  void update();
//}
//
//class InputKeyboard extends Input{
//  InputKeyboard([int keyboardIndex=0]){}
//  void update(){
//    if('a' != null){
//     _entries[0]= 1.0;
//    }
//  }
//}
//class InputJoystick extends Input{
//  InputJoystick([int index=0]){
//    _base = new Gorgon.Input(index);
//  }
//
//  void update(){
//    if('analogic' != null){
//      _entries[0]= 0.5;
//    }
//  }
//}

class Zero{
  GameController controller;
  Command basicAttack;

  Zero(){
//    loadConfig;
    List<Command> cl = new List<Command>();
    cl.add(new Command("leftDash", ["left", "left"], this.leftDash));
    controller = new GameController(cl);
  }

  void leftDash() {
    return true;
  }

  void update(){

    if(controller.check("dash")){
      //faz dash do capiroto
    }
  }
}
/// BUFFER WHITE MAGIC
class KeyboardInput{
  Keyboard keyboard;
  Map<String,int> map;

  bool check(String key){
    return keyboard[map[key]];
  }
}

class InputBuffer{
  int currentFrame=0;
  int maxFrames = 60;
  List<String> _buffer;
  KeyboardInput input;

  InputBuffer(KeyboardInput input, int bufferLength) {
    this.input = input;
    _buffer = new List<String>(bufferLength);
  }

  void update(){
    currentFrame%=_buffer.length;
      input.map.forEach((String entry, int key){
        if(input.check(entry)){
          _buffer[currentFrame]= entry;
        }
      });
      ++currentFrame;
    }

  bool checkCommand(Command command) {
    //check if command was executed in this buffer
    return true;
  }
}

class Command {
  String name;
  List<String> actions;
  Function callback;
  Command(this.name, this.actions,[this.callback]);
}

class CommandList {
  List<Command> _commands;

  int get length => _commands.length;
  Command operator[](int i) => _commands[i];

  CommandMap(){
    _commands = new List<Command>();
  }

  void add(String commandName, List<String> commandActions, [Function callback]) {
    _commands.add(new Command(commandName, commandActions, callback));
  }

  void sort(){
    //sort the list
  }
}

class GameController {
  CommandList _commandList;
  InputBuffer _buffer;
  GameController(KeyboardInput input, CommandList commandList) {
    _commandList = commandList;
    _commandList.sort();
    _buffer = new InputBuffer(input, _commandList.length);
  }

  void update(){
    _buffer.update();
    for(int i = 0; i < _commandList.length; ++i){
      Command command = _commandList[i];
      if(_buffer.checkCommand(command)){
        if(eventConsumedByCommand(command)) break;
      }
    }
  }

  bool eventConsumedByCommand(Command cmd) => cmd.callback != null && cmd.callback();


  bool check(String cmd) {
    //checar se o buffer contem o comando

    _commandList.commands[]
  }
}




//CommandList a;
a.add("~sf, -> + b0").add("");


//Input keyboard, joy1,joy2;

//CommandList a; <- InputMap config;



void a(){
  var a = new KeyboardInputMap();
  a["left"] = 32;
  a["right"]= 33;
  a["up"]= 34;
  a["Attack"] = 666;

  var cmd = new CommandList();
  cmd.add("dash",["right", "right"]);

}

















main() {
  Display display = new Display(querySelector("#display"), width: 320, height: 240);

  Spritepack sp = new Spritepack.fromTileSheet("resources/bg-tile.png", 8, 8, new Point2D.zero());
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
    cam.follow([chico1]);
    cam.zoomFactor  = 1.0;

    Timer timer = new Timer.periodic(const Duration(milliseconds: 1000 ~/ 60), (_) {
      display.clear();
      background.drawFromCamera(cam);
      background.update();
      cam.update();
    });
  });

}
