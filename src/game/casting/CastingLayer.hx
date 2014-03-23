package game.casting;

import game.casting.AlphaButton;
import game.casting.BaseButton;
import game.casting.SpellButton;
import game.casting.spells.CastAgent;
import game.casting.spells.MeteorSpell;
import game.casting.spells.SpellBase;
import game.casting.spells.WallOfFireSpell;
import game.KillingField;
import haxe.ds.GenericStack.GenericStack;
import nme.Assets;
import nme.display.Bitmap;
import nme.display.Sprite;
import nme.events.Event;
import nme.events.MouseEvent;
import viewingApparatus.LensBase;
import viewingApparatus.Monocle;

/**
 * ...
 * @author Dmitriy Barabanschikov
 */

class CastingLayer extends Sprite
{
	private var killingField:KillingField;
	private var castingWheelTLBase:BaseButton;
	private var castingWheelTL1:SpellButton;
	private var castingWheelTL2:SpellButton;
	private var baseButtons:GenericStack<ButtonWrapper>;
	private var castingWheelTRBase:BaseButton;
	private var castingWheelTR1:SpellButton;
	private var castingWheelTR2:SpellButton;
	private var castingWheelBRBase:BaseButton;
	private var castingWheelBR1:SpellButton;
	private var castingWheelBR2:SpellButton;
	private var castingWheelBLBase:BaseButton;
	private var castingWheelBL2:SpellButton;
	private var castingWheelBL1:SpellButton;
	private var spellButtons:GenericStack<SpellButton>;
	private var selectedSpell:SpellBase;
	private var display:LensBase;
	private var castAgent:CastAgent;
	private var mouseDown:Bool;
	private var lastCursorX:Float;
	private var lastCursorY:Float;
	private var mouseSpeedX:Float;
	private var mouseSpeedY:Float;
	
	static private inline var castScale:Float = 0.7;

