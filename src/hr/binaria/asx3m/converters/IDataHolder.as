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
	import system.data.Iterator;
	
	public interface IDataHolder
	{
	function get(key:Object):Object;
    function put(key:Object,value:Object):void;
    function keys():Iterator;
	}
}