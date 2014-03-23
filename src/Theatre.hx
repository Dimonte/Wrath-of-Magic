package  ;

import flash.display.Sprite;
import game.casting.CastingLayer;
import game.KillingField;
import nme.Assets;
import nme.display.Bitmap;
import nme.events.MouseEvent;
import viewingApparatus.LensBase;
import viewingApparatus.Monocle;
#if cpp
import viewingApparatus.PocketMonocle;
#end
import viewingApparatus.XRay;

/**
 * ...
 * @author Dmitriy Barabanschikov
 */

class Theatre extends Sprite
{
	private var controlLayer:CastingLayer;
	private var lensBase:LensBase;
	private var killingField:KillingField;
	private var xRay:XRay;
	
	public function new() 
	{
		super();
		killingField = new KillingField();
		
		#if cpp
		lensBase = new PocketMonocle(killingField, 800,480);
		#else
		lensBase = new Monocle(killingField);
		#end
		addChild(lensBase);
		
		xRay =  new XRay(killingField);
		//addChild(xRay);
		
		xRay.y = 120;
		xRay.scaleY = 0.625;
		xRay.alpha = 0.5;
		
		controlLayer = new CastingLayer(killingField, lensBase);
		addChild(controlLayer);
		
		var restartTap:Sprite = new Sprite();
		restartTap.addChild(new Bitmap(Assets.getBitmapData("assets/blue_reload.png", false)));
		restartTap.scaleX = restartTap.scaleY = 0.5;
		addChild(restartTap);
		restartTap.addEventListener(MouseEvent.CLICK, restartTap_clickHandler);
		
		//addChild(new Stats()).alpha = 0.5;
		//addChild(new FrameStats(this));
	}
	
	private function restartTap_clickHandler(e:MouseEvent):Void 
	{
		killingField.init();
		controlLayer.init();
	}
	
	public function update():Void
	{
		killingField.update();
		lensBase.update();
	}
	
}