package game.casting.spells.wallOfFireAssets;
import game.casting.spells.CastAgent;
import game.casting.spells.wallOfFireAssets.Flame;
import game.KillingField;

/**
 * ...
 * @author Dmitriy Barabanschikov
 */

class WallOfFireCastAgent extends CastAgent
{
	private var flamesStarted:Int;
	private var lastFlameX:Float;
	private var lastFlameY:Float;
	private var framesSinceLastFlame:Int;

	public function new() 
	{
		super();
		flamesStarted = 0;
		framesSinceLastFlame = 0;
	}
	
	override public function applyEffectToWorld(world:KillingField, worldX:Float, worldY:Float):Void 
	{
		var distanceSquared:Float = Math.pow((worldX - lastFlameX), 2) + Math.pow((worldY - lastFlameY), 2);
		if (distanceSquared> 2000 || !(flamesStarted > 0) || framesSinceLastFlame > 10) 
		{
			addFlameToWorld(world, worldX, worldY);
		}
		framesSinceLastFlame++;
		if (flamesStarted >= 6) 
		{
			depleted = true;
		}
	}
	
	private function addFlameToWorld(world:KillingField, worldX:Float, worldY:Float):Void
	{
		
		var flame:Flame = new Flame();
		flame.x = worldX;
		flame.y = worldY;
		world.addSpellEffect(flame);
		
		
		lastFlameX = worldX;
		lastFlameY = worldY;
		flamesStarted++;
		framesSinceLastFlame = 0;
	}
	
}