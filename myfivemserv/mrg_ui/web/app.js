const Root = document.querySelector(":root");
function showLabel() {
    $('.streetlabel').addClass('show');        // animuj wejście
  }

  function hideLabel() {
    $('.streetlabel').removeClass('show');       // animuj wyjście
  }

function getDangerColor(code) {
    switch (code) {
      case "green": return "#29750d";
      case "orange": return "#bf610f";
      case "red": return "#ff0000";
      case "black": return "#000";
      default: return "#29750d";
    }
  }

  function updateDate() {
    var d = new Date();
    let dzien = d.getDate();
    if (dzien < 10) {
        dzien = "0" + dzien;
    }
    let miesiace = new Array();
    miesiace[0] = "JAN";
    miesiace[1] = "FEB";
    miesiace[2] = "MAR";
    miesiace[3] = "APR";
    miesiace[4] = "MAY";
    miesiace[5] = "JUN";
    miesiace[6] = "JUL";
    miesiace[7] = "AUG";
    miesiace[8] = "SEP";
    miesiace[9] = "OCT";
    miesiace[10] = "NOV";
    miesiace[11] = "DEC";
    let miesiac = miesiace[d.getMonth()];
    let rok = d.getFullYear();
    let godzina = d.getHours();
    if (godzina < 10) {
        godzina = "0" + godzina;
    }
    let minuta = d.getMinutes();
    if (minuta < 10) {
        minuta = "0" + minuta;
    }
    let sekunda = d.getSeconds();
    if (sekunda < 10) {
        sekunda = "0" + sekunda;
    }
    $('#bodycam_date').html(`${dzien} ${miesiac} ${rok} ${godzina}:${minuta}:${sekunda}`);
}

  
let nuiReady = false
let bodycamInterval;
let Show = true
Talking = false
window.addEventListener('message', function(event) {
    let data = event.data
    switch(data.action) {
        case 'HelpNotification':
            if (data.show) {
                $('#text').html(data.msg)
                $('#help').fadeIn(300)
            } else {
                $('#help').fadeOut(300)
                setTimeout(function() {
                    $('#text').html("")
                }, 300)
            }    
            break;
        case 'updateStatus':
            UpdateStatus(event.data.data)
            break;
        case 'updateTalking':
            Talking = event.data.data
            break;
        case "showProgressBar":
            showProgressBar(data.label, data.duration)
        break;
        case "showCinematic":
            ChangeCinematic(data.data)
        break;
        case "cancelProgressBar":
            cancelProgressBar();
        break;
        case 'setVisible':
            if(event.data.data.enabled){
                $('body').fadeIn(200);
            }else{
                $('body').fadeOut(200);
            }
            Show = event.data.data.enabled
        break;
        case 'toggleBodycam':
            if(event.data.data.show){
                $('.bodycam').fadeIn(200);
                updateDate()
                bodycamInterval = setInterval(function() {
                    updateDate();
                }, 1000);
            }else{
                $('.bodycam').fadeOut(200);
                clearInterval(bodycamInterval);
            }
            break;
        case 'openSettings':
            $('.settings').fadeIn(200);
            break;
        case 'InVehicleMode':
            if(event.data.data){
                $('#notifications').addClass("up")
                showLabel()
                $('.element-carhud').fadeIn(200)
            }else{
                $('#notifications').removeClass("up")
                hideLabel()
                $('.element-carhud').fadeOut(200)
            }
            break;
        case 'sendNotify':
            createToast(event.data.data.message, event.data.data.tyoe, event.data.data.title, event.data.data.time);
            break;
        case 'SendSeatbeltBeep':
            $.playSound("seatbelt.ogg")
            var audio = document.getElementById("audioplayer");
            $('#audioplayer')[0].volume = 0.25;
            break;
        case 'setVehicleProperties':
            let speed = $("#carhud_speed");
            var tmpSpeed = Math.floor(event.data.data.speed) + ''
            if(event.data.data.speed >= 100) {
                speed.html('<span style="color: white">' + tmpSpeed+ '</span>')
            } else if(event.data.data.speed > 9 && event.data.data.speed <= 99) {
                speed.html('0<span style="color: white">' + tmpSpeed + '</span>')
            } else if(event.data.data.speed > 0 && event.data.data.speed <= 9) {
                speed.html('00<span style="color: white">' + tmpSpeed+ '</span>')
            } else {
                speed.html('000')
            }
            $(".carhud_rpm").css("width", event.data.data.rpm+"%");
            let iconsCount = 0;
            if(event.data.data.show.seatbelt){
                iconsCount++
                $(`#seatbelt`).fadeIn(100)
                $(`.seatbelt-defs`).html(`
                    <filter id="shadowsvg-seatbelt">
                        <feDropShadow dx="0" dy="0" stdDeviation="5" flood-color="var(--seatbelt${event.data.data.seatbelt ? "On" : "Off"}Color)"></feDropShadow>
                    </filter>    
                `)
                $(`#seatbelt_main`).css("stroke", `var(--seatbelt${event.data.data.seatbelt ? "On" : "Off"}Color`)
            }else{
                $(`#seatbelt`).fadeOut(100)
            }
            if(event.data.data.show.engine){
                iconsCount++
                $(`#engine`).fadeIn(100)
                $(`.engine-defs`).html(`
                    <linearGradient id="gradient-engine">
                        <stop offset="${event.data.data.enginehealth}%" stop-color="#ffffff" stop-opacity="1"></stop>
                        <stop offset="${event.data.data.enginehealth}%" stop-color="#040e1b" stop-opacity="1"></stop>
                    </linearGradient>
                    <filter id="shadowsvg-engine">
                        <feDropShadow dx="0" dy="0" stdDeviation="5" flood-color="var(--engineColor)"></feDropShadow>
                    </filter>    
                `)
            }else{
                $(`#engine`).fadeOut(100)
            }
            if(event.data.data.show.fuel){
                iconsCount++
                $(`#fuel`).fadeIn(100)
                $(`.fuel-defs`).html(`
                    <linearGradient id="gradient-fuel">
                        <stop offset="${event.data.data.fuel}%" stop-color="#ffffff" stop-opacity="1"></stop>
                        <stop offset="${event.data.data.fuel}%" stop-color="#040e1b" stop-opacity="1"></stop>
                    </linearGradient>
                    <filter id="shadowsvg-fuel">
                        <feDropShadow dx="0" dy="0" stdDeviation="5" flood-color="var(--fuelColor)"></feDropShadow>
                    </filter>    
                `)
            }else{
                $(`#fuel`).fadeOut(100)
            }

            $('.carhud_uppr_box').css( { "right" : `0.0vw` } )
            break;
        case 'setRoad':
            $('.direction-text').html(event.data.data.direction)
            $('#street-header').html(event.data.data.street)
            $('#street-footer').html(event.data.data.zone)
            break;
        case 'updateBodycam':
            $('#bodycam_name').html(event.data.data.name)
            $('#bodycam_job').html(event.data.data.department)
            Root.style.setProperty("--bodycamR", event.data.data.color[0]);
            Root.style.setProperty("--bodycamG", event.data.data.color[1]);
            Root.style.setProperty("--bodycamB", event.data.data.color[2]);
            break;
        case 'openScoreboard':
            $('.content').addClass("content-visible")
            $('.content').removeClass("content-hidden")
            //event.data.data
            $('#job').html(event.data.data.job.label+" - "+event.data.data.job.grade_label)
            $('#playerCount').html(event.data.data.counter.players+"/"+event.data.data.slots)
            $('#dangerColorStroke').html(`
                    <path stroke-width="22" fill="transparent" stroke="${getDangerColor(event.data.data.code)}" 
                        d="M896 704C896 720.213333 887.04 734.293333 873.386667 741.546667L536.32 930.986667C529.493333 936.106667 520.96 938.666667 512 938.666667 503.04 938.666667 494.506667 936.106667 487.68 930.986667L150.613333 741.546667C136.96 734.293333 128 720.213333 128 704L128 320C128 303.786667 136.96 289.706667 150.613333 282.453333L487.68 93.013333C494.506667 87.893333 503.04 85.333333 512 85.333333 520.96 85.333333 529.493333 87.893333 536.32 93.013333L873.386667 282.453333C887.04 289.706667 896 303.786667 896 320L896 704Z" />
                `)
            $('#dangerColor').css("background", getDangerColor(event.data.data.code))
            $('#adminsOnline').html(event.data.data.ping+"ms")
            Object.keys(event.data.data.counter).forEach((key) => {
                $(".count[data-job='"+key+"']").html(event.data.data.counter[key])
            })
            let time = new Date().toLocaleTimeString("PL-PL")
            $("#footerDate").html(new Date().toLocaleDateString()+" "+time.slice(0, time.length-3))
            break;
        case 'closeScoreboard':
            $('.content').removeClass("content-visible")
            $('.content').addClass("content-hidden")
            break;
        case 'startNUI':
            nuiReady = true
            $('body').fadeIn(200)
            $('#scoreboard-subtitle').html(`ID: `+event.data.data.ServerId+" SSN: "+String(event.data.data.ssn).padStart(5, '0'))
        break;
    }
})
function UpdateStatus(data) { 
    Object.keys(data).forEach((element, index) => {
        data[element] = Number(data[element]);
        if(element == "voice"){
            $(`.${element}-defs`).html(`
                <linearGradient id="gradient-${element}">
                    <stop offset="${data[element]}%" stop-color="#${Talking ? "bfbdbd" : "ffffff"}" stop-opacity="1"></stop>
                    <stop offset="${data[element]}%" stop-color="#040e1b" stop-opacity="1"></stop>
                </linearGradient>
                <filter id="shadowsvg-${element}">
                    <feDropShadow dx="0" dy="0" stdDeviation="5" flood-color="var(--${element}Color)"></feDropShadow>
                </filter>    
            `)
        }else if(element == "oxygen" || element == "sprint"){
            if(data[element] < 100){
                $(`#${element}`).fadeIn(200)
                $(`.${element}-defs`).html(`
                    <linearGradient id="gradient-${element}">
                        <stop offset="${data[element]}%" stop-color="#ffffff" stop-opacity="1"></stop>
                        <stop offset="${data[element]}%" stop-color="#040e1b" stop-opacity="1"></stop>
                    </linearGradient>
                    <filter id="shadowsvg-${element}">
                        <feDropShadow dx="0" dy="0" stdDeviation="5" flood-color="var(--${element}Color)"></feDropShadow>
                    </filter>    
                `)
            }else{
                $(`#${element}`).fadeOut(200)
            }
        }else if(element == "armour"){
            if(data[element] > 0){
                $(`#${element}`).fadeIn(200)
                $(`.${element}-defs`).html(`
                    <linearGradient id="gradient-${element}">
                        <stop offset="${data[element]}%" stop-color="#ffffff" stop-opacity="1"></stop>
                        <stop offset="${data[element]}%" stop-color="#040e1b" stop-opacity="1"></stop>
                    </linearGradient>
                    <filter id="shadowsvg-${element}">
                        <feDropShadow dx="0" dy="0" stdDeviation="5" flood-color="var(--${element}Color)"></feDropShadow>
                    </filter>    
                `)
            }else{
                $(`#${element}`).fadeOut(200)
            }
        }else{
            $(`.${element}-defs`).html(`
                <linearGradient id="gradient-${element}">
                    <stop offset="${data[element]}%" stop-color="#ffffff" stop-opacity="1"></stop>
                    <stop offset="${data[element]}%" stop-color="#040e1b" stop-opacity="1"></stop>
                </linearGradient>
                <filter id="shadowsvg-${element}">
                    <feDropShadow dx="0" dy="0" stdDeviation="5" flood-color="var(--${element}Color)"></feDropShadow>
                </filter>    
            `)
        }
    });
}
let options = {
    "healthColor": {
        title: "Kolor zdrowia",
        default: "#e04a36"
    },
    "armourColor": {
        title: "Kolor pancerza",
        default: "#8b8b8b"
    },
    "hungerColor": {
        title: "Kolor głodu",
        default: "#ffa836"
    },
    "thirstColor": {
        title: "Kolor spragnienia",
        default: "#3392ff"
    },
    "sprintColor": {
        title: "Kolor kondycji",
        default: "#7eff43"
    },
    "oxygenColor": {
        title: "Kolor tlenu",
        default: "#385dff"
    },
    "voiceColor": {
        title: "Kolor głosu",
        default: "#af38ff"
    }
}

