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

package hr.binaria.asx3m.converters.reflection
{
	
	public interface IReflectionProvider
	{
	
	/**
	 * Creates a new instance of the specified type. It is in the responsibility
         * of the implementation how such an instance is created.
	 * @param type	the type to instantiate
	 * @return	a new instance of this type
	 */
    function newInstance(type:Class):Object;
    
    function writeField(object:Object, fieldName:String, value:Object, definedIn:Class):void;

    function getFieldType(object:Object, fieldName:String, definedIn:Class):Class;

    function fieldDefinedInClass(fieldName:String, type:Class):Boolean;

    /**
     * Returns a field defined in some class.
     * @param definedIn	class where the field was defined
     * @param fieldName	field name
     * @return	the field itself
     */
	function getField(definedIn:Class, fieldName:String):*;
	}
}