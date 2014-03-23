package game;

import sphaeraGravita.collision.PhysicalBody;
import sphaeraGravita.shapes.BaseShape;
/**
 * ...
 * @author Dmitriy Barabanschikov
 */
class CollisionToken
{
	public var collidingBody:PhysicalBody;
	public var selfShape:BaseShape;
	public var otherShape:BaseShape;
	
	public function new(collidingBody:PhysicalBody, selfShape:BaseShape, otherShape:BaseShape) 
	{
		this.collidingBody = collidingBody;
		this.selfShape = selfShape;
		this.otherShape = otherShape;
	}
	
}