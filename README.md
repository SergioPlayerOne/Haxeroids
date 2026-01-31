# Haxeroids

## What is this?

Haxeroids is a simple recreation of the arcade game Asteroids made in Haxe with OpenFL. This was made by me as a learning exercise to learn how to finish projects (which I might have partially failed at...) and how to code games without a game engine.

## Controls

- W: Move your spaceship forward.
- A/D: Rotate the spaceship counterclockwise or clockwise respectively.
- S: Decelerate your spaceship faster than by simply not accelerating.
- Space: Shoot bullets from your spaceship.
- Escape: (In UIs) Go back.

## Experience with Haxe + OpenFL

The overall experience of making this game were great: OpenFL is high level enough so that you don't reinvent the wheel while still providing some low-level access to allow you to build your own systems to make the game run. It was really fun for the most part, and I wish I can keep using game frameworks instead of game engines for my future projects. However, I feel that other frameworks (Eg. MonoGame, Raylib...) provide a much better low-level access with the tradeoff of them being more complicated to use, which is something I prefer. I think Haxe + OpenFL is the perfect start for anyone wanting to make games without a game engine, but for me at least, it will just be temporary (I'd like to try out Raylib next).

## IMPORTANT DISCLAIMER

The code of this game is bad, like... REALLY BAD. Don't take this as a good learning resource, but rather as an example of how a project can escalate in complexity faster than you imagined, resulting in poor code. As this is a learning project that I wanted to finish quickly, I won't refactor the code.

Also, the game isn't finished (who would've thought...), as there are still missing textures and sound effects, I just got burned out of making all of these and having to implement them in my horrible code. I might go back and add the missing sprites in the future, but I don't think I will. Still, the game is playable, so that's still a win for me.

## How to run

- 1: Clone this repository.
- 2: Install Haxe and OpenFL.
- 3: Run openfl test <platform> (only desktop, Neko and Hashlink are supported).