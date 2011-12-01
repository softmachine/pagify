$(document).ready ->
    jQuery(top).trigger('initialize:frame');

    $(window).bind 'mercury:saved', ->
      window.location = window.location.href.replace(/\/editor\//i, '/');

    # alert ('customizations loaded');