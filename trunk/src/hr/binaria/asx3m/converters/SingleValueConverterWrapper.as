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

package hr.binaria.asx3m.converters
{
	import hr.binaria.asx3m.io.IHierarchicalStreamWriter;
	import hr.binaria.asx3m.io.IHierarchicalStreamReader;

	public class SingleValueConverterWrapper implements IConverter, ISingleValueConverter
	{
		private var wrapped:ISingleValueConverter;
		
		public function SingleValueConverterWrapper(wrapped:ISingleValueConverter){
			this.wrapped = wrapped;
		}
		
		public function marshal(source:Object, writer:IHierarchicalStreamWriter, context:IMarshallingContext):void
		{
			writer.setValue(toString(source));
		}
		
		public function unmarshal(reader:IHierarchicalStreamReader, context:IUnmarshallingContext):Object
		{
			return fromString(reader.getValue()); 
		}
		
		public function canConvert(type:Class):Boolean
		{
			return wrapped.canConvert(type);
		}
		
		public function toString(obj:Object):String
		{
			var stringValue:String=wrapped.toString(obj);
			return stringValue;
		}
		
		public function fromString(str:String):Object
		{
			return wrapped.fromString(str);
		}
		
	}
}