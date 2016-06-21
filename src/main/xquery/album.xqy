xquery version "1.0-ml";

import module namespace lib-view = "http://www.xmlmachines.com/ml-itunes/lib-view" at "/lib/lib-view.xqy";
import module namespace lib-data = "http://www.xmlmachines.com/ml-itunes/lib-data" at "/lib/lib-data.xqy";

declare variable $artist := xdmp:get-request-field("artist");
declare variable $album := xdmp:get-request-field("album");

declare variable $last-fm-data := fn:doc(lib-data:create-document-uri("lfm-album", $artist, $album));

declare function local:itunes-information() as element(div) {
    element div { attribute class { "row" },
        element h3 {"In iTunes"},
        <table class="table table-striped table-bordered">
            {lib-view:generate-table-headings-for-itunes-entries()}
            <tbody>{
                for $i in cts:search(doc()/iTunes-item,
                    cts:and-query((
                        cts:element-value-query(xs:QName("Artist"), $artist),
                        cts:element-value-query(xs:QName("Album"), $album)
                    ))
                )
                return lib-view:generate-table-row-from-itunes-entry($i)
            }</tbody>
        </table>
    }
};

declare function local:last-fm-data() as element(div) {
    element div { attribute class { "row" },
        element textarea {$last-fm-data},
        element h3 {"Last FM Data"},
        lib-view:create-paragraph-element("Name", xs:string($last-fm-data/LastFMAlbumData/lfm/album/name)),
        lib-view:create-paragraph-element("Artist", xs:string($last-fm-data/LastFMAlbumData/lfm/album/artist)),
        lib-view:create-paragraph-with-link("Last FM URI", xs:string($last-fm-data/LastFMAlbumData/lfm/album/url)), 
        lib-view:create-paragraph-element("Musicbrainz id",  xs:string($last-fm-data/LastFMAlbumData/lfm/album/mbid)),
        (: lib-view:create-paragraph-wth-image( ) :)
        <p><img src="{fn:data($last-fm-data//image[@size eq 'extralarge'])}" alt="Cover Art" title="Cover Art" class="img-thumbnail" /></p>,
        lib-data:process-tracks($last-fm-data/LastFMAlbumData/lfm/album/tracks)
        
        (: local:show-table()	:)	
    }
};

(: Module main :)
lib-view:create-bootstrap-page("iTunes App",
	element div { attribute class {"container"},
		lib-view:page-header("MarkLogic iTunes", "Album", " "),
        local:itunes-information(),
	    local:last-fm-data()	
	}
)