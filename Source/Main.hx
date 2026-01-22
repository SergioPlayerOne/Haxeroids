package;

import openfl.Lib.getTimer;
import openfl.events.Event;
import openfl.display.Sprite;
import core.Actions;

/**
 * The entry point of the game which initializes the game in its initial state
 */
class Main extends Sprite
{
	var spaceship:Spaceship;
	var bullet:Bullet;

	public function new()
	{
		super();

		stage.color = 0x000000;
		stage.frameRate = 60;

		spaceship = new Spaceship(stage);
		bullet = new Bullet(stage);

		Actions.init(stage);

		addEventListener(Event.ENTER_FRAME, onFrame);
	}

	private var lastTime:Int = 0;

	private function onFrame(_:Event):Void {
		// Calculates the time since the last frame to set it as the deltaTime
		var currentTime:Int = getTimer();
		var deltaMs:Int = currentTime - lastTime;
		var deltaTime:Float = deltaMs / 1000;
		lastTime = currentTime;

		// Updates the spaceship
		spaceship.update(deltaTime);

		// Sets all of the actions with isJustPressed = true or isJustReleased = true to false to avoid
		// Those properties to carry on to the next frame
		for (action in Actions.actionList.iterator()) {
			action.isJustPressed = false;
			action.isJustReleased = false;
		}
	}
}
