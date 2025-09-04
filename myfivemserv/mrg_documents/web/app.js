var titles = {
    ['idcard']: 'DOWÓD OSOBISTY',
    ['driver']: 'PRAWO JAZDY',
    ['weapon']: 'LICENCJA NA BROŃ',
    ['pilot']: "LICENCJA PILOTA",
    ['mechanic']: 'LEGITYMACJA',
    ['doj']: 'LEGITYMACJA'
}
var info = {
    ['idcard']: 'DATA URODZENIA',
    ['driver']: 'KATEGORIE',
    ['pilot']: "KATEGORIE",
    ['weapon']: 'KATEGORIE',
    ['mechanic']: 'STOPIEŃ',
    ['doj']: 'STOPIEŃ'
}

var locales = {
    "male": "Mężczyzna",
    "female": "Kobieta",
    "wait": "Odczekaj chwile",
    "firstName": "Imię",
    "lastName": "Nazwisko",
    "dob": "Data urodzenia",
    "sex": "Płeć",
    "idcard": "DOWÓD OSOBISTY",
    "driver": "PRAWO JAZDY",
    "weapon": "LICENCJA NA BROŃ",
    "mechanic": "LEGITYMACJA",
    "doj": "LEGITYMACJA",
    "idcard_info": "DATA URODZENIA",
    "driver_info": "KATEGORIE",
    "weapon_info": "KATEGORIE",
    "mechanic_info": "STOPIEŃ",
    "doj_info": "STOPIEŃ",
    "los_santos": "LOS SANTOS",
    "fullName": "IMIĘ I NAZWISKO",
    "badge": "NUMER ODZNAKI",
    "grade": "STOPIEŃ",
    "signature": "PODPIS",
    "class_1": "Klasa 1",
    "planes": "Samoloty",
    "citizenid": "SSN",
    "nationality": "Narodowość",
    "document": "DOKUMENT"
};

