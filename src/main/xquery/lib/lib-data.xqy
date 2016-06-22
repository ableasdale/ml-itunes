xquery version "1.0-ml";

module namespace lib-data = "http://www.xmlmachines.com/ml-itunes/lib-data";

import module namespace lib-view = "http://www.xmlmachines.com/ml-itunes/lib-view" at "/lib/lib-view.xqy";
import module namespace config = "http://www.xmlmachines.com/ml-itunes/config" at "/lib/config.xqy";

declare namespace xe = "xdmp:eval";
declare namespace opensearch = "http://a9.com/-/spec/opensearch/1.1/";

(: Data Functions for calling Gracenote DB :)

declare private function lib-data:gracenote-album-request($artist-name as xs:string, $album-title as xs:string) { 
xdmp:quote(
  <QUERIES>
    <LANG>eng</LANG>
    <AUTH>
      <CLIENT>{$config:GRACENOTE-CLIENT-ID}</CLIENT>
      <USER>{$config:GRACENOTE-USER-ID}</USER>
    </AUTH>
    <QUERY CMD="ALBUM_SEARCH">
      <TEXT TYPE="ARTIST">{$artist-name}</TEXT>
      <TEXT TYPE="ALBUM_TITLE">{$album-title}</TEXT>
      <!-- for 1 track do: TEXT TYPE="TRACK_TITLE">all in</TEXT-->
        <OPTION>
        <PARAMETER>SELECT_EXTENDED</PARAMETER>
        <VALUE>COVER,REVIEW,ARTIST_BIOGRAPHY,ARTIST_IMAGE,ARTIST_OET,MOOD,TEMPO</VALUE>
      </OPTION>
      <OPTION>
        <PARAMETER>SELECT_DETAIL</PARAMETER>
        <VALUE>GENRE:3LEVEL,MOOD:2LEVEL,TEMPO:3LEVEL,ARTIST_ORIGIN:4LEVEL,ARTIST_ERA:2LEVEL,ARTIST_TYPE:2LEVEL</VALUE>
      </OPTION>
    </QUERY>
  </QUERIES>)};


declare private function lib-data:request-from-gracenote($payload) {
xdmp:http-post(
  $config:GRACENOTE-API-URI,
  <options xmlns="xdmp:http">
    <data>{$payload}</data>
    <headers>
      <content-type>application/xml</content-type>
    </headers>
    <verify-cert>false</verify-cert>
  </options>) 
};

declare function lib-data:request-album-information-from-gracenote($artist-name as xs:string, $album-title as xs:string) {
  lib-data:request-from-gracenote(lib-data:gracenote-album-request($artist-name, $album-title))
};

(: End Data Functions for calling Gracenote DB :)

(: Data Functions for Last FM :)

declare function lib-data:request-artist-information-from-lastfm($artist-name as xs:string) { 
  xdmp:http-get($config:LAST-FM-API-URI||"?method=artist.getinfo&amp;artist="||xdmp:url-encode($artist-name,fn:true())||"&amp;api_key="||$config:LAST-FM-URI-KEY)  
};

declare function lib-data:request-album-information-from-lastfm($artist-name as xs:string, $album-name as xs:string) { 
  xdmp:http-get($config:LAST-FM-API-URI||"?method=album.getInfo&amp;artist="||xdmp:url-encode($artist-name,fn:true())||"&amp;album="||xdmp:url-encode($album-name,fn:true())||"&amp;api_key="||$config:LAST-FM-URI-KEY)
};

declare function lib-data:request-track-data-from-last-fm($artist-name as xs:string, $track-name as xs:string) {
  xdmp:http-get($config:LAST-FM-API-URI||"?method=track.getInfo&amp;artist="||xdmp:url-encode($artist-name,fn:true())||"&amp;track="||xdmp:url-encode($track-name,fn:true())||"&amp;api_key="||$config:LAST-FM-URI-KEY)  
};

