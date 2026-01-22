import haxe.xml.Printer;
import core.Vector2;
import openfl.Vector;
import openfl.display.Stage;
import openfl.display.Sprite;

class Bullet extends Sprite {
    private static inline var MOVE_SPEED:Int = 10;
    private static inline var DIRECTION_MULTIPLIER:Int = 20;
    private static inline var POOLED_BULLETS:Int = 100;

    public var isActive:Bool = false;
    private var direction:Vector2 = new Vector2(0, 0);

    public function new(stage:Stage) {
        super();

        graphics.beginFill(0xFFFFFF);
        graphics.drawCircle(0, 0, 4);
        graphics.endFill();
        visible = false;
        stage.addChild(this);
    }

    public static function initBullets(stage:Stage):Vector<Bullet> {
        var bulletPool = new Vector<Bullet>();
        for (i in 0...POOLED_BULLETS) {
            bulletPool[i] = new Bullet(stage);
        }
        return bulletPool;
    }

    public function activate(xPos:Float, yPos:Float, direction:Vector2) {
        this.isActive = true;
        visible = true;

        // Positions the bullet right at the front of the Spaceship
        this.x = xPos + direction.x * DIRECTION_MULTIPLIER;
        this.y = yPos + direction.y * DIRECTION_MULTIPLIER;

        // Sets the bullet's direction to the direction it was fired in
        this.direction = direction;
    }

    public function update(deltaTime:Float) {
        if (!this.isActive) {
            return;
        }

        // Moves forward constantly in the direction it was fired in
        this.x += this.direction.x * MOVE_SPEED;
        this.y += this.direction.y * MOVE_SPEED;

        // Checks if it collides with any asteroid
        //for (asteroid in Main.asteroids) {
        //    if (this.collidesWithAsteroid(asteroid)) {
        //        trace("Collided!");
        //    }
        //}
    }   

    private function collidesWithAsteroid(asteroid:Asteroid) {
        return (asteroid.x - this.x) * (asteroid.x - this.x) + (asteroid.y - this.y) * (asteroid.y - this.y) <= (Asteroid.RADIUS * Asteroid.RADIUS);
    }
}