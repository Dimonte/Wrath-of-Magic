package viewingApparatus;
import game.KillingField;
import nme.display.Sprite;

/**
 * ...
 * @author Dmitriy Barabanschikov
 */

class LensBase extends Sprite
{
	public var target:KillingField;

	public function new(target:KillingField) 
	{
		super();
		this.target = target;
	}
	
	public function worldXToScreenX(worldX:Float):Float
	{
		return worldX;
	}
	
	public function worldYToScreenY(worldY:Float):Float
	{
		return worldY*0.625+120;
	}
	
	public function screenXToWorldX(screenX:Float):Float
	{
		return screenX;
	}
	
	public function screenYToWorldY(screenY:Float):Float
	{
		return (screenY-120)*1.6;
	}
	
	public function update() 
	{
		
	}
	
}