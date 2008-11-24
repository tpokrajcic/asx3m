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

package hr.binaria.asx3m.converters.collections
{
	import hr.binaria.asx3m.converters.IConverter;
	import hr.binaria.asx3m.converters.IMarshallingContext;
	import hr.binaria.asx3m.converters.IUnmarshallingContext;
	import hr.binaria.asx3m.io.IHierarchicalStreamReader;
	import hr.binaria.asx3m.io.IHierarchicalStreamWriter;
	import hr.binaria.asx3m.mapper.IMapper;
	
	import mx.collections.ArrayCollection;

	public class ListConverter extends AbstractCollectionConverter implements IConverter
	{		
		private var _alias:Array;
		
		public function ListConverter(mapper:IMapper) {
			super(mapper);	
			_mapper=mapper;
			_alias=[];
			_alias["String"]="string";
			_alias["Number"]="int";
			_alias["Boolean"]="boolean";
		}
		
		override public function canConvert(type:Class):Boolean{	
			return (new type() is ArrayCollection);
		}
		override public function marshal(source:Object, writer:IHierarchicalStreamWriter, context:IMarshallingContext):void {
			var collection:ArrayCollection = source as ArrayCollection;
						
			for each (var item:Object in collection){
				writeItem(item, context, writer);
			}			
			
			/* var objDescriptor:XML=describeType(source);
			var cSource:ArrayCollection=source as ArrayCollection;
			for each(var variable:XML in objDescriptor.elements("variable")){
				var variableType:String;
				//skip variables with null value
				if (cSource[variable.@name]!=null){
					//first check if there's metadata defined type
					variableType=getRemoteType(variable.elements("metadata"));
					if (variableType==null){
						//then try if there's matching alias. if not use actionscript type.
						variableType=_alias[variable.@type] ? _alias[variable.@type] : variable.@type;
					}
						writer.startNode("variableType");
						writer.setValue(cSource[variable.@name]);
						writer.endNode();
				}
				else {
					writer.startNode("null");
					writer.endNode();
				}										
			} */
		}		
		
		override public function unmarshal(reader:IHierarchicalStreamReader, context:IUnmarshallingContext):Object {
			var object:ArrayCollection=new ArrayCollection();	
			var item:XML;
			while (reader.hasMoreChildren()){
				reader.moveDown();
				item=reader.getCurrent();				
				var itemClass:Class;				
				itemClass=_mapper.realClass(item.name());
				if (itemClass!=null){
					object.addItem(context.convertAnother(null,itemClass,null));
				}				 
				reader.moveUp();
			}		
			return object;
		}	
		/* private function getRemoteType(metadataList:XMLList):String{
			var remoteType:String;			
			for each (var metadata:XML in metadataList){
				if (metadata.@name=="RemoteType"){
					for each (var arg:XML in metadata.elements("arg")){
						if (arg.@key=="alias"){
							remoteType=arg.@value;							
						}
					}
				}
			}
			return remoteType;
		}	*/	
	} 
}