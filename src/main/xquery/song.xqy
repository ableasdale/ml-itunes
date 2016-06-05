xquery version "1.0-ml";

declare namespace mb = "http://musicbrainz.org/ns/mmd-2.0#";

import module namespace lib-view = "http://www.xmlmachines.com/ml-itunes/lib-view" at "/lib/lib-view.xqy";

declare variable $itunes-id := xdmp:get-request-field("id");

declare variable $doc := cts:search(fn:doc()/iTunes-item , cts:element-value-query(xs:QName("Track-ID"), $itunes-id));
(: TODO - scrobbler data for track :)


lib-view:create-bootstrap-page("iTunes App",
	element div {attribute class { "container" },
		lib-view:page-header("MarkLogic iTunes", "Song", " "),
		element div {attribute class { "row" },
			<h2>Song&emsp;<small>{$doc/Name}</small></h2>,
			<textarea>{$doc}</textarea>
		}
	}
)