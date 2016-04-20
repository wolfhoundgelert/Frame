package com.wolfhoundgelert.frame;
import openfl.display.BitmapData;
import openfl.display.DisplayObject;
import openfl.display.MovieClip;
import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.geom.Matrix;
import openfl.geom.Rectangle;

/**
 * @author wolfhoundgelert
 */
class FrameHelper {

	public static var EMPTY_FRAME(default, null) = new Frame(null, 0, 0);
	public static var enterFrame:DisplayObject;
	
	static var _MATRIX(default, null) = new Matrix();
	
	public static function makeStrip(source:Sprite, borderSpace:Int = 0, smoothing:Bool = false):FrameStrip {
		var list = makeList(source, borderSpace);
		return new FrameStrip(list, smoothing);
	}
	
	static function makeList(source:Sprite, borderSpace:Int):Array<Frame> {
		var list = new Array<Frame>();
		var clip:MovieClip = Std.is(source, MovieClip) ? cast(source, MovieClip) : null;
		var length = clip != null ? clip.totalFrames : 1;
		if(length == 1) {
			list[0] = makeFrame(source, borderSpace);
		} else {
			for(it in 0...length) {
				clip.gotoAndStop(it + 1);
				list[it] = makeFrame(clip, borderSpace);
			}
		}
		return list;
	}
	
	static function makeFrame(source:Sprite, borderSpace:Int):Frame {
		var bounds = source.getBounds(null);
		if(bounds.width < 1 || bounds.height < 1) return EMPTY_FRAME;
		var left = Math.floor(bounds.left);
		var right = Math.ceil(bounds.right);
		var top = Math.floor(bounds.top);
		var bottom = Math.ceil(bounds.bottom);
		var doubleSpace = borderSpace * 2;
		var bd = new BitmapData(right - left + doubleSpace, bottom - top + doubleSpace, true, 0x00000000);
		_MATRIX.tx = -left + borderSpace;
		_MATRIX.ty = -top + borderSpace;
		bd.draw(source, _MATRIX);
		return new Frame(bd, left - borderSpace, top - borderSpace);
	}
}