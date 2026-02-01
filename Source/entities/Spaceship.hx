package entities;

import openfl.geom.Point;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.display.Stage;
import openfl.display.Sprite;
import openfl.geom.Rectangle;
import core.Actions;
import core.Vector2;
import openfl.Lib.getTimer;

/**
 * The Spaceship that the player controls, which can move and shoot bullets
 */
class Spaceship extends Sprite {
    private static inline var MOVEMENT_ACCELERATION:Int = 5;
    private static inline var MOVEMENT_NATURAL_DEACCELERATION:Int = 2;
    private static inline var MOVEMENT_MANUAL_DEACCELERATION: Int = 4;
    private static inline var MAX_MOVEMENT_VELOCITY:Int = 3;

    private static inline var ROTATION_ACCELERATION:Int = 18;
    private static inline var ROTATION_DEACCELERATION:Int = 12;
    private static inline var MAX_ROTATION_VELOCITY:Int = 8;

    private static inline var SHOOT_COOLDOWN_MS:Int = 100;
    private static inline var FRAME_CHANGE_MS:Int = 200;

    private static inline var COLLISION_RADIUS:Int = 10;

    private var bullets:Array<Bullet>;
    private var asteroids:Array<Asteroid>;

    public var isHit:Bool = false;

    private var secondFrame:Bool = false;
    private var bitmap:Bitmap;
    private var spriteSheet:Bitmap;

    /**
     * Creates and initializes a new Spaceship
     *
     * @param stage The stage to which the Spaceship will be added to
     */
    public function new(stage:Stage, bullets:Array<Bullet>, asteroids:Array<Asteroid>):Void {
        super();
        
        // Draws the ship's sprite and positions it in the center of the screen
        spriteSheet = new Bitmap(BitmapData.fromFile("Assets/Spaceship.png"));
        bitmap = new Bitmap(new BitmapData(16, 16));
        bitmap.bitmapData.copyPixels(spriteSheet.bitmapData, new Rectangle(0, 0, 16, 16), new Point());
        bitmap.scaleX = 3;
        bitmap.scaleY = 3;
        bitmap.x = -24;
        bitmap.y = -20;
        this.addChild(bitmap);
        graphics.beginFill(0xFF0000);
        graphics.drawCircle(this.x, this.y, COLLISION_RADIUS);
        graphics.endFill();
        this.x = stage.stageWidth / 2;
		this.y = stage.stageHeight / 2;

        this.bullets = bullets;
        this.asteroids = asteroids;
    }

    private var movementVelocity:Vector2 = new Vector2(0, 0);
    private var rotationVelocity:Float = 0;
    private var direction:Vector2 = new Vector2(0, 0);
    private var lastShootTime:Int = 0;
    private var lastFrameChangeTime:Int = 0;

