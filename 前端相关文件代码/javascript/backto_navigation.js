// JavaScript Document

$(function(){
    'use strict';
	var title_height = 221;


    $(window).scroll(function(){
        var this_scrollTop = $(this).scrollTop();
        
		if(this_scrollTop>title_height ){
            $(".navigation").stop().fadeTo(100,0.95) ;
        }
		if(this_scrollTop<title_height ){
		    $(".navigation").stop().fadeTo(50,0) ;
		}
    });
	
	$("#navigation_back_top").click(function(){$('html,body').animate({scrollTop: '0px'}, 400);}); 
});