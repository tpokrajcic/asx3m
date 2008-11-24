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

package hr.binaria.asx3m.mapper
{
	import flash.utils.*;
	
	import vegas.data.Map;
	import vegas.data.Set;
	import vegas.data.iterator.Iterator;
	import vegas.data.map.HashMap;
	import vegas.data.sets.HashSet;
	
	public class ClassAliasingMapper extends MapperWrapper
	{
		protected var typeToName:Map = new HashMap();
	    protected var classToName:Map = new HashMap();
	    protected var nameToType:Map = new HashMap();
	    protected var knownAttributes:Set = new HashSet();
			
		public function ClassAliasingMapper(wrapped:IMapper){
			super(wrapped);
		}
		
		public function addClassAlias(name:String, type:Class):void {
	        nameToType.put(name, getQualifiedClassName(type));
	        classToName.put(getQualifiedClassName(type), name);
    	}
		
		public function addClassAttributeAlias(name:String, type:Class):void {
        addClassAlias(name, type);
        knownAttributes.insert(name);
	    }
	
	    public function addTypeAlias(name:String, type:Class):void {
	        nameToType.put(name, getQualifiedClassName(type));
	        typeToName.put( getQualifiedClassName(type), name);
	    }
	    
	    public function temTypeAsAttribute(clazz:Class):Boolean {
	        return classToName.containsKey(clazz);
	    }
	
	    public function aliasIsAttribute(name:String):Boolean  {
	        return nameToType.containsKey(name);
	    }
	    
	    public override function serializedClass(type:Class):String {
	        var alias:String = String (classToName.get(getQualifiedClassName(type)));
	        if (alias != "undefined") {
	            return alias;
	        } else {
	            for (var iter:Iterator = typeToName.keyIterator(); iter.hasNext();) {
	                var compatibleType:Class = Class (flash.utils.getDefinitionByName(iter.next()));
	                if (type is compatibleType) {
	                    return String (typeToName.get(compatibleType));
	                }
	            }
	            return super.serializedClass(type);
	        }
   		 }
   		 
   		 public override function realClass(elementName:String):Class {
	        var mappedName:String = nameToType.get(elementName);
	
	        if (mappedName != null) {
	            var type:Class = primitiveClassNamed(mappedName);
	            if (type != null) {
	                return type;
	            }
	            elementName = mappedName;
	        }
	        return super.realClass(elementName);
	    }
	    
	     private function readResolve():Object {
	        var nameToType:Map = new HashMap();
	        for (var iter:Iterator = classToName.keyIterator(); iter.hasNext();) {
	            var type:Object = iter.next();
	            nameToType.put(classToName.get(type), type);
	        }
	        for (iter = typeToName.keyIterator(); iter.hasNext();) {
	            type = Class (iter.next());
	            nameToType.put(typeToName.get(type), getQualifiedClassName(type));
	        }        
	        return this;
	    }
	    
	    private function primitiveClassNamed(name:String):Class {
	          var result:Class=Class ((name=="boolean") ?  getDefinitionByName("Boolean") :
		                (name=="byte") ? getDefinitionByName("int") :
		                (name=="char") ? getDefinitionByName("String"):
		                (name=="short") ? getDefinitionByName("int") :
		                (name=="int") ? getDefinitionByName("int") :
		                (name=="long") ? getDefinitionByName("Number") :
		                (name=="big-decimal") ? getDefinitionByName("Number") : 
		                (name=="float") ? getDefinitionByName("Number") : 
		                (name=="double") ? getDefinitionByName("Number") :  
		                null);
	          return result;	                            
	    }		
	}
}