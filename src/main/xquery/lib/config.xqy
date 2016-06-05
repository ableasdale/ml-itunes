xquery version "1.0-ml";

module namespace config = "http://www.xmlmachines.com/ml-itunes/config";

(: See: https://developer.gracenote.com/web-api :)
declare variable $GRACENOTE-CLIENT-ID as xs:string := "xxxx";
declare variable $GRACENOTE-USER-ID as xs:string := "yyyy";
declare variable $GRACENOTE-API-URI as xs:string := "https://czzzz.web.cddbp.net/webapi/xml/1.0/";

(: See: http://wiki.musicbrainz.org/XMLWebService :)
declare variable $MUSICBRAINZ-USER-AGENT-STRING as xs:string := "MarkLogic iTunes/0.1 (example@example.com)";
declare variable $MUSICBRAINZ-ROOT-XML-ELEMENT as xs:string := "ArtistData";  

(: See: http://www.last.fm/api :)    
declare variable $LAST-FM-URI-KEY as xs:string := "aaaaaaaa";
declare variable $LAST-FM-ROOT-XML-ELEMENT as xs:string := "LastFMArtistData";   