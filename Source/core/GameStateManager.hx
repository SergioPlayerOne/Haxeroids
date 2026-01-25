package core;

import openfl.display.Stage;
import states.PlayingState;

class GameStateManager {
    private var stage:Stage;
    private var currentState:GameState;

    private var playingState:PlayingState;

    public function new(stage:Stage) {
        playingState = new PlayingState(stage);

        currentState = playingState;
    }

    public function changeState(newGameState:GameState) {
        currentState.exit(newGameState);
        currentState = newGameState;
        currentState.enter();
    }
}