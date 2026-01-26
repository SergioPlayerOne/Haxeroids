package core;

import openfl.display.Stage;

/**
 * Represents a state of the game, containing everything it needs to run properly
 */
interface GameState {
    private var stage:Stage;
    public function enter(previousState:GameState):Void;
    public function update(deltaTime:Float, gameTime:Float):Void;
    public function exit(newState:GameState):Void;
}