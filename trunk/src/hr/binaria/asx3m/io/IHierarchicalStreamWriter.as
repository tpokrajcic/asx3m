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

package hr.binaria.asx3m.io
{
	
	public interface IHierarchicalStreamWriter
	{
		function startNode(name:String):void;

    	function addAttribute(name:String, value:String):void;

	    /**
	     * Write the value (text content) of the current node.
	     */
    	function setValue(text:String):void;

    	function endNode():void;

	    /**
	     * Flush the writer, if necessary.
	     */
    	function flush():void;

	    /**
	     * Close the writer, if necessary.
	     */
   		 function close():void;

	    
     	function underlyingWriter():IHierarchicalStreamWriter;
	}
}