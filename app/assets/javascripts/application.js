// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require_tree .

$(document).ready(function(){
    $('#lodd').jrumble({
        rumbleEvent: 'constant',
        rangeX: 1,
        rangeY: 3,
        rangeRot: 1
    });
    
    $('td').click(function(){
       $('.buyRow').css("background-color","white");
       $('.buyRow').css("color","black");
       
       if($(this).parent().hasClass('buyRow')){
           $(this).parent().css("background-color","#51A351");
           $(this).parent().css("color","white");
       }
    });
   
    $('#srchField').onEnter(function(){
       searchTaggedSongs($('#srchField').val())
    });
   
    $("#srchField").focus(function() {
        $('#searchTips').slideDown();
    }).blur(function() {
        $('#searchTips').slideUp();
    });
});

function btnTrack(){
    $('#newTrack').stop().slideDown();
    $('#btnTrack').hide();
}

function newTrack(){
    $('#newTrack').stop().hide();
    $('#btnTrack').stop().show();
}

function bandDetailShow(){
    $('#bandDetails').stop().hide();
    $('#updateBand').stop().slideDown();
}

function bandAllowUpdate(){
    $('#updateBand').stop().hide();
    $('#bandDetails').stop().show();
}

function injectSongForm(){
    
}

function infoCredit(){
    $('#infoPurchase').stop().slideDown();
}

function innerAlbumToggle(){
    $('#albumInner').slideToggle();
}

function displayAllSongs() {
    $.ajax({
     type: 'GET',
     url: '/purchases/displayall',
     success: createSuccessHandler,
     error: createErrorHandler
    });
}

function createSuccessHandler(data) {
    $('#usrSongs').html(data);
    $('#btnAllSongs').hide();
}

function createErrorHandler(data) {
    $('#usrSongs').html(
        '<div class="alert alert-error">' +
          '<button type="button" class="close" data-dismiss="alert">×</button>' +
          '<h3 style="font-weight: 300">Awh Snap =/</h3>' +
          '<p style="font-size: 16px; font-weight: 300">' +
            'A problem occured when we tried to display all your songs.<br/>' +
            'Please <strong>refresh</strong> the page and everything should be back to normal!' +
          '</p>' +
        '</div>'
    );
}

function searchTaggedSongs(tag) {
    $.ajax({
     type: 'GET',
     url: '/home/search?tag=' + tag,
     success: createSuccessHandlerSearch,
     error: createErrorHandlerSearch
    });
}

function createSuccessHandlerSearch(data) {
    var json = data, obj = JSON.parse(json);
    var newTable = '<table class="table table-striped"><tr class="info"><td>Band Name</td><td>Track Name</td><td>Price</td><td>View</td></tr>'
        
    $.each(obj, function(index) {
        newTable += '<tr>' + 
            '<td>' + obj[index].band_name + '</td>' +
            '<td>' + obj[index].name + '</td>' +
            '<td>' + (parseInt(obj[index].cost) / 100).toFixed(2) + '</td>' +
            '<td>' + '<a href="/songs/' + obj[index].id + '">View</a>' + '</td>' + 
            '</tr>';
    });
    newTable += '</table>'
    
    $('#songs').html(newTable);
}

function createErrorHandlerSearch(data) {
    $('#songrows').html(
        '<div class="alert alert-error">' +
          '<button type="button" class="close" data-dismiss="alert">×</button>' +
          '<h3 style="font-weight: 300">Awh Snap =/</h3>' +
            'A problem occured when we tried to display the search results<br/>' +
            'Please <strong>refresh</strong> the page and everything should be back to normal!' +
          '</p>' +
        '</div>'
    );
}

function showPopout(){
    $('a[rel=popover]').popover();
    event.preventDefault();
}


/*
 * Hooks the ENTER keypress to the textbox
 */
jQuery.fn.onEnter = function(callback)
{
    this.keyup(function(e)
        {
            if(e.keyCode == 13)
            {
                e.preventDefault();
                if (typeof callback == 'function')
                    callback.apply(this);
            }
        }
    );
    return this;
}