	public function new(killingField:KillingField, display:LensBase) 
	{
		this.killingField = killingField;
		this.display = display;
		super();
		
		graphics.clear();
		graphics.beginFill(0, 0.1);
		graphics.drawRect(0, 0, 800, 480);
		graphics.endFill();
		addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
		addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		
		baseButtons = new GenericStack<ButtonWrapper>();
		spellButtons = new GenericStack<SpellButton>();
		
		
		
		castingWheelTLBase = new BaseButton(Assets.getBitmapData("assets/castingWheel/CastingWheelTLBase.png"), Assets.getBitmapData("assets/castingWheel/CastingWheelTLBase.png"));
		castingWheelTLBase.overStateData = Assets.getBitmapData("assets/castingWheel/CastingWheelTLBase_HL.png");
		castingWheelTLBase.selectedStateData = Assets.getBitmapData("assets/castingWheel/CastingWheelTLBase_HL.png");
		addBaseButton(castingWheelTLBase, -castingWheelTLBase.width, -castingWheelTLBase.height);
		
		castingWheelTL1 = new SpellButton(Assets.getBitmapData("assets/castingWheel/CastingWheelTL1.png"), Assets.getBitmapData("assets/castingWheel/CastingWheelTL1.png"));
		castingWheelTL1.overStateData = Assets.getBitmapData("assets/castingWheel/CastingWheelTL1_HL.png");
		castingWheelTL1.selectedStateData = Assets.getBitmapData("assets/castingWheel/CastingWheelTL1_HL.png");
		addSpellButton(castingWheelTL1, castingWheelTLBase, -168, 72, new MeteorSpell());
		
		castingWheelTL2 = new SpellButton(Assets.getBitmapData("assets/castingWheel/CastingWheelTL2.png"), Assets.getBitmapData("assets/castingWheel/CastingWheelTL2.png"));
		castingWheelTL2.overStateData = Assets.getBitmapData("assets/castingWheel/CastingWheelTL2_HL.png");
		castingWheelTL2.selectedStateData = Assets.getBitmapData("assets/castingWheel/CastingWheelTL2_HL.png");
		addSpellButton(castingWheelTL2, castingWheelTLBase, 72, -168, new WallOfFireSpell());
		
		castingWheelTRBase = new BaseButton(Assets.getBitmapData("assets/castingWheel/CastingWheelTRBase.png"), Assets.getBitmapData("assets/castingWheel/CastingWheelTRBase.png"));
		castingWheelTRBase.overStateData = Assets.getBitmapData("assets/castingWheel/CastingWheelTRBase_HL.png");
		castingWheelTRBase.selectedStateData = Assets.getBitmapData("assets/castingWheel/CastingWheelTRBase_HL.png");
		addBaseButton(castingWheelTRBase, 0, -castingWheelTRBase.height);
		
		castingWheelTR1 = new SpellButton(Assets.getBitmapData("assets/castingWheel/CastingWheelTR1.png"), Assets.getBitmapData("assets/castingWheel/CastingWheelTR1.png"));
		castingWheelTR1.overStateData = Assets.getBitmapData("assets/castingWheel/CastingWheelTR1_HL.png");
		castingWheelTR1.selectedStateData = Assets.getBitmapData("assets/castingWheel/CastingWheelTR1_HL.png");
		addSpellButton(castingWheelTR1, castingWheelTRBase, -72, -168, new MeteorSpell());
		
		castingWheelTR2 = new SpellButton(Assets.getBitmapData("assets/castingWheel/CastingWheelTR2.png"), Assets.getBitmapData("assets/castingWheel/CastingWheelTR2.png"));
		castingWheelTR2.overStateData = Assets.getBitmapData("assets/castingWheel/CastingWheelTR2_HL.png");
		castingWheelTR2.selectedStateData = Assets.getBitmapData("assets/castingWheel/CastingWheelTR2_HL.png");
		addSpellButton(castingWheelTR2, castingWheelTRBase, 192, 72, new MeteorSpell());
		
		castingWheelBRBase = new BaseButton(Assets.getBitmapData("assets/castingWheel/CastingWheelBRBase.png"), Assets.getBitmapData("assets/castingWheel/CastingWheelBRBase.png"));
		castingWheelBRBase.overStateData = Assets.getBitmapData("assets/castingWheel/CastingWheelBRBase_HL.png");
		castingWheelBRBase.selectedStateData = Assets.getBitmapData("assets/castingWheel/CastingWheelBRBase_HL.png");
		addBaseButton(castingWheelBRBase, 0, 0);
		
		castingWheelBR1 = new SpellButton(Assets.getBitmapData("assets/castingWheel/CastingWheelBR1.png"), Assets.getBitmapData("assets/castingWheel/CastingWheelBR1.png"));
		castingWheelBR1.overStateData = Assets.getBitmapData("assets/castingWheel/CastingWheelBR1_HL.png");
		castingWheelBR1.selectedStateData = Assets.getBitmapData("assets/castingWheel/CastingWheelBR1_HL.png");
		addSpellButton(castingWheelBR1, castingWheelBRBase, 192, -72, new MeteorSpell());
		
		castingWheelBR2 = new SpellButton(Assets.getBitmapData("assets/castingWheel/CastingWheelBR2.png"), Assets.getBitmapData("assets/castingWheel/CastingWheelBR2.png"));
		castingWheelBR2.overStateData = Assets.getBitmapData("assets/castingWheel/CastingWheelBR2_HL.png");
		castingWheelBR2.selectedStateData = Assets.getBitmapData("assets/castingWheel/CastingWheelBR2_HL.png");
		addSpellButton(castingWheelBR2, castingWheelBRBase, -72, 192, new MeteorSpell());
		
		castingWheelBLBase = new BaseButton(Assets.getBitmapData("assets/castingWheel/CastingWheelBLBase.png"), Assets.getBitmapData("assets/castingWheel/CastingWheelBLBase.png"));
		castingWheelBLBase.overStateData = Assets.getBitmapData("assets/castingWheel/CastingWheelBLBase_HL.png");
		castingWheelBLBase.selectedStateData = Assets.getBitmapData("assets/castingWheel/CastingWheelBLBase_HL.png");
		addBaseButton(castingWheelBLBase, -288, 0);
		
		castingWheelBL1 = new SpellButton(Assets.getBitmapData("assets/castingWheel/CastingWheelBL1.png"), Assets.getBitmapData("assets/castingWheel/CastingWheelBL1.png"));
		castingWheelBL1.overStateData = Assets.getBitmapData("assets/castingWheel/CastingWheelBL1_HL.png");
		castingWheelBL1.selectedStateData = Assets.getBitmapData("assets/castingWheel/CastingWheelBL1_HL.png");
		addSpellButton(castingWheelBL1, castingWheelBLBase, 72, 192, new MeteorSpell());
		
		castingWheelBL2 = new SpellButton(Assets.getBitmapData("assets/castingWheel/CastingWheelBL2.png"), Assets.getBitmapData("assets/castingWheel/CastingWheelBL2.png"));
		castingWheelBL2.overStateData = Assets.getBitmapData("assets/castingWheel/CastingWheelBL2_HL.png");
		castingWheelBL2.selectedStateData = Assets.getBitmapData("assets/castingWheel/CastingWheelBL2_HL.png");
		addSpellButton(castingWheelBL2, castingWheelBLBase, -168, -72, new MeteorSpell());
		
		init();
	}
	
