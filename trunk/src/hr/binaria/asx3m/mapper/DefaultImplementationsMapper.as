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

package hr.binaria.asx3m.mapper
{
	import system.data.Map;
	import system.data.maps.HashMap;

	public class DefaultImplementationsMapper extends MapperWrapper
	{
		private var typeToImpl:Map = new HashMap();
    	private var implToType:Map = new HashMap();
	
		public function DefaultImplementationsMapper(wrapped:IMapper) {
			super(wrapped);
		}
		
		public function addDefaultImplementation(defaultImplementation:Class, ofType:Class):void {
	        typeToImpl.put(ofType, defaultImplementation);
	        implToType.put(defaultImplementation, ofType);
	    }		

		override public function serializedClass(type:Class):String
		{
			var baseType:Class = implToType.get(type) as Class;
        	return baseType == null ? super.serializedClass(type) : super.serializedClass(baseType);   
		}	
		
		override public function defaultImplementationOf(type:Class):Class
		{
			if (typeToImpl.containsKey(type)) {
	            return typeToImpl.get(type) as Class;
	        } else {
	            return super.defaultImplementationOf(type);
	        }
		}
		
	}
}