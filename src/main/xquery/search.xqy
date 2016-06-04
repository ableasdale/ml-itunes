xquery version "1.0-ml";

import module namespace lib-view = "http://www.marklogic.com/sysadmin/lib-view" at "lib/lib-view.xqy";

declare variable $term := xdmp:get-request-field("term");
declare variable $match := cts:search(doc()/iTunes-item, cts:element-word-query(xs:QName("Artist"), $term));

(: Module main :)
lib-view:create-bootstrap-page("iTunes App",
	element div { attribute class {"container"},
		lib-view:page-header("MarkLogic iTunes", "Search", " "),
		element div { attribute class { "row" },
			<h2>Artists <small>"{$term}"</small></h2>,
			
				fn:distinct-values(for $i in $match return xs:string($i/Artist)),	
				(: for $i in cts:search() :)

			<p><small>{cts:element-values(xs:QName("Artist"), (), (), $term)}</small></p>,
			
			<h2>Albums <small>"{$term}"</small></h2>,
				fn:distinct-values(for $i in $match return xs:string($i/Album)),
					
			<h2>Songs <small>"{$term}"</small></h2>,
				for $i in $match
				return element p {$i/Name}
		}
	}
)