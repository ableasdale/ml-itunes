xquery version "1.0-ml";

import module namespace lib-data = "http://www.xmlmachines.com/ml-itunes/lib-data" at "/lib/lib-data.xqy";

lib-data:request-album-information-from-lastfm("Sugar","Copper Blue"),
lib-data:request-artist-information-from-lastfm("Sugar")