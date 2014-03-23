package sphaeraGravita.shapes;

import nme.errors.IllegalOperationError;
import sphaeraGravita.collision.AABB;
import sphaeraGravita.collision.PhysicalBody;
import sphaeraGravita.math.Vector2D;
/**
 * ...
 * @author Dimonte
 */
class BaseShape
{
	public var body:PhysicalBody;
	public var previous:BaseShape;
	public var next:BaseShape;
	public var sensor:Bool;
	public var name:String;
	public var enabled:Bool;
	
	public var type:String;
	
	public function new(type:String) 
	{
		this.type = type;
		enabled = true;
	}
	
	public function getBoundingAABB():AABB
	{
		throw new IllegalOperationError("Function must be overridden");
		return new AABB();
	}
	
}