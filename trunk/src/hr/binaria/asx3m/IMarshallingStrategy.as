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

package hr.binaria.asx3m
{
	import hr.binaria.asx3m.converters.IConverterLookup;
	import hr.binaria.asx3m.mapper.IMapper;
	import hr.binaria.asx3m.io.IHierarchicalStreamWriter;
	import hr.binaria.asx3m.io.IHierarchicalStreamReader;
	import hr.binaria.asx3m.converters.IDataHolder;
	
	public interface IMarshallingStrategy
	{
		function unmarshall(root:Object, reader:IHierarchicalStreamReader, dataHolder:IDataHolder, converterLookup:IConverterLookup, mapper:IMapper):Object;
		function marshall(obj:Object, writer:IHierarchicalStreamWriter, converterLookup:IConverterLookup, mapper:IMapper, dataHolder:IDataHolder):void;		
	}
}