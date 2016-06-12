xquery version "1.0-ml";

import module namespace lib-data = "http://www.xmlmachines.com/ml-itunes/lib-data" at "/lib/lib-data.xqy";

declare namespace opensearch = "http://a9.com/-/spec/opensearch/1.1/";

<search xmlns:opensearch="http://a9.com/-/spec/opensearch/1.1/">
    {xdmp:http-get("http://ws.audioscrobbler.com/2.0/?method=album.search&amp;album=Copper%20Blue&amp;api_key=7b55e6d1d0d65a538aeb44977c79e961")}
</search>
(: lib-data:request-album-information-from-lastfm("Sugar","Copper Blue"),
lib-data:request-artist-information-from-lastfm("Sugar"),
lib-data:search-last-fm-for-album("Copper Blue") 
xdmp:tidy(lib-data:search-last-fm-for-artist("Sugar"))
:)