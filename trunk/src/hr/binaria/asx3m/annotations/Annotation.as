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

package hr.binaria.asx3m.annotations
{
	public class Annotation
	{
		private var m_holder:String;
		private var m_name:String;
		private var m_value:String;
		
		public function Annotation(holder:String, name:String, value:String){
			this.m_holder=holder;
			this.m_name=name;
			this.m_value=value;		
		}
		
		public function get holder():String{return m_holder;}
		public function get name():String{return m_name;}
		public function get value():String{return m_value;}
		public function set holder(value:String):void{this.m_holder=value;}
		public function set name(value:String):void{this.m_name=value;}
		public function set value(value:String):void{this.m_value=value;}		
	}
}