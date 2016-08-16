xquery version "1.0-ml";

import module namespace lib-view = "http://www.xmlmachines.com/ml-itunes/lib-view" at "lib/lib-view.xqy";

declare variable $TERM := xdmp:get-request-field("term");
declare variable $OPTIONS := ("wildcarded", "whitespace-insensitive", "punctuation-insensitive", "case-insensitive");

declare variable $artist-match := cts:search(doc()/iTunes-item, cts:element-word-query(xs:QName("Artist"), $TERM, $OPTIONS));
declare variable $album-match := cts:search(doc()/iTunes-item, cts:element-word-query(xs:QName("Album"), $TERM, $OPTIONS));
declare variable $track-match := cts:search(doc()/iTunes-item, cts:element-word-query(xs:QName("Name"), $TERM, $OPTIONS));


declare variable $data as element(div) :=
	element div { attribute class {"container"},
		lib-view:page-header("MarkLogic iTunes", "Search", " "),
		element div { attribute class { "row" },
            lib-view:h2("Artists", $TERM),
            lib-view:unstyled-ul(for $i in fn:distinct-values( for $i in $artist-match return xs:string($i/Artist)) return element li {element a {attribute href {"/artist.xqy?artist="||$i}, $i}} ),
            lib-view:h2("Albums", $TERM),
            lib-view:unstyled-ul(for $i in fn:distinct-values( for $i in $album-match return xs:string($i/Artist)||"~"||xs:string($i/Album)) let $j := fn:tokenize($i, "~") return element li {element a {attribute href {"/album.xqy?artist="||$j[1]||"&amp;album="||$j[2]}, $j[2]}, " by ", element a {attribute href {"/artist.xqy?artist="||$j[1]}, $j[1]}}),
            lib-view:h2("Tracks", $TERM),
            lib-view:unstyled-ul(for $i in $track-match return element li {element a {attribute href{"/track.xqy?id="||$i/Track-ID}, $i/Name}})
		}
	};

(: Module main :)
lib-view:create-bootstrap-page("iTunes App", $data)