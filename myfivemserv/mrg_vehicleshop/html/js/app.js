var money = Intl.NumberFormat('en-US', {minimumFractionDigits: 0});

var vehicles = null
var selectedVehicle = null
var selectedCategory = null
var categories = null
let soldvehicles

var testDrive = null
var testDrivePrice = null

function selectCategory(category) {
    const allClass = document.getElementsByClassName('vehicle');
    if (selectedCategory != category) {
        $(`.vehicleshop-categories > .${selectedCategory}`).removeClass("selected-category");
    }
    selectedCategory = category
    $(`.vehicleshop-categories > .${category}`).addClass("selected-category");
    $.post('https://mrg_vehicleshop/action', JSON.stringify({action: 'select-category'}));
    if (!category) {
		for (let i = 0; i < allClass.length; i++) {
			allClass[i].style.display = '';
		}
	} else {
		const showClass = document.getElementsByClassName(category);
		for (let i = 0; i < allClass.length; i++) {
			allClass[i].style.display = 'none';
		}
		for (let i = 0; i < showClass.length; i++) {
			showClass[i].style.display = '';
		}
	}
}
let onStock = false
$(document).on('click', '.vehicle', function(e) {
    var price = $(this).data('price')
    var model = $(this).data('model')
    if (!selectedVehicle) {
        $('.right-bar').fadeIn(100)
    }
    if (model && price) {
        if (selectedVehicle != $(this)) {
            $(selectedVehicle).removeClass("selected-vehicle");
        }
        selectedVehicle = $(this);
        $(this).addClass("selected-vehicle");
        for (const [key, value] of Object.entries(vehicles)) {
            if(value.model === model){
                $('#price').html(money.format(value.price))
                if(value.limit){
                    limit = Number(value.limit) - (soldvehicles[value.model] || 0)
                    if (limit >= 1){
                        $('.test-but').css('opacity', 1)
                        $('.buy-but').css('opacity', 1)
                        onStock = true
                    }else{
                        onStock = false
                        $('.test-but').css('opacity', 0.5)
                        $('.buy-but').css('opacity', 0.5)
                    }
                    $('.on-stock').html("Na stanie: "+limit+"/"+value.limit)
                }else{
                    onStock = true
                    $('.test-but').css('opacity', 1)
                    $('.buy-but').css('opacity', 1)
                    $('.on-stock').html("Na stanie: <span style='position:relative; top: 2.5px;'>∞</span>")
                }
            }
        }
        $.post('https://mrg_vehicleshop/action', JSON.stringify({
            action: 'select',
            model: model
        }));
    }
});

openVehicleShop = function() {
    $("body").fadeIn(500);
    $(".vehicle-list").empty()
    $('.vehicleshop-categories').empty()
    if (testDrive) {
        $('.test-button').show()
        if (testDrivePrice) {
            $('.test-button > div').html(`${translate.test} $${testDrivePrice}`)
        } else {
            $('.test-button > div').html(`${translate.test}`)
        }
    } else {
        $('.test-button').hide()
    }
    for (const [key, value] of Object.entries(categories)) {
        $('.vehicleshop-categories').append(`
            <div class="category ${value}" onclick="selectCategory('${value}')">
                <img src="icons/${value}.svg">
                <span class="tooltiptext">${translate.categories[value]}</span>
            </div>
        `)
    }
    vehicles.forEach((value) => {
        $('.vehicle-list').append(`
            <div class="vehicle ${value.category}" data-model="${value.model}" data-price="${value.price}">
                <div>
                    <div class="vehicle-info">
                        <p class="vehicle-brand">${value.brand}</p>
                        <p class="vehicle-name">${value.name}</p>
                    </div>
                    <div class="vehicle-price">
                        <p>${money.format(value.price)}<span class="dollar-icon">${translate.currency}</span></p>
                    </div>
                </div>
            </div>
        `)
    })
};