    public function update(deltaTime: Float) {
        var isMoving:Bool = false;

        // Gets the rotation the ship has to do and applies it
        if (Actions.isActionPressed("RotateLeft")) {
            rotationVelocity -= ROTATION_ACCELERATION * deltaTime;
            if (rotationVelocity < -MAX_ROTATION_VELOCITY) {
                rotationVelocity = -MAX_ROTATION_VELOCITY;
            }
        } else if (Actions.isActionPressed("RotateRight")) {
            rotationVelocity += ROTATION_ACCELERATION * deltaTime;
            if (rotationVelocity > MAX_ROTATION_VELOCITY) {
                rotationVelocity = MAX_ROTATION_VELOCITY;
            }
        } else {
            // If there's none, applies deacceleration
            if (rotationVelocity > ROTATION_DEACCELERATION * deltaTime) {
                rotationVelocity -= ROTATION_DEACCELERATION * deltaTime;
            } else if (rotationVelocity < -ROTATION_DEACCELERATION * deltaTime) {
                rotationVelocity += ROTATION_DEACCELERATION * deltaTime;
            } else {
                rotationVelocity = 0;
            }
        }
        // Applies the rotationVelocity onto the actual sprite's rotation
        rotation += rotationVelocity;

        // Gets the direction the ship is facing in a Vector2 based on rotation
        direction = Vector2.fromAngle(rotation);

        // Gets the velocity the ship has to apply to itself and applies it
        if (Actions.isActionPressed("Accelerate")) {
            // Changes the bitmap frame
            isMoving = true;

            movementVelocity += direction * MOVEMENT_ACCELERATION * deltaTime;
            if (movementVelocity.x > MAX_MOVEMENT_VELOCITY) {
                movementVelocity.x = MAX_MOVEMENT_VELOCITY;
            } else if (movementVelocity.x < -MAX_MOVEMENT_VELOCITY) {
                movementVelocity.x = -MAX_MOVEMENT_VELOCITY;
            } else if (movementVelocity.y > MAX_MOVEMENT_VELOCITY) {
                movementVelocity.y = MAX_MOVEMENT_VELOCITY;
            } else if (movementVelocity.y < -MAX_MOVEMENT_VELOCITY) {
                movementVelocity.y = -MAX_MOVEMENT_VELOCITY;
            }
        } else if (Actions.isActionPressed("Deaccelerate")) {
            if (movementVelocity.x > MOVEMENT_MANUAL_DEACCELERATION * deltaTime) {
                movementVelocity.x -= MOVEMENT_MANUAL_DEACCELERATION * deltaTime;
            } else if (movementVelocity.x < -MOVEMENT_MANUAL_DEACCELERATION * deltaTime) {
                movementVelocity.x += MOVEMENT_MANUAL_DEACCELERATION * deltaTime;
            } else {
                movementVelocity.x = 0;
            }
            if (movementVelocity.y > MOVEMENT_MANUAL_DEACCELERATION * deltaTime) {
                movementVelocity.y -= MOVEMENT_MANUAL_DEACCELERATION * deltaTime;
            } else if (movementVelocity.y < -MOVEMENT_MANUAL_DEACCELERATION * deltaTime) {
                movementVelocity.y += MOVEMENT_MANUAL_DEACCELERATION * deltaTime;
            } else {
                movementVelocity.y = 0;
            }
        } else {
            // If there's none, applies deacceleration
            if (movementVelocity.x > MOVEMENT_NATURAL_DEACCELERATION * deltaTime) {
                movementVelocity.x -= MOVEMENT_NATURAL_DEACCELERATION * deltaTime;
            } else if (movementVelocity.x < -MOVEMENT_NATURAL_DEACCELERATION * deltaTime) {
                movementVelocity.x += MOVEMENT_NATURAL_DEACCELERATION * deltaTime;
            } else {
                movementVelocity.x = 0;
            }
            if (movementVelocity.y > MOVEMENT_NATURAL_DEACCELERATION * deltaTime) {
                movementVelocity.y -= MOVEMENT_NATURAL_DEACCELERATION * deltaTime;
            } else if (movementVelocity.y < -MOVEMENT_NATURAL_DEACCELERATION * deltaTime) {
                movementVelocity.y += MOVEMENT_NATURAL_DEACCELERATION * deltaTime;
            } else {
                movementVelocity.y = 0;
            }
        }
        // Applies the movementVelocity onto the actual sprite's position
        x += movementVelocity.x;
        y += movementVelocity.y;

        // Checks if it's colliding with any asteroid
        for (asteroid in this.asteroids) {
            var dx = this.x - asteroid.x;
            var dy = this.y - asteroid.y;
            var distSq = dx * dx + dy * dy;
            var radiusSum = COLLISION_RADIUS + asteroid.radius;
            var radiusSumSq = radiusSum * radiusSum;
            
            if (distSq <= radiusSumSq) {
                isHit = true;
            }
        }

        // Makes the spaceship shoot a bullet if the player requested to do so and if the cooldown has finished
        if (Actions.isActionJustPressed("Shoot") && getTimer() - lastShootTime >= SHOOT_COOLDOWN_MS) {
            // Sets lastShootTime to the current time
            lastShootTime = getTimer();

            // Activates the next available bullet
            for (bullet in bullets) {
                if (!bullet.isActive) {
                    bullet.activate(x, y, direction);
                    break;
                }
            }
        }

        // If the ship is moving, updates the ship's bitmap
        if (isMoving) {
            if (getTimer() - lastFrameChangeTime >= FRAME_CHANGE_MS) {
                secondFrame = !secondFrame;
                lastFrameChangeTime += FRAME_CHANGE_MS;

                if (secondFrame) {
                    bitmap.bitmapData.copyPixels(spriteSheet.bitmapData, new Rectangle(32, 0, 16, 16), new Point());
                } else {
                    bitmap.bitmapData.copyPixels(spriteSheet.bitmapData, new Rectangle(16, 0, 16, 16), new Point());
                }
            }
        } else {
            lastFrameChangeTime += getTimer() - lastFrameChangeTime;
            bitmap.bitmapData.copyPixels(spriteSheet.bitmapData, new Rectangle(0, 0, 16, 16), new Point());
        }
    }
}