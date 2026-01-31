package states;

import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.system.System;
import core.Actions;
import openfl.display.Stage;
import core.GameState;

class MainMenuState implements GameState{
    private static inline var SELECTED_BUTTON_SCALE:Int = 2;
    private static inline var REGULAR_BUTTON_SCALE:Int = 1;

    private var logo:Bitmap;
    private var playButton:Bitmap;
    private var settingsButton:Bitmap;
    private var quitButton:Bitmap;

    private var selectedButtonIndex:Int = 0;

    public var changeToPlayingState:Bool = false;
    public var changeToSettingsState:Bool = false;

    private function changeButtonToSelected(button:Bitmap) {
        // These values have to be saved in order to correct the button's position later
        var oldWidth:Float = button.width;
        var oldHeight:Float = button.height;

        button.scaleX = SELECTED_BUTTON_SCALE;
        button.scaleY = SELECTED_BUTTON_SCALE;

        var newWidth:Float  = button.width;
        var newHeight:Float = button.height;

        // When the button is scaled its position is messed up, so it has to be corrected
        button.x -= (newWidth - oldWidth) / 2;
        button.y -= (newHeight - oldHeight) / 2;
    }

    private function changeButtonToUnselected(button:Bitmap) {
        // These values have to be saved in order to correct the button's position later
        var oldWidth:Float  = button.width;
        var oldHeight:Float = button.height;

        button.scaleX = REGULAR_BUTTON_SCALE;
        button.scaleY = REGULAR_BUTTON_SCALE;

        var newWidth:Float = button.width;
        var newHeight:Float = button.height;

        // When the button is scaled its position is messed up, so it has to be corrected
        button.x -= (newWidth - oldWidth) / 2;
        button.y -= (newHeight - oldHeight) / 2;
    }

    private var stage:Stage;
    public function new(stage:Stage) {
        this.stage = stage;

        logo = new Bitmap(BitmapData.fromFile("Assets/Logo.png"));
        logo.x = (stage.stageWidth - logo.width) / 2;
        logo.y = 50;

        logo.smoothing = false;

        playButton = new Bitmap(BitmapData.fromFile("Assets/PlayButton.png"));
        playButton.x = (stage.stageWidth - playButton.width) / 2;
        playButton.y = 300;
        playButton.smoothing = false;
        changeButtonToSelected(playButton);

        settingsButton = new Bitmap(BitmapData.fromFile("Assets/SettingsButton.png"));
        settingsButton.x = (stage.stageWidth - settingsButton.width) / 2;
        settingsButton.y = 400;
        settingsButton.smoothing = false;

        quitButton = new Bitmap(BitmapData.fromFile("Assets/QuitButton.png"));
        quitButton.x = (stage.stageWidth - quitButton.width) / 2;
        quitButton.y = 500;
        quitButton.smoothing = false;
    }

    public function enter(_:GameState) {
        stage.addChild(logo);
        stage.addChild(playButton);
        stage.addChild(settingsButton);
        stage.addChild(quitButton);
    }

    public function update(_:Float, _:Float) {
        var indexChanged:Bool = false;

        // Checks if the player pressed the up or down keys to change the selected button
        if (Actions.isActionJustPressed("Accelerate")) {
            indexChanged = true;
            if (selectedButtonIndex == 0) {
                selectedButtonIndex = 2;
            } else {
                selectedButtonIndex--;
            }
        } else if (Actions.isActionJustPressed("Deaccelerate")) {
            indexChanged = true;
            if (selectedButtonIndex == 2) {
                selectedButtonIndex = 0;
            } else {
                selectedButtonIndex++;
            }
        }

        // Sets the correct size for each button based on selectedButtonIndex
        if (indexChanged) {
            switch (selectedButtonIndex) {
                case 0: {
                    changeButtonToSelected(playButton);
                    changeButtonToUnselected(settingsButton);
                    changeButtonToUnselected(quitButton);
                }
                case 1: {
                    changeButtonToSelected(settingsButton);
                    changeButtonToUnselected(playButton);
                    changeButtonToUnselected(quitButton);
                }
                case 2: {
                    changeButtonToSelected(quitButton);
                    changeButtonToUnselected(playButton);
                    changeButtonToUnselected(settingsButton);
                }
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
        stage.removeChild(logo);
        stage.removeChild(playButton);
        stage.removeChild(settingsButton);
        stage.removeChild(quitButton);
    }
}