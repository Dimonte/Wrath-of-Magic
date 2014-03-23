package game;

import assets.animations.goblinAnimations.GoblinAttacking;
import game.faunaInfesta.BehaviourState;
import sphaeraGravita.collision.PhysicalBody;
import sphaeraGravita.shapes.BaseShape;
import assets.animations.goblinAnimations.GoblinDying;
import assets.animations.goblinAnimations.GoblinWalking;
import assets.GraphicsLibrary;
import flash.geom.Rectangle;
import game.GameEntity;
import sphaeraGravita.math.Vector2D;
import sphaeraGravita.shapes.CircleShape;
/**
 * ...
 * @author Dmitriy Barabanschikov
 */
class Goblin extends Enemy
{
	private var state:String;
	private var target:GameEntity;
	public var desiredSpeed:Vector2D;
	
	private var mass:Float;
	
	public var hp:Int;
	
	public function new() 
	{
		super(); 
		mass = 4;
		hp = Std.int(Math.random()*50) + 20;
		
		graphicsAsset = GraphicsLibrary.getGoblin();
		animation = new GoblinWalking();
		
		collisionCategory = CollisionCategory.ENEMIES;
		collisionMask = CollisionCategory.FORTIFICATIONS;
		
		var shape:CircleShape = new CircleShape(0, 0, 10);
		shape.sensor = true;
		addShape(shape);
		init();
	}
	
	override public function reactToCollision(collidingBody:PhysicalBody, selfShape:BaseShape, otherShape:BaseShape):Void 
	{
		var collidingEntity:GameEntity = cast(collidingBody, GameEntity);
		if (collidingEntity.type == EntityType.FORTIFICATION) 
		{
			target = collidingEntity;
		}
	}
	
	private function switchState(newState:String):Void
	{
		if (state == BehaviourState.DIE) 
		{
			return;
		}
		
		if (state == newState) 
		{
			return;
		}
		
		state = newState;
		
		if (newState == BehaviourState.DIE) 
		{
			speed.x = 0;
			speed.y = 0;
			animation = new GoblinDying();
			animationCompleteFunction = completelyDead;
			return;
		}
		
		if (newState == BehaviourState.ATTACK) 
		{
			speed.x = 0;
			speed.y = 0;
			animation = new GoblinAttacking();
			animationCompleteFunction = doDamageToFortification;
		}
		
		if (newState == BehaviourState.ADVANCE) 
		{
			animation = new GoblinWalking();
		}
	}
	
	private function resetState():Void
	{
		if (state == BehaviourState.DIE)
		{
			return;
		}
		animation = null;
		state = null;
	}
	
	private function doDamageToFortification():Void
	{
		target.recieveDamage(1, "");
		resetState();
	}
	
	private function decideWhatToDo():Void
	{
		if (target != null) 
		{
			switchState(BehaviourState.ATTACK);
			return;
		}
		
		switchState(BehaviourState.ADVANCE);
	}
	
	override public function update():Void 
	{
		if (altitude > 0) 
		{
			altSpeed -= 1;
		}
		
		altitude += altSpeed;
		
		if (altitude < 0) 
		{
			if (position.y < 0 || position.y > 480) 
			{
				disableShapes();
				if (altitude < -800) 
				{
					die();
				}
			} else 
			{
				resetState();
				altitude = 0;
				altSpeed = 0;
				hp -= Std.int(Std.random(20) + 20);
			}
		}
		
		updateState();
		super.update();
		
		target = null;
	}
	
	private function updateState():Void
	{
		switch(state) 
		{
			case BehaviourState.ADVANCE:
				updateAdvance();
			case BehaviourState.ATTACK:
				updateAttack();
			default:
				decideWhatToDo();
		}
	}
	
	private function updateAttack():Void
	{
		speed.x = 0;
		speed.y = 0;
		if (target == null) 
		{
			resetState();
			decideWhatToDo();
			return;
		}
	}
	
	private function updateAdvance():Void
	{
		speed.x += (desiredSpeed.x - speed.x) / 10;
		speed.y += (desiredSpeed.y - speed.y) / 10;
		decideWhatToDo();
	}
	
	
	override public function recieveDamage(damageAmount:Int, damageType:String):Void 
	{
		hp -= damageAmount;
		if (hp <= 0)
		{
			switchState(BehaviourState.DIE);
		}
	}
	
	private function completelyDead():Void
	{
		dead = true;
		animation = null;
	}
	
	override public function push(forceX:Float, forceY:Float, forceZ:Float):Void
	{
		if (hp > 0) 
		{
			speed.x += forceX / 10;
			speed.y += forceY / 10;
		}
		else
		{
			speed.x += forceX / mass;
			speed.y += forceY / mass;
			altSpeed += forceZ / mass;
		}
		
	}
	
}