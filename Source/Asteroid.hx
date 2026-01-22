import core.Vector2;
import openfl.Vector;
import openfl.display.Stage;
import openfl.display.Sprite;

class Asteroid extends Sprite {
    public static inline var RADIUS:Int = 30;
    private static inline var INITIAL_ASTEROIDS:Int = 3;

    public var direction:Vector2 = new Vector2(0, 0);

    public function new(stage:Stage) {
        super();

        graphics.beginFill(0x5C5C5C);
        graphics.drawCircle(0, 0, 40);
        graphics.endFill();
        stage.addChild(this);
    }

    public static function initAsteroids(stage:Stage):Vector<Asteroid> {
        var asteroidList = new Vector<Asteroid>();
        var windowPerimeter:Int = stage.stageWidth * 2 + stage.stageHeight * 2;

        for (i in 0...INITIAL_ASTEROIDS) {
            var asteroid = new Asteroid(stage);
            var spawnPositionIndex = Random.int(0, windowPerimeter - 1);

            // Checks to which side of the window the spawnPositionIndex is pointing at
            if (spawnPositionIndex < stage.stageWidth) { // Top
                asteroid.y = 0;
                asteroid.x = spawnPositionIndex;
                asteroid.direction = Vector2.fromAngle(Random.int(140, 220));
            } else if (spawnPositionIndex < stage.stageWidth + stage.stageHeight) { // Right
                asteroid.x = stage.stageWidth;
                asteroid.y = spawnPositionIndex - stage.stageWidth;
                asteroid.direction = Vector2.fromAngle(Random.int(-50, -130));
            } else if (spawnPositionIndex < stage.stageWidth * 2 + stage.stageHeight) { // Bottom
                asteroid.y = stage.stageHeight;
                asteroid.x = spawnPositionIndex - stage.stageHeight - stage.stageWidth;
                asteroid.direction = Vector2.fromAngle(Random.int(40, -40));
            } else { // Left
                asteroid.x = 0;
                asteroid.y = spawnPositionIndex - stage.stageWidth * 2 - stage.stageHeight;
                asteroid.direction = Vector2.fromAngle(Random.int(50, 130));
            }

            // Adds the asteroid to the list
            asteroidList[i] = asteroid;
        }

        return asteroidList;
    }

    public function update(deltaTime:Float) {
        this.x += this.direction.x * 100 * deltaTime;
        this.y += this.direction.y * 100 * deltaTime;
    }

    public function onCollide() {
        
    }
}