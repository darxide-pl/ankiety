var section_dron = document.getElementById('dron');
var section_nav = document.getElementsByTagName('nav')[0];

$(window).scroll(function(){
	menuStyle()
})

#(document).ready(function() {
	menuStyle()
})


function menuStyle()
{	
	if ($(window).scrollTop() > section_dron.offsetHeight - section_nav.offsetHeight) {
		section_nav.setAttribute("class", "lower");
	} else {
		section_nav.setAttribute("class", "");
	}
}

