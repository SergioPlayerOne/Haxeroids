package core;

private class Vector2Default {
    public var x:Float;
    public var y:Float;

    public inline function new(x:Float, y:Float) {
        this.x = x;
        this.y = y;
    }
}

@:forward(x, y)
abstract Vector2(Vector2Default) from Vector2Default to Vector2Default {
    public inline function new(x:Float, y:Float) {
        this = new Vector2Default(x, y);
    }

    public inline function magnitudeSq() {
        return this.x * this.x + this.y * this.y;
    }

    @:op(A + B)
    public static inline function add(a:Vector2, b:Vector2) {
        return new Vector2(a.x + b.x, a.y + b.y);
    }

    @:op(A - B)
    public static inline function sub(a:Vector2, b:Vector2) {
        return new Vector2(a.x - b.x, a.y - b.y);
    }

    @:op(A * B)
    public static inline function mul(a:Vector2, b:Float) {
        return new Vector2(a.x * b, a.y * b);
    }

    public static inline function fromAngle(angle:Float) {
        var rad = (angle - 90) * Math.PI / 180;
        return new Vector2(Math.cos(rad), Math.sin(rad));
    }


    @:op(A > B)
    public static inline function greaterThan(a:Vector2, b:Vector2) {
        return a.magnitudeSq() > b.magnitudeSq();
    }

     @:op(A < B)
    public static inline function lesserThan(a:Vector2, b:Vector2) {
        return a.magnitudeSq() < b.magnitudeSq();
    }
}