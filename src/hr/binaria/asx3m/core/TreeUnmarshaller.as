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
	import flash.utils.getQualifiedClassName;
	
	import hr.binaria.asx3m.converters.IConverter;
	import hr.binaria.asx3m.converters.IConverterLookup;
	import hr.binaria.asx3m.converters.IDataHolder;
	import hr.binaria.asx3m.converters.IUnmarshallingContext;
	import hr.binaria.asx3m.io.IHierarchicalStreamReader;
	import hr.binaria.asx3m.mapper.IMapper;
	
	import vegas.data.iterator.Iterator;
	import vegas.data.stack.SimpleStack;

	public class TreeUnmarshaller implements IUnmarshallingContext
	{
		private var _root:Object;
	    protected var _reader:IHierarchicalStreamReader;
	    private var _converterLookup:IConverterLookup;
	    private var _mapper:IMapper;
	    //TODO: zamijeniti sa FastStack
	    private var types:SimpleStack = new SimpleStack();
	    private var dataHolder:IDataHolder;
	    //private var final PrioritizedList validationList = new PrioritizedList();
		
		public function TreeUnmarshaller(root:Object, reader:IHierarchicalStreamReader,
                            converterLookup:IConverterLookup, mapper:IMapper) {
			this._root = root;
	        this._reader = reader;
	        this._converterLookup = converterLookup;
	        this._mapper = mapper;
		}

		public function convertAnother(parent:Object, type:Class, converter:IConverter):Object
		{
			var converter:IConverter = _converterLookup.lookupConverterForType(type);
			return convert(parent, type, converter);
		}
		
		protected function convert(parent:Object, type:Class, converter:IConverter):Object {
	        var result:Object;
	        try {
	            types.push(_mapper.defaultImplementationOf(type));
	            result = converter.unmarshal(_reader, this);
	            types.pop();
	            return result;
	        } catch (conversionException:ConversionException) {
	            addInformationTo(conversionException, type);
	            throw conversionException;
	        }
	        return result;
	    }
	    
	    public function start(dataHolder:IDataHolder):Object {
	        this.dataHolder = dataHolder;
	        //class attribute can force marshalling to particular type
	        var classAttribute:String = _reader.getAttribute(mapper.aliasForAttribute(null, "class"));
	        var type:Class;
	        if (classAttribute == "") {
	            type = mapper.realClass(_reader.getNodeName());
	        } else {
	            type = mapper.realClass(classAttribute);
	        }
	        var result:Object = convertAnother(null, type, null);
	        /* var validations:Iterator = validationList.iterator();
	        while (validations.hasNext()) {
	            validations.next();
	        } */
	        return result;
	    }
	    private function addInformationTo(error:Error, type:Class):void {
	        error.message+=" class:"+getQualifiedClassName(type);
	        error.message+=" required-type:"+getQualifiedClassName(getRequiredType());
	    }
	    
		public function put(key:Object, value:Object):void
		{
			lazilyCreateDataHolder();
       		dataHolder.put(key, value);
		}
		
		public function get(key:Object):Object
		{
			lazilyCreateDataHolder();
       		return dataHolder.get(key);
		}
		
		public function currentObject():Object
		{
			return types.size() == 1 ? _root : null;
		}
		
		public function keys():Iterator
		{
			lazilyCreateDataHolder();
        	return dataHolder.keys();
		}
		
		public function getRequiredType():Class
		{
			 return types.peek() as Class;
		}
		
		private function lazilyCreateDataHolder():void {
        if (dataHolder == null) {
            dataHolder = new MapBackedDataHolder();
        	}
    	}
    	
    	protected function get mapper():IMapper {return this._mapper;}
		
	}
}