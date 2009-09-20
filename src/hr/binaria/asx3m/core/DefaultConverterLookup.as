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
	import hr.binaria.asx3m.converters.IConverterLookup;
	import hr.binaria.asx3m.converters.IConverter;
	import hr.binaria.asx3m.mapper.IMapper;
	import hr.binaria.asx3m.core.util.PrioritizedList;
	import system.data.Map;
	import system.data.maps.HashMap;
	import system.data.List;
	import system.data.lists.ArrayList;
	import system.data.Iterator;
	import hr.binaria.asx3m.converters.ISingleValueConverter;

	public class DefaultConverterLookup implements IConverterLookup
	{
		//TODO: make it PrioritizedList
		//private var converters:PrioritizedList = new PrioritizedList();
		private var converters:ArrayList = new ArrayList();
	    private var typeToConverterMap:Map = new HashMap();
	    private var mapper:IMapper;
		
		public function DefaultConverterLookup(mapper:IMapper){
			this.mapper=mapper;
		}
		
		public function lookupConverterForType(type:Class):IConverter
		{
			var cachedConverter:IConverter = IConverter (typeToConverterMap.get(type));
	        if (cachedConverter != null) {
	        	return cachedConverter;
	        }
	        var mapType:Class = mapper.defaultImplementationOf(type);
	        var iterator:Iterator = converters.iterator();
	        while (iterator.hasNext()) {
	            var converter:IConverter = IConverter (iterator.next());
	            if (converter.canConvert(mapType)) {
	                typeToConverterMap.put(type, converter);
	                return converter;
	            }
	        }
	        //TODO: throw exception
	        //throw new ConversionException("No converter specified for " + type);
	        return null;
		}
		
		public function registerConverter(converter:IConverter, priority:int):void {
	        //TODO: PrioritizedList
	        //converters.add(converter, priority);
	        if (priority<0){
	        	//have to put reflectionconverter to the bottom. 
	        	converters.addAt(converters.lastIndexOf+1,converter);
	        }
	        else {
	        	converters.addAt(0,converter);
	        }
	        for (var iter:Iterator = this.typeToConverterMap.keyIterator(); iter.hasNext();) {
	            var type:Class = Class (iter.next());
	            if (converter.canConvert(type)) {
	                iter.remove();
	            }
	        }
	    }		    
	}
}