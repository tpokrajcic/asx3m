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
	import vegas.data.list.ArrayList;
	import vegas.data.iterator.Iterator;
	
	public class Annotated
	{
		private var m_fieldAnnotations:ArrayList;
		private var m_classAnnotations:ArrayList;
		
		public function Annotated(){
			m_fieldAnnotations=new ArrayList();
			m_classAnnotations=new ArrayList();
		}
		
		public function get fieldAnnotations():ArrayList{return m_fieldAnnotations;}
		public function get classAnnotations():ArrayList{return m_classAnnotations;}
				
		public function addFieldAnnotation(annotation:Annotation):void{
			m_fieldAnnotations.insert(annotation);
		}
		public function addClassAnnotation(annotation:Annotation):void{
			m_classAnnotations.insert(annotation);
		}
		
		public function getFieldAnnotation(fieldName:String, annotationType:String):Annotation{
			var annotation:Annotation;
			for (var iterator:Iterator=m_fieldAnnotations.iterator();iterator.hasNext();){
				annotation=iterator.next();
				if (annotation.holder==fieldName && annotation.name==annotationType){
					return annotation;
				}
			}
			return null;
		}				
		
		public function getClassAnnotation(annotationType:String):Annotation{
			var annotation:Annotation;
			for (var iterator:Iterator=m_classAnnotations.iterator();iterator.hasNext();){
				annotation=iterator.next();
				if (annotation.name==annotationType){
					return annotation;
				}
			}
			return null;
		}	
	}
}