package;

import Random;
import Asteroid.AsteroidSize;
import openfl.Vector;
import openfl.Lib.getTimer;
import openfl.events.Event;
import openfl.display.Sprite;
import core.Actions;
import core.Vector2;

/**
 * The entry point of the game which initializes the game in its initial state
 */
class Main extends Sprite
{
	private static inline var MIN_ASTEROID_TIME_INCREMENT = 4000;
	private static inline var MAX_ASTEROID_TIME_INCREMENT = 6000;

	private var spaceship:Spaceship;
	private var asteroids:Vector<Asteroid>;
	private var bullets:Vector<Bullet>;

	public function new()
	{
		super();

		stage.color = 0x000000;
		stage.frameRate = 60;

		bullets = Bullet.initBullets(stage);
		asteroids = Asteroid.initAsteroids(stage, asteroids);
		spaceship = new Spaceship(stage, bullets, asteroids);
		Actions.init(stage);
		addEventListener(Event.ENTER_FRAME, onFrame);
	}

	private var lastFrameTime:Int = 0;
	private var lastAsteroidTime:Int = 0;
	private var nextAsteroidTime:Int = 4000;

	private function onFrame(_:Event):Void {
		// Calculates the time since the last frame to set it as the deltaTime
		var currentTime:Int = getTimer();
		var deltaMs:Int = currentTime - lastFrameTime;
		var deltaTime:Float = deltaMs / 1000;
		lastFrameTime = currentTime;

		// Updates every class that needs so
		spaceship.update(deltaTime);

		for (bullet in bullets) {
			bullet.update(deltaTime, asteroids); // A bullet will only update if it's active
		}
		
		// Asteroids are more complex because they have to be created and deleted at runtime
		var i = asteroids.length - 1;
		while (i >= 0) {
			var asteroid = asteroids[i];

			if (asteroid.isAlive) {
				asteroid.update(deltaTime);
				if (asteroid.isHitByBullet) {
					var newSize;
					switch (asteroid.size) {
						case Large: newSize = Medium;
						case Medium: newSize = Small;
						case Small: newSize = Large;
					}
					if (newSize == Large) { // The asteroid is in the smallest size possible, so destroy it
						asteroid.destroy();
					} else { // The asteroid is still big enough, so split it into 2 smaller ones
						var asteroid_1 = new Asteroid(stage, newSize);
						asteroid_1.x = asteroid.x;
						asteroid_1.y = asteroid.y;
						asteroid_1.direction = Vector2.fromAngle(Random.int(-180, 180));
						asteroids.push(asteroid_1);

						var asteroid_2 = new Asteroid(stage, newSize);
						asteroid_2.x = asteroid.x;
						asteroid_2.y = asteroid.y;
						asteroid_2.direction = Vector2.rotateFromAngle(-asteroid_1.direction, Random.int(-30, 30));
						asteroids.push(asteroid_2);

						asteroid.destroy();
					}
					asteroid.isHitByBullet = false;
				}
			} else {
				asteroids.removeAt(i);
			}

			i--;
		}
		
		// Spawns 4 new asteroids when currentTime reaches nextAsteroidTime
		if (currentTime >= nextAsteroidTime) {
			asteroids.push(Asteroid.atScreenBorder(stage));
			asteroids.push(Asteroid.atScreenBorder(stage));
			asteroids.push(Asteroid.atScreenBorder(stage));
			asteroids.push(Asteroid.atScreenBorder(stage));
			nextAsteroidTime += Random.int(MIN_ASTEROID_TIME_INCREMENT, MAX_ASTEROID_TIME_INCREMENT);
		}

		// Sets all of the actions with isJustPressed = true or isJustReleased = true to false to avoid
		// Those properties to carry on to the next frame
		for (action in Actions.actionList.iterator()) {
			action.isJustPressed = false;
			action.isJustReleased = false;
		}
	}
}
