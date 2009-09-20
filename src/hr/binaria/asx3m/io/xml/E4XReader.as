/*
 * Copyright (C) 2008 Tomislav Pokrajcic
 * All rights reserved.
 *
 * The software in this package is published under the terms of the BSD
 * style license a copy of which has been included with this distribution in
 * the LICENSE.txt file.
 * 
 * Created on 15. March 2008 by Tomislav Pokrajcic
 */

package hr.binaria.asx3m.io.xml
{
	import hr.binaria.asx3m.io.IHierarchicalStreamReader;
	
	import mx.collections.XMLListCollection;
	
	import system.data.Iterator;
	import system.data.stacks.ArrayStack;

	public class E4XReader implements IHierarchicalStreamReader
	{
		private var _pointers:ArrayStack;
		private var _currentElement:XML;
		private var _current:XML;
		
		public function E4XReader(xml:XML) {
			_current=xml;
			_pointers=new ArrayStack();
			_pointers.push(new Pointer());
			reassignCurrentElement(_current);
		}
		
		public function getCurrent():* {
			return _current;
		}

		public function hasMoreChildren():Boolean
		{
			var pointer:Pointer = _pointers.peek() as Pointer;

	        if (pointer.v < getChildCount()) {
	            return true;
	        } else {
	            return false;
	        }
		}
		
		public function moveDown():void
		{
			var pointer:Pointer = _pointers.peek() as Pointer;
	        _pointers.push(new Pointer());
	
	        _current = getChild(pointer.v) as XML;
	
	        pointer.v++;
	        reassignCurrentElement(_current);
		}
		
		public function moveUp():void
		{
			_current = getParent() as XML;
       		_pointers.pop();
       		reassignCurrentElement(_current);
		}
		
		protected function getParent():Object {
	        return _currentElement.parent();
	    }
	    
		protected function getChild(index:int):Object {
	        return new XMLListCollection(_currentElement.children()).getItemAt(index);	        
	    }
	    
	    protected function getChildCount():int {
	        return new XMLListCollection(_currentElement.children()).length;
	    }
		
		public function getNodeName():String
		{
			return _currentElement.name();
		}
		
		public function getValue():String
		{
			return _currentElement.toString();
		}
		
		public function getAttribute(name:String):String
		{			
			if (name!=null){
				return _currentElement.attribute(name).toString();
			}
			else {
				return null;
			}
		}		
		
		public function getAttributeCount():int
		{
			var i:int=0
			for each (var xml:XML in _currentElement.attributes()){
				i++;
			}
			return i;
		}
		
		public function getAttributeName(index:int):String
		{
			//TODO: implement function
			return null;
		}
		
		public function getAttributeNames():Iterator
		{
			//TODO: implement function
			return null;
		}
		
		public function close():void
		{
			//do nothing
		}
		
		public function underlyingReader():IHierarchicalStreamReader
		{
			return null;
		}
		//
		protected function reassignCurrentElement(current:XML):void  {
	        _currentElement = current;
	    }
		
	}
}

class Pointer{
	public var v:int;
}