const SetupDocument = ((data) => {
    if (data.type == 'lspd' || data.type == 'ems' || data.type == 'lssd' || data.type == 'lsfd') {
        let $newDocument = $(`<div class="badge"></div>`);
        $('.app-wrapper').append($newDocument);
        $newDocument.html(`
            <div class="badge-main">
                <div class="badge-title ${data.type}">
                    <span>
                    ${data.type == 'lspd' ? 'POLICE' : data.type == 'lssd' ? 'SHERIFF' : data.type == 'ems' || data.type == 'lsfd' ? 'FIRE' : ''}
                    </span>
                    <span>${locales.los_santos}</span>
                </div>
                <div class="badge-row">
                    <span>${locales.fullName}</span>
                    <span>${data.firstName} ${data.lastName}</span>
                </div>
                <div class="badge-row">
                    <span>${locales.badge}</span>
                    <span>${data.badge}</span>
                </div>
                <div class="badge-row">
                    <span>${locales.grade}</span>
                    <span>${data.grade}</span>
                </div>
                <div class="badge-row">
                    <span>${locales.signature}</span>
                    <span class="badge-sign">${data.firstName} ${data.lastName}</span>
                </div>
                <img src="img/${data.type}.png" alt="" class="badge-bg-logo">
            </div>
            <img class="badge-logo" src="img/${data.type}_badge.png" alt="">`);
            setTimeout(() => {
                $newDocument.css({
                    transform: 'translateX(0)',
                    opacity: '1.0'
                }, 500)
                setTimeout(() => {
                    if ($newDocument) {
                        $newDocument.css({
                            transform: 'translateX(-200%)',
                            opacity: '0.0'
                        })
                        setTimeout(() => {
                            $newDocument.remove();
                        }, 500);
                    }
                }, 6000);
            }, 100);
        } else if (data.type == 'note') {
            let $newDocument = $(`
            <div class="note-wrapper">
                <span> ${data.firstName} ${data.lastName}</span>
                <span><i class="fa fa-phone phone-icon"></i> ${data.number}</span>
            </div>`);
            $('.app-wrapper').append($newDocument);
            setTimeout(() => {
                $newDocument.css({
                    transform: 'translateX(0)',
                    opacity: '1.0'
                }, 500)
                setTimeout(() => {
                    if ($newDocument) {
                        $newDocument.css({
                            transform: 'translateX(-200%)',
                            opacity: '0.0'
                        })
                        setTimeout(() => {
                            $newDocument.remove();
                        }, 500);
                    }
                }, 6000);
            }, 100);
        } else {
        let $newDocument = $(`<div class="id-card ${data.type}"></div>`);
        $('.app-wrapper').append($newDocument);
        let licenses = []
        data.licenses.forEach(element => {
            licenses.push(element.type)
        });
        $newDocument.html(`
            <img class="id-bg-img" src="img/${data.type}.png" alt="" />
            <div class="id-card-top">
                <span>${locales.los_santos}</span>
                <span>${titles[data.type] || locales.document}</span>
            </div>
            <div class="id-card-main">
                <div class="id-photo" style="background: center / cover no-repeat url(${data.photo});">
                </div>
                <div class="id-card-info">
                    <div class="info-row">
                        <span>${locales.fullName}</span>
                        <span>${data.firstName} ${data.lastName}</span>
                    </div>
                    <div class="info-row">
                        <span>${info[data.type] || locales.dob.toUpperCase()}</span>
                        <span>${data.type == 'idcard' ? data.dob : data.type == 'driver' ? (
                            (licenses.includes("drive_bike") ? "<span>A</span>" : "<span style='opacity: 0.5'>A</span>")+" "+(licenses.includes("drive") ? "<span>B</span>" : "<span style='opacity: 0.5'>B</span>")+" "+(licenses.includes("drive_truck") ? "<span>C</span>" : "<span style='opacity: 0.5'>C</span>")
                        ) : data.type == 'weapon' ? ((!licenses.includes("weapon") && !licenses.includes("long-rifle") ? "<span>Brak Licencji</span>" : (licenses.includes("weapon") ? "<span>Klasa 1</span>" : "<span style='opacity: 0.5'>Klasa 1</span>")+" "+(licenses.includes("long-rifle") ? "<span>Klasa 2</span>" : "") )) : data.type == 'pilot' ? (
                            ((!licenses.includes("practical_helicopter") && !licenses.includes("practical_plane") ? "<span>Brak Licencji</span>" : (licenses.includes("practical_helicopter") ? "<span>Helikopter</span>" : "<span style='opacity: 0.5'>Helikopter</span>")+" "+(licenses.includes("practical_plane") ? "<span>Samolot</span>" : "<span style='opacity: 0.5'>Samolot</span>") ))
                        ) : data.grade}</span>
                    </div>
                    <div class="info-row">
                        <span>${(locales.sex).toUpperCase()}</span>
                        <span>${data.sex}</span>
                    </div>
                    <div class="info-row">
                        <span>${locales.nationality}</span>
                        <span>${data.nationality}</span>
                    </div>
                </div>
            </div>
            <div class="id-bot">
                <div class="id-identificator">
                    <span>${(data.ssn).toString().padStart(5, '0')}</span>
                </div>
                <div class="player-sign">
                    <span>${data.firstName} ${data.lastName}</span>
                </div>
            </div>`);
            setTimeout(() => {
                $newDocument.css({
                    transform: 'translateX(0)',
                    opacity: '1.0'
                }, 500)
                setTimeout(() => {
                    if ($newDocument) {
                        $newDocument.css({
                            transform: 'translateX(-200%)',
                            opacity: '0.0'
                        })
                        setTimeout(() => {
                            $newDocument.remove();
                        }, 500);
                    }
                }, 6000);
            }, 100);
    }
})

window.addEventListener("message", (event) => {
    let data = event.data;
    switch(data.action) {
        case 'ShowDocument':
            SetupDocument(data.document);
            break;
        case 'CloseDocument':
            let document = $('.badge');
            if (document.length < 1) {
                document = $('.id-card');
            }

            if (document.length > 1) {
                document.css({
                    transform: 'translateX(-200%)',
                    opacity: '0.0'
                });
                setTimeout(() => {
                    document.remove();
                }, 500);
            }
            break;
    }
})