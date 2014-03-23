package viewingApparatus;
import assets.GraphicsLibrary;
import dataStructures.DLL;
import game.GameEntity;
import game.KillingField;
import nme.display.Bitmap;
import nme.display.Sprite;
import nme.display.Tilesheet;
import nme.geom.Point;

/**
 * ...
 * @author Dmitriy Barabanschikov
 */

class PocketMonocle extends LensBase
{
	private var screenWidth:Int;
	private var screenHeight:Int;
	private var toDraw:Array<Float>;
	private var tilesCanvas:Sprite;

	public function new(target:KillingField, screenWidth:Int, screenHeight:Int) 
	{
		super(target);
		
		this.screenWidth = screenWidth;
		this.screenHeight = screenHeight;
		
		
		var background:Bitmap = new Bitmap(GraphicsLibrary.getBackground().getBitmapDataForFrame(0));
		/*background.scaleX = screenWidth / background.width;
		background.scaleY = screenHeight / background.height;*/
		addChild(background);
		
		tilesCanvas = new Sprite();
		addChild(tilesCanvas);
		
		
		toDraw = new Array<Float>();
		
		//createScoreDisplay();
	}
	
	override public function update():Void
	{
		super.update();
		tilesCanvas.graphics.clear();
		drawStuff();
	}
	
	public function drawStuff():Void
	{
		var lastDrawnEntity:Int = 0;
		var entity:GameEntity;
		var correctedEntityPosition:Point;
		
		var drawListPosition:Int = 0;
		
		for (i in 0...target.displayList.length) 
		{
			entity = target.displayList[i];
			if (entity.position.y >= 0) 
			{
				break;
			}
			drawListPosition = drawEntity(entity, toDraw, drawListPosition);
			lastDrawnEntity = i+1;
		}
		
		toDraw[drawListPosition] = 0;
		drawListPosition++;
		toDraw[drawListPosition] = 0;
		drawListPosition++;
		toDraw[drawListPosition] = GraphicsLibrary.getGround().tileSheetFrameID[0];
		drawListPosition++;
		toDraw[drawListPosition] = 1;
		drawListPosition++;
		
		if (lastDrawnEntity < target.displayList.length) 
		{
			for (i in lastDrawnEntity...target.displayList.length) 
			{
				entity = target.displayList[i];
				drawListPosition = drawEntity(entity, toDraw, drawListPosition);
			}
		}
		
		while (toDraw.length > drawListPosition) 
		{
			toDraw.pop();
		}
		
		GraphicsLibrary.tilesheet.drawTiles(tilesCanvas.graphics, toDraw, false, Tilesheet.TILE_ALPHA);
	}
	
	private function drawEntity(ge:GameEntity, drawList:Array<Float>, toDrawLength:Int):Int
	{
		var screenX:Int = Std.int(worldXToScreenX(ge.x) + ge.graphicsAsset.sizeCorrection.x);
		var screenY:Int = Std.int(Std.int(worldYToScreenY(ge.y) - ge.altitude + ge.graphicsAsset.sizeCorrection.y));
		drawList[toDrawLength] = screenX;
		toDrawLength++;
		drawList[toDrawLength] = screenY;
		toDrawLength++;
		drawList[toDrawLength] = ge.graphicsAsset.tileSheetFrameID[ge.frameRectNum];
		toDrawLength++;
		drawList[toDrawLength] = ge.graphicsAlpha;
		toDrawLength++;
		return toDrawLength;
	}
	
}