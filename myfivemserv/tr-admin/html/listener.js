$(function(){
    window.onload = (e) => {
        window.addEventListener("message", (event) => {
            var item = event.data;
            if(item !== undefined && item.action === "show") {
                if (item.display) {
                    $('#'+item.type).show();
                    $('#'+item.type+"-audio")[0].play();
                } else{
                    $('#'+item.type).hide();
                    $('#'+item.type+"-audio")[0].pause();
                }
            }
        })
    }
    
    AudioEnd = function(e) {
        $('.image').hide();
    }
})