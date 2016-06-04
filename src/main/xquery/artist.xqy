xquery version "1.0-ml";

declare namespace mb = "http://musicbrainz.org/ns/mmd-2.0#";

import module namespace lib-view = "http://www.marklogic.com/sysadmin/lib-view" at "lib/lib-view.xqy";

declare variable $artist := xdmp:get-request-field("artist");

declare function local:musicbrainz(){
	xdmp:http-get(
   "http://musicbrainz.org/ws/2/artist/?query=artist:"||xdmp:url-encode($artist,fn:true()),
 
 <options xmlns="xdmp:http">
    <headers>
      <User-Agent>{"MarkLogic iTunes v0.1"}</User-Agent>
    </headers>
   </options>)[2]
};

declare function local:do-search(){
	<table class="table table-striped table-bordered">
		{lib-view:create-thead-element(("ID", "Title", "Artist", "Album", "Year", "Size (MB)"))}
		<tbody>
			{
				for $i in cts:search( fn:doc()/iTunes-item,
				  cts:element-value-query(xs:QName("Artist"), $artist)
				)
				order by fn:number($i/Track-ID)
	
				return element tr {
					element td {xs:string($i/Track-ID)},
					element td {xs:string($i/Name)},
					element td {<a href="artist.xqy?artist={xs:string($i/Artist)}">{xs:string($i/Artist)}</a>},
					element td {xs:string($i/Album)},
					element td {xs:string($i/Year)},
					element td {fn:round-half-to-even( xs:double(xs:unsignedLong($i/Size) div 1024 div 1024), 2)}
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
			<h2>Artist <small>{$artist}</small></h2>,
			<h3>MusicBrainz</h3>,
			<textarea>{local:musicbrainz()}</textarea>,
			<h3>In iTunes</h3>,
			local:do-search()
		}
	}
)