changeColor = function(r, g , b, index) {
    if (selectedVehicle) {
        $.post('https://mrg_vehicleshop/action', JSON.stringify({
            action: 'select-color',
            color: {
                r: r, 
                g: g , 
                b: b,
                index: index
            }
        }));
    }
}
    
window.onload = function(e) {
    $('.price > .dollar-icon').html(translate.currency)
    $('.buy-but').html(translate.buy)
    $('.test-but').html(translate.test)
    $('.color-text > div').html(translate.color)
}
    
window.addEventListener('message', function(event) {
    switch(event.data.action) {
        case 'open':
            $(".vehicleshop-logo > .vehicleshop-icon").empty()
            $(".vehicleshop-name").html(event.data.name)
            $(".vehicleshop-logo > .vehicleshop-icon").append(`<i class="${event.data.icon}"></i>`)
            vehicles = Object.values(event.data.vehicles).sort((a, b) => parseFloat(a.price) - parseFloat(b.price))
            categories = event.data.categories
            testDrive = event.data.testDrive
            soldvehicles = event.data.soldModels
            testDrivePrice = event.data.testDrivePrice == 0 && null || event.data.testDrivePrice
            openVehicleShop()
            break;
        case 'close':
            $.post('https://mrg_vehicleshop/action', JSON.stringify({action: 'close'}));
            $("body").fadeOut(5)
            $('.right-bar').fadeOut(5)
            selectedVehicle = null
            selectedCategory = null
            break
        case 'startTest':
            $("body").fadeOut(5)
            break
        case 'stopTest':
            $("body").fadeIn(5)
            break
        case 'bought':
            $("body").fadeOut(5)
            $('.right-bar').fadeOut(5)
            selectedVehicle = null
            selectedCategory = null
            break
    }
})


function close(){
    $.post('https://mrg_vehicleshop/action', JSON.stringify({action: 'close'}));
    $("body").fadeOut(5)
    $('.right-bar').fadeOut(5)
    selectedVehicle = null
    selectedCategory = null
}

window.addEventListener('keydown', function(event) {
    if (event.keyCode === 27) {
        close()
    }
    // if (event.keyCode === 37) {
    //     $.post('https://mrg_vehicleshop/action', JSON.stringify({action: 'rotate-left'}));
    // }
    // if (event.keyCode === 39) {
    //     $.post('https://mrg_vehicleshop/action', JSON.stringify({action: 'rotate-right'}));
    // }
}, false);


var currentElement = null;
var mouseDown = false;
var lastX = 0;
document.addEventListener('mouseover', function (e) {
    currentElement = e.target;
});
window.addEventListener("mousedown", (e) => {
    if (currentElement && currentElement.nodeName == "DIV" || !currentElement.classList.contains("main-screen")){
        lastX = e.offsetX;
        mouseDown = true;
    }
});
window.addEventListener("mouseup", (e) => {
    if (currentElement && currentElement.nodeName == "DIV" || !currentElement.classList.contains("main-screen")){
        lastX = 0;
        mouseDown = false;
    }
});
window.addEventListener("mousemove", (e) => {
    if (!currentElement || currentElement.nodeName !== "DIV" || !currentElement.classList.contains("main-screen")){
        lastX = 0;
        mouseDown = false;
    }
    if (!mouseDown) return;
    let t = lastX - e.offsetX;
    if (Math.abs(t) > 0) {
        $.post(`https://${GetParentResourceName()}/action`, JSON.stringify({
            action: 'car-rotate',
            dist: t
        }));
        lastX = e.offsetX;
    }
});

$(document).on('click', '.close', function(){
    close()
})

$(document).on('click', '.buy-but', function(e){
    if(onStock){
        $.post("https://mrg_vehicleshop/action", JSON.stringify({action: 'buy'}));
    }
});

$(document).on('click', '.test-but', function(e){
    if(onStock){
        $.post("https://mrg_vehicleshop/action", JSON.stringify({action: 'test'}));
    }
});