declare function lib-data:request-similar-tracks-from-last-fm($artist-name as xs:string, $track-name as xs:string) {
  xdmp:http-get($config:LAST-FM-API-URI||"?method=track.getsimilar&amp;artist="||xdmp:url-encode($artist-name,fn:true())||"&amp;track="||xdmp:url-encode($track-name,fn:true())||"&amp;api_key="||$config:LAST-FM-URI-KEY)
};

(: TODO - LFM Search doesn't really work as the XML returned from the webservice doesn't have the correct namespace :)

declare function lib-data:search-last-fm-for-album($album-name as xs:string) {
  xdmp:log($config:LAST-FM-API-URI||"?method=album.search&amp;album="||xdmp:url-encode($album-name,fn:true())||"&amp;api_key="||$config:LAST-FM-URI-KEY),
  element opensearch:osresults {
  (: xdmp:http-get($config:LAST-FM-API-URI||"?method=album.search&amp;album="||xdmp:url-encode($album-name,fn:true())||"&amp;api_key="||$config:LAST-FM-URI-KEY):)
  }
 (: TODO - this will search -- consider for later feature? 
  $config:LAST-FM-API-URI||"?method=album.search&amp;album="||xdmp:url-encode($album-name,fn:true())||"&amp;api_key="||$config:LAST-FM-URI-KEY) 
  http://a9.com/-/spec/opensearch/1.1/
  :)  
};

declare function lib-data:search-last-fm-for-artist($artist-name as xs:string) {
    xdmp:http-get($config:LAST-FM-API-URI||"?method=artist.search&amp;artist="||xdmp:url-encode($artist-name,fn:true())||"&amp;api_key="||$config:LAST-FM-URI-KEY,
    <options xmlns="xdmp:http-get">
      <format xmlns="xdmp:document-get">text</format>
    </options>
    )[2]
};

declare function lib-data:display-last-fm-track-information($trackdata) {
    lib-view:create-paragraph-element("Name", xs:string($trackdata/LastFMTrackData/lfm/track/name)),
    lib-view:create-paragraph-element("Artist", xs:string($trackdata/LastFMTrackData/lfm/track/artist)),
    lib-view:create-paragraph-with-link("Last FM URI", xs:string($trackdata/LastFMTrackData/lfm/track/url)), 
    lib-view:create-paragraph-element("Musicbrainz id",  xs:string($trackdata/LastFMTrackData/lfm/track/mbid)),
    lib-view:create-paragraph-wth-image(fn:data($trackdata//image[@size eq 'extralarge']), "Cover Art")
};

(: End Data Functions for Last FM :)

(: Data Functions for Musicbrainz :)

declare function lib-data:request-artist-information-from-musicbrainz($artist-name as xs:string) {
xdmp:http-get(
  $config:MUSICBRAINZ-API-URI||"artist/?query=artist:"||xdmp:url-encode($artist-name,fn:true()),
  <options xmlns="xdmp:http">
    <headers>
      <User-Agent>{$config:MUSICBRAINZ-USER-AGENT-STRING}</User-Agent>
    </headers>
  </options>)
};

(: End Data Functions for Musicbrainz :)

(: Other API Functions :)

 (: Discogs API is JSON ONLY :)
declare function lib-data:lookup-release-on-discogs($release-id as xs:string) { 
xdmp:http-get(
   "https://api.discogs.com/releases/"||$release-id)
};

declare function lib-data:get-options-node() as element(xe:options) { 
  <options xmlns="xdmp:eval">
    <transaction-mode>update-auto-commit</transaction-mode>
    <database>{xdmp:database($config:ITUNES-DATABASE-NAME)}</database>
  </options>
};

(: $item could be a track title or an album title :)
declare function lib-data:create-document-uri($prefix as xs:string, $artist as xs:string, $item as xs:string) {
  ("/"||$prefix||"/"||xdmp:url-encode($artist, fn:true())||"/"||xdmp:url-encode($item, fn:true())||".xml")
};

declare function lib-data:process-tracks($tracks as element(tracks)) {
    element h4 {"Track Listing"},
    element ul {for $track in $tracks/track return element li {lib-view:generate-href(xs:string($track/name))}}
};