window.onload = function(){
    $('body').fadeOut(0)
    $('#armour').fadeOut(0)
    $('#help').fadeOut(0)
    $('.bodycam').fadeOut(0);
    $('#oxygen').fadeOut(0)
    $('.settings').fadeOut(0)
    $('.element-carhud').fadeOut(0)
    setInterval(() => {
        if(nuiReady && Show == true && new String($('body').css('display')) == 'none'){
            $('body').fadeIn(200)
        }
    }, 1000);
    if (localStorage.getItem("main_color") == null) {
        localStorage.setItem("main_color", "#f99406")
        $("#hud_edit").append(`
            <div class="setting">
                <div class="name">Kolor GUI</div>
                <div class="dsadauidha">
                    <label>
                        <input id="changemaincolor" type="color" value="#f99406">
                    </label>
                </div>
            </div>    
        `)
        $.post("https://mrg_ui/changeColor", JSON.stringify({
            color: "#f99406"
        }));
    }else{
        Root.style.setProperty("--main", localStorage.getItem("main_color"));
        $("#hud_edit").append(`
            <div class="setting">
                <div class="name">Kolor GUI</div>
                <div class="dsadauidha">
                    <label>
                        <input id="changemaincolor" type="color" value="${localStorage.getItem("main_color")}">
                    </label>
                </div>
            </div>    
        `)
        $.post("https://mrg_ui/changeColor", JSON.stringify({
            color: localStorage.getItem("main_color")
        }));
    }
    $('#changemaincolor').change(function(){
        var color = $(this).val();
        Root.style.setProperty("--main", color);
        localStorage.setItem("main_color", color);
        $.post("https://mrg_ui/changeColor", JSON.stringify({
            color: color
        }));
    })
    Object.keys(options).forEach(element => {
        let option = options[element]
        if (localStorage.getItem(element) == null) {
            Root.style.setProperty("--"+element, option.default);
            localStorage.setItem(element, option.default);
            $("#hud_edit").append(`
                <div class="setting">
                    <div class="name">${option.title}</div>
                    <div class="dsadauidha">
                        <label>
                            <input id="change${element}" type="color" value="${option.default}">
                        </label>
                    </div>
                </div>    
            `)
        }else{
            var color = localStorage.getItem(element)
            Root.style.setProperty("--"+element, color);
            $("#hud_edit").append(`
                <div class="setting">
                    <div class="name">${option.title}</div>
                    <div class="dsadauidha">
                        <label>
                            <input id="change${element}" type="color" value="${color}">
                        </label>
                    </div>
                </div>    
            `)
        }
        $('#change'+element).change(function(){
            var color = $(this).val();
            Root.style.setProperty("--"+element, color);
            localStorage.setItem(element, color);
        })
    });
    if (localStorage.getItem("watermark_show") == null) {
        localStorage.setItem("watermark_show", true)
    }else{
        ChangeWatermark(localStorage.getItem("watermark_show") == "true")
        $("#"+(localStorage.getItem("watermark_show") == "true" ? "1-2" : "1-1")).prop("checked", true);
        $("#"+(localStorage.getItem("watermark_show") == "true" ? "1-1" : "1-2")).prop("checked", false);
    }
}

