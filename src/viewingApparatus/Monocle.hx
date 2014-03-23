package viewingApparatus;

import assets.GraphicsLibrary;
import dataStructures.DLLNode;
import game.GameEntity;
import game.KillingField;
import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.geom.Point;
import nme.geom.Rectangle;
/**
 * ...
 * @author Dmitriy Barabanschikov
 */
class Monocle extends LensBase
{
	
	private var canvas:BitmapData;
	private var backgroundData:BitmapData;
	private var backgroundFrontData:BitmapData;
	var alphaBD:BitmapData;
	var alphaRect:Rectangle;
	
	public function new(target:KillingField) 
	{
		super(target);
		canvas = new BitmapData(800, 480, true, 0x00000000);
		
		alphaBD = new BitmapData(2048, 2048, true, 0x0);
		alphaRect = new Rectangle(0, 0, 0, 0);
		
		addChild(new Bitmap(canvas));
		
		backgroundData = GraphicsLibrary.getBackground().getBitmapDataForFrame(0);
		backgroundFrontData = GraphicsLibrary.getGround().getBitmapDataForFrame(0);
	}
	
	override public function update():Void
	{
		//canvas.fillRect(new Rectangle(0, 0, 800, 480), 0x00000000);
		
		var lastDrawnEntity:Int = 0;
		var entity:GameEntity;
		var correctedEntityPosition:Point;
		
		canvas.copyPixels(backgroundData, new Rectangle(0, 0, 800, 480), new Point(0, 0));
		
		for (i in 0...target.displayList.length) 
		{
			entity = target.displayList[i];
			if (entity.position.y >= 0) 
			{
				break;
			}
			correctedEntityPosition = new Point(entity.position.x, entity.position.y*0.625+120 - entity.altitude).add(entity.graphicsAsset.sizeCorrection);
			canvas.copyPixels(entity.graphicsAsset.spriteSheet, entity.graphicsAsset.frameRectangles[entity.frameRectNum], correctedEntityPosition, null, null, true);
			lastDrawnEntity = i+1;
		}
		
		canvas.copyPixels(backgroundFrontData, new Rectangle(0, 0, 800, 384), new Point(0, 0), null, null, true);
		//*
		
		if (lastDrawnEntity < target.displayList.length) 
		{
			for (i in lastDrawnEntity...target.displayList.length) 
			{
				entity = target.displayList[i];
				correctedEntityPosition = new Point(worldXToScreenX(entity.position.x), worldYToScreenY(entity.position.y) - entity.altitude).add(entity.graphicsAsset.sizeCorrection);
				var frameRect:Rectangle = entity.graphicsAsset.frameRectangles[entity.frameRectNum];
				alphaRect.width = frameRect.width;
				alphaRect.height = frameRect.height;
				alphaBD.fillRect(alphaRect, Std.int(entity.graphicsAlpha*255) << 24);
				canvas.copyPixels(entity.graphicsAsset.spriteSheet, frameRect, correctedEntityPosition, alphaBD, null, true);
			}
		}
	}
	
	
	
}