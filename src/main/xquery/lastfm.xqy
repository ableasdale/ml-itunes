xquery version "1.0-ml";

import module namespace lib-view = "http://www.xmlmachines.com/ml-itunes/lib-view" at "lib/lib-view.xqy";

(: font-family: "Myriad Set Pro", "Lucida Grande", "Helvetica Neue", "Helvetica", "Arial", "Verdana", "sans-serif"; :)

(: TODO Last.Fm hookup and http://dbtune.org/last-fm/ http://www.last.fm/api/scrobbling:)
(: TODO https://acoustid.org/webservice :)
(: https://developers.soundcloud.com/docs/api/guide :)
(: Lyrics - https://developer.musixmatch.com/mmplans :)
(: http://ws.audioscrobbler.com/2.0/?method=user.getrecenttracks&user=bbcradio1&api_key=<key> :)

(:https://developer.spotify.com/web-api/ JSON ONLY
<id>72b3e198f0e0a8a9d32a752e36fbb75e</id><Track-ID>19959</Track-ID><Name>These Are Days</Name><Artist>10,000 Maniacs</Artist><Album-Artist>10,000 Maniacs</Album-Artist><Composer>Rob Buck</Composer><Album>MTV Unplugged</Album><Genre>Adult Alternative Pop</Genre><Kind>MPEG audio file</Kind><Size>5926370</Size><Total-Time>294321</Total-Time><Disc-Number>1</Disc-Number><Disc-Count>1</Disc-Count><Track-Number>1</Track-Number><Track-Count>14</Track-Count><Year>1993</Year><Date-Modified>2015-03-24T13:04:16Z</Date-Modified><Date-Added>2006-06-13T20:32:19Z</Date-Added><Bit-Rate>160</Bit-Rate><Sample-Rate>44100</Sample-Rate><Comments>Cleaned by TuneUp!</Comments><Artwork-Count>1</Artwork-Count><Persistent-ID>8A3EA83E83344C94</Persistent-ID><Track-Type>File</Track-Type>
:)

declare variable $DOC as document-node() := fn:doc(local:create-uri($artist));

declare variable $CONTENT as element(div) :=
    <div class="body-wrap">
        <div class="container">

            <div class="row">
                <h2>MarkLogic iTunes <small>Demo page</small></h2>
                {lib-view:nav()}
            </div>

            <div class="row">
                <h3>{fn:data($DOC/LastFMArtistData/lfm/artist/name)}</h3>
                <div class="widget-container boxed">
                    <div class="inner">
                        <div class="tab-image pull-left">
                            {element img {attribute class {"img-thumbnail"}, attribute src {fn:data($DOC/LastFMArtistData/lfm/artist/image[@size eq 'mega'])}}}
                        </div>
                        <p class="pre-wrap">{fn:data($DOC/LastFMArtistData/lfm/artist/bio/content)}</p>
                    </div>
                </div>
            </div>

            <div class="row">
                <h4>Tags</h4>
                {for $i in $DOC/LastFMArtistData/lfm/artist/tags/tag
                return element div {attribute class {"ribbon ribbon-purple"}, element a {attribute href {$i/url}, element span {$i/name}}}}
            </div>

            <div class="row">
                <div class="example-code">
                    <textarea>
                        {$DOC}
                    </textarea>
                </div>
            </div>
        </div>
    </div>;

declare variable $artist := xdmp:get-request-field("artist");

declare function local:create-uri($item as xs:string){
    ("/lfm/" || xdmp:url-encode($item, fn:true()) || ".xml")
};

declare function local:show-table() {
    <table class="table table-striped table-bordered">
        {lib-view:create-thead-element(("ID", "Title", "Artist", "Album", "Year", "Size (MB)"))}
        <tbody>
            {
            (: Works but annoyingly slow - fn:subsequence((for $i in (//iTunes-item) order by fn:number($i/Track-ID) :)
                for $j in cts:element-values(xs:QName("Track-ID"), (), ("limit=1000"))
                let $i := doc()/iTunes-item/Track-ID[. eq $j]/..
                return element tr {
                    element td {xs:string($i/Track-ID)},
                    element td {xs:string($i/Name)},
                    element td {<a href="artist.xqy?artist={xs:string($i/Artist)}">{xs:string($i/Artist)}</a>, " [", <a href="musicbrainz.xqy">MB</a>, "] [", <a href="lastfm.xqy?artist={xs:string($i/Artist)}">LFM</a>, "]"},
                    element td {xs:string($i/Album)},
                    element td {xs:string($i/Year)},
                    element td {fn:round-half-to-even(xs:double(xs:unsignedLong($i/Size) div 1024 div 1024), 2)}
                }
            }
        </tbody>
    </table>
};

(: Module main
lib-view:create-bootstrap-page("iTunes App",
	element div { attribute class {"container"},
		lib-view:page-header("MarkLogic iTunes", "Last FM Data", " "),
		element div { attribute class { "row" },
			<textarea>
				{fn:doc(local:create-uri($artist))}
			</textarea>
			(: local:show-table()	:)	
		}
	}
) :)
(: Module main :)
lib-view:create-cstack-page("iTunes App", $CONTENT)