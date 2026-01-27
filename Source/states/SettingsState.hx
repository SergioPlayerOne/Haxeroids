package states;

import core.Actions;
import openfl.display.Stage;
import core.GameState;

class SettingsState implements GameState {
    public var changeToMainMenuState:Bool = false;
    
    private var stage:Stage;
    public function new(stage:Stage) this.stage = stage;

    public function enter(previousState:GameState):Void {

    }

    public function update(deltaTime:Float, gameTime:Float):Void {
        if (Actions.isActionJustPressed("UI_Back")) {
            changeToMainMenuState = true;
        }
    }

    public function exit(newState:GameState):Void {

    }
}