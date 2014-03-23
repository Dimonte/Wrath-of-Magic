package game.casting;
import game.casting.spells.SpellBase;
import nme.display.BitmapData;

/**
 * ...
 * @author Dmitriy Barabanschikov
 */

class SpellButton extends AlphaButton
{
	public var spell:SpellBase;

	public function new(?up:BitmapData = null, ?hitTest:BitmapData = null) 
	{
		super();
		if (up != null) 
		{
			upStateData = up;
		}
		if (hitTest != null) 
		{
			hitTestData = hitTest;
		}
	}
	
	override private function set_selected(value:Bool):Bool 
	{
		//alpha = value ? 1 : 0.5;
		return super.set_selected(value);
	}
	
}