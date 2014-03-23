package game.casting;
import game.casting.AlphaButton;

/**
 * ...
 * @author Dmitriy Barabanschikov
 */

class ButtonWrapper 
{
	public var button:AlphaButton;
	public var xMod:Float;
	public var yMod:Float;

	public function new(button:AlphaButton, xMod:Float, yMod:Float) 
	{
		this.button = button;
		this.xMod = xMod;
		this.yMod = yMod;
	}
	
}