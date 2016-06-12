xquery version "1.0-ml";

import module namespace lib-data = "http://www.xmlmachines.com/ml-itunes/lib-data" at "/lib/lib-data.xqy";
import module namespace config = "http://www.xmlmachines.com/ml-itunes/config" at "/lib/config.xqy";

declare function local:create-uri($item as xs:string) {
  ("/lfm/"||xdmp:url-encode($item, fn:true())||".xml")
};

declare function local:has-meta($item as xs:string) as xs:boolean {
  fn:local-name(fn:doc(local:create-uri($item))/node()) eq $config:LAST-FM-ARTIST-ROOT-XML-ELEMENT
};

(: Module Main :)
for $i in cts:element-values(xs:QName("Artist"), (), ())
return 
  if(local:has-meta($i))
  then(xdmp:log("Skipping matched search: " || $i))
  else (
    xdmp:spawn-function(function() {
    let $response := lib-data:request-artist-information-from-lastfm($i)
    return (
      xdmp:log($response),  
      xdmp:document-insert( local:create-uri($i), element {xs:QName($config:LAST-FM-ARTIST-ROOT-XML-ELEMENT)} {$response[2]} )
    )	
    }, lib-data:get-options-node()
  )
)

(: ?method=album.search&album=believe&api_key=YOUR_API_KEY :)