$(document).ready(function () {
    console.log("ready");

    new jPlayerPlaylist({
        jPlayer: "#jquery_jplayer_1",
        cssSelectorAncestor: "#jp_container_1"
    }, [
        {
            title: "<span class='item-artist'>Rihanna - </span><span class='item-song'>Only Girl</span><img class='item-image' src='images/temp/music-player-4.jpg' alt='' />",
            mp3: "http://www.jplayer.org/audio/mp3/TSP-05-Your_face.mp3",
            oga: "http://www.jplayer.org/audio/ogg/TSP-05-Your_face.ogg"
        },
        {
            title: "<span class='item-artist'>Yaki Da - </span><span class='item-song'>Dancing</span><img class='item-image' src='images/temp/music-player-5.jpg' alt='' />",
            mp3: "http://www.jplayer.org/audio/mp3/TSP-07-Cybersonnet.mp3",
            oga: "http://www.jplayer.org/audio/ogg/TSP-07-Cybersonnet.ogg"
        },
        {
            title: "<span class='item-artist'>Pandora - </span><span class='item-song'>Sands of Time</span><img class='item-image' src='images/temp/music-player-6.jpg' alt='' />",
            mp3: "http://www.jplayer.org/audio/mp3/Miaow-07-Bubble.mp3",
            oga: "http://www.jplayer.org/audio/ogg/Miaow-07-Bubble.ogg"
        }
    ], {
        swfPath: "js",
        supplied: "oga, mp3",
        wmode: "window",
        smoothPlayBar: false,
        keyEnabled: false
    });
});