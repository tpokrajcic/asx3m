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

package hr.binaria.asx3m.mapper
{
	import hr.binaria.asx3m.converters.ISingleValueConverter;
	

	public class MapperWrapper implements IMapper
	{
		private var wrapped:IMapper;

	    public function MapperWrapper(wrapped:IMapper) {
	        this.wrapped = wrapped;
	    }
		
		public function getConverterFromItemType(fieldName:String, type:Class, definedIn:Class):ISingleValueConverter
		{			
			return wrapped.getConverterFromItemType(fieldName, type, definedIn);
		}
		
		public function serializedMember(type:Class, memberName:String):String
		{			
			return wrapped.serializedMember(type, memberName);
		}
		
		public function lookupMapperOfType(type:Class):IMapper
		{			
			//return wrapped.lookupMapperOfType(type);
			return this is type ? this : wrapped.lookupMapperOfType(type);
		}
		
		public function defaultImplementationOf(type:Class):Class
		{			
			return wrapped.defaultImplementationOf(type);
		}
		
		public function realMember(type:Class, serialized:String):String
		{			
			return wrapped.realMember(type, serialized);
		}
		
		public function aliasForAttribute(definedIn:Class, fieldName:String):String
		{			
			return wrapped.aliasForAttribute(definedIn, fieldName);
		}
		
		public function getConverterFromAttribute(type:Class, attribute:String):ISingleValueConverter
		{			
			return wrapped.getConverterFromAttribute(type, attribute);
		}
		
		public function shouldSerializeMember(definedIn:Class, fieldName:String):Boolean
		{			
			return wrapped.shouldSerializeMember(definedIn, fieldName);
		}
		
		public function attributeForAlias(definedIn:Class, alias:String):String
		{
			
			return wrapped.attributeForAlias(definedIn, alias);
		}
		
		public function realClass(elementName:String):Class
		{			
			return wrapped.realClass(elementName);
		}
		
		public function getFieldNameForItemTypeAndName(definedIn:Class, itemType:Class, itemFieldName:String):String
		{			
			return wrapped.getFieldNameForItemTypeAndName(definedIn, itemType, itemFieldName);
		}
		
		public function isImmutableValueType(type:Class):Boolean
		{			
			return wrapped.isImmutableValueType(type);
		}
		
		public function getItemTypeForItemFieldName(definedIn:Class, itemFieldName:String):Class
		{			
			return wrapped.getItemTypeForItemFieldName(definedIn, itemFieldName);
		}
		
		public function serializedClass(type:Class):String
		{			
			return wrapped.serializedClass(type);
		}
		
	}
}