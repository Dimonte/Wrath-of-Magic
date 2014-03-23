package game;

import dataStructures.DLL;
import dataStructures.DLLNode;
import sphaeraGravita.collision.CollisionEngine;
import sphaeraGravita.collision.PhysicalBody;
import sphaeraGravita.math.Vector2D;
/**
 * ...
 * @author Dmitriy Barabanschikov
 */
class KillingField
{
	private var collisionEngine:CollisionEngine;
	private var goblinAllowance:Int;
	
	public var fortifications:Array<GameEntity>;
	public var spellEffects:Array<GameEntity>;
	public var enemies:Array<GameEntity>;
	
	public var displayList:Array<GameEntity>;
	
	public function new() 
	{
		collisionEngine = new CollisionEngine();
		init();
	}
	
	public function init():Void
	{
		fortifications = new Array();
		var wall:Wall = new Wall();
		wall.x = 40;
		fortifications.push(wall);
		
		goblinAllowance = 6;
		
		var palisade:Palisade = new Palisade();
		palisade.x = 240;
		fortifications.push(palisade);
		
		enemies = new Array();
		spellEffects = new Array();
		displayList = new Array();
		createGoblin();
	}
	
	private function createGoblin():Void
	{
		if (enemies.length > goblinAllowance) 
		{
			return;
		}
		var goblin:Goblin = new Goblin();
		//*
		goblin.position.x = 820;
		/*/
		goblin.position.x = 120;
		//*/
		goblin.position.y = Std.int(Math.random() * 440 + 20);
		goblin.desiredSpeed = new Vector2D(( -6 -Math.random() * 2) / 4, 0);
		goblin.speed.x = goblin.desiredSpeed.x;
		goblin.world = this;
		enemies.push(goblin);
	}
	
	public function update():Void
	{
		if (Math.random() > 0.994)
		{
			goblinAllowance++;
		}
		
		while(Math.random() > (1 - goblinAllowance/100)) 
		{
			
			//return;
			createGoblin();
		}
		
		
		
		updatePositionsInList(enemies);
		updatePositionsInList(spellEffects);
		
		collideListWithList(fortifications, enemies);
		collideListWithList(enemies, spellEffects);
		
		updateLogicInList(enemies);
		updateLogicInList(spellEffects);
		
		removeDeadEntities(enemies);
		removeDeadEntities(spellEffects);
		
		updateDisplayList();
	}
	
	private function updatePositionsInList(list:Array<GameEntity>):Void
	{
		var i:Int = list.length;
		while (i-- > 0) 
		{
			list[i].updateStart();
			list[i].position.add(list[i].speed);
			list[i].altitude += list[i].altSpeed;
		}
	}
	
	private function updateLogicInList(list:Array<GameEntity>):Void
	{
		var i:Int = list.length;
		while (i-- > 0) 
		{
			list[i].update();
			list[i].updateEnd();
		}
	}
	
	private function removeDeadEntities(list:Array<GameEntity>):Void
	{
		var i:Int = list.length;
		while (i-- > 0) 
		{
			if (list[i].dead) 
			{
				list.splice(i, 1);
			}
		}
	}
	
	public function addSpellEffect(spellEffect:GameEntity):Void
	{
		spellEffect.world = this;
		spellEffects.push(spellEffect);
	}
	
	private function updateDisplayList():Void
	{
		while (displayList.length > 0) 
		{
			displayList.pop();
		}
		
		displayList = displayList.concat(fortifications);
		displayList = displayList.concat(enemies);
		displayList = displayList.concat(spellEffects);
		
		displayList.sort(sortEntitiesByY);
	}
	
	private function sortEntitiesByY(a:GameEntity, b:GameEntity):Int
	{
		if (a.y > b.y) 
		{
			return 1;
		}
		if (a.y < b.y) 
		{
			return -1;
		}
		if (a.x > b.x) 
		{
			return 1;
		}
		if (a.x < b.x) 
		{
			return -1;
		}
		return 0;
	}
	
	public function collideListWithList(listOne:Array<GameEntity>, listTwo:Array<GameEntity>):Void
	{
		for(listOneEntity in listOne) 
		{
			for(listTwoEntity in listTwo)
			{
				collisionEngine.collideBodies(listOneEntity, listTwoEntity);
			}
		}
	}
	
}