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
	public interface ISingleValueConverter extends IConverterMatcher
	{
		/**
	     * Marshalls an Object into a single value representation.
	     * @param obj the Object to be converted
	     * @return a String with the single value of the Object or <code>null</code>
	     */
	    function toString(obj:Object):String;
	
	    /**
	     * Unmarshalls an Object from its single value representation.
	     * @param str the String with the single value of the Object
	     * @return the Object
	     */
	    function fromString(str:String):Object;
		}
}