function ChangeWatermark(data){
    localStorage.setItem("watermark_show", data);
    $(".watermark")[data ? "fadeIn" : "fadeOut"](500)
}

function ChangeCinematic(data){
    $(".app-cinematic")[!data ? "fadeIn" : "fadeOut"](500)
    $(".app-hud-container")[data ? "fadeIn" : "fadeOut"](500)
    if (localStorage.getItem("watermark_show") != null) {
        if(localStorage.getItem("watermark_show") != "false"){
            $(".watermark")[data ? "fadeIn" : "fadeOut"](500)
        }
    }
}



let index = 0,
toasts = [],
maxOpened = 3;

const types = {
    info: { icon: "fa-solid fa-circle-info", color: "#ff9e30" },
    inform: { icon: "fa-solid fa-circle-info", color: "#ff9e30" },
    failure: { icon: "fa-solid fa-x", color: "#fc2003" },
    error: { icon: "fa-solid fa-x", color: "#fc0703" },
    warning: { icon: "fa-sharp fa-solid fa-triangle-exclamation", color: "#fcba03" },
    success: { icon: "fa-solid fa-check", color: "#45fc03" },
};

function checkURL(url) {
    return(url.match(/\.(jpeg|jpg|gif|png)$/) != null);
}

function remove(id) {
    var toast = findToast(id);

    if (toast) {
        $('#toast-' + id).addClass('toast-leave');
        setTimeout(function () {
            $('#toast-' + id).css('display', 'none');
            $('#toast-' + id).remove();
        }, 1000);
        var index = toasts.indexOf(toast);
        toasts.splice(index, 1);
    }

    function findToast(toastId) {
        for (var i = 0; i < toasts.length; i++) {
            if (toasts[i].id == id) {
                return toasts[i];
            }
        }
    }
}

