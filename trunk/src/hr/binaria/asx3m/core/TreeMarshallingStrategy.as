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
	import hr.binaria.asx3m.IMarshallingStrategy;
	import hr.binaria.asx3m.converters.IConverterLookup;
	import hr.binaria.asx3m.converters.IDataHolder;
	import hr.binaria.asx3m.io.IHierarchicalStreamReader;
	import hr.binaria.asx3m.io.IHierarchicalStreamWriter;
	import hr.binaria.asx3m.mapper.IMapper;

	public class TreeMarshallingStrategy implements IMarshallingStrategy
	{
		public function unmarshall(root:Object, reader:IHierarchicalStreamReader, dataHolder:IDataHolder, converterLookup:IConverterLookup, mapper:IMapper):Object
		{
			var unmarshaller:TreeUnmarshaller=new TreeUnmarshaller(root,reader,converterLookup,mapper);
			return unmarshaller.start(dataHolder);
		}
		
		public function marshall(obj:Object, writer:IHierarchicalStreamWriter, converterLookup:IConverterLookup, mapper:IMapper, dataHolder:IDataHolder):void
		{
			var marshaller:TreeMarshaller=new TreeMarshaller(writer,converterLookup,mapper);
			marshaller.start(obj,dataHolder);
		}
		
	}
}