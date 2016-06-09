xquery version "1.0-ml";

import module namespace lib-view = "http://www.xmlmachines.com/ml-itunes/lib-view" at "lib/lib-view.xqy";

declare variable $selection as xs:string := xdmp:get-request-field("q", "all");

declare function local:create-li-element($i as xs:string) as element(li) {
	element li {
		element a { attribute href {"/artist.xqy?artist="||xdmp:url-encode($i, fn:true())}, $i }, 
		"&emsp;", 
		element span { attribute class {"badge"},
			element span { attribute class {"glyphicon glyphicon-cd"}, " "}, 
				"&nbsp;", 
				cts:frequency($i)
		}
	}	
};

declare function local:list-albums(){
	element p {
		lib-view:generate-az-links("/albums.xqy?q=")
	},
	element ul {
		if ($selection eq "all") 
		then (
			for $i in cts:element-values(xs:QName("Album"), (), ())
			order by cts:frequency($i) descending 
			return local:create-li-element($i)
		)
		else (
			for $i in cts:element-values(xs:QName("Album"), (), ()) (: , "The" :)
			where fn:starts-with($i, $selection, "http://marklogic.com/collation/codepoint")
			order by cts:frequency($i) descending 
			return local:create-li-element($i)

		
		)
 	}
};

(: Module main :)
lib-view:create-bootstrap-page("iTunes App",
	element div {attribute class { "container" },
		lib-view:page-header("MarkLogic iTunes", "Albums", " "),
		element div {attribute class { "row" },
			<h2>Albums&emsp;<small>{$selection}</small></h2>,
			local:list-albums()
		}
	}
)