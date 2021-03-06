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

package hr.binaria.asx3m.converters.basic
{
	import hr.binaria.asx3m.converters.ISingleValueConverter;

	public class AbstractSingleValueConverter implements ISingleValueConverter
	{
		public function toString(obj:Object):String
		{
			return obj == null ? null : obj.toString();
		}
		
		public function fromString(str:String):Object
		{
			return null;
		}
		
		public function canConvert(type:Class):Boolean
		{
			return false;
		}		
	}
}