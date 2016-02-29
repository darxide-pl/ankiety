$('.dcell').each(function (){

var id = $(this).prop('id')

var waypoint = new Waypoint({
  element: document.getElementById(id),
  handler: function(direction) {

  	if(direction == 'down'){
		$('#'+id).find('.dfront').addClass('df-a')
    	$('#'+id).find('.dcircle').addClass('dshr')
    	$('#'+id).find('.dshup').addClass('dcenter')
      $('#'+id).find('.dftext').addClass('dnone')
      $('#'+id).find('.dftext2').removeClass('dnone')
    } else {
    	$('#'+id).find('.dfront').removeClass('df-a')
    	$('#'+id).find('.dcircle').removeClass('dshr')
    	$('#'+id).find('.dshup').removeClass('dcenter')
      $('#'+id).find('.dftext').removeClass('dnone')
      $('#'+id).find('.dftext2').addClass('dnone')
    }


  },
  offset:300
})

})