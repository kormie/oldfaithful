(function( $ ) {

  $.fn.resizeAvatar = function( ) {
    var aspectRatio = 0
      ,	isIE6 = $.browser.msie && (6 == ~~ $.browser.version);
    
    if (params.height >= 100 && params.width >= 100 ){
      var zoom = true;
    }else{
      var zoom = false;
    }
    
    return this.one( "load", function() {

      this.removeAttribute( "height","width" )
      this.style.height = this.style.width = "";

      var picH = this.height
        ,	picW = this.width
        ,	picAR = imgWidth / imgHeight
        ,	aHeight = 80
        ,	aWidth = 80
        ,	aAR = 1;

      // Only resize the images that need resizing
      if ( ( picH > 80) || ( picW > 80) ) {

        if ( picAR > 1 ) {
          aH = ~~ ( picH / picW * 80 );
        } else {
          aW = ~~ ( picW / picH * 80 );
        }
        if ( zoom = false){
          this.height = aH;
          this.width = aW;  
        }else if (zoom = true && aH < 80){
          this.height = 80;
          return this.height
        }else if (zoom = true && aW < 80){
          this.width = 80;
        } 
      }
    })
    .each(function() {

      // Trigger load event (for Gecko and MSIE)
      if ( this.complete || isIE6 ) {
        $( this ).trigger( "load" );
      }
    });
    
  };  
})( jQuery );