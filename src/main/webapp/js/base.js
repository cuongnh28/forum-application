$(function(){

    var profile = $("#profile");
    var downMenu = $("#down-menu");

    profile.mouseover(function(){
        downMenu.show();
        $(this).css("background-color","#333");
    }).mouseout(function(){
        downMenu.hide();
        $(this).css("background-color","#3d444c");
    });

    downMenu.mouseover(function(){
        downMenu.show();
    }).mouseout(function(){
        downMenu.hide();
    });

    for (let i = 0; i < document.querySelectorAll('input').length; i++) {
        document.querySelectorAll('input')[i].onclick = function (){
            document.querySelector('#error').innerHTML = ''
            document.querySelector('#error-message').innerHTML = ''
        }
    }

});


