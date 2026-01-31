package core;

import states.SettingsState;
import states.MainMenuState;
import states.GameOverState;
import openfl.display.Stage;
import states.PlayingState;

class GameStateManager {
    private var stage:Stage;
    public var currentState:GameState;

    public var mainMenuState:MainMenuState;
    public var settingsState:SettingsState;
    public var playingState:PlayingState;
    public var gameOverState:GameOverState;

    public function new(stage:Stage) {
        mainMenuState = new MainMenuState(stage);
        settingsState = new SettingsState(stage);
        playingState = new PlayingState(stage);
        gameOverState = new GameOverState(stage);

        currentState = mainMenuState;
        currentState.enter(playingState);
    }

    public function changeState(newGameState:GameState) {
        currentState.exit(newGameState);
        newGameState.enter(currentState);
        currentState = newGameState;
    }
}