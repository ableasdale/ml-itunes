xquery version "1.0-ml";

import module namespace lib-view = "http://www.xmlmachines.com/ml-itunes/lib-view" at "lib/lib-view.xqy";

declare variable $term := xdmp:get-request-field("term");
declare variable $OPTIONS := ("whitespace-insensitive", "punctuation-insensitive", "case-insensitive");

declare variable $artist-match := cts:search(doc()/iTunes-item, cts:element-word-query(xs:QName("Artist"), $term, $OPTIONS));
declare variable $album-match := cts:search(doc()/iTunes-item, cts:element-word-query(xs:QName("Album"), $term, $OPTIONS));
declare variable $track-match := cts:search(doc()/iTunes-item, cts:element-word-query(xs:QName("Name"), $term, $OPTIONS));


declare variable $data as element(div) :=
	element div { attribute class {"container"},
		lib-view:page-header("MarkLogic iTunes", "Search", " "),
		element div { attribute class { "row" },
			<h2>Artists <small>"{$term}"</small></h2>,
            element ul {attribute class {"list-unstyled"},
                for $i in fn:distinct-values( for $i in $artist-match return xs:string($i/Artist)) return element li {element a {attribute href {"/artist.xqy?artist="||$i}, $i}}
            },
			<h2>Albums <small>"{$term}"</small></h2>,
            element ul {attribute class {"list-unstyled"},
                for $i in fn:distinct-values( for $i in $album-match return xs:string($i/Artist)||"~"||xs:string($i/Album)) let $j := fn:tokenize($i, "~") return element li {element a {attribute href {"/album.xqy?artist="||$j[1]||"&amp;album="||$j[2]}, $j[2] || " by " || $j[1]}}
            },

			<h2>Songs <small>"{$term}"</small></h2>,
            element ul {attribute class {"list-unstyled"},
                for $i in $track-match return element li {element a {attribute href{"/track.xqy?id="||$i/Track-ID}, $i/Name}}
            }
		}
	};

(: Module main :)
lib-view:create-bootstrap-page("iTunes App", $data)