import core.Vector2;
import openfl.Vector;
import openfl.display.Stage;
import openfl.display.Sprite;

enum AsteroidSize {
    Large;
    Medium;
    Small;
}

class Asteroid extends Sprite {
    private static inline var MIN_RADIUS_LARGE:Int = 80;
    private static inline var MAX_RADIUS_LARGE:Int = 100;
    private static inline var MIN_RADIUS_MEDIUM:Int = 50;
    private static inline var MAX_RADIUS_MEDIUM:Int = 70;
    private static inline var MIN_RADIUS_SMALL:Int = 20;
    private static inline var MAX_RADIUS_SMALL:Int = 30;

    private static inline var INITIAL_ASTEROIDS:Int = 3;
    private static inline var SPAWN_LOCATION_INCREMENT:Int = 90;

    public var direction:Vector2 = new Vector2(0, 0);
    public var radius:Int;

    public function new(stage:Stage, size:AsteroidSize) {
        super();

        var windowPerimeter:Int = stage.stageWidth * 2 + stage.stageHeight * 2;
        var spawnPositionIndex = Random.int(0, windowPerimeter - 1);
        this.radius = (() -> switch(size) {
            case Large: Random.int(MIN_RADIUS_LARGE, MAX_RADIUS_LARGE);
            case Medium: Random.int(MIN_RADIUS_MEDIUM, MAX_RADIUS_MEDIUM);
            case Small: Random.int(MIN_RADIUS_SMALL, MAX_RADIUS_SMALL);
        })();

        // Checks to which side of the window the spawnPositionIndex is pointing at
        if (spawnPositionIndex < stage.stageWidth) { // Top
            this.y = -SPAWN_LOCATION_INCREMENT;
            this.x = spawnPositionIndex;
            this.direction = Vector2.fromAngle(Random.int(140, 220));
        } else if (spawnPositionIndex < stage.stageWidth + stage.stageHeight) { // Right
            this.x = stage.stageWidth + SPAWN_LOCATION_INCREMENT;
            this.y = spawnPositionIndex - stage.stageWidth;
            this.direction = Vector2.fromAngle(Random.int(-50, -130));
        } else if (spawnPositionIndex < stage.stageWidth * 2 + stage.stageHeight) { // Bottom
            this.y = stage.stageHeight + SPAWN_LOCATION_INCREMENT;
            this.x = spawnPositionIndex - stage.stageHeight - stage.stageWidth;
            this.direction = Vector2.fromAngle(Random.int(40, -40));
        } else { // Left
            this.x = -SPAWN_LOCATION_INCREMENT;
            this.y = spawnPositionIndex - stage.stageWidth * 2 - stage.stageHeight;
            this.direction = Vector2.fromAngle(Random.int(50, 130));
        }

        graphics.beginFill(0x5C5C5C);
        graphics.drawCircle(0, 0, this.radius);
        graphics.endFill();
        stage.addChild(this);
    }

    public static function initAsteroids(stage:Stage):Vector<Asteroid> {
        var asteroidList = new Vector<Asteroid>();
        for (i in 0...INITIAL_ASTEROIDS) {
            var asteroid = new Asteroid(stage, AsteroidSize.Large);
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