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

package hr.binaria.asx3m.converters.reflection
{
	import hr.binaria.asx3m.converters.IUnmarshallingContext;
	import hr.binaria.asx3m.converters.IConverter;
	import hr.binaria.asx3m.io.IHierarchicalStreamReader;
	import hr.binaria.asx3m.converters.IMarshallingContext;
	import hr.binaria.asx3m.io.IHierarchicalStreamWriter;
	import hr.binaria.asx3m.annotations.Annotated;
	import system.data.lists.ArrayList;
	import system.data.Iterator;
	import hr.binaria.asx3m.annotations.Annotation;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import hr.binaria.asx3m.mapper.IMapper;

	public class AnnotatedReflectionConverter implements IConverter
	{
		private var mapper:IMapper;	
		private var reflectionProvider:IReflectionProvider;
		 
		public function AnnotatedReflectionConverter(mapper:IMapper, reflectionProvider:IReflectionProvider){
			this.mapper = mapper;
	        this.reflectionProvider = reflectionProvider;
		}
		
		public function unmarshal(reader:IHierarchicalStreamReader, context:IUnmarshallingContext):Object
		{
			return null;
		}
		
		public function marshal(source:Object, writer:IHierarchicalStreamWriter, context:IMarshallingContext):void
		{					
			var name:String;
			if (source == null) {
	            // todo: this is duplicated in TreeMarshaller.start()
	            name = this.mapper.serializedClass(null);
	            writer.startNode(name);
	            writer.endNode();
	        } else {
				var annotations:ArrayList=(Annotated(source)).fieldAnnotations;
				var annotation:Annotation;
				for (var iterator:Iterator=annotations.iterator();iterator.hasNext();){
					annotation=Annotation(iterator.next());
		            name=annotation.holder;
		            writer.startNode(name);
		            context.convertAnother(source[name], null);
		            writer.endNode();
				}            
       		}
		}
		
		public function canConvert(type:Class):Boolean
		{
			return new type() is Annotated;
		}
		
	}
}