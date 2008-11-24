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
	public class NumberConverter extends AbstractSingleValueConverter
	{
		public override function canConvert(type:Class):Boolean{
			return new type() is Number;
		}
		override public function toString(obj:Object):String
		{
			return (obj==null || isNaN(Number(obj))) ? null : obj.toString();
		}
		public override function fromString(value:String):Object{
			return isNaN(Number(value)) ? null : new Number(value);
		}
	}
}