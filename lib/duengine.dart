/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 *
 * This library contains a set of classes that let you create a 2d game.
 */
library duengine;
import 'package:gorgon/gorgon.dart';
import 'dart:math';
import 'dart:html';

part 'src/input/input_base.dart';
part 'src/input/input_command.dart';
part 'src/input/input_command_controller.dart';
part 'src/input/input_buffer.dart';
part 'src/input/input_keyboard.dart';
part 'src/game_object.dart';
part 'src/tile.dart';
part 'src/tilemap.dart';
part 'src/layer.dart';
part 'src/background.dart';
part 'src/camera/camera.dart';
part 'src/camera/follower_camera.dart';
part 'src/camera/transition_camera.dart';
part 'src/camera/transition_camera_builder.dart';
part 'src/camera/interpolator.dart';

