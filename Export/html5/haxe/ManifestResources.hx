package;

import haxe.io.Bytes;
import haxe.io.Path;
import lime.utils.AssetBundle;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import lime.utils.Assets;

#if sys
import sys.FileSystem;
#end

#if disable_preloader_assets
@:dox(hide) class ManifestResources {
	public static var preloadLibraries:Array<Dynamic>;
	public static var preloadLibraryNames:Array<String>;
	public static var rootPath:String;

	public static function init (config:Dynamic):Void {
		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();
	}
}
#else
@:access(lime.utils.Assets)


@:keep @:dox(hide) class ManifestResources {


	public static var preloadLibraries:Array<AssetLibrary>;
	public static var preloadLibraryNames:Array<String>;
	public static var rootPath:String;


	public static function init (config:Dynamic):Void {

		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();

		rootPath = null;

		if (config != null && Reflect.hasField (config, "rootPath")) {

			rootPath = Reflect.field (config, "rootPath");

			if(!StringTools.endsWith (rootPath, "/")) {

				rootPath += "/";

			}

		}

		if (rootPath == null) {

			#if (ios || tvos || webassembly)
			rootPath = "assets/";
			#elseif android
			rootPath = "";
			#elseif (console || sys)
			rootPath = lime.system.System.applicationDirectory;
			#else
			rootPath = "./";
			#end

		}

		#if (openfl && !flash && !display)
		
		#end

		var data, manifest, library, bundle;

<<<<<<< HEAD
=======
		data = '{"name":null,"assets":"aoy4:pathy17:assets%2FLogo.pngy4:sizei8664y4:typey5:IMAGEy2:idR1y7:preloadtgoR0y23:assets%2FPlayButton.pngR2i630R3R4R5R7R6tgoR0y23:assets%2FQuitButton.pngR2i519R3R4R5R8R6tgoR0y27:assets%2FSettingsButton.pngR2i645R3R4R5R9R6tgh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("default", library);
>>>>>>> dev
		

		

	}


}

#if !display
#if flash

<<<<<<< HEAD
=======
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_logo_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_playbutton_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_quitbutton_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_settingsbutton_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__manifest_default_json extends null { }
>>>>>>> dev


#elseif (desktop || cpp)

<<<<<<< HEAD
=======
@:keep @:image("Assets/Logo.png") @:noCompletion #if display private #end class __ASSET__assets_logo_png extends lime.graphics.Image {}
@:keep @:image("Assets/PlayButton.png") @:noCompletion #if display private #end class __ASSET__assets_playbutton_png extends lime.graphics.Image {}
@:keep @:image("Assets/QuitButton.png") @:noCompletion #if display private #end class __ASSET__assets_quitbutton_png extends lime.graphics.Image {}
@:keep @:image("Assets/SettingsButton.png") @:noCompletion #if display private #end class __ASSET__assets_settingsbutton_png extends lime.graphics.Image {}
@:keep @:file("") @:noCompletion #if display private #end class __ASSET__manifest_default_json extends haxe.io.Bytes {}
>>>>>>> dev



#else



#end

#if (openfl && !flash)

#if html5

#else

#end

#end
#end

#end