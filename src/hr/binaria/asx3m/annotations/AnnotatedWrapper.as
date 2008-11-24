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
	import hr.binaria.asx3m.annotations.Annotation;
	
	public class AnnotatedWrapper
	{
		private var m_object:Object;
		private var m_typeAnnotation:Annotation;
		
		public function AnnotatedWrapper(object:Object, annotation:Annotation){
			this.object=object;
			if ((object is Annotated) && annotation!=null){
				this.m_typeAnnotation=(Annotated (object)).getClassAnnotation("JavaType");
			}
			else {
				this.m_typeAnnotation=annotation;				
			}
		}
		
		public function get object():Object{return m_object;}
		public function set object(value:Object):void{m_object=value;}
		public function get typeAnnotation():Annotation{return m_typeAnnotation;}
		public function set typeAnnotation(value:Annotation):void{m_typeAnnotation=value;}	
	}
}