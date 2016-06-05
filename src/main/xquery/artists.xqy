xquery version "1.0-ml";

import module namespace lib-view = "http://www.xmlmachines.com/ml-itunes/lib-view" at "lib/lib-view.xqy";

declare function local:list-artists(){
	element ul {
		for $i in cts:element-values(xs:QName("Artist"), (), ("limit=20000"))
		order by cts:frequency($i) descending
		return 
			element li {
				element a { attribute href {"/artist.xqy?artist="||xdmp:url-encode($i, fn:true())}, $i }, 
				"&emsp;", 
				element span { attribute class {"badge"},
					element span { attribute class {"glyphicon glyphicon-cd"}, " "}, 
						"&nbsp;", 
						cts:frequency($i)
				}
			}	
 	}
};

(: Module main :)
lib-view:create-bootstrap-page("iTunes App",
	element div {attribute class { "container" },
		lib-view:page-header("MarkLogic iTunes", "Artists", " "),
		element div {attribute class { "row" },
			<h2>Artists <small>TODO</small></h2>,
			local:list-artists()
		}
	}
)