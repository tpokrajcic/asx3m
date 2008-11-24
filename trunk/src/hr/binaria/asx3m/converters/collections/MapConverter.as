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
	
	import vegas.data.Map;
	import vegas.data.iterator.Iterator;
	import vegas.data.map.HashMap;
	
	import flash.utils.getQualifiedClassName;
	import flash.utils.getDefinitionByName;

	public class MapConverter extends AbstractCollectionConverter implements IConverter
	{		
		private var _alias:Array;
		
		public function MapConverter(mapper:IMapper) {		
			super(mapper);	
			_alias=new Array();
			_alias["String"]="string";
			_alias["Number"]="int";
			_alias["Boolean"]="boolean";
		}

		override public function canConvert(type:Class):Boolean
		{			
			return new type() is Map;
		}
		
		override public function marshal(source:Object, writer:IHierarchicalStreamWriter, context:IMarshallingContext):void {
			var map:Map = source as Map;
			var key:Object;
	        for (var iterator:Iterator = map.keyIterator(); iterator.hasNext();) {
	            key = iterator.next();
	            writer.startNode("entry");	
	            writeItem(key, context, writer);
	            writeItem(map.get(key), context, writer);	
	            writer.endNode();
	        }
		}
		
		override public function unmarshal(reader:IHierarchicalStreamReader, context:IUnmarshallingContext):Object
		{
			//posloziti AbstractCollectionConverter pa HashMap izvuci preko
			//default implementation
			var object:HashMap=new HashMap();			
	    	var entryItemIndex:int;
			var node:XML=reader.getCurrent();
			var entry:XML;
			while (reader.hasMoreChildren()){
				reader.moveDown();
				entry=reader.getCurrent();
				entryItemIndex=0;
				while (reader.hasMoreChildren()){
					reader.moveDown();
					var item:XML=reader.getCurrent();
					if (entryItemIndex==0){
						var key:String=item.toString();
					}
					else if (entryItemIndex==1) {
						var itemClass:Class;				
						itemClass=_mapper.realClass(item.name());
						if (itemClass!=null){
							object[key]=context.convertAnother(null,itemClass,null);
						}
					}	   
					entryItemIndex++;   
					reader.moveUp();
				}						
				reader.moveUp();
			}			
			return object;
		}		
	}
}