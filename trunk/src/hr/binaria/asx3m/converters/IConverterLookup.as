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
	import hr.binaria.asx3m.converters.IConverter;
	
	public interface IConverterLookup
	{
		/**
	     * Lookup a converter for a specific type.
	     * <p/>
	     * This type may be any Class, including primitive and array types. It may also be null, signifying
	     * the value to be converted is a null type.
	     */
	    function lookupConverterForType(type:Class):IConverter;
		}
}