xquery version "1.0-ml";

module namespace lib-data = "http://www.xmlmachines.com/ml-itunes/lib-data";

import module namespace config = "http://www.xmlmachines.com/ml-itunes/config" at "/lib/config.xqy";

declare namespace xe = "xdmp:eval";

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
xdmp:http-get( 
  $config:LAST-FM-API-URI||"?method=artist.getinfo&amp;artist="||xdmp:url-encode($artist-name,fn:true())||"&amp;api_key="||$config:LAST-FM-URI-KEY)  
};

declare function lib-data:request-album-information-from-lastfm($artist-name as xs:string, $album-name as xs:string) { 
xdmp:http-get( 
  $config:LAST-FM-API-URI||"?method=album.getInfo&amp;artist="||xdmp:url-encode($artist-name,fn:true())||"&amp;album="||xdmp:url-encode($album-name,fn:true())||"&amp;api_key="||$config:LAST-FM-URI-KEY)  
  (: TODO - this will search -- consider for later feature? $config:LAST-FM-API-URI||"?method=album.search&amp;album="||xdmp:url-encode($album-name,fn:true())||"&amp;api_key="||$config:LAST-FM-URI-KEY) :)  
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

declare function lib-data:get-options-node() as element(xe:options){
  <options xmlns="xdmp:eval">
    <transaction-mode>update-auto-commit</transaction-mode>
    <database>{xdmp:database($config:ITUNES-DATABASE-NAME)}</database>
  </options>
};
