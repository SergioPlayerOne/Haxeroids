package entities;

import core.Vector2;
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

    private static inline var MIN_SPEED_LARGE:Int = 90;
    private static inline var MAX_SPEED_LARGE:Int = 110;
    private static inline var MIN_SPEED_MEDIUM:Int = 150;
    private static inline var MAX_SPEED_MEDIUM:Int = 180;
    private static inline var MIN_SPEED_SMALL:Int = 220;
    private static inline var MAX_SPEED_SMALL:Int = 300;

    private static inline var INITIAL_ASTEROIDS:Int = 3;
    private static inline var SPAWN_LOCATION_INCREMENT:Int = 90;

    private static var asteroids:Array<Asteroid>;

    public var direction:Vector2;
    public var radius:Int;
    public var size:AsteroidSize;
    public var speed:Int;
    public var isAlive:Bool = true;
    public var isHitByBullet:Bool = false;

    public function new(stage:Stage, size:AsteroidSize) {
        super();

        this.size = size;
        this.speed = (() -> switch(size) {
            case Large: Random.int(MIN_SPEED_LARGE, MAX_SPEED_LARGE);
            case Medium: Random.int(MIN_SPEED_MEDIUM, MAX_SPEED_MEDIUM);
            case Small: Random.int(MIN_SPEED_SMALL, MAX_SPEED_SMALL);
        })();
        this.radius = (() -> switch(size) {
            case Large: Random.int(MIN_RADIUS_LARGE, MAX_RADIUS_LARGE);
            case Medium: Random.int(MIN_RADIUS_MEDIUM, MAX_RADIUS_MEDIUM);
            case Small: Random.int(MIN_RADIUS_SMALL, MAX_RADIUS_SMALL);
        })();

        graphics.beginFill(0x5C5C5C);
        graphics.drawCircle(0, 0, this.radius);
        graphics.endFill();
        stage.addChild(this);
    }

    public static function atScreenBorder(stage:Stage):Asteroid {
        var asteroid = new Asteroid(stage, Large);
        var windowPerimeter:Int = stage.stageWidth * 2 + stage.stageHeight * 2;
        var spawnPositionIndex = Random.int(0, windowPerimeter - 1);

        // Checks to which side of the window the spawnPositionIndex is pointing at
        if (spawnPositionIndex < stage.stageWidth) { // Top
            asteroid.y = -SPAWN_LOCATION_INCREMENT;
            asteroid.x = spawnPositionIndex;
            asteroid.direction = Vector2.fromAngle(Random.int(140, 220));
        } else if (spawnPositionIndex < stage.stageWidth + stage.stageHeight) { // Right
            asteroid.x = stage.stageWidth + SPAWN_LOCATION_INCREMENT;
            asteroid.y = spawnPositionIndex - stage.stageWidth;
            asteroid.direction = Vector2.fromAngle(Random.int(-50, -130));
        } else if (spawnPositionIndex < stage.stageWidth * 2 + stage.stageHeight) { // Bottom
            asteroid.y = stage.stageHeight + SPAWN_LOCATION_INCREMENT;
            asteroid.x = spawnPositionIndex - stage.stageHeight - stage.stageWidth;
            asteroid.direction = Vector2.fromAngle(Random.int(40, -40));
        } else { // Left
            asteroid.x = -SPAWN_LOCATION_INCREMENT;
            asteroid.y = spawnPositionIndex - stage.stageWidth * 2 - stage.stageHeight;
            asteroid.direction = Vector2.fromAngle(Random.int(50, 130));
        }

        return asteroid;
    }

    public static function initAsteroids(stage:Stage, asteroidsMain:Array<Asteroid>):Array<Asteroid> {
        asteroids = asteroidsMain;
        var asteroidList = new Array<Asteroid>();
        for (i in 0...INITIAL_ASTEROIDS) {
            var asteroid = Asteroid.atScreenBorder(stage);
            asteroidList[i] = asteroid;
        }
        return asteroidList;
    }

    public function update(deltaTime:Float) {
        this.x += this.direction.x * this.speed * deltaTime;
        this.y += this.direction.y * this.speed * deltaTime;

        // If it goes out of the screen's bounds, it kill itself
        if (this.x > stage.stageWidth + 100 || this.x < -stage.stageWidth - 100 || this.y > stage.stageHeight + 100 || this.y < -stage.stageHeight - 100) {
            this.destroy();
        }
    }

    public function onCollide() {
        isHitByBullet = true;
    }

    public function destroy() {
        isAlive = false;
        this.parent.removeChild(this);
    }
}