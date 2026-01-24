package;

import Random;
import Asteroid.AsteroidSize;
import openfl.Vector;
import openfl.Lib.getTimer;
import openfl.events.Event;
import openfl.display.Sprite;
import core.Actions;

/**
 * The entry point of the game which initializes the game in its initial state
 */
class Main extends Sprite
{
	private static inline var MIN_ASTEROID_TIME_INCREMENT = 5000;
	private static inline var MAX_ASTEROID_TIME_INCREMENT = 7000;

	private var spaceship:Spaceship;
	private var asteroids:Vector<Asteroid>;
	private var bullets:Vector<Bullet>;

	public function new()
	{
		super();

		stage.color = 0x000000;
		stage.frameRate = 60;

		bullets = Bullet.initBullets(stage);
		spaceship = new Spaceship(stage, bullets);
		asteroids = Asteroid.initAsteroids(stage);

		Actions.init(stage);

		addEventListener(Event.ENTER_FRAME, onFrame);
	}

	private var lastFrameTime:Int = 0;
	private var lastAsteroidTime:Int = 0;
	private var nextAsteroidTime:Int = 5000;

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
		for (asteroid in asteroids) {
			asteroid.update(deltaTime);
		}
		
		// Spawns 2 new asteroids when currentTime reaches nextAsteroidTime
		if (currentTime >= nextAsteroidTime) {
			asteroids.push(new Asteroid(stage, AsteroidSize.Large));
			asteroids.push(new Asteroid(stage, AsteroidSize.Large));
			asteroids.push(new Asteroid(stage, AsteroidSize.Large));
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
