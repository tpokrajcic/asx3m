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

package hr.binaria.asx3m.converters.extended
{
	import hr.binaria.asx3m.converters.basic.AbstractSingleValueConverter;
	
	//converts from and to java.sql.Date represented as yyyy-mm-dd.
	public class DateConverter extends AbstractSingleValueConverter
	{
		public function DateConverter() {
			super();
		}
		
		public override function canConvert(type:Class):Boolean{
			return new type() is Date;
		}
		override public function toString(obj:Object):String
		{
			if (obj!=null){
				var date:Date=(obj as Date);			
				return (String(date.fullYear+"-"+addLeadingZero((date.month+1))+"-"+addLeadingZero(date.date)+" "+addLeadingZero(date.hours)+":"+addLeadingZero(date.minutes)+":"+addLeadingZero(date.seconds)+"."+date.milliseconds));
			}
			else {
				return null;
			}
		}
		public override function fromString(value:String):Object{
			var date:Date=new Date();
			date.setFullYear(Number(value.substr(0,4)), Number(value.substr(5,2))-1,Number(value.substr(8,2)))
			date.setHours(Number(value.substr(11,2)), Number(value.substr(14,2)), Number(value.substr(17,2)), Number(value.substr(20,3)));
			return date;
		}
		
		private function addLeadingZero(number:Number):String {
			return (number.toString().length==2 ? number.toString() : "0"+number.toString());
		}
			
	}
}