package ;

import assets.GraphicsLibrary;
import nme.display.Sprite;
import nme.display.StageAlign;
import nme.display.StageScaleMode;
import nme.events.Event;
import nme.Lib;

/**
 * ...
 * @author Dmitriy Barabanschikov
 */

class Main extends Sprite
{
	private var theatre:Theatre;
	private var oldScale:Float;
	
	static public function main() 
	{
		var stage = Lib.current.stage;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.align = StageAlign.TOP_LEFT;
		// entry point
		Lib.current.addChild(new Main());
	}
	
	public function new()
	{
		super ();
		
		if (stage == null )
		{
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		else 
		{
			addedToStageHandler();
		}
	}
	
	private function addedToStageHandler(?e:Event = null):Void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		initialize ();
		construct ();
	}
	
	private function initialize() 
	{
		GraphicsLibrary.initialize();
	}
	
	private function construct() 
	{
		theatre = new Theatre();
		addChild(theatre);
		
		addEventListener(Event.ENTER_FRAME, enterFrameHandler);
	}
	
	private function enterFrameHandler(e:Event):Void 
	{
		theatre.update();
		
		
		var xMod:Float = Lib.current.stage.stageWidth / 800;
		var yMod:Float = Lib.current.stage.stageHeight / 480;
		var scale:Float = Math.min(xMod, yMod);
		
		if (scale == oldScale) 
		{
			return;
		}
		
		oldScale = scale;
		theatre.scaleX = theatre.scaleY = scale;
		theatre.x = Std.int((Lib.current.stage.stageWidth - 800*scale) / 2);
		theatre.y = Std.int((Lib.current.stage.stageHeight - 480*scale) / 2);
	}
	
}