/*version tmy20140921*/


function inputAct(){

	$( "input" ).focus(function() {
		$(this).attr('placeholder','');
	});
	$( "input" ).blur(function() {
		var placeHolder = $(this).next().attr('data-tip');
		$(this).attr('placeholder',placeHolder);
	});
}

function bgSlide(){
	var slideNum=$('.bg').children('li').length;
	var i = 0;
	var slider = setInterval(function(){goSlide(slideNum);},5000);

	function goSlide(slideNum){

		if(i==slideNum-1){
			var before = i ;
			var now = 0 ;
			i=0;
		}else{
			var before = i ;
			var now = i+1 ;
			i++;
		};
		if(i%2==0){
			$('.bg').children('li').eq(now).children('img').removeClass( "big small" ).addClass( "big" );
		}else{
			$('.bg').children('li').eq(now).children('img').removeClass( "big small" ).addClass( "small" );
		}
		$('.bg').children('li').eq(now).fadeIn(2500);
		$('.bg').children('li').eq(before).fadeOut(2500);
	}

}