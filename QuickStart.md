# Introduction #
Here's a simple code that illustrates usage of asx3m library.<br>
It defines two DTO classes and de/serializes them.<br>
All public properties are serialized, no matter if they are defined over getter/setter or directly.<br>
<br>
<pre><code>package hr.binaria.dto <br>
{<br>
	public class Client<br>
	{<br>
		private var _age:int;<br>
		<br>
		public var id:Number;<br>
		public var name:String;<br>
		public var contacted:Boolean;<br>
		public var mainProduct:Product;<br>
		public var products:Array;<br>
		<br>
		public function get age():int{<br>
			return _age;<br>
		}<br>
		public function set age(value:int):void {<br>
			return _age;<br>
		}<br>
	}<br>
}<br>
<br>
package hr.binaria.dto<br>
{<br>
	public class Product<br>
	{<br>
		public var id:Number;<br>
		public var name:String;<br>
	}<br>
}<br>
<br>
package {<br>
       import flash.display.Sprite;<br>
	<br>
       import hr.binaria.dto.Product;<br>
       import hr.binaria.dto.Client;<br>
       import hr.binaria.asx3m.Asx3mer;<br>
<br>
	public class Asx3mTest extends Sprite<br>
	{<br>
                		<br>
		public function Asx3mTest()<br>
		{	<br>
			<br>
			var client:Client=new Client();				<br>
			client.contacted=false;<br>
			client.name="John";<br>
			<br>
			client.mainProduct=new Product();<br>
			client.mainProduct.id=0;<br>
			client.mainProduct.name="Main product";<br>
			<br>
			var prod1:Product=new Product();<br>
			prod1.id=1;<br>
			prod1.name="Product 1";<br>
			var prod2:Product=new Product();<br>
			prod2.id=2;<br>
			prod2.name="Product 2";<br>
			<br>
			client.products=new Array;<br>
			client.products.push(prod1);<br>
			client.products.push(prod2);<br>
						<br>
			//convert object to XML<br>
			var xmlObj:XML=Asx3mer.instance.toXML(client);<br>
			trace(xmlObj);	<br>
<br>
			//decode object from XML				<br>
			var clientDecoded:Client=Asx3mer.instance.fromXML(xmlObj) as Client;				<br>
			<br>
			//convert object to xml forcing type	<br>
			var xmlObjForced:XML=Asx3mer.instance.toXML(client,"SomeOtherType");<br>
			trace(xmlObjForced);	<br>
		}		<br>
	}<br>
}<br>
</code></pre>

Trace output is:<br>
<pre><code>&lt;hr.binaria.dto.Client&gt;<br>
  &lt;name&gt;John&lt;/name&gt;<br>
  &lt;mainProduct&gt;<br>
    &lt;name&gt;Main product&lt;/name&gt;<br>
    &lt;id&gt;0&lt;/id&gt;<br>
  &lt;/mainProduct&gt;<br>
  &lt;products&gt;<br>
    &lt;hr.binaria.dto.Product&gt;<br>
      &lt;name&gt;Product 1&lt;/name&gt;<br>
      &lt;id&gt;1&lt;/id&gt;<br>
    &lt;/hr.binaria.dto.Product&gt;<br>
    &lt;hr.binaria.dto.Product&gt;<br>
      &lt;name&gt;Product 2&lt;/name&gt;<br>
      &lt;id&gt;2&lt;/id&gt;<br>
    &lt;/hr.binaria.dto.Product&gt;<br>
  &lt;/products&gt;<br>
  &lt;contacted&gt;false&lt;/contacted&gt;<br>
&lt;/hr.binaria.dto.Client&gt;<br>
<br>
&lt;SomeOtherType&gt;<br>
  &lt;name&gt;John&lt;/name&gt;<br>
  &lt;mainProduct&gt;<br>
    &lt;name&gt;Main product&lt;/name&gt;<br>
    &lt;id&gt;0&lt;/id&gt;<br>
  &lt;/mainProduct&gt;<br>
  &lt;products&gt;<br>
    &lt;hr.binaria.dto.Product&gt;<br>
      &lt;name&gt;Product 1&lt;/name&gt;<br>
      &lt;id&gt;1&lt;/id&gt;<br>
    &lt;/hr.binaria.dto.Product&gt;<br>
    &lt;hr.binaria.dto.Product&gt;<br>
      &lt;name&gt;Product 2&lt;/name&gt;<br>
      &lt;id&gt;2&lt;/id&gt;<br>
    &lt;/hr.binaria.dto.Product&gt;<br>
  &lt;/products&gt;<br>
  &lt;contacted&gt;false&lt;/contacted&gt;<br>
&lt;/SomeOtherType&gt;<br>
</code></pre>