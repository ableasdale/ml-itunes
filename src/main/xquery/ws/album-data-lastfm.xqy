xquery version "1.0-ml";

import module namespace lib-data = "http://www.xmlmachines.com/ml-itunes/lib-data" at "/lib/lib-data.xqy";
import module namespace config = "http://www.xmlmachines.com/ml-itunes/config" at "/lib/config.xqy";

declare function local:has-meta($artist as xs:string, $album as xs:string) as xs:boolean {
    fn:local-name(fn:doc(lib-data:create-document-uri("lfm-album", $artist, $album))/node()) eq $config:LAST-FM-ALBUM-ROOT-XML-ELEMENT
};

(: Module Main :)
for $i in cts:element-values(xs:QName("Artist"), (), ())
let $j := cts:element-values(xs:QName("Album"), (), (), cts:element-value-query(xs:QName("Artist"), $i)) 
return 
	for $item in $j
	return if(local:has-meta($i, $item))
	then(xdmp:log("Skipping matched search: " || $i || " - " || $item))
	else (
		xdmp:spawn-function(function() {
            xdmp:document-insert( lib-data:create-document-uri("lfm-album", $i, $item), 
                element {xs:QName($config:LAST-FM-ALBUM-ROOT-XML-ELEMENT)} {
                lib-data:request-album-information-from-lastfm($i, $item)[2]}
            )				
		}, lib-data:get-options-node())
	)	
