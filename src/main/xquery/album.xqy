xquery version "1.0-ml";

import module namespace lib-view = "http://www.xmlmachines.com/ml-itunes/lib-view" at "/lib/lib-view.xqy";
import module namespace lib-data = "http://www.xmlmachines.com/ml-itunes/lib-data" at "/lib/lib-data.xqy";

declare variable $artist := xdmp:get-request-field("artist");
declare variable $album := xdmp:get-request-field("album");

(: Module main :)
lib-view:create-bootstrap-page("iTunes App",
	element div { attribute class {"container"},
		lib-view:page-header("MarkLogic iTunes", "Album", " "),
		element div { attribute class { "row" },
			<textarea>
				{fn:doc(lib-data:create-album-uri("lfm", "artist", "album"))}
			</textarea>
			(: local:show-table()	:)	
		}
	}
)