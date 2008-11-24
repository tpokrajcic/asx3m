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

package hr.binaria.asx3m
{	
	import flash.utils.*;
	
	import hr.binaria.asx3m.annotations.AnnotatedWrapper;
	import hr.binaria.asx3m.annotations.Annotation;
	import hr.binaria.asx3m.converters.*;
	import hr.binaria.asx3m.converters.basic.*;
	import hr.binaria.asx3m.converters.collections.ArrayConverter;
	import hr.binaria.asx3m.converters.collections.ListConverter;
	import hr.binaria.asx3m.converters.collections.MapConverter;
	import hr.binaria.asx3m.converters.extended.DateConverter;
	import hr.binaria.asx3m.converters.reflection.*;
	import hr.binaria.asx3m.core.DefaultConverterLookup;
	import hr.binaria.asx3m.core.TreeMarshallingStrategy;
	import hr.binaria.asx3m.io.IHierarchicalStreamDriver;
	import hr.binaria.asx3m.io.IHierarchicalStreamReader;
	import hr.binaria.asx3m.io.IHierarchicalStreamWriter;
	import hr.binaria.asx3m.io.xml.E4XReader;
	import hr.binaria.asx3m.io.xml.E4XWriter;
	import hr.binaria.asx3m.mapper.ClassAliasingMapper;
	import hr.binaria.asx3m.mapper.DefaultImplementationsMapper;
	import hr.binaria.asx3m.mapper.DefaultMapper;
	import hr.binaria.asx3m.mapper.IMapper;
	import hr.binaria.asx3m.mapper.ImmutableTypesMapper;
	
	import mx.collections.ArrayCollection;
	
	import vegas.data.map.HashMap;
	
	public class Asx3m
	{
		public static const NO_REFERENCES:int = 1001;
	    public static const ID_REFERENCES:int = 1002;
	    public static const XPATH_RELATIVE_REFERENCES:int = 1003;
	    public static const XPATH_ABSOLUTE_REFERENCES:int = 1004;
	    
	    public static const PRIORITY_VERY_HIGH:int = 10000;
	    public static const PRIORITY_NORMAL:int = 0;
	    public static const PRIORITY_LOW:int = -10;
	    public static const PRIORITY_VERY_LOW:int = -20;
		
		private var _marshallingStrategy:IMarshallingStrategy;
		private var _converterLookup:DefaultConverterLookup;
		private var _mapper:IMapper;
		private var _classAliasingMapper:ClassAliasingMapper;
		private var _defaultImplementationsMapper:DefaultImplementationsMapper;
		private var _reflectionProvider:IReflectionProvider;
		private var _serializationMode:Number;
		
		public function Asx3m(caller:Object, reflectionProvider:IReflectionProvider=null, mapper:IMapper=null, driver:IHierarchicalStreamDriver=null){
			if (accessRights(caller)){
				_marshallingStrategy=new TreeMarshallingStrategy();
				_mapper = mapper == null ? buildMapper() : mapper;
				_converterLookup = new DefaultConverterLookup(_mapper);
				_reflectionProvider = reflectionProvider;
	       
				setupMappers();
				setupDefaultImplementations();
				setupAliases();
				setupConverters();	    	 
				preinitClasses();
			}
		}
		
		public function marshall(obj:Object, writer:IHierarchicalStreamWriter, dataHolder:IDataHolder ):void {	
			_marshallingStrategy.marshall(obj, writer, _converterLookup, _mapper, dataHolder);	
		}
		
		public function unmarshall(reader:IHierarchicalStreamReader, root:Object, dataHolder:IDataHolder):Object {
	        return _marshallingStrategy.unmarshall(root, reader, dataHolder, _converterLookup, _mapper);
	    }
		public function toXML(obj:Object):XML {
			var xmlXStream:XML=<dummy/>;
	        var writer:IHierarchicalStreamWriter = new E4XWriter(xmlXStream);
	        marshall(obj, writer, null);
	        return xmlXStream;
	    }
	    public function fromXML(xml:XML):Object {
	    	var reader:E4XReader=new E4XReader(xml);
	        return unmarshall(reader, null, null);
	    }
	    /**
	    * Enables user-defined type mapping during runtime. 
	    * Example use is adapting standard AS3 types to server method argument types.
	    * AS3 Number can regulary be serialized as Java int, float, uint etc. and there must 
	    * be a way of defining a desired type at the moment of serialization call. 
	    */
	    
	    public function toCustomTypedXML(obj:Object, customType:String):XML{
	    	var xmlXStream:XML=<start/>;
		    var writer:IHierarchicalStreamWriter = new E4XWriter(xmlXStream);
		    if (customType!=null){
			    var annotation:Annotation=new Annotation(null, "JavaType", customType);
			    /**
			    * AnnotatedWrapper is tunneled all the way to IMarshallingContext class.
			    * There it's extracted and Object is provided to appropriate Converter class.
			    * Annotation is used within IMarshallingContext to start a node with provided type name.
			    */
			    _marshallingStrategy.marshall(new AnnotatedWrapper(obj,annotation), writer, _converterLookup, _mapper, null);	
		    }
		    else { 
		    	marshall(obj, writer, null);
		    }
		    return xmlXStream;
	    }
	    
	    protected function setupMappers():void {
	    	var mapperNamespace:String="hr.binaria.asx3m.mapper.";
	        _classAliasingMapper = ClassAliasingMapper (_mapper.lookupMapperOfType(Class (getDefinitionByName(mapperNamespace+"ClassAliasingMapper"))));
	 	  	_defaultImplementationsMapper = DefaultImplementationsMapper (_mapper.lookupMapperOfType(Class (getDefinitionByName(mapperNamespace+"DefaultImplementationsMapper"))));
	 	}
	 	protected function setupAliases():void {
	 		alias("string",getDefinitionByName("String") as Class);
	 		alias("boolean",getDefinitionByName("Boolean") as Class);
	 		alias("int",getDefinitionByName("Number") as Class);
	 		alias("long",getDefinitionByName("Number") as Class);
	 		alias("double",getDefinitionByName("Number") as Class);
	 		alias("big-decimal",getDefinitionByName("Number") as Class);
	 		alias("object",getDefinitionByName("Object") as Class);
	 		alias("map", getDefinitionByName(getQualifiedClassName(new HashMap())) as Class);
	 		alias("list", getDefinitionByName(getQualifiedClassName(new ArrayCollection())) as Class);
	 		aliasType("sql-timestamp", getDefinitionByName(getQualifiedClassName(new Date())) as Class);
	 	} 
	 	protected function setupConverters():void{
	 		var reflectionConverter:ReflectionConverter;
	 		reflectionConverter = new ReflectionConverter(_mapper, _reflectionProvider);
	        registerConverter(reflectionConverter, PRIORITY_VERY_LOW); 
	        registerConverter(new NullConverter(), PRIORITY_NORMAL);
	        registerSingleValueConverter(new StringConverter(), PRIORITY_NORMAL);
	        registerSingleValueConverter(new NumberConverter(), PRIORITY_NORMAL);
	        registerSingleValueConverter(new BooleanConverter(), PRIORITY_NORMAL);
	        registerSingleValueConverter(new DateConverter(), PRIORITY_NORMAL);
	        registerConverter(new MapConverter(_mapper), PRIORITY_NORMAL);
	        registerConverter(new ListConverter(_mapper), PRIORITY_NORMAL);
	        registerConverter(new ArrayConverter(_mapper), PRIORITY_NORMAL);
	        //TODO: register all other converters       		
	 	}
	 	protected function setupImmutableTypes():void {
	 		
	 	}
	 	protected function setupDefaultImplementations():void {
	 		if (_defaultImplementationsMapper == null) {
	            return;
	        }
	        //addDefaultImplementation(getDefinitionByName(getQualifiedClassName(new HashMap())) as Class, getDefinitionByName(getQualifiedClassName()) as Class);
	 	}
	 	public function addDefaultImplementation(defaultImplementation:Class, ofType:Class):void {
	        if (_defaultImplementationsMapper == null) {
	            /* throw new InitializationException("No "
	                    + DefaultImplementationsMapper.class.getName()
		                    + " available"); */
	        }
	        _defaultImplementationsMapper.addDefaultImplementation(defaultImplementation, ofType);
	    }
	    private function buildMapper():IMapper{
	    	var mapper:IMapper=new DefaultMapper();
	    	mapper = new ClassAliasingMapper(mapper);
	    	mapper = new DefaultImplementationsMapper(mapper);
	    	mapper = new ImmutableTypesMapper(mapper);
	        return mapper;
	    }
	    public function alias(name:String, type:Class):void {
	        if (_classAliasingMapper == null) {
	            throw new InitializationException("No "
	                    + ClassAliasingMapper//.class.getName()
	                    + " available");
	        }
	        _classAliasingMapper.addClassAlias(name, type);
	    }
	    public function aliasType(name:String, type:Class):void {
	        if (_classAliasingMapper == null) {
	            throw new InitializationException("No "
	                    + ClassAliasingMapper//.class.getName()
	                    + " available");
	        }
	        _classAliasingMapper.addTypeAlias(name, type);
	    }
	    public function registerConverter(converter:IConverter, priority:int):void {
	        _converterLookup.registerConverter(converter, priority);
	    }
	    public function registerSingleValueConverter(converter:ISingleValueConverter, priority:int):void {
	        _converterLookup.registerConverter(new SingleValueConverterWrapper(converter), priority);
	    }
	    
	    //Class must be instantiated once or Flex can't recognize it!
	    private function preinitClasses():void {	
	    }
	    
	    private function accessRights(caller:Object):Boolean{
	    	return caller is Asx3mer;	    	
	    }
    
	}
}