$(document).ready(function() {
    $('a[rel=twipsy], span[rel=twipsy]').twipsy({'placement': 'below'});
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
