package game.casting.spells.meteorAssets;
import assets.GraphicsLibrary;
import game.GameEntity;

/**
 * ...
 * @author Dmitriy Barabanschikov
 */

class Meteor extends GameEntity
{

	public function new() 
	{
		super();
		
		graphicsAsset = GraphicsLibrary.getMeteor();
	}
	
	override public function update():Void 
	{
		super.update();
		
		var chanceOfSmoke:Float = Math.max(0, (altitude - 100) / 500);
		
		while(Std.random(1) < chanceOfSmoke)
		{
			var smokeTrail:SmokeTrail = new SmokeTrail();
			smokeTrail.x = x;
			smokeTrail.y = y + Std.random(4) - 2;
			smokeTrail.altSpeed = -10;
			smokeTrail.altitude = altitude + 30 + Std.random(20);
			smokeTrail.speed.x = Std.random(20) - 10;
			world.addSpellEffect(smokeTrail);
			chanceOfSmoke -= 0.1;
		}
		
		if (altitude <= 0 && y >= 0 && y <= 480) 
		{
			var explosion:Explosion = new Explosion();
			explosion.x = x;
			explosion.y = y;
			world.addSpellEffect(explosion);
			dead = true;
			
			var numParticles:Int = Std.random(50) + 50;
			for (i in 0...numParticles)
			{
				var particle:FlameParticle = new FlameParticle();
				particle.x = x;
				particle.y = y;
				particle.speed.x = Math.random() * 8 -4;
				particle.speed.y = Math.random() * 8 -4;
				particle.altSpeed = Math.random() * 10 + 10;
				particle.altitude = 10;
				world.addSpellEffect(particle);
			}
		}
		
		if (altitude < -200) 
		{
			dead = true;
		}
		
	}
	
}