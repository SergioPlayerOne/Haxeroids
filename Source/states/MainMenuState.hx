package states;

import openfl.system.System;
import openfl.Lib;
import core.Actions;
import openfl.display.Stage;
import core.GameState;

class MainMenuState implements GameState{
    private var selectedButtonIndex:Int = 0;

    public var changeToPlayingState:Bool = false;
    public var changeToSettingsState:Bool = false;

    private var stage:Stage;
    public function new(stage:Stage) this.stage = stage;

    public function enter(_:GameState) {

    }

    public function update(_:Float, _:Float) {
        if (Actions.isActionJustPressed("Accelerate")) {
            if (selectedButtonIndex == 0) {
                selectedButtonIndex = 2;
            } else {
                selectedButtonIndex--;
            }
        } else if (Actions.isActionJustPressed("Deaccelerate")) {
            if (selectedButtonIndex == 2) {
                selectedButtonIndex = 0;
            } else {
                selectedButtonIndex++;
            }
        }

        // If a button is pressed, switches to the correct scene depending on selectedButtonIndex
        if (Actions.isActionJustPressed("Shoot")) {
            if (selectedButtonIndex == 0) { // Play
                changeToPlayingState = true;
            } else if (selectedButtonIndex == 1) { // Settings
                changeToSettingsState = true;
            } else { // Quit
                System.exit(0);
            }
        }
    }

    public function exit(_:GameState) {
        
    }
}