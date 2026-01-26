package states;

import core.Actions;
import openfl.display.Stage;
import core.GameState;

class GameOverState implements GameState {
    private var stage:Stage;
    private var previousState:GameState;
    public var changeToPlayingState:Bool = false;

    public function new(stage:Stage) this.stage = stage;

    public function enter(previousState:GameState) {
        trace("Game over. Press <Space> to restart");
        this.previousState = previousState;
    }

    public function update(deltaTime:Float, gameTime:Float) {
        // Still updates the PlayingState so that asteroids keep moving

        if (Actions.isActionJustPressed("Shoot")) {
            changeToPlayingState = true;
        }
    }

    public function exit(newState:GameState) {
        
    }
}