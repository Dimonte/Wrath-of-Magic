package game.casting.spells.meteorAssets;
import assets.GraphicsLibrary;
import game.GameEntity;

/**
 * ...
 * @author Dmitriy Barabanschikov
 */

class MeteorReticle extends GameEntity
{
	private var i:Int;

	public function new() 
	{
		super();
		graphicsAsset = GraphicsLibrary.getMeteorReticle();
	}
	
	override public function update():Void 
	{
		super.update();
		frameRectNum = Std.int(i / 5);
		i++;
		if (i > 25) 
		{
			dead = true;
		}
	}
	
}