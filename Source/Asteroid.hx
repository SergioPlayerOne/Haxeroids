import openfl.display.Stage;
import openfl.display.Sprite;

class Asteroid extends Sprite{
    public function new(stage:Stage) {
        super();

        graphics.beginFill(0x5C5C5C);
        graphics.drawCircle(0, 0, 40);
        graphics.endFill();
        this.x = (stage.stageWidth / 2) + 400;
        this.y = (stage.stageHeight / 2) - 100;
        stage.addChild(this);
    }
}