package game.casting.spells.meteorAssets;
import assets.GraphicsLibrary;
import game.GameEntity;

/**
 * ...
 * @author Dmitriy Barabanschikov
 */

class FlameParticle extends GameEntity
{

	public function new() 
	{
		super();
		graphicsAsset = GraphicsLibrary.getFlameParticleAsset();
	}
	
	override public function update():Void 
	{
		altSpeed -= 0.9;
		
		if (altitude < 0) 
		{
			dead = true;
		}
	}
	
}