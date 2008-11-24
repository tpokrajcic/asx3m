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

	public class ArrayConverter extends AbstractCollectionConverter implements IConverter
	{		
		private var _alias:Array;
		
		public function ArrayConverter(mapper:IMapper) {
			super(mapper);	
			_mapper=mapper;
			_alias=new Array();
			_alias["String"]="string";
			_alias["Number"]="int";
			_alias["Boolean"]="boolean";
		}
		
		override public function canConvert(type:Class):Boolean{	
			return (new type() is Array);
		}
		override public function marshal(source:Object, writer:IHierarchicalStreamWriter, context:IMarshallingContext):void {			
			var collection:ArrayCollection = new ArrayCollection(source as Array);
						
			for each (var item:Object in collection){
				writeItem(item, context, writer);
			}			
		}		
		
		override public function unmarshal(reader:IHierarchicalStreamReader, context:IUnmarshallingContext):Object {
			var object:Array=[];	
			var item:XML;
			while (reader.hasMoreChildren()){
				reader.moveDown();
				item=reader.getCurrent();				
				var itemClass:Class;				
				itemClass=_mapper.realClass(item.name());
				if (itemClass!=null){
					object.push(context.convertAnother(null,itemClass,null));
				}
				reader.moveUp();
			}		
			return object;
		}		}
}