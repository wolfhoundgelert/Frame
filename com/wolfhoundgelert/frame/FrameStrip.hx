package com.wolfhoundgelert.frame;

import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.errors.ArgumentError;
import openfl.events.Event;

/**
 * @author wolfhoundgelert
 */
class FrameStrip extends Sprite {
	
	public function new(list:Array<Frame>, smoothing:Bool = false) {
		super();
		if(list == null || list.length == 0) throw new ArgumentError("Wrong list!");
		_list = list;
		_smoothing = smoothing;
		addChild(_bitmap);
		mouseEnabled = false;
		mouseChildren = false;
		gotoFrame(0);
	}
	
	var _bitmap = new Bitmap();
	var _list:Array<Frame>;
	var _repeat:Bool;
	var _currentIndex:Int;
	
	var _smoothing:Bool;
	
	public function play(repeat:Bool = false) {
		if(_list.length == 1) return;
		_repeat = repeat;
		FrameHelper.enterFrame.addEventListener(Event.ENTER_FRAME, handler_enterFrame);
	}
	
	public function stop() {
		FrameHelper.enterFrame.removeEventListener(Event.ENTER_FRAME, handler_enterFrame);
	}
	
	public function gotoFrame(index:Int) {
		_currentIndex = index % _list.length;
		var frame = _list[_currentIndex];
		_bitmap.x = frame.x;
		_bitmap.y = frame.y;
		_bitmap.bitmapData = frame.bitmapData;
		_bitmap.smoothing = _smoothing;
	}
	
	function handler_enterFrame(event:Event) {
		gotoFrame(++_currentIndex);
		if(!_repeat && _currentIndex == _list.length - 1) {
			stop();
			if(willTrigger(Event.COMPLETE)) {
				dispatchEvent(new Event(Event.COMPLETE, true));
			}
		}
	}
}