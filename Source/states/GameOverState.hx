package states;

import core.Actions;
import openfl.display.Stage;
import core.GameState;

class GameOverState implements GameState {
    private var stage:Stage;
<<<<<<< HEAD
    private var previousState:GameState;
    public var changeToPlayingState:Bool = false;
=======
    public var changeToPlayingState:Bool = false;
    public var changeToMainMenuState:Bool = false;
>>>>>>> dev

    public function new(stage:Stage) this.stage = stage;

    public function enter(previousState:GameState) {
<<<<<<< HEAD
        trace("Game over. Press <Space> to restart");
        this.previousState = previousState;
    }

    public function update(deltaTime:Float, gameTime:Float) {
        // Still updates the PlayingState so that asteroids keep moving

        if (Actions.isActionJustPressed("Shoot")) {
            changeToPlayingState = true;
        }
=======

    }

    public function update(deltaTime:Float, gameTime:Float) {
        if (Actions.isActionJustPressed("Shoot")) {
            changeToPlayingState = true;
        }
        else if (Actions.isActionJustPressed("UI_Back")) {
            changeToMainMenuState = true;
        }
>>>>>>> dev
    }

    public function exit(newState:GameState) {
        
    }
}