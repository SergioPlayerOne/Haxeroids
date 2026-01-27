package;

import states.PlayingState;
import openfl.Lib.getTimer;
import openfl.events.Event;
import openfl.display.Sprite;
import core.Actions;
import core.GameStateManager;

enum GameState {
	
}

/**
 * The entry point of the game which initializes the game in its initial state
 */
class Main extends Sprite {
	private var gameStateManager:GameStateManager;

	public function new() {
		super();

		stage.color = 0x000000;
		stage.frameRate = 60;

		Actions.init(stage);
		gameStateManager = new GameStateManager(stage);
		addEventListener(Event.ENTER_FRAME, onFrame);
	}

	private var lastFrameTime:Int = 0;
	private var nextAsteroidTime:Int = 4000;

	private function onFrame(_:Event):Void {
		// Calculates the time since the last frame to set it as the deltaTime
		var gameTime:Int = getTimer();
		var deltaMs:Int = gameTime - lastFrameTime;
		var deltaTime:Float = deltaMs / 1000;
		lastFrameTime = gameTime;

		// Updates the current active scene
		gameStateManager.currentState.update(deltaTime, gameTime);

		// Checks the public variables of the current state
		if (gameStateManager.currentState == gameStateManager.playingState && gameStateManager.playingState.switchToGameOverState) {
			gameStateManager.changeState(gameStateManager.gameOverState);
			gameStateManager.playingState.switchToGameOverState = false;
		}
		else if (gameStateManager.currentState == gameStateManager.gameOverState && gameStateManager.gameOverState.changeToPlayingState) {
			gameStateManager.changeState(gameStateManager.playingState);
			gameStateManager.gameOverState.changeToPlayingState = false;
		}
		else if (gameStateManager.currentState == gameStateManager.gameOverState && gameStateManager.gameOverState.changeToMainMenuState) {
			gameStateManager.changeState(gameStateManager.mainMenuState);
			gameStateManager.gameOverState.changeToMainMenuState = false;
		}
		else if (gameStateManager.currentState == gameStateManager.mainMenuState && gameStateManager.mainMenuState.changeToPlayingState) {
			gameStateManager.changeState(gameStateManager.playingState);
			gameStateManager.mainMenuState.changeToPlayingState = false;
		}
		else if (gameStateManager.currentState == gameStateManager.mainMenuState && gameStateManager.mainMenuState.changeToSettingsState) {
			gameStateManager.changeState(gameStateManager.settingsState);
			gameStateManager.mainMenuState.changeToSettingsState = false;
		}
		else if (gameStateManager.currentState == gameStateManager.settingsState && gameStateManager.settingsState.changeToMainMenuState) {
			gameStateManager.changeState(gameStateManager.mainMenuState);
			gameStateManager.settingsState.changeToMainMenuState = false;
		}

		// Sets all of the actions with isJustPressed = true or isJustReleased = true to false to avoid
		// Those properties to carry on to the next frame
		for (action in Actions.actionList.iterator()) {
			action.isJustPressed = false;
			action.isJustReleased = false;
		}
	}
}
