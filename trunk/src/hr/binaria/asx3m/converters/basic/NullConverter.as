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

package hr.binaria.asx3m.converters.basic
{
	import hr.binaria.asx3m.converters.IConverter;
	import hr.binaria.asx3m.io.IHierarchicalStreamWriter;
	import hr.binaria.asx3m.converters.IMarshallingContext;
	import hr.binaria.asx3m.converters.IUnmarshallingContext;
	import hr.binaria.asx3m.io.IHierarchicalStreamReader;

	public class NullConverter implements IConverter
	{
		public function NullConverter()
			{
			super();
		}

		public function canConvert(type:Class):Boolean
		{
			return type == null;
		}
		
		public function marshal(source:Object, writer:IHierarchicalStreamWriter, context:IMarshallingContext):void
		{
			writer.startNode("null");
			writer.endNode();
		}
		
		public function unmarshal(reader:IHierarchicalStreamReader, context:IUnmarshallingContext):Object
		{
			return null;
		}
		
	}
}