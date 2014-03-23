package game.casting;
import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.display.Sprite;
import nme.events.Event;
import nme.events.MouseEvent;
import motion.Actuate;

/**
 * ...
 * @author Dmitriy Barabanschikov
 */

class AlphaButton extends Sprite
{
	private var _minAlpha:Int;
	
	private function get_minAlpha():Int 
	{
		return _minAlpha;
	}
	
	private function set_minAlpha(value:Int):Int 
	{
		return _minAlpha = value;
	}
	
	public var minAlpha(get_minAlpha, set_minAlpha):Int;
	
	private var _upStateData:BitmapData;
	
	private function get_upStateData():BitmapData 
	{
		return _upStateData;
	}
	
	private function set_upStateData(value:BitmapData):BitmapData 
	{
		_upStateData = value;
		updateState();
		return _upStateData;
	}
	
	public var upStateData(get_upStateData, set_upStateData):BitmapData;
	
	
	private var _overStateData:BitmapData;
	
	private function get_overStateData():BitmapData 
	{
		return _overStateData;
	}
	
	private function set_overStateData(value:BitmapData):BitmapData 
	{
		_overStateData = value;
		updateState();
		return _overStateData;
	}
	
	public var overStateData(get_overStateData, set_overStateData):BitmapData;
	
	private var _selectedStateData:BitmapData;
	
	private function get_selectedStateData():BitmapData 
	{
		return _selectedStateData;
	}
	
	private function set_selectedStateData(value:BitmapData):BitmapData 
	{
		_selectedStateData = value;
		updateState();
		return _selectedStateData;
	}
	
	public var selectedStateData(get_selectedStateData, set_selectedStateData):BitmapData;
	
	private var _hitTestData:BitmapData;
	
	private function get_hitTestData():BitmapData 
	{
		return _hitTestData;
	}
	
	private function set_hitTestData(value:BitmapData):BitmapData 
	{
		return _hitTestData = value;
	}
	
	public var hitTestData(get_hitTestData, set_hitTestData):BitmapData;
	
	private var _selected:Bool;
	
	private function get_selected():Bool 
	{
		return _selected;
	}
	
	private function set_selected(value:Bool):Bool 
	{
		return _selected = value;
	}
	
	public var selected(get_selected, set_selected):Bool;
	
	private var over:Bool;
	private var down:Bool;
	private var mouseDown:Bool;
	private var stateHolder:Bitmap;

	public function new() 
	{
		minAlpha = 128;
		super();
		addEventListener(MouseEvent.CLICK, clickHandler);
		addEventListener(MouseEvent.ROLL_OVER, rollOverHandler, false, 999);
		addEventListener(MouseEvent.ROLL_OUT, rollOutHandler, false, 999);
		stateHolder = new Bitmap();
		stateHolder.smoothing = true;
		addChild(stateHolder);
		
		//BUG hack
		addEventListener(Event.ENTER_FRAME, enterFrameHandler);
	}
	
	private function rollOutHandler(e:MouseEvent):Void 
	{
		e.stopImmediatePropagation();
		//removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
	}
	
	private function rollOverHandler(e:MouseEvent):Void 
	{
		e.stopImmediatePropagation();
	}
	
	private function updateState() 
	{
		if (over && overStateData != null) 
		{
			stateHolder.bitmapData = overStateData;
		}
		else if (selected && selectedStateData != null) 
		{
			stateHolder.bitmapData = selectedStateData;
		}
		else 
		{
			stateHolder.bitmapData = upStateData;
		}
	}
	
	private function enterFrameHandler(e:Event):Void 
	{
		//BUG hack
		if (visible && checkMouseAgainstHitTestState()) 
		{
			if (!over) 
			{
				over = true;
				dispatchEvent(new CastingButtonEvent(CastingButtonEvent.BUTTON_OVER, true, false, mouseX, mouseY, this));
			}
		}
		else 
		{
			if (over) 
			{
				over = false;
				dispatchEvent(new CastingButtonEvent(CastingButtonEvent.BUTTON_OUT, true, false, mouseX, mouseY, this));
			}
		}
		
		updateState();
	}
	
	private function clickHandler(e:MouseEvent):Void 
	{
		if (!checkMouseAgainstHitTestState())
		{
			e.stopImmediatePropagation();
		}
	}
	
	private function checkMouseAgainstHitTestState():Bool
	{
		var testData:BitmapData = hitTestData != null ? hitTestData : upStateData;
		if (testData == null) 
		{
			return false;
		}
		var alphaValue:Int = testData.getPixel32(Std.int(mouseX), Std.int(mouseY)) >>> 24;
		if (alphaValue >= minAlpha) 
		{
			return true;
		}
		return false;
	}
	
	public function getToAlpha(value:Float):Void
	{
		Actuate.tween(this, 1, { alpha: value }, false);
	}
	
}