function createToast(message, type, title, duration) {
    if (checkURL(message)) {
        message = "Załącznik";
    }
    const toastType = types[type] || types.info; // Domyślnie 'info' jeśli nie ma takiego typu
    sendnotify(message, type, title, duration, toastType.color, toastType.icon);
}

function sendnotify(message, type, title, duration, color, icon) {
    var toast = {};
    toast.id = index++;

    toast.code = `
    <div id="toast-${toast.id}" class="notification index-${toast.id}" data-v-748e3f0e style="--color: ${color}; --time: ${duration / 1000}s;">
        <div class="icon" data-v-748e3f0e>
            <div class="icon-svg" data-v-748e3f0e>
                <i class="${icon}" data-v-748e3f0e></i>
            </div>
            <svg class="hexagon" data-v-748e3f0e xmlns="http://www.w3.org/2000/svg" viewBox="45 45 930 930">
                <path fill="transparent" stroke="${color}" stroke-width="24" d="M896 704C896 720.213333 887.04 734.293333 873.386667 741.546667L536.32 930.986667C529.493333 936.106667 520.96 938.666667 512 938.666667 503.04 938.666667 494.506667 936.106667 487.68 930.986667L150.613333 741.546667C136.96 734.293333 128 720.213333 128 704L128 320C128 303.786667 136.96 289.706667 150.613333 282.453333L487.68 93.013333C494.506667 87.893333 503.04 85.333333 512 85.333333 520.96 85.333333 529.493333 87.893333 536.32 93.013333L873.386667 282.453333C887.04 289.706667 896 303.786667 896 320L896 704Z"></path>
            </svg>
            <div class="background" data-v-748e3f0e style="--color: ${color}1a;"></div>
        </div>
        <div class="content" data-v-748e3f0e>
            <div class="title" data-v-748e3f0e>${title}</div>
            <div class="message" data-v-748e3f0e>${message}</div>
            <div class="progress" data-v-748e3f0e style="--color: ${color}90;">
                <div class="progress-val" data-v-748e3f0e></div>
            </div>
        </div>
    </div>`;

    if (maxOpened && toasts.length >= maxOpened) {
        remove(toasts[0].id);
    }
    $.playSound("intuition.mp3")
    toasts.push(toast);
    $('#notifications').append(toast.code);

    // Apply type-based class and icon adjustments
    $('#toast-' + toast.id).addClass(type);
    setTimeout(function () {
        $('#toast-' + toast.id).removeClass('toast-enter');
        remove(toast.id);
    }, duration+200);
}

