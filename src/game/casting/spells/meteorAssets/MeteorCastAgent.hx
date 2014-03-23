package game.casting.spells.meteorAssets;
import game.casting.spells.CastAgent;
import game.KillingField;

/**
 * ...
 * @author Dmitriy Barabanschikov
 */

class MeteorCastAgent extends CastAgent
{
	private var meteorsSent:Int;
	private var lastMeteorX:Float;
	private var lastMeteorY:Float;
	private var framesSinceLastMeteor:Int;

	public function new() 
	{
		super();
		meteorsSent = 0;
	}
	
	override public function applyEffectToWorld(world:KillingField, worldX:Float, worldY:Float):Void 
	{
		if (framesSinceLastMeteor % 5 == 0) 
		{
			addMeteorToWorld(world, worldX, worldY);
		}
		else
		{
			var distanceSquared:Float = Math.pow((worldX - lastMeteorX), 2) + Math.pow((worldY - lastMeteorY), 2);
			if (distanceSquared + framesSinceLastMeteor * 200 > 10000) 
			{
				addMeteorToWorld(world, worldX, worldY);
			}
		}
		framesSinceLastMeteor++;
		if (meteorsSent >= 3) 
		{
			depleted = true;
		}
	}
	
	private function addMeteorToWorld(world:KillingField, worldX:Float, worldY:Float):Void
	{
		//worldY = Math.min(480, Math.max(0, worldY));
		
		var reticle:MeteorReticle = new MeteorReticle();
		reticle.x = worldX;
		reticle.y = worldY;
		world.addSpellEffect(reticle);
		
		var meteor:Meteor = new Meteor();
		//meteor.x = worldX - 240;
		meteor.x = worldX;
		meteor.y = worldY;
		SOSLog.sosTrace( "meteor.y : " + meteor.y );
		meteor.altitude = 560;
		meteor.altSpeed = -28;
		world.addSpellEffect(meteor);
		
		
		lastMeteorX = worldX;
		lastMeteorY = worldY;
		framesSinceLastMeteor = 0;
		meteorsSent++;
	}
	
}