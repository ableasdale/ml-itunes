xquery version "1.0-ml";

import module namespace lib-data = "http://www.xmlmachines.com/ml-itunes/lib-data" at "/lib/lib-data.xqy";

(: lib-data:request-album-information-from-gracenote("flying lotus", "until the quiet comes") :)




(: Main :)
for $i in cts:element-values(xs:QName("Artist"), (), ("limit=1"))
	let $j := cts:element-values(xs:QName("Album"), (), (), cts:element-value-query(xs:QName("Artist"), $i)) 
	return lib-data:request-album-information-from-gracenote($i, $j)
		

	(: lib-data:request-album-information-from-gracenote("Sugar", "Copper Blue") :)