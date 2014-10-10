/*version tmy20140921*/
/*version tmy20141010*/

function contentResize(){
	 contentWidth();
      $(window).resize(function(){
        contentWidth();
      });

    function contentWidth(){
    	var w = $('section').width();
    	var vatContentW = w-290;
    	if(vatContentW>390){
        	$('.content').width(vatContentW);
    	}else{
    		$('.content').width(390);
    	};
     };
     $( 'input[name="subBtn"]:radio' ).change(function(){
     	var listStyle = $(this).val();
     	$('.favoriteList').removeClass().addClass('favoriteList').addClass(listStyle);
     });
}

function googleMap(){
	var map;
	var markers = [];
	var inicenter;

	var locationStr='媽，我在這!(･∀･)っ'
	var askbounds;
	var mapTimeOut;
	function initialize() {

		if (navigator.geolocation) {
	        var a = navigator.geolocation.getCurrentPosition(showPosition,wrong,{timeout:8000});
	    } else {
	        showPosition({ coords: { latitude: 25.047924, longitude: 121.517081 } });//如果不支援geolocation,定位台北市火車站
	        locationStr='臺北火車站';
	    }

	    function wrong(error) {
	        locationStr='臺北火車站';
	        showPosition({ coords: { latitude: 25.047924, longitude: 121.517081 } });
	        switch (error.code) {
	            case error.TIMEOUT:
	                alert('呃...頭上剛好有片烏雲飄過，造成衛星定位不準。\n將採系統預設位置顯示。');
	                break;

	            case error.POSITION_UNAVAILABLE:
	                if(sessionStorage && sessionStorage.MAP_POSITION_UNAVAILABLE==1){
	                	console.log('MAP_POSITION_UNAVAILABLE');
					}else{
					  	sessionStorage.MAP_POSITION_UNAVAILABLE=1;
	                	alert('無法取得定位');
					}
	                break;

	            case error.PERMISSION_DENIED://拒絕
	                if(sessionStorage && sessionStorage.PERMISSION_DENIED==1){
	                	console.log('PERMISSION_DENIED');
					}else{
					  	sessionStorage.PERMISSION_DENIED=1;
	                	alert('為了提供更好的服務，\n請允許定位功能喔!');
					}
	                break;

	            case error.UNKNOWN_ERROR:
	                alert('不明的錯誤，請稍候再試');
	                break;
	        }
	    }
	    function showPosition(position){
	    	var inilat = position.coords.latitude;
	    	var inilnt = position.coords.longitude;

	    	inicenter = new google.maps.LatLng(inilat, inilnt);
	        var mapOptions = {
				zoom: 12,
	            center: inicenter,
				panControl: true,
				panControlOptions: {
			  		position: google.maps.ControlPosition.RIGHT_CENTER
				},
				zoomControl: true,
				zoomControlOptions: {
					style: google.maps.ZoomControlStyle.DEFAULT,
					position: google.maps.ControlPosition.RIGHT_CENTER
				},
				streetViewControl: true,
				scaleControl:true
	        };
	        map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
	        var marker = new google.maps.Marker({
	            position: inicenter,
	            map: map
	        });
	        var infowindow = new google.maps.InfoWindow({
		        content: "<div style=\"width:130px;padding:5px 0;text-align:center;\">"+locationStr+"</div>"
		    });
		    google.maps.event.addListener(marker, 'mouseover', function() {
		        infowindow.open(map, this);
		    });
		    google.maps.event.addListener(marker, 'mouseout', function() {
		        infowindow.close(map, this);
		    });
	    }
	}
	google.maps.event.addDomListener(window, 'load', initialize);

}

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