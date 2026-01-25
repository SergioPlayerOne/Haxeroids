package states;

import openfl.display.Stage;
import core.GameState;
import core.Vector2;
import entities.Spaceship;
import entities.Bullet;
import entities.Asteroid;

class PlayingState implements GameState{
    private static inline var MIN_ASTEROID_TIME_INCREMENT = 4000;
	private static inline var MAX_ASTEROID_TIME_INCREMENT = 6000;

    private var stage:Stage;
    private var spaceship:Spaceship;
    private var bullets:Array<Bullet>;
    private var asteroids:Array<Asteroid>;

    public function new(stage:Stage) this.stage = stage;

    public function enter():Void {
        this.bullets = Bullet.initBullets(stage);
        this.asteroids = Asteroid.initAsteroids(stage, asteroids);
        this.spaceship = new Spaceship(stage, bullets, asteroids);
    }

    private var nextAsteroidTime = 4000;
    public function update(deltaTime:Float, gameTime:Float):Void {
        spaceship.update(deltaTime);

        for (bullet in bullets) {
            bullet.update(deltaTime, asteroids); // Bullets will only update themselves if they're active
        }

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
				asteroids.splice(i, 1);
			}
			i--;
		}

        // Spawns 4 new asteroids when currentTime reaches nextAsteroidTime
		if (gameTime >= nextAsteroidTime) {
			for (i in 0...4) {
                asteroids.push(Asteroid.atScreenBorder(stage));
            }
			nextAsteroidTime += Random.int(MIN_ASTEROID_TIME_INCREMENT, MAX_ASTEROID_TIME_INCREMENT);
		}
    }

    public function exit(newState:GameState):Void {
        trace("Exited playing state");
    }
}