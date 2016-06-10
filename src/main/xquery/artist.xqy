xquery version "1.0-ml";

declare namespace mb = "http://musicbrainz.org/ns/mmd-2.0#";

import module namespace lib-view = "http://www.xmlmachines.com/ml-itunes/lib-view" at "/lib/lib-view.xqy";

declare variable $artist := xdmp:get-request-field("artist");

declare function local:create-uri($item as xs:string){
  ("/"||xdmp:url-encode($item, fn:true())||".xml")
};

declare function local:create-lfm-uri($item as xs:string){
  ("/lfm/"||xdmp:url-encode($item, fn:true())||".xml")
};

declare function local:do-search(){
	<table class="table table-striped table-bordered">
		{lib-view:generate-table-headings-for-itunes-entries()}
		<tbody>
			{
				for $i in cts:search( fn:doc()/iTunes-item,
				  cts:element-value-query(xs:QName("Artist"), $artist)
				)
				order by fn:number($i/Track-ID)
				return lib-view:generate-table-row-from-itunes-entry($i)
			}
		</tbody>
	</table>
};
declare function local:mb-matches(){
		<table class="table table-striped table-bordered">
		{lib-view:create-thead-element(("Created", "Name", "Sort Name", "Country", "Life Span"))}
		<tbody>
			{
				for $i in fn:doc(local:create-uri($artist))//mb:metadata/mb:artist-list/mb:artist
				return element tr {
						element td {xs:string($i/mb:name)},
						element td {"TODO"}
				}
			}
		</tbody>
	</table>
};

(: Module main :)
lib-view:create-bootstrap-page("iTunes App",
	element div {attribute class { "container" },
		lib-view:page-header("MarkLogic iTunes", "Artist: "|| $artist, " "),
		element div {attribute class { "row" },
			<h2>Artist&emsp;<small>{$artist}</small></h2>,
			<h3>MusicBrainz Search Matches</h3>,
			local:mb-matches(),
			<textarea>{fn:doc(local:create-uri($artist))}</textarea>,
			<h3>Last FM</h3>,
			<textarea>{fn:doc(local:create-lfm-uri($artist))}</textarea>,
			<h3>In iTunes</h3>,
			local:do-search()
		}
	}
)