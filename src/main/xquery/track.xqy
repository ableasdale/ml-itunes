xquery version "1.0-ml";

declare namespace mb = "http://musicbrainz.org/ns/mmd-2.0#";

import module namespace lib-view = "http://www.xmlmachines.com/ml-itunes/lib-view" at "/lib/lib-view.xqy";
import module namespace lib-data = "http://www.xmlmachines.com/ml-itunes/lib-data" at "/lib/lib-data.xqy";

declare variable $itunes-id := xdmp:get-request-field("id");

declare variable $doc := cts:search(fn:doc()/iTunes-item , cts:element-value-query(xs:QName("Track-ID"), $itunes-id));
declare variable $last-fm-trackdata := doc(lib-data:create-document-uri("lfm", xs:string($doc/Artist), xs:string($doc/Name)));

(: TODO - scrobbler data for track :)

lib-view:create-bootstrap-page("iTunes App",
	element div {attribute class { "container" },
		lib-view:page-header("MarkLogic iTunes", "Track information", " "),
		element div {attribute class { "row" },
			<h2>Track information&emsp;<small>{xs:string($doc/Artist)}: {xs:string($doc/Name)}</small></h2>,
			lib-view:generate-track-info($doc),
			<textarea>{$doc}</textarea>,
			<h2>Last FM Track information</h2>,
			lib-data:display-last-fm-track-information($last-fm-trackdata),
			<textarea>{$last-fm-trackdata}</textarea>,
			<h2>(Last FM) Similar</h2>,
			(: ex - doc("/lfm-similar/Arrested%20Development/People%20Everyday.xml"):)
			<textarea>{doc(lib-data:create-document-uri("lfm-similar", xs:string($doc/Artist), xs:string($doc/Name)))}</textarea>
		}
	}
)