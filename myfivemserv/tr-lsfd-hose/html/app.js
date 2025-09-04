var colorInc = 100 / 3;
var currentProgress = 100;
setProgress(currentProgress)

function setProgress(val) {
    if (val >= 0 && val <= 100) {
        //Progress Bar Animation Code From https://codepen.io/junebug12851/pen/mJZNqN
        var valOrig = val;
        currentProgress = val;

        $(".progress").css("height", val + "%");
    } else {
        $(".progress").css("height", 0 + "%");
        currentProgress = 100;
    }
}

window.addEventListener('message', function(event) {
    if (event.data.action === "openui") {
        var type = event.data.type;
        if (type === "show") {
            $('.mainDiv').fadeIn(200);
        } else if (type === "hide") {
            $('.mainDiv').fadeOut(200);
            $(".progress").css("height", 100 + "%");
        }
    } else if (event.data.action === "updateTank") {
        var type = event.data.type;
        setProgress(type);
    }
});
$('.mainDiv').hide();