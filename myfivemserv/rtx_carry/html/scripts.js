var carryresourcename = "'+carryresourcename+'";

function closeMain() {
	$("body").css("display", "none");
}
function openMain() {
	$("body").css("display", "block");
}

$(".closetypemenu").click(function(){
    $.post('http://'+carryresourcename+'/closetypeselect', JSON.stringify({}));
});

window.addEventListener('message', function (event) {

	var item = event.data;
	
	if (item.message == "showcarryrequestreceiever") {
		$('#carryrequester').hide();
		$('#carryed').hide();
		$('#carrytype').hide();
		$('#carryreceiever').show();
		openMain();
	}	
	
	if (item.message == "showcarryrequestrequester") {
		$('#carryreceiever').hide();
		$('#carryed').hide();
		$('#carrytype').hide();
		$('#carryrequester').show();
		document.getElementById("secondsremainingrequest").innerHTML = item.remainingseconds;
		openMain();
	}		
	
	if (item.message == "showcarryed") {
		$('#carryreceiever').hide();
		$('#carryrequester').hide();
		$('#carrytype').hide();
		$('#carryed').show();
		openMain();
	}	

	if (item.message == "showtypes") {
		$('#carryreceiever').hide();
		$('#carryrequester').hide();
		$('#carryed').hide();
		$('#carrytype').show();
		openMain();
	}			
	
	if (item.message == "hide") {
		closeMain();
		$('#carryreceiever').hide();
		$('#carryrequester').hide();
		$('#carrytype').hide();
		$('#carryed').hide();
	}
	
	if (item.message == "updateinterfacedata") {
		carryresourcename = item.carryresouredata;
		let root = document.documentElement;
		root.style.setProperty('--color', item.interfacecolordata);	
	}			
});

$(".carry1select").click(function () {
	closeMain();
	$('#carryreceiever').hide();
	$('#carryrequester').hide();
	$('#carryed').hide();
	$('#carrytype').hide();
	$.post('http://'+carryresourcename+'/selecttype', JSON.stringify({
		carrytype: "type1"
	}));
});

$(".carry2select").click(function () {
	closeMain();
	$('#carryreceiever').hide();
	$('#carryrequester').hide();
	$('#carryed').hide();
	$('#carrytype').hide();
	$.post('http://'+carryresourcename+'/selecttype', JSON.stringify({
		carrytype: "type2"
	}));
});

$(".carry3select").click(function () {
	closeMain();
	$('#carryreceiever').hide();
	$('#carryrequester').hide();
	$('#carryed').hide();
	$('#carrytype').hide();
	$.post('http://'+carryresourcename+'/selecttype', JSON.stringify({
		carrytype: "type3"
	}));
});