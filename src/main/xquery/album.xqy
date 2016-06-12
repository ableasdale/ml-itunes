xquery version "1.0-ml";

import module namespace lib-view = "http://www.xmlmachines.com/ml-itunes/lib-view" at "/lib/lib-view.xqy";
import module namespace lib-data = "http://www.xmlmachines.com/ml-itunes/lib-data" at "/lib/lib-data.xqy";

declare variable $artist := xdmp:get-request-field("artist");
declare variable $album := xdmp:get-request-field("album");

declare variable $last-fm-data := fn:doc(lib-data:create-document-uri("lfm", $artist, $album));

(: Module main :)
lib-view:create-bootstrap-page("iTunes App",
	element div { attribute class {"container"},
		lib-view:page-header("MarkLogic iTunes", "Album", " "),
		element div { attribute class { "row" },
            <h2>Last FM Data</h2>,
            <p><img src="{fn:data($last-fm-data//image[@size eq 'extralarge'])}" alt="Cover Art" title="Cover Art" class="img-thumbnail" /></p>,
			<textarea>
				{$last-fm-data}
			</textarea>
			(: local:show-table()	:)	
		}
	}
)