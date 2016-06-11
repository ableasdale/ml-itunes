xquery version "1.0-ml";

import module namespace lib-data = "http://www.xmlmachines.com/ml-itunes/lib-data" at "/lib/lib-data.xqy";
import module namespace config = "http://www.xmlmachines.com/ml-itunes/config" at "/lib/config.xqy";

declare function local:create-uri($artist as xs:string, $album as xs:string){
  ("/gn/"||xdmp:url-encode($artist, fn:true())||"/"||xdmp:url-encode($album, fn:true())||".xml")
};

declare function local:has-meta($artist as xs:string, $album as xs:string) as xs:boolean {
  fn:local-name(fn:doc(local:create-uri($artist, $album))/node()) eq $config:GRACENOTE-ROOT-XML-ELEMENT
};

(: Module main :)
for $i in cts:element-values(xs:QName("Artist"), (), ())
let $j := cts:element-values(xs:QName("Album"), (), (), cts:element-value-query(xs:QName("Artist"), $i)) 
return 
	if(local:has-meta($i, $j))
	then(xdmp:log("Skipping: " || $i))
	else (
		xdmp:spawn-function(function() {
			let $response := lib-data:request-album-information-from-gracenote($i, $j)
			return (
				xdmp:log($response),  
				xdmp:document-insert( local:create-uri($i, $j), 
					element {xs:QName($config:GRACENOTE-ROOT-XML-ELEMENT)} {
    				$response[2]}
				)
			)	
		}, lib-data:get-options-node())
	)	
