import openfl.Vector;
import openfl.display.Stage;
import openfl.display.Sprite;

class Asteroid extends Sprite {

    public static inline var RADIUS:Int = 30;

    public function new(stage:Stage, x:Int, y:Int) {
        super();

        graphics.beginFill(0x5C5C5C);
        graphics.drawCircle(0, 0, 40);
        graphics.endFill();
        this.x = (stage.stageWidth / 2) + x;
        this.y = (stage.stageHeight / 2) + y;
        stage.addChild(this);
    }

    public static function initTestAsteroids(stage:Stage):Vector<Asteroid> {
        var asteroidList = new Vector<Asteroid>(3, true);
        asteroidList[0] = (new Asteroid(stage, 200, -300));
        asteroidList[1] = (new Asteroid(stage, -300, 200));
        asteroidList[2] = (new Asteroid(stage, -100, 300));
        return asteroidList;
    }

    public function onCollide() {
        
    }
}