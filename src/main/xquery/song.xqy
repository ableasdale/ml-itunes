xquery version "1.0-ml";

declare namespace mb = "http://musicbrainz.org/ns/mmd-2.0#";

import module namespace lib-view = "http://www.xmlmachines.com/ml-itunes/lib-view" at "/lib/lib-view.xqy";
import module namespace lib-data = "http://www.xmlmachines.com/ml-itunes/lib-data" at "/lib/lib-data.xqy";

declare variable $itunes-id := xdmp:get-request-field("id");

declare variable $doc := cts:search(fn:doc()/iTunes-item , cts:element-value-query(xs:QName("Track-ID"), $itunes-id));
(: TODO - scrobbler data for track :)


lib-view:create-bootstrap-page("iTunes App",
	element div {attribute class { "container" },
		lib-view:page-header("MarkLogic iTunes", "Track information", " "),
		element div {attribute class { "row" },
			<h2>Track information&emsp;<small>{xs:string($doc/Artist)}: {xs:string($doc/Name)}</small></h2>,
			<textarea>{$doc}</textarea>,
			<h2>(Last FM) Similar</h2>,
			<p>TODO - at the moment this is a live lookup - save the data so we dont have to keep going back to LFM for it</p>,
			<textarea>{lib-data:request-similar-tracks-from-last-fm(xs:string($doc/Artist), xs:string($doc/Name))}</textarea>
		}
	}
)