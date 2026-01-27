package states;

import core.Actions;
import openfl.display.Stage;
import core.GameState;

class GameOverState implements GameState {
    private var stage:Stage;
    public var changeToPlayingState:Bool = false;
    public var changeToMainMenuState:Bool = false;

    public function new(stage:Stage) this.stage = stage;

    public function enter(previousState:GameState) {

    }

    public function update(deltaTime:Float, gameTime:Float) {
        if (Actions.isActionJustPressed("Shoot")) {
            changeToPlayingState = true;
        }
        else if (Actions.isActionJustPressed("UI_Back")) {
            changeToMainMenuState = true;
        }
    }

    public function exit(newState:GameState) {
        
    }
}