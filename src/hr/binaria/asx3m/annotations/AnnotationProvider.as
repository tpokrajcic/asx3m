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
	public class AnnotationProvider
	{
		public function getAnnotation(field:String, object:Object):Annotation {		
			return (Annotated (object)).getFieldAnnotation(field, "JavaType")
		}
		
		public function getRemoteTypeAnnonation(variable:String, object:Object):void{}
		public function getRemoteClassAnnonation(object:Object):void{}
	}
}