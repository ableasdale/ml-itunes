xquery version "1.0-ml";

(: TODO - this is a little broken right now :)

declare function local:create-uri($item as xs:string){
  ("/lfm/"||xdmp:url-encode($item, fn:true())||".xml")
};

declare function local:has-meta($item as xs:string) as xs:boolean {
  fn:local-name(fn:doc(local:create-uri($item))/node()) eq $LFM-ROOT-ELEMENT
};

for $i in cts:element-values(xs:QName("Artist"), (), ("limit=1000"))
return if(local:has-meta($i))
then(xdmp:log("Skipping: " || $i))
else

xdmp:spawn-function(function() {
let $response := xdmp:http-get( 
	"http://ws.audioscrobbler.com/2.0/?method=artist.getinfo&amp;artist="||xdmp:url-encode($i,fn:true())||"&amp;api_key="||$LFM-URI-KEY,
 <options xmlns="xdmp:http">
    <headers>
      <User-Agent>{"MarkLogic iTunes/0.1"}</User-Agent>
    </headers>
   </options>)
return (
xdmp:log($response),  
xdmp:document-insert( local:create-uri($i), element {xs:QName($LFM-ROOT-ELEMENT)} {
    $response[2]
}))	

},
    <options xmlns="xdmp:eval">
        <transaction-mode>update-auto-commit</transaction-mode>
        <database>{xdmp:database("iTunes")}</database>
    </options>
) 
