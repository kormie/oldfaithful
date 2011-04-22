(function( $ ) {

  $.fn.resizeAvatar = function( ) {
    var $this = $(this)

    var aspectRatio = 0
      ,	isIE6 = $.browser.msie && (6 == ~~ $.browser.version);
    
    var zoom = false
    
    if (this.height() >= 100 && this.width() >= 100 ){
      zoom = true;
    }
    
    return this.one( "load", function() {

      this.removeAttribute( "height","width" )
      this.style.height = this.style.width = "";

      var picH = this.height
        ,	picW = this.width
        ,	picAR = picW / picH
        , pVC = picW/2
        , pHC = picH/2
        ,	aH = 80
        ,	aW = 80
        ,	aAR = 1;

      // Only resize the images that need resizing
      if ( ( picH > 80) || ( picW > 80) ) {

        if ( picAR > 1 ) {
          aH = ~~ ( picH / picW * 80 );
        } else {
          aW = ~~ ( picW / picH * 80 );
        }
        if ( zoom == false){
          this.height = aH;
          this.width = aW;  
        }else if (zoom == true && aH < 80){
          this.height = 80;
        }else if (zoom == true && aW < 80){
          this.width = 80;
        } 
      }
      
      
      var aHC = $(this).width()/2
        , aVC = $(this).height()/2;
      
      if  (aVC > 40 || aHC > 40) {
        var atop = 0;
        var aleft = 0;
        if (aVC > aHC){
          $this.css("margin-top", function(){
            atop = 40 - aVC;
            atop += "px";
            return atop;
          })
        }else{
          $this.css("margin-left", function(){
            left = 40 - aHC
            left += "px"});
            return aleft;
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