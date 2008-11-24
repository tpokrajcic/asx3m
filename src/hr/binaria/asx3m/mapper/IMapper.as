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
	
	public interface IMapper
	{
    
    /**
     * How a class name should be represented in its serialized form.
     */
    function serializedClass(type:Class):String;

    /**
     * How a serialized class representation should be mapped back to a real class.
     */
    function realClass(elementName:String):Class;

    /**
     * How a class member should be represented in its serialized form.
     */
    function serializedMember(type:Class, memberName:String):String;

    /**
     * How a serialized member representation should be mapped back to a real member.
     */
    function realMember(type:Class, serialized:String):String;

    /**
     * Whether this type is a simple immutable value (int, boolean, String, URL, etc.
     * Immutable types will be repeatedly written in the serialized stream, instead of using object references.
     */
    function isImmutableValueType(type:Class):Boolean;

    function defaultImplementationOf(type:Class):Class;

    /**
     * Get the name of the field that acts as the default collection for an object, or return null if there is none.
     *
     * @param definedIn     owning type
     * @param itemType      item type
     * @param itemFieldName optional item element name
     */
    function getFieldNameForItemTypeAndName(definedIn:Class, itemType:Class, itemFieldName:String):String;

    function getItemTypeForItemFieldName(definedIn:Class, itemFieldName:String):Class;

    //function getImplicitCollectionDefForFieldName(itemType:Class, fieldName:String):ImplicitCollectionMapping;

    /**
     * Determine whether a specific member should be serialized.
     *
     * @since 1.1.3
     */
    function shouldSerializeMember(definedIn:Class, fieldName:String):Boolean;

   /*  interface ImplicitCollectionMapping {
        String getFieldName();
        String getItemFieldName();
        Class getItemType();
    } */
    
    function lookupMapperOfType(type:Class):IMapper;

    /**
     * Returns a single value converter to be used in a specific field.
     * 
     * @param fieldName the field name
     * @param type the field type
     * @param definedIn the type which defines this field
     * @return a SingleValueConverter or null if there no such converter should be used for this
     *         field.
     * since 1.2.2
     */
    function getConverterFromItemType(fieldName:String, type:Class, definedIn:Class):ISingleValueConverter;

    /**
     * Returns an alias for a single field defined in an specific type.
     * 
     * @param definedIn the type where the field was defined
     * @param fieldName the field name
     * @return the alias for this field or its own name if no alias was defined
     * since 1.2.2
     */
    function aliasForAttribute(definedIn:Class, fieldName:String):String;

    /**
     * Returns the field name for an aliased attribute.
     * 
     * @param definedIn the type where the field was defined
     * @param alias the alias
     * @return the original attribute name
     * since 1.2.2
     */
    function attributeForAlias(definedIn:Class, alias:String):String;

    /**
     * Returns which converter to use for an specific attribute in a type.
     * 
     * @param type the field type
     * @param attribute the attribute name
     * since 1.2.2
     */
    function getConverterFromAttribute(type:Class, attribute:String):ISingleValueConverter;
}
}
