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

package hr.binaria.asx3m.core
{
	import hr.binaria.asx3m.converters.IDataHolder;
	import system.data.Map;
	import system.data.maps.HashMap;
	import system.data.Iterator;

	public class MapBackedDataHolder implements IDataHolder
	{
		private var map:Map;		
	    
	     public function MapBackedDataHolder(map:Map=null) {
	        if (map==null){
	        	this.map=new HashMap();
	        }
	        else {
	        	this.map = map;
	        }
	    }
	    
		public function keys():Iterator
		{
			return (map.getKeys()).iterator();
		}
		
		public function put(key:Object, value:Object):void
		{
			map.put(key, value);
		}
		public function get(key:Object):Object
		{
			return map.get(key);
		}		
	}
}