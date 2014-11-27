/*version tmy20140921*/
/*version tmy20141010*/

function logIn(e){
	var $nickname=$(e).find('#nickname'),
		$account=$(e).find('#account'),
		$password=$(e).find('#password'),
		$password_confirmation=$(e).find('#password_confirmation'),
		submit=true,
		emailPattern = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i,
		pwPattern= /^[a-zA-Z]{1}[a-zA-Z0-9]{5,11}$/;
		
	if($.trim($nickname.val())==''){
		submit=false;
		$nickname.next().attr('data-error','暱稱不可為空');
	}else{
		$nickname.next().attr('data-error','');
	}
	if($.trim($account.val())==''){
		submit=false;
		$account.next().attr('data-error','帳號不可為空');
	}else if (!emailPattern.test($account.val())){
	  	submit=false;
	  	$account.next().attr('data-error','帳號格式錯誤(email)');
	}else{
		$account.next().attr('data-error','');
	}

	if($.trim($password.val())==''){
		submit=false;
		$password.next().attr('data-error','密碼不可為空');
	}else if (!pwPattern.test($password.val())){
	  	submit=false;
	  	$password.next().attr('data-error','密碼格式錯誤');
	}else{
		$password.next().attr('data-error','');
		if($password.val()!=$password_confirmation.val()){
			submit=false;
			$password_confirmation.next().attr('data-error','確認密碼不符合');
		}else{
			$password_confirmation.next().attr('data-error','');
		}
	}
	if (submit) {
		return true;
	}else{
		$('.indexInfo').addClass('signUpError').delay(400).queue(function(){
			$(this).removeClass("signUpError").dequeue();
		});
		return false;
	};
}

function contentResize(){
	 contentWidth();
      $(window).resize(function(){
        contentWidth();
        $('#fb-comments').find('span').width('100%');
        $('#fb-comments').find('iframe').width('100%');//修改ＦＢ外掛留言視窗寬度
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

function googleMap(option){
//function googleMap(user_id,center,distance)
	var user_id = option.user_id,
		center = option.center,
		distance = option.distance,
		from = option.from,
		near = option.near,
		isFavorite = option.favorite,
		favoriteMsg = option.favoriteMsg,
		favoriteLat = option.favoriteLat,
		favoriteLon = option.favoriteLon,
		favoriteAdd = option.favoriteAdd;
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

		    var branches = [];
		    if(isFavorite){
		    	//如果是內容頁，則不post
		    	var infowindow_a = new google.maps.InfoWindow();
		    	var latlon_a = new google.maps.LatLng(
                        parseFloat(favoriteLat), parseFloat(favoriteLon));
                markers = new google.maps.Marker({
                    position: latlon_a,
                    title: favoriteMsg,
                    //icon: b.icon,
                    map: map,
                    zIndex: 1
                });
                attachSecretMessage(markers,favoriteAdd,favoriteMsg,'',infowindow_a);

				var bounds = new google.maps.LatLngBounds();
				bounds.extend(inicenter);
				bounds.extend(latlon_a);
                map.fitBounds(bounds);
		    	
		    	return
		    }
		    $.post("/askcoodinate", {id: user_id, c: center, d: distance, near: near, from: from}, function(data) {
		    	//console.log(data);
	            //有資料才做
	            console.log('psot');
	            if(data!=""){
	                for (i = 0; i < data.length; i++) {

	                	var store = data[i];

						var siteX=(inilat*2)-store['latitude'];
						var siteY=(inilnt*2)-store['longitude'];
	                    
	                    branches.push({
	                        address: store['address'],
	                        msg: store['msg'],
	                        pic_file_name: store['pic_file_name'],
	                        latlng: new google.maps.LatLng(
	                            parseFloat(store['latitude']), parseFloat(store['longitude'])),
	                        siteLatlng: new google.maps.LatLng(
	                            parseFloat(siteX), parseFloat(siteY)),
	                        dist: 0
	                    });
	                }

					var infowindow = new google.maps.InfoWindow();
					var bounds = new google.maps.LatLngBounds();
					bounds.extend(inicenter);
					for (i = 0; i < data.length; i++) {
						var b = branches[i];
	                    if ( b == undefined ){
	                    	continue
	                    }
	                    //console.dir(b.latlng.lat()+"/"+isNaN(b.latlng.lat()));
	                    if(!isNaN(b.latlng.lat())){
							bounds.extend(b.latlng);
							//bounds.extend(b.siteLatlng);
	                    }
	                    markers[i] = new google.maps.Marker({
	                        position: b.latlng,
	                        title: b.msg,
	                        //icon: b.icon,
	                        map: map,
	                        zIndex: 1
	                    });
	                    attachSecretMessage(markers[i],b.address,b.msg,b.pic_file_name,infowindow);

					}

	                map.fitBounds(bounds);
	            }
		    });
	    }
	}
	//每一個標記點加入一個視窗資訊的事件處理器
	function attachSecretMessage(marker, address, msg, pic ,infowindow) {
	    var cont = "<div id=\"infobox\">"+address+"</div>";
	    google.maps.event.addListener(marker, 'mouseover', function() {
	    	infowindow.setContent(cont);
	        infowindow.open(map, this);
	       	this.setOptions({zIndex:2});
	    });
	    google.maps.event.addListener(marker, 'mouseout', function() {
	        infowindow.close(map, this);
	       	this.setOptions({zIndex:1});
	    });
	    google.maps.event.addListener(marker, 'click', function() {
	    });	
	}
	google.maps.event.addDomListener(window, 'load', initialize);

}

function inputAct(){

	$( "input" ).focus(function() {
		$(this).attr('placeholder','');
	});
	$( "input" ).blur(function() {
		var placeHolder = $(this).next().attr('data-tipB');
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