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
	public class ConversionException extends Error
	{
		public function ConversionException(message:String="", id:int=0)
		{
			super(message, id);			
		}
		
	}
}