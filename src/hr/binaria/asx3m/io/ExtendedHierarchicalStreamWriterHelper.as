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
	import hr.binaria.asx3m.io.IHierarchicalStreamWriter;
	
	public class ExtendedHierarchicalStreamWriterHelper
	{
		public static function startNode(writer:IHierarchicalStreamWriter, name:String, type:Class):void {
        if (writer is IExtendedHierarchicalStreamWriter) {
            ((IHierarchicalStreamWriter) (writer)).startNode(name, type);
        } else {
            writer.startNode(name);
        }
    }
	}
}