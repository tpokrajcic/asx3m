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
	import vegas.data.iterator.Iterator;
	
	public interface IHierarchicalStreamReader
	{
	
	/**
     * Retrieve the current processed node.
     * 
     * @return the current node
     */
	function getCurrent():*;
	/**
     * Does the node have any more children remaining that have not yet been read?
     */
    function hasMoreChildren():Boolean;

    /**
     * Select the current child as current node.
     * A call to this function must be balanced with a call to {@link #moveUp()}.
     */
    function moveDown():void;

    /**
     * Select a parent node as current node.
     */
    function moveUp():void;

    /**
     * Get a name of the current node.
     */
    function getNodeName():String;

    /**
     * Get a value (text content) of the current node.
     */
    function getValue():String;

    /**
     * Get a value of an attribute for the current node. 
     */
    function getAttribute(name:String):String;
    
    
    /**
     * Number of attributes in current node.
     */
    function getAttributeCount():int;

    /**
     * Name of attribute in current node.
     */
    function getAttributeName(index:int):String;

    /**
     * Names of attributes (as Strings). 
     */
    function getAttributeNames():Iterator;

    /**
     * If any errors are detected, allow the reader to add any additional information that can aid debugging
     * (such as line numbers, XPath expressions, etc).
     
    function appendErrors(ErrorWriter errorWriter):void;
    * */

    /**
     * Close the reader, if necessary.
     */
    function close():void;

    /**
     * Return the underlying HierarchicalStreamReader implementation.
     *
     * <p>If a Converter needs to access methods of a specific HierarchicalStreamReader implementation that are not
     * defined in the HierarchicalStreamReader interface, it should call this method before casting. This is because
     * the reader passed to the Converter is often wrapped/decorated by another implementation to provide additional
     * functionality (such as XPath tracking).</p>
     *
     * <p>For example:</p>
     * <pre>MySpecificReader mySpecificReader = (MySpecificReader)reader; <b>// INCORRECT!</b>
     * mySpecificReader.doSomethingSpecific();</pre>

     * <pre>MySpecificReader mySpecificReader = (MySpecificReader)reader.underlyingReader();  <b>// CORRECT!</b>
     * mySpecificReader.doSomethingSpecific();</pre>
     *
     * <p>Implementations of HierarchicalStreamReader should return 'this', unless they are a decorator, in which case
     * they should delegate to whatever they are wrapping.</p>
     */
    function underlyingReader():IHierarchicalStreamReader;
	}
}