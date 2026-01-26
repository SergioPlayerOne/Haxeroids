package core;

import states.GameOverState;
import openfl.display.Stage;
import states.PlayingState;

class GameStateManager {
    private var stage:Stage;
    public var currentState:GameState;

    public var playingState:PlayingState;
    public var gameOverState:GameOverState;

    public function new(stage:Stage) {
        playingState = new PlayingState(stage);
        gameOverState = new GameOverState(stage);

        currentState = playingState;
        currentState.enter(playingState);
    }

    public function changeState(newGameState:GameState) {
        currentState.exit(newGameState);
        trace(currentState);
        trace(newGameState);
        newGameState.enter(currentState);
        currentState = newGameState;
    }
}