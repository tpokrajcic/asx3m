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

package hr.binaria.asx3m.io.xml
{
	import hr.binaria.asx3m.io.IHierarchicalStreamWriter;
	
	import system.data.List;
	import system.data.lists.ArrayList;
	import system.data.stacks.ArrayStack;

	public class E4XWriter implements IHierarchicalStreamWriter
	{
		private var _result:List;
		private var _nodeStack:ArrayStack;
		
		/** 
		 * container - XML object that holds result.
		 */ 
		public function E4XWriter(container:XML){					
			container.setName("root_helper");
			_nodeStack=new ArrayStack();
			_result=new ArrayList();			
			if (container != null) {
	            _nodeStack.push(container);
	            _result.add(container);
       		 }
		}
		
		public function flush():void
		{
			//do nothing
		}
		public function close():void{
			//do nothing
		}
		
		public function endNode():void
		{
			var node:XML = _nodeStack.pop();
			if (_nodeStack.size() == 0) {
				_result.add(node);
       		}
		}
		
		public function startNode(name:String):void
		{			
			//replace <root_helper/> node with root node of serialized object  
			if (_nodeStack.size()==1 && _nodeStack.peek()==<root_helper/>){	
				_nodeStack.peek().setName(name);
			}
			else {
				_nodeStack.push(createNode(name));
			}
		}
		
		public function createNode(name:String):XML 
		{	
			var node:XML=<new/>;
			node.setName(name);
			if (top()!=null){
				top().appendChild(node);
			}
			return node;			
		}
		
		public function addAttribute(name:String, value:String):void
		{			
			top().@[name]=value;
		}
		
		public function setValue(text:String):void
		{
			top().appendChild(text);
		}		
		
		public function underlyingWriter():IHierarchicalStreamWriter
		{			
			return null;
		}	
		
		public function getCurrent():XML {
        	return _nodeStack.peek();
    	}
	    private function top():XML{
		    return getCurrent();
	    }
	    public function getTopLevelNodes():List {
	        return _result;
	    }
		
	}
}