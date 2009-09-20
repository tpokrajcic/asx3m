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
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	
	import hr.binaria.asx3m.converters.IConverter;
	import hr.binaria.asx3m.converters.IMarshallingContext;
	import hr.binaria.asx3m.converters.IUnmarshallingContext;
	import hr.binaria.asx3m.io.IHierarchicalStreamReader;
	import hr.binaria.asx3m.io.IHierarchicalStreamWriter;
	import hr.binaria.asx3m.mapper.IMapper;
	
	public class ReflectionConverter implements IConverter
	{
		private var _alias:Array;
		private var _mapper:IMapper;
		private var _reflectionProvider:IReflectionProvider;
		
		public function ReflectionConverter(mapper:IMapper, reflectionProvider:IReflectionProvider) {        	
        	_mapper=mapper;
        	_reflectionProvider=reflectionProvider;
        	_alias=new Array();
			_alias["String"]="string";
			_alias["Number"]="int";
			_alias["Boolean"]="boolean";	
    	}

	    public function canConvert(type:Class):Boolean {
	        return new type() is Object;
	    }
	    
	    public function marshal(source:Object, writer:IHierarchicalStreamWriter, context:IMarshallingContext):void
		{
			var objDescriptor:XML=describeType(source);
			var property:XML;	
			var propertyType:String;	
			var propertyValue:Object;		
			for each(property in objDescriptor.elements("variable")){				
				propertyValue=source[property.@name];
				//we have to get rid of NaN values and convert them to null
				if (propertyValue is Number && isNaN(Number(propertyValue))) {
					propertyValue=null;
				}
				//skip variables with null value
				if (propertyValue!=null){					
					writer.startNode(property.@name);	
					context.convertAnother(propertyValue,null);					
					writer.endNode();	
				}					
			}	
			//completely the same for accessor nodes:
			for each(property in objDescriptor.elements("accessor")){
				if (property.@access=="readonly"){
					continue;
				}
				writer.startNode(property.@name);	
				//skip variables with null value
				if (source[property.@name]!=null){					
					context.convertAnother(source[property.@name],null);
				}				
				writer.endNode();		
			}	
		}
		
		public function unmarshal(reader:IHierarchicalStreamReader, context:IUnmarshallingContext):Object
		{
			var node:XML;
			var objectClass:Class;
			var objDescriptor:XML;
			var object:Object;
			var propertyType:String;
			var propertyClass:Class;
			node=reader.getCurrent();
			//TODO: handle exception
			objectClass=context.getRequiredType() as Class;//flash.utils.getDefinitionByName(node.name()) as Class;
			object=new objectClass();
			objDescriptor=describeType(object);
			while (reader.hasMoreChildren()){
				reader.moveDown();
				node=reader.getCurrent();
				propertyType=getTypeFromDescriptor(node.name(), objDescriptor);
				//ignore xml value if property with the same doesn't exist in class
				if (propertyType!=null){
					propertyClass=_mapper.realClass(propertyType);							
					object[node.name()]=context.convertAnother(null,propertyClass,null);			
				}								
				reader.moveUp(); 
				}			
			return object;
		}
		
		/**
		 * Checks if property with given name exists in class and returns property type.
		 * Returns null if class has no property with that name.
		 * 
		 * @param name property name
		 * @return 
		 * 
		 */
		private function getTypeFromDescriptor(name:String, objDescriptor:XML):String {
			for each(var property:XML in objDescriptor.elements("variable")) {
				if (property.@name==name){
					return (String(property.@type));//.replace("::","."));
				}
			}
			for each(var accessor:XML in objDescriptor.elements("accessor")) {
				if (accessor.@name==name){
					return (String(accessor.@type));//.replace("::","."));
				}
			}
			return null;
		}
		
		private function escapeNull(value:*):* {
			if (value==null){
				return ("");
			}
			else {
				return (value);
			}
		}
	}
}