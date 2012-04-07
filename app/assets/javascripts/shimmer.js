Rshot = {};

$(document).ready(function() {
    $('a[rel=tooltip], span[rel=tooltip]').tooltip();

    $('a[rel=popover]').popover({html: true});

    $('.carousel').carousel();

    $("a.lightbox").fancybox({
        'transitionIn'  :   'elastic',
        'transitionOut' :   'elastic',
        'speedIn'       :   600,
        'speedOut'      :   200,
        'overlayShow'   :   true,
        'hideOnContentClick': true
    });

    if( $('#geotag-map').size() > 0 ) {
        // add leaflet map

        Rshot.map = new L.Map('geotag-map');
        var mapnik_osm = new L.TileLayer(
            "http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            {
                maxZoom: 14,
                minZoom: 1,
                attribution: "Map: &copy; <a href=\"http://www.openstreetmap.org\" target=\"_blank\" style=\"\">OpenStreetMap contributors</a>, "
                +"<a href=\"http://creativecommons.org/licenses/by-sa/2.0/\" target=\"_blank\">CC-BY-SA</a>"
            }
        );

        Rshot.map.addLayer(mapnik_osm);

        if( $('#geotag-map').data('lat') != '' && $('#geoip-map').data('lon') != '' ) {
            Rshot.map.setView(new L.LatLng($('#geotag-map').data('lat'), $('#geotag-map').data('lon')), 9);
            var markerLocation = new L.LatLng($('#geotag-map').data('lat'), $('#geotag-map').data('lon'));
            var marker = new L.Marker(markerLocation);
            Rshot.map.addLayer(marker);
            marker.bindPopup($('#geotag-map').data('description')); // .openPopup();
        }
    }
});
