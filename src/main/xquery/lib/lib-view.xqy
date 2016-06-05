xquery version "1.0-ml";

module namespace lib-view = "http://www.xmlmachines.com/ml-itunes/lib-view";

declare function lib-view:create-bootstrap-page($title as xs:string, $content as element(div)){
    lib-view:create-bootstrap-page($title, $content, ())
};

declare function lib-view:create-bootstrap-page($title as xs:string, $content as element(div), $additional-resource as item()?) {
    xdmp:set-response-content-type("text/html; charset=utf-8"),
    '<!DOCTYPE html>',
    element html {attribute lang {"en"},
    element head {
        element meta {attribute charset {"utf-8"}},
        element meta {attribute http-equiv {"X-UA-Compatible"}, attribute content {"IE=edge"}},
        element meta {attribute name {"viewport"}, attribute content {"width=device-width, initial-scale=1"}},
        element title {$title},
        element link {
            attribute rel {"stylesheet"},
            attribute href {"https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"},
            attribute integrity {"sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7"},
            attribute crossorigin {"anonymous"}
        },
        element link {
            attribute rel {"stylesheet"},
            attribute href {"https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css"},
            attribute integrity {"sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r"},
            attribute crossorigin {"anonymous"}
        },
        element link { 
            attribute rel {"stylesheet"},
            attribute href {"/assets/style.css"}
        }
    },
    element body { $content }
    },
    <script src="https://code.jquery.com/jquery-2.2.1.min.js">{" "}</script>,
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous">{" "}</script>,
 
    <script src="https://cdnjs.cloudflare.com/ajax/libs/d3/3.5.16/d3.js">{" "}</script>,
    <script src="https://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.8.3/underscore-min.js">{" "}</script>,
    $additional-resource
};


declare function lib-view:navigation() as element(div) {
    <div class="navbar navbar-default" role="navigation">
        <div class="container-fluid">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse"
                data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                </button>
                <!-- img style="max-width:150px; padding-top:8px;" id="nav-logo" src="/assets/images/marklogic.png"/ -->
            </div>

            <div class="navbar-collapse collapse">
                <ul class="nav navbar-nav">
                    <!-- TODO - add class="active" to active page -->
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Dashboard <span class="caret"></span></a>
                        <ul class="dropdown-menu" role="menu">
                            <li><a href="/">Overview</a></li>  
                            <li><a href="/artists.xqy">Artists</a></li>                           
                        </ul>
                    </li>
                    <!-- li><a href="/security.xqy">Security</a></li-->
                    
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Documentation <span class="caret"></span></a>
                        <ul class="dropdown-menu" role="menu">
                            <li><a href="#">TODO</a></li>
                        </ul>
                    </li>

                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Music Tools <span class="caret"></span></a>
                        <ul class="dropdown-menu" role="menu">
                            <li><a href="#"><span class="glyphicon glyphicon-download-alt" aria-hidden="true">{" "}</span> Export iTunes XML</a></li>
                        </ul>
                    </li>
                    <li><a href="#">TODO</a></li>
                </ul>
                <form class="navbar-form pull-right" action="/search.xqy" method="post">
                    <div class="input-group">
                        <input type="text" name="term" class="form-control" placeholder="Search" />
                        <span class="input-group-btn">
                            <button class="btn btn-default" type="submit">
                                <span class="glyphicon glyphicon glyphicon-search"></span>
                            </button>
                        </span>
                    </div>
                </form>
            </div>
        </div>
    </div>
};

(: Not relevant for this project 
declare function lib-view:database-select() as element(div) {
    element div {attribute class {"dropdown"},
        element button {
            attribute class {"btn btn-default dropdown-toggle pull-right"},
            attribute type {"button"},
            attribute id {"database-select"},
            attribute data-toggle {"dropdown"},
            attribute aria-haspopup {"true"},
            attribute aria-expanded {"true"},
            "Choose database ", element span {attribute class {"caret"}}
        },
        element ul {
            attribute class {"dropdown-menu"}, attribute aria-labelledby {"database-select"},
            element li {attribute class {"dropdown-header"}, "Available Databases:"},
            for $x in xdmp:database-name(xdmp:databases())
            return
                element li {element a {attribute href {concat("?db=", $x)}, $x}}
        }
    }
}; :)

declare function lib-view:generate-table-headings-for-itunes-entries(){
    lib-view:create-thead-element(("ID", "Title", "Artist", "Album", "Year", "Time","Size (MB)"))
};

declare function lib-view:generate-table-row-from-itunes-entry($i as element(iTunes-item)) as element(tr) {
    element tr {
        element td {<a href="/song.xqy?id={xs:string($i/Track-ID)}">{xs:string($i/Track-ID)}</a>},
        element td {<a href="/song.xqy?id={xs:string($i/Track-ID)}">{xs:string($i/Name)}</a>},
        element td {<a href="/artist.xqy?artist={xs:string($i/Artist)}">{xs:string($i/Artist)}</a>, " [",<a href="musicbrainz.xqy?artist={xs:string($i/Artist)}">MB</a>,"] [",<a href="lastfm.xqy?artist={xs:string($i/Artist)}">LFM</a>,"]"},
        element td {xs:string($i/Album)},
        element td {xs:string($i/Year)},
        (: Total time is in miliseconds :)
        element td { xs:duration("PT" || fn:round(xs:integer($i/Total-Time) div 1000) || "S" )  },
        element td {fn:round-half-to-even( xs:double(xs:unsignedLong($i/Size) div 1024 div 1024), 2)}
    }
};

declare function lib-view:page-header($title as xs:string, $subtitle as xs:string, $dropdown as item()?) as element(div)+ {
        element div {attribute class {"row"},
            element div {attribute class {"col-md-9"}, element h3 {$title, " ", element small {$subtitle}}},
            element div {attribute class {"col-md-3"}, attribute style {"padding-top:1em;"}, $dropdown}
        },
        element div {attribute class {"row"}, lib-view:navigation()}
};


declare function lib-view:create-thead-element($headers as xs:string*) as element(thead) {
    element thead {
        element tr {
            for $header in $headers
            return element th {attribute class {"text-center"}, $header}
        }
    }
};
