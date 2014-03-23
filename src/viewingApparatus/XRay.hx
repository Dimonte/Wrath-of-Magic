package viewingApparatus;

import game.GameEntity;
import game.KillingField;
import nme.display.Sprite;
import nme.events.Event;
import sphaeraGravita.collision.AABB;
import sphaeraGravita.collision.PhysicalBody;
import sphaeraGravita.math.Vector2D;
import sphaeraGravita.shapes.BaseShape;
import sphaeraGravita.shapes.CircleShape;
import sphaeraGravita.shapes.Polygon;
import sphaeraGravita.shapes.ShapeType;
/**
 * ...
 * @author Dmitriy Barabanschikov
 */
class XRay extends Sprite
{
	private var killingField:KillingField;
	
	public function new(killingField:KillingField) 
	{
		super();
		this.killingField = killingField;
		addEventListener(Event.ENTER_FRAME, enterFrameHandler);
	}
	
	private function enterFrameHandler(e:Event):Void 
	{
		update();
	}
	
	public function update():Void
	{
		graphics.clear();
		drawBodyList(killingField.fortifications, 0x0000FF);
		drawBodyList(killingField.enemies, 0x00FF00);
		drawBodyList(killingField.spellEffects, 0xFF0000);
	}
	
	private function drawBodyList(bodyList:Array<GameEntity>, color:Int = 0x000099):Void
	{
		for(body in bodyList) 
		{
			drawBody(body, color);
		}
	}
	
	public function drawBody(body:GameEntity, color:Int = 0x000099):Void
	{
		if (body == null)
		{
			return;
		}
		var shape:BaseShape;
		//drawBoundingAABB(body, 0x0);
		//trace("Drawing shapes");
		shape = body.shapeList;
		while (shape != null)
		{
			drawShape(shape, color);
			shape = shape.next;
		}
	}
	
	public function drawShape(shape:BaseShape, color:Int = 0x000000 ):Void
	{
		graphics.lineStyle(1, color, shape.enabled ? 1 : 0.5);
		switch (shape.type)
		{
			case ShapeType.CIRCLE_SHAPE:
				drawCircle(cast(shape, CircleShape), color);
			case ShapeType.POLYGON_SHAPE:
				drawPolygon(cast(shape, Polygon), color);
			default: 
		}
	}
	
	private function drawPolygon(shape:Polygon, color:Int):Void
	{
		var body:PhysicalBody = shape.body;
		var drawVector:Vector2D = body.localToWorld(shape.vertices[0]);
		graphics.beginFill(color, shape.enabled ? 0.3 : 0.15);
		graphics.moveTo(drawVector.x, drawVector.y);
		for (i in 0...shape.vertices.length) 
		{
			drawVector = body.localToWorld(shape.vertices[i]);
			//trace("[" + i + "]", "local:", shape.vertices[i], "   global:", drawVector);
			graphics.lineTo(drawVector.x, drawVector.y);
		}
		drawVector = body.localToWorld(shape.vertices[0]);
		graphics.lineTo(drawVector.x, drawVector.y);
		graphics.endFill();
		/*for (i = 0; i < shape.vertices.length; i++) 
		{
			drawArrowForVector(shape.normals[i], shape.getWorldVergeCenter(i) );
		}*/
	}
	
	public function drawLineForVector(sourcePoint:Vector2D, vector:Vector2D):Void
	{
		var pointOne:Vector2D = sourcePoint.add(vector.multiply( -1000));
		graphics.moveTo(pointOne.x, pointOne.y);
		var pointTwo:Vector2D = sourcePoint.add(vector.multiply(1000));
		graphics.lineTo(pointTwo.x, pointTwo.y);
	}
	
	private function drawBoundingAABB(body:PhysicalBody, color:Int):Void
	{
		//return;
		graphics.lineStyle(1, color, 0.3);
		var worldAABB:AABB = body.worldAABB;
		graphics.beginFill(color, 0.1);
		graphics.drawRect(worldAABB.lowerBound.x, worldAABB.lowerBound.y, worldAABB.getWidth(), worldAABB.getHeight());
		graphics.endFill();
	}
	
	private function drawCircle(shape:CircleShape, color:Int):Void
	{
		var position:Vector2D = shape.body.localToWorld(shape.position);
		graphics.beginFill(color, 0.3);
		graphics.drawCircle(position.x, position.y, shape.radius);
		graphics.endFill();
		//drawCenterPoint(position.x, position.y);
	}
	
	public function drawCenterPoint(x:Float, y:Float):Void
	{
		var offset:Float = 2;
		graphics.moveTo(x - offset, y - offset);
		graphics.lineTo(x + offset, y + offset);
		graphics.moveTo(x - offset, y + offset);
		graphics.lineTo(x + offset, y - offset);
	}
	
	public function drawArrowBetweenPoints(source:Vector2D, destination:Vector2D):Void
	{
		graphics.moveTo(source.x, source.y);
		graphics.lineTo(destination.x, destination.y);
		graphics.moveTo(destination.x, destination.y);
		var angle:Float = Math.atan2(destination.subtract(source).y, destination.subtract(source).x);
		graphics.lineTo(destination.x + Math.cos(angle +  Math.PI * 3 / 4) * 5, destination.y + Math.sin(angle + Math.PI * 3 / 4) * 5);
		graphics.moveTo(destination.x, destination.y);
		graphics.lineTo(destination.x + Math.cos(angle -  Math.PI * 3 /4) * 5, destination.y + Math.sin(angle - Math.PI * 3 /4) * 5);
	}
	
	public function drawLineBetweenPoints(source:Vector2D, destination:Vector2D):Void
	{
		graphics.moveTo(source.x, source.y);
		graphics.lineTo(destination.x, destination.y);
	}
	
	public function drawArrowForVector(vector:Vector2D, source:Vector2D):Void
	{
		graphics.moveTo(source.x, source.y);
		var destination:Vector2D = source.clone().add(vector);
		graphics.lineTo(destination.x, destination.y);
		graphics.moveTo(destination.x, destination.y);
		var angle:Float = Math.atan2(destination.clone().subtract(source).y, destination.clone().subtract(source).x);
		graphics.lineTo(destination.x + Math.cos(angle +  Math.PI * 3 / 4) * 5, destination.y + Math.sin(angle + Math.PI * 3 / 4) * 5);
		graphics.moveTo(destination.x, destination.y);
		graphics.lineTo(destination.x + Math.cos(angle -  Math.PI * 3 /4) * 5, destination.y + Math.sin(angle - Math.PI * 3 /4) * 5);
	}
	
}