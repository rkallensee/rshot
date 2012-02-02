$(document).ready(function() {
    $('a[rel=tooltip], span[rel=tooltip]').tooltip();

    $('a[rel=popover]').popover({html: true});

    $("a.lightbox").fancybox({
        'transitionIn'  :   'elastic',
        'transitionOut' :   'elastic',
        'speedIn'       :   600,
        'speedOut'      :   200,
        'overlayShow'   :   true,
        'hideOnContentClick': true
    });
});
