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
	import system.data.sets.HashSet;
	
	public class ImmutableTypesMapper extends MapperWrapper
	{
		private var immutableTypes:HashSet;
		
		public function ImmutableTypesMapper(wrapped:IMapper)
		{
			super(wrapped);
			immutableTypes=new HashSet();
		}
		
		public function addImmutableType(type:Class):void {
	        immutableTypes.add(type);
	    }
	    
	    override public function isImmutableValueType(type:Class):Boolean {
	        if (immutableTypes.contains(type)) {
	            return true;
	        } else {
	            return super.isImmutableValueType(type);
	        }
	    }
		
	}
}