$(document).ready ->
    jQuery(top).trigger('initialize:frame');

    $(window).bind 'mercury:saved', ->
      alert("mercury:saved")
      window.location = window.location.href.replace(/\/editor\//i, '/');

    $(window).bind 'mercury:ready', ->
      alert("mercury:ready")
      Mercury.saveURL="/sepp";

    # alert ('customizations loaded');