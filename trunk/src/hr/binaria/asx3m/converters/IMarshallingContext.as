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
	public interface IMarshallingContext extends IDataHolder
	{
		/**
		 * Converts another object searching for the default converter
		 * @param nextItem	the next item to convert
		 */
		 //no overloading in as3
		//function convertAnother(nextItem:Object):void;
		
		/**
	     * Converts another object using the specified converter
	     * @param nextItem	the next item to convert
	     * @param converter	the Converter to use
	     * @since 1.2
	     */
		function convertAnother(nextItem:Object, converter:IConverter):void;
	}
}