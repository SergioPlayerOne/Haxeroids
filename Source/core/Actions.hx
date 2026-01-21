package core;

import haxe.ds.StringMap;
import openfl.ui.Keyboard;
import openfl.events.KeyboardEvent;
import openfl.display.Stage;

/**
 * Represents the state of an action, including if it's currently being pressed and
 * if it has been just pressed or released in the current frame
 */
private typedef ActionState = {
    isJustPressed:Bool,
    isPressed:Bool,
    isJustReleased:Bool
}

/**
 * A class that abstracts input by assining multiple inputs to an action.
 * This can and should be used to support mulitple inputs from different platforms
 */
class Actions {
    public static var actionList:StringMap<ActionState> = new StringMap();

    /**
     * Initializes the actions system
     * @param stage The stage which runs the game
     */
    public static function init(stage:Stage):Void {
        // Adds all of the actions to actionList
        actionList.set("Accelerate", {isJustPressed: false, isPressed: false, isJustReleased: false});
        actionList.set("Deaccelerate", {isJustPressed: false, isPressed: false, isJustReleased: false});
        actionList.set("RotateLeft", {isJustPressed: false, isPressed: false, isJustReleased: false});
        actionList.set("RotateRight", {isJustPressed: false, isPressed: false, isJustReleased: false});
        actionList.set("Shoot", {isJustPressed: false, isPressed: false, isJustReleased: false});

        // Binds all of the events to their respective actions
        stage.addEventListener(KeyboardEvent.KEY_DOWN, updateActionsOnEnter);
        stage.addEventListener(KeyboardEvent.KEY_UP, updateActionsOnRelease);
    }

    /**
     * Fires every time a key is pressed
     *
     * init() must be called in order to bind this action to the KEY_DOWN event
     */
    private static function updateActionsOnEnter(event:KeyboardEvent):Void {
        if (event.keyCode == Keyboard.W || event.keyCode == Keyboard.UP) {
            setActionAsEntered("Accelerate");
        }
        else if (event.keyCode == Keyboard.S || event.keyCode == Keyboard.DOWN) {
            setActionAsEntered("Deaccelerate");
        }
        else if (event.keyCode == Keyboard.A || event.keyCode == Keyboard.LEFT) {
            setActionAsEntered("RotateLeft");
        }
        else if (event.keyCode == Keyboard.D || event.keyCode == Keyboard.RIGHT) {
            setActionAsEntered("RotateRight");
        }
        else if (event.keyCode == Keyboard.SPACE) {
            setActionAsEntered("Shoot");
        }
    }

    /**
     * Fires every time a key is pressed
     *
     * init() must be called in order to bind this action to the KEY_DOWN event
     */
    private static function updateActionsOnRelease(event:KeyboardEvent):Void {
        if (event.keyCode == Keyboard.W || event.keyCode == Keyboard.UP) {
            setActionAsReleased("Accelerate");
        }
        else if (event.keyCode == Keyboard.S || event.keyCode == Keyboard.DOWN) {
            setActionAsReleased("Deaccelerate");
        }
        else if (event.keyCode == Keyboard.A || event.keyCode == Keyboard.LEFT) {
            setActionAsReleased("RotateLeft");
        }
        else if (event.keyCode == Keyboard.D || event.keyCode == Keyboard.RIGHT) {
            setActionAsReleased("RotateRight");
        }
        else if (event.keyCode == Keyboard.SPACE) {
            setActionAsReleased("Shoot");
        }
    }

    /**
     * Sets a given action as {isJustPressed = true, isPressed = true, isJustReleased = false}
     *
     * The function won't do anything if isPressed = true. This is to avoid repeats of the KEY_DOWN
     * event from interfiering with the functionality
     *
     * isJustPressed must be set back to false at the end of the game loop
     *
     * @param action The action to set as entered
     */
    private static function setActionAsEntered(action:String):Void {
        var actionState = actionList.get(action);
        if (!actionState.isPressed) {
            actionState.isJustPressed = true;
            actionState.isPressed = true;
            actionState.isJustReleased = false;
        }
    }
    
    /**
     * Sets a given action as {isJustPressed = false, isPressed = false, isJustReleased = true}
     *
     * The function won't do anything if isPressed = true. This is to avoid repeats of the KEY_UP
     * event from interfiering with the functionality
     *
     * isJustReleased must be set back to false at the end of the game loop
     *
     * @param action The action to set as released
     */
    private static function setActionAsReleased(action:String):Void {
        var actionState = actionList.get(action);
        if (actionState.isPressed) {
            actionState.isJustPressed = false;
            actionState.isPressed = false;
            actionState.isJustReleased = true;
        }
    }

    /**
     * Checks if a given action was just pressed during this frame.
     *
     * @param action The action to check for
     * @return true if the given action has isJustPressed = true, otherwise false
     */
    public static function isActionJustPressed(action:String):Bool {
        return actionList.get(action).isJustPressed;
    }

    /**
     * Checks if a given action is being pressed during this frame.
     *
     * @param action The action to check for
     * @return true if the given action has isPressed = true, otherwise false
     */
    public static function isActionPressed(action:String):Bool {
        return actionList.get(action).isPressed;
    }

     /**
     * Checks if a given action has been released during this frame.
     *
     * @param action The action to check for
     * @return true if the given action has isJustReleased = true, otherwise false
     */
    public static function isActionJustReleased(action:String):Bool {
        return actionList.get(action).isJustReleased;
    }
}