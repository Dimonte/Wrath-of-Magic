package game.casting;
import haxe.ds.GenericStack;
import nme.display.BitmapData;
import nme.events.MouseEvent;

/**
 * ...
 * @author Dmitriy Barabanschikov
 */

class BaseButton extends AlphaButton
{
	private var dependentButtons:GenericStack<ButtonWrapper>;

	public function new(?up:BitmapData = null, ?hitTest:BitmapData = null) 
	{
		super();
		dependentButtons = new GenericStack<ButtonWrapper>();
		if (up != null) 
		{
			upStateData = up;
		}
		if (up != null) 
		{
			hitTestData = up;
		}
	}
	
	public function addDependentButton(button:AlphaButton, xModifier:Float, yModifier:Float):Void
	{
		dependentButtons.add(new ButtonWrapper(button, xModifier, yModifier));
	}
	
	override private function set_selected(value:Bool):Bool 
	{
		for (dependentButtonWrapper in dependentButtons) 
		{
			if (value && !dependentButtonWrapper.button.visible)
			{
				dependentButtonWrapper.button.alpha = 0;
				dependentButtonWrapper.button.getToAlpha(value ? 1 : 0);
			}
			dependentButtonWrapper.button.visible = value;
			dependentButtonWrapper.button.selected = false;
			dependentButtonWrapper.button.x = x + dependentButtonWrapper.xMod;
			dependentButtonWrapper.button.y = y + dependentButtonWrapper.yMod;
		}
		
		//alpha = value ? 1 : 0.5;
		
		return super.set_selected(value);
	}
	
}