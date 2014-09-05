library game_object_test;

import "package:unittest/unittest.dart";
import 'package:mockito/mockito.dart';
import "package:duengine/duengine.dart";
import "package:gorgon/gorgon.dart";
import "helper.dart";

void main() {
  group("GameObject", () {
    GameObject object;

    final Point2D position = new Point2D.zero();
    final num scale = 1.5;
    final num rotation = 10.0;
    final double alpha = 0.5;
    final Mirroring mirroring = Mirroring.None;

    setUp(() {
      object = new GameObject(new Spritepack(), new Animationpack(), position, scale: scale, rotation: rotation, alpha: alpha, mirroring: mirroring);
      object.animator = new MockAnimator();
    });

    group("constructor", () {
      test("should create an Animator with the provided spritepack and animationpack.", () {
        expect(object.animator, isNotNull);
      });

      test("should set the position provided", () {
        expect(object.position, equals(position));
      });

      test("should set the rotation provided", () {
        expect(object.rotation, equals(rotation));
      });

      test("should set the alpha provided", () {
        expect(object.alpha, equals(alpha));
      });

      test("should set the mirroring provided", () {
        expect(object.mirroring, equals(mirroring));
      });

      test("should set the scale provided", () {
        expect(object.scale, equals(scale));
      });
    });

    group("update", () {
      group("when the object is active", () {
        setUp(() {
          object.active = true;
        });

        test("should update the animator", () {
          object.update();
          verify(object.animator.runStep());
        });
      });

      group("when the object is not active", () {
        setUp(() {
          object.active = false;
        });

        test("when the object is not active it should not update the animator", () {
          object.update();
          verifyNever(object.animator.runStep());
        });
      });
    });

    group("draw", () {
      group("when the object is active", () {
        Point2D drawpos;
        setUp(() {
          object.active = true;
          drawpos = new Point2D(30, 60);
        });

        test("should draw the object.", () {
          object.draw(drawpos);
          verify(object.animator.draw(any, alpha: any, mirroring: any, rotation: any, scale: any));
        });

        test("should draw the object in the correct position", () {
          object.draw(drawpos);
          verify(object.animator.draw(object.position + drawpos, alpha: any, mirroring: any, rotation: any, scale: any));
        });

        test("should draw the object with the correct alpha", () {
          double drawalpha = 0.5;
          object.draw(drawpos, alpha: drawalpha);
          verify(object.animator.draw(any, alpha: object.alpha * drawalpha, mirroring: any, rotation: any, scale: any));
        });

        test("should draw the object with the correct mirroring", () {
          Mirroring drawmirror = Mirroring.H;
          object.draw(drawpos, mirroring: drawmirror);
          verify(object.animator.draw(any, alpha: any, mirroring: object.mirroring ^ drawmirror, rotation: any, scale: any));
          drawmirror = Mirroring.HV;
          object.draw(drawpos, mirroring: drawmirror);
        });

        test("should draw the object with the correct rotation", () {
          num drawrotation = 35;
          object.draw(drawpos, rotation: drawrotation);
          verify(object.animator.draw(any, alpha: any, mirroring: any, rotation: object.rotation + drawrotation, scale: any));
        });

        test("should draw the object with the correct scale", () {
          num drawscale = 0.3;
          object.draw(drawpos, scale: drawscale);
          verify(object.animator.draw(any, alpha: any, mirroring: any, rotation: any, scale: object.scale * drawscale));
        });
      });

      group("when the object is not active", () {
        setUp(() {
          object.active = false;
        });

        test("should not draw the object.", () {
          object.active = false;
          object.draw(new Point2D.zero());
          verifyNever(object.animator.draw(any));
        });
      });
    });

  });
}
