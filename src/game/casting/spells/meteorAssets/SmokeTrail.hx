package game.casting.spells.meteorAssets;
import assets.GraphicsLibrary;
import game.GameEntity;

/**
 * ...
 * @author Dmitriy Barabanschikov
 */

class SmokeTrail extends GameEntity
{
	private var i:Int;
	private var frameLength:Int;

	public function new() 
	{
		super();
		graphicsAsset = GraphicsLibrary.getMeteorSmokeTrail();
		frameLength = Std.int(Std.random(5) + 4);
	}
	
	override public function update():Void 
	{
		speed.x *= 0.9;
		altSpeed *= 0.9;
		
		super.update();
		frameRectNum = Std.int(i / frameLength);
		graphicsAlpha = (1 - i / (frameLength * 5));
		i++;
		if (i > frameLength*5) 
		{
			dead = true;
		}
	}
	
}