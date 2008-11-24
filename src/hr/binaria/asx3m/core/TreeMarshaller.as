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

package hr.binaria.asx3m.core
{
	import flash.utils.*;		import hr.binaria.asx3m.annotations.AnnotatedWrapper;	import hr.binaria.asx3m.annotations.Annotation;	import hr.binaria.asx3m.converters.IConverter;	import hr.binaria.asx3m.converters.IConverterLookup;	import hr.binaria.asx3m.converters.IDataHolder;	import hr.binaria.asx3m.converters.IMarshallingContext;	import hr.binaria.asx3m.io.IHierarchicalStreamWriter;	import hr.binaria.asx3m.mapper.IMapper;		import vegas.data.iterator.Iterator;

	public class TreeMarshaller implements IMarshallingContext
	{
		protected var converterLookup:IConverterLookup;
		private var mapper:IMapper;
		private var dataHolder:IDataHolder;
		protected var writer:IHierarchicalStreamWriter;
		
		public function TreeMarshaller(
										writer:IHierarchicalStreamWriter,
										converterLookup:IConverterLookup, 
										mapper:IMapper){
			this.converterLookup=converterLookup;
			this.mapper=mapper;		
			this.writer=writer;	
		}
		
		
		public function convertAnother(item:Object, converter:IConverter):void{
			if (converter==null) {
				converter = converterLookup.lookupConverterForType(Class (getDefinitionByName(getQualifiedClassName(item))));
			}
        	convert(item, converter);
		}
		public function convert(item:Object, converter:IConverter):void {
			//TODO: reference check
			converter.marshal(item, writer, this);
		}
		public function start(maybeWrappedObject:Object, dataHolder:IDataHolder):void {
			this.dataHolder=dataHolder;
			var object:Object;
			var type:String;
			if (maybeWrappedObject == null) {
				//type=mapper.serializedClass(null);
	            //writer.startNode(type);
	            writer.startNode("null");
	            writer.endNode();
	        } else {
	        	if (maybeWrappedObject is AnnotatedWrapper){
	        		object=(AnnotatedWrapper(maybeWrappedObject)).object;
	        		type=(Annotation ((AnnotatedWrapper(maybeWrappedObject)).typeAnnotation)).value;
	        		//ExtendedHierarchicalStreamWriterHelper.startNode(writer, type, null/* Class (getDefinitionByName(getQualifiedClassName(object))) */);            	  
	        		  
	        	}
	        	else {
	        		object=maybeWrappedObject;
	        		var qName:String=getQualifiedClassName(object);
	        		var classReference:Class=getDefinitionByName(qName) as Class;
	        		//ExtendedHierarchicalStreamWriterHelper.startNode(writer, mapper.serializedClass(Class (getDefinitionByName(getQualifiedClassName(object)))),Class (getDefinitionByName(getQualifiedClassName(object))));	            
	        		type=mapper.serializedClass(classReference);
	        	}
	        	writer.startNode(type);
	            convertAnother(object, null);
	            writer.endNode();
	        }
		}
		
		public function get(key:Object):Object {
        lazilyCreateDataHolder();
        return dataHolder.get(key);
    }

    public function put(key:Object, value:Object):void {
        lazilyCreateDataHolder();
        dataHolder.put(key, value);
    }

    public function keys():Iterator {
        lazilyCreateDataHolder();
        return dataHolder.keys();
    }

    private function lazilyCreateDataHolder():void {
        if (dataHolder == null) {
            dataHolder = new MapBackedDataHolder(null);
        }
    }
		
	
		
	}
}