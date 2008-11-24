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
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import hr.binaria.asx3m.converters.IConverter;
	import hr.binaria.asx3m.converters.IMarshallingContext;
	import hr.binaria.asx3m.converters.IUnmarshallingContext;
	import hr.binaria.asx3m.io.IHierarchicalStreamReader;
	import hr.binaria.asx3m.io.IHierarchicalStreamWriter;
	import hr.binaria.asx3m.mapper.IMapper;
			
	public class AbstractCollectionConverter implements IConverter
	{
		protected var _mapper:IMapper;
		
		public function AbstractCollectionConverter(mapper:IMapper){			
			_mapper=mapper;
		}
		
		public function canConvert(type:Class):Boolean{
			return false;
		}
		public function marshal(source:Object, writer:IHierarchicalStreamWriter, context:IMarshallingContext):void{}		
		
		public function unmarshal(reader:IHierarchicalStreamReader, context:IUnmarshallingContext):Object{
			return null;
		}

		protected function writeItem(item:Object, context:IMarshallingContext, writer:IHierarchicalStreamWriter):void {
        // PUBLISHED API METHOD! If changing signature, ensure backwards compatability.
        var name:String;
        if (item == null) {
            // todo: this is duplicated in TreeMarshaller.start()
            name = _mapper.serializedClass(null);
            writer.startNode(name);
            writer.endNode();
        } else {
            name = _mapper.serializedClass(getDefinitionByName(getQualifiedClassName(item)) as Class);
            //ExtendedHierarchicalStreamWriterHelper.startNode(writer, name, item.getClass());
            writer.startNode(name);
            context.convertAnother(item,null);
            writer.endNode();
        }
    }
	}
	
	
}