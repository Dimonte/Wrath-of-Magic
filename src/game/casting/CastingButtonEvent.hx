package game.casting;
import nme.display.InteractiveObject;
import nme.events.Event;
import nme.events.MouseEvent;

/**
 * ...
 * @author Dmitriy Barabanschikov
 */

class CastingButtonEvent extends MouseEvent
{

	static public inline var BUTTON_OVER:String = "buttonOver";
	static public inline var BUTTON_OUT:String = "buttonOut";
	
	public function new(type:String, ?bubbles:Bool = true, ?cancelable:Bool = false, ?localX:Float = 0, ?localY:Float = 0, ?relatedObject:InteractiveObject = null)
	{
		super(type, bubbles, cancelable, localX, localY, relatedObject);
	}
	
	override public function clone():Event
	{
		return new CastingButtonEvent(type, bubbles, cancelable, localX, localY, relatedObject);
	}
	
}