xquery version "1.0-ml";

module namespace config = "http://www.xmlmachines.com/ml-itunes/config";

(: See: https://developer.gracenote.com/web-api :)
declare variable $GRACENOTE-CLIENT-ID as xs:string := "xxxx";
declare variable $GRACENOTE-USER-ID as xs:string := "yyyy";
declare variable $GRACENOTE-API-URI as xs:string := "https://czzzz.web.cddbp.net/webapi/xml/1.0/";
declare variable $GRACENOTE-ARTIST-ROOT-XML-ELEMENT as xs:string := "GracenoteArtistData";
declare variable $GRACENOTE-ALBUM-ROOT-XML-ELEMENT as xs:string := "GracenoteAlbumData";

(: See: http://wiki.musicbrainz.org/XMLWebService :)
declare variable $MUSICBRAINZ-USER-AGENT-STRING as xs:string := "MarkLogic iTunes/0.1 (example@example.com)";
declare variable $MUSICBRAINZ-API-URI as xs:string := "http://musicbrainz.org/ws/2/";
declare variable $MUSICBRAINZ-ARTIST-ROOT-XML-ELEMENT as xs:string := "MusicbrainzArtistData";  
declare variable $MUSICBRAINZ-ALBUM-ROOT-XML-ELEMENT as xs:string := "MusicbrainzAlbumData"; 

(: See: http://www.last.fm/api :)   
declare variable $LAST-FM-URI-KEY as xs:string := "aaaaaaaa";
declare variable $LAST-FM-API-URI as xs:string := "http://ws.audioscrobbler.com/2.0/";
declare variable $LAST-FM-ARTIST-ROOT-XML-ELEMENT as xs:string := "LastFMArtistData";   
declare variable $LAST-FM-ALBUM-ROOT-XML-ELEMENT as xs:string := "LastFMAlbumData";  

declare variable $ITUNES-DATABASE-NAME as xs:string := "iTunes";