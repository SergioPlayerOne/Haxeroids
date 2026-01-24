import openfl.display.Stage;
import openfl.Vector;
import openfl.display.Sprite;
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

    private var bullets:Vector<Bullet>;

    /**
     * Creates and initializes a new Spaceship
     *
     * @param stage The stage to which the Spaceship will be added to
     */
    public function new(stage:Stage, bullets:Vector<Bullet>) {
        super();
        
        // Draws the ship's sprite and positions it in the center of the screen
        graphics.beginFill(0xFFFFFF);
        graphics.drawTriangles(Vector.ofArray([0.0, -20,  15, 15,  -15, 15]));
        graphics.endFill();
        this.x = stage.stageWidth / 2;
        this.y = stage.stageHeight / 2;
        stage.addChild(this);

        this.bullets = bullets;
    }

    private var movementVelocity:Vector2 = new Vector2(0, 0);
    private var rotationVelocity:Float = 0;
    private var direction:Vector2 = new Vector2(0, 0);
    private var lastShootTime:Int = 0;

    public function update(deltaTime: Float) {
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
    }
}