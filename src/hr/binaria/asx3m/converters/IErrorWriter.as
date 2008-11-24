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
	/**
	 * To aid debugging, some components are passed an ErrorWriter
	 * when things go wrong, allowing them to add information
	 * to the error message that may be helpful to diagnose problems.
	 *
	 * @author Joe Walnes
	 */
	public interface IErrorWriter
	{		
	
	/**
     * Add some information to the error message.
     *
     * @param name        Something to identify the type of information (e.g. 'XPath').
     * @param information Detail of the message (e.g. '/blah/moo[3]'
     */
	function add(name:String, information:String):void;
	}
}