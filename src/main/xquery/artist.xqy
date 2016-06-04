xquery version "1.0-ml";

import module namespace lib-view = "http://www.marklogic.com/sysadmin/lib-view" at "lib/lib-view.xqy";

(: Module main :)
lib-view:create-bootstrap-page("iTunes App",
	element div {attribute class {"container"},
		lib-view:page-header("MarkLogic iTunes", "Overview", " "),
		element div {
			<h1>Artist: 10,000 Maniacs</h1>	
		}
	}
)