xquery version "1.0-ml";

import module namespace lib-data = "http://www.xmlmachines.com/ml-itunes/lib-data" at "/lib/lib-data.xqy";
import module namespace config = "http://www.xmlmachines.com/ml-itunes/config" at "/lib/config.xqy";

declare function local:has-meta($artist as xs:string, $album as xs:string) as xs:boolean {
  fn:local-name(fn:doc(lib-data:create-document-uri("gn",$artist, $album))/node()) eq $config:GRACENOTE-ALBUM-ROOT-XML-ELEMENT
};

(: Module Main :)
for $i in cts:element-values(xs:QName("Artist"), (), ("limit=1"))
let $j := cts:element-values(xs:QName("Album"), (), (), cts:element-value-query(xs:QName("Artist"), $i)) 
return 
	for $item in $j
	return if(local:has-meta($i, $item))
	then(xdmp:log("Skipping matched search: " || $i || " - " || $item))
	else (
		xdmp:spawn-function(function() {
			let $response := lib-data:request-album-information-from-gracenote($i, $item)
			return (
				xdmp:log($response),  
				xdmp:document-insert( lib-data:create-document-uri("gn", $i, $item), 
					element {xs:QName($config:GRACENOTE-ALBUM-ROOT-XML-ELEMENT)} {
    				$response[2]}
				)
			)	
		}, lib-data:get-options-node())
	)	
