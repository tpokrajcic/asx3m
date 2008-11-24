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
	import flash.utils.getDefinitionByName;
	
	import hr.binaria.asx3m.converters.ISingleValueConverter;
	
	import system.Reflection;
	

	public class DefaultMapper implements IMapper
	{
		public function shouldSerializeMember(definedIn:Class, fieldName:String):Boolean
		{
			return true;
		}
		
		public function attributeForAlias(definedIn:Class, alias:String):String
		{
			return alias;
		}
		
		public function realMember(type:Class, serialized:String):String
		{
			return serialized;
		}
		
		public function isImmutableValueType(type:Class):Boolean
		{
			return false;
		}
		
		public function lookupMapperOfType(type:Class):IMapper
		{
			return null;
		}
		
		public function serializedClass(type:Class):String
		{
			var className:String=(Reflection.getClassName(type, true)).replace(/::/,".");	
			return (className);
		}
		
		public function getConverterFromAttribute(type:Class, attribute:String):ISingleValueConverter
		{
			return null;
		}
		
		public function aliasForAttribute(definedIn:Class, fieldName:String):String
		{
			return fieldName;
		}
		
		public function getItemTypeForItemFieldName(definedIn:Class, itemFieldName:String):Class
		{
			return null;
		}
		
		public function getFieldNameForItemTypeAndName(definedIn:Class, itemType:Class, itemFieldName:String):String
		{
			return null;
		}
		
		public function defaultImplementationOf(type:Class):Class
		{
			return type;
		}
		
		public function serializedMember(type:Class, memberName:String):String
		{
			return memberName;
		}
		
		public function getConverterFromItemType(fieldName:String, type:Class, definedIn:Class):ISingleValueConverter
		{
			return null;
		}
		
		public function realClass(elementName:String):Class
		{
			var realClass:Class=null;
			try {
				elementName=convertToFlexClassName(elementName);
           		realClass=flash.utils.getDefinitionByName(elementName) as Class;
	        } catch (e:ReferenceError) {
	            //TODO: throw exception
	            //throw new CannotResolveClassException(elementName + " : " + e.getMessage());
	        }
	        return realClass;
		}
		
		//not in interface:
		
		public function lookupName(type:Class):String {
	        return serializedClass(type);
	    }

	    public function lookupType(elementName:String):Class {
	        return realClass(elementName);
	    }
	    
	    private function convertToFlexClassName(name:String):String {
	    	//skip if already flex name. 
	    	//if there are any "." and none "::", replace last "." with "::"
	    	if (name.indexOf(".")!=-1 && name.indexOf("::")==-1){
	    		var nameSeparatorIndex:int=name.lastIndexOf(".");
	    		name=name.substring(0,nameSeparatorIndex)+"::"+name.substring(nameSeparatorIndex+1, name.length);
	    	}
	    	return name;
	    }
	}
}