$.extend({
    playSound: function () {
        return $(
            '<audio id="audioplayer" class="sound-player" autoplay="autoplay" style="display:none;">' +
            '<source src="' + arguments[0] + '" />' +
            '<embed src="' + arguments[0] + '" hidden="true" autostart="true" loop="false"/>' +
            '</audio>'
        ).appendTo('body');
    },
    stopSound: function () {
        $(".sound-player").remove();
    }
});


function CloseHudEdit() {
    $('.settings').fadeOut(200);
    $.post("https://mrg_ui/closeSettings", JSON.stringify());
}


$(document).on('keyup',function(evt) {
    if (evt.keyCode == 27) {
        CloseHudEdit();
    }
});



let progressbar1, progressbar2, progressbar3
let progState = false

function showProgressBar(title, time) {
    progState = true
	$('#progressbar-val').css('right', '0');
    $('#progressbar-val').css('transition', `width linear 0s`);
    $('#progressbar-val').css('width', '0');
    $('#progressbar-title').html(title);
    progressbar1 = setTimeout(function () {
        $('#progressbar').css('opacity', '1');
    }, 500);
    progressbar2 = setTimeout(function () {
        $('#progressbar-val').css('transition', `width linear ${time / 1000 + "s"}`);
        $('#progressbar-val').css('width', '100%');
    }, 1000);
    progressbar3 = setTimeout(function () {
        $('#progressbar').css('opacity', '0');
        $.post(`https://${GetParentResourceName()}/sendRequest`, JSON.stringify({action: 'finishProgressBar'}));
    }, 1000 + time);
}

function cancelProgressBar() {
    progState = false
    $.post(`https://${GetParentResourceName()}/sendRequest`, JSON.stringify({action: 'cancelProgressBar'}));
    $('#progressbar').css('opacity', '0');
    clearTimeout(progressbar1);
    clearTimeout(progressbar2);
    clearTimeout(progressbar3);
}