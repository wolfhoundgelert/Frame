package com.wolfhoundgelert.frame;
import flash.display.BitmapData;

/**
 * @author wolfhoundgelert
 */
class Frame {
	
	public function new(bitmapData:BitmapData, x:Int, y:Int) {
		this.bitmapData = bitmapData;
		this.x = x;
		this.y = y;
	}
	
	public var bitmapData(default, null):BitmapData;
	public var x(default, null):Int;
	public var y(default, null):Int;
}