	public function init():Void
	{
		lastCursorX = 0;
		lastCursorY = 0;
		mouseSpeedX = 0;
		mouseSpeedY = 0;
		selectedSpell = null;
		mouseDown = false;
	}
	
	private function addSpellButton(spellButton:SpellButton, baseButton:BaseButton, xMod:Float, yMod:Float, ?spell:SpellBase) 
	{
		if (spell != null) 
		{
			spellButton.spell = spell;
		}
		
		spellButton.scaleX = spellButton.scaleY = castScale;		
		spellButton.visible = false;
		spellButton.addEventListener(CastingButtonEvent.BUTTON_OVER, spellButton_buttonOverHandler);
		baseButton.addDependentButton(spellButton, xMod*castScale, yMod*castScale);
		spellButtons.add(spellButton);
		addChild(spellButton);
	}
	
	private function spellButton_buttonOverHandler(e:CastingButtonEvent):Void 
	{
		SOSLog.sosTrace( "CastingLayer.spellButton_buttonOverHandler > e : " + e );
		
		for (spellButton in spellButtons) 
		{
			spellButton.selected = spellButton == e.target;
		}
		for (baseButtonWrapper in baseButtons) 
		{
			baseButtonWrapper.button.getToAlpha(baseButtonWrapper.button.selected ? 0.8 : 0.4);
		}
		selectedSpell = cast(e.target, SpellButton).spell;
	}
	
	private function addBaseButton(baseButton:BaseButton, xMod:Float, yMod:Float)
	{
		baseButton.visible = false;
		baseButton.scaleX = baseButton.scaleY = castScale;
		baseButton.addEventListener(CastingButtonEvent.BUTTON_OVER, baseButton_buttonOverHandler);
		addChild(baseButton);
		baseButtons.add(new ButtonWrapper(baseButton, xMod*castScale, yMod*castScale));
	}
	
	private function baseButton_buttonOverHandler(e:CastingButtonEvent):Void 
	{
		for (baseButtonWrapper in baseButtons) 
		{
			baseButtonWrapper.button.selected = baseButtonWrapper.button == e.target;
			baseButtonWrapper.button.getToAlpha(baseButtonWrapper.button.selected ? 1 : 0.6);
		}
	}
	
	private function mouseUpHandler(e:MouseEvent):Void 
	{
		mouseDown = false;
		for (baseButtonWrapper in baseButtons)
		{
			baseButtonWrapper.button.visible = false;
			baseButtonWrapper.button.selected = false;
		}
	}
	
	private function mouseDownHandler(e:MouseEvent):Void 
	{
		mouseDown = true;
		if (castAgent != null) 
		{
			return;
		}
		
		if (selectedSpell != null) 
		{
			castAgent = selectedSpell.getCastAgent();
			selectedSpell = null;
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			return;
		}
		
		lastCursorX = mouseX;
		lastCursorY = mouseY;
		
		for (baseButtonWrapper in baseButtons)
		{
			baseButtonWrapper.button.visible = true;
			baseButtonWrapper.button.selected = false;
			baseButtonWrapper.button.alpha = 1;
			baseButtonWrapper.button.x = mouseX + baseButtonWrapper.xMod;
			baseButtonWrapper.button.y = mouseY + baseButtonWrapper.yMod;
		}
		
	}
	
	private function updateCast() 
	{
		castAgent.applyEffectToWorld(killingField, display.screenXToWorldX(lastCursorX), display.screenYToWorldY(lastCursorY));
		if (castAgent.depleted) 
		{
			castAgent = null;
			removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
	}
	
	private function enterFrameHandler(e:Event):Void 
	{
		if (mouseDown) 
		{
			mouseSpeedX = mouseX - lastCursorX;
			mouseSpeedY = mouseY - lastCursorY;
			lastCursorX = mouseX;
			lastCursorY = mouseY;
			SOSLog.sosTrace( "mouseY : " + mouseY );
		}
		else 
		{
			lastCursorX += mouseSpeedX;
			lastCursorY += mouseSpeedY;
		}
		updateCast();
	}
	
}