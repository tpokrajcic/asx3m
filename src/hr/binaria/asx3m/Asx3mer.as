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

package hr.binaria.asx3m
{
	import flash.utils.describeType;
	
	public class Asx3mer
	{
		private var _xstream:Asx3m;
		private var _instance:Asx3mer;
		
		/* Singleton functionality */
		private static var _instance:Asx3mer;
		public function Asx3mer(enforcer:SingletonEnforcer){
			init();
		}
		
		public static function get instance():Asx3mer {
			if (Asx3mer._instance==null){
				Asx3mer._instance=new Asx3mer(new SingletonEnforcer);
			}
			return Asx3mer._instance;
		}
		
		private function init():void {
			_xstream=new Asx3m(this, null,null,null);
		}
		
		public function toXML(object:Object, forcedType:String=null):XML{
	        if (forcedType!=null){
	        	return (_xstream.toCustomTypedXML(object, forcedType));
	        }
	        else {
	        	return (_xstream.toXML(object));
	        }
   		 }   		 
   		
   		public function fromXML(xmlObject:XML):Object {
	        return _xstream.fromXML(xmlObject);
	    }		    
	}	
}

class SingletonEnforcer{}