var locales = {};
var vehData;

window.onload = (() => {
    $.post('https://p_mechanicjob/NUILoaded').then(data => {
        locales = data;
    })
})

const ShowHistory = (() => {
    $('.vehicle-data-wrapper').animate({
        right: '-40rem',
        opacity: '0.0'
    }, 800);
    setTimeout(() => {
        $('.vehicle-history-wrapper').animate({
            right: '1rem',
            opacity: '1.0'
        })
    }, 750);
});

const HideHistory = (() => {
    $('.vehicle-history-wrapper').animate({
        right: '-40rem',
        opacity: '0.0'
    }, 800);
    setTimeout(() => {
        $('.vehicle-data-wrapper').animate({
            right: '1rem',
            opacity: '1.0'
        })
    }, 750);
});

window.addEventListener("message", (event) => {
    const data = event.data;
    switch(data.action) {
        case 'toggleVehicleInfo':
            const infoWrapper = $('.vehicle-data-wrapper');
            if (data.state) {
                if (infoWrapper.length > 0) {
                    infoWrapper.remove();
                }

                const vehicleData = data.data;
                vehData = data.data;
                let engineParts = [];
                let bodyParts = [];
                vehicleData.parts.engine.map((parts, index) => {
                    for (let i in parts) {
                        engineParts.push(parts[i]);
                    }
                })

                vehicleData.parts.body.map((parts, index) => {
                    for (let i in parts) {
                        bodyParts.push(parts[i]);
                    }
                })
                const $vehicleData = $(`
                <div class="vehicle-info-wrapper vehicle-data-wrapper">
                    <div class="vehicle-info-title">
                        <span>${locales.vehicle_info}</span>
                        <span>${vehicleData.label}</span>
                    </div>
                    <div class="vehicle-info-main">
                        <div class="vehicle-info-row">
                            <span>${locales.engine}</span>
                            <span>${vehicleData.stats.engineHealth}<font>%</font></span>
                        </div>
                        <div class="vehicle-info-row">
                            <span>${locales.body}</span>
                            <span>${vehicleData.stats.bodyHealth}<font>%</font></span>
                        </div>
                        <div class="vehicle-info-row">
                            <span>${locales.engine_oil}</span>
                            <span>${vehicleData.stats.engineOil}<font>%</font></span>
                        </div>
                        <div class="vehicle-info-row">
                            <span>${locales.gear_oil}</span>
                            <span>${vehicleData.stats.gearOil}<font>%</font></span>
                        </div>
                        <div class="vehicle-info-row">
                            <span>${locales.brakes}</span>
                            <span>${vehicleData.stats.brakes}<font>%</font></span>
                        </div>
                        <div class="vehicle-info-row">
                            <span>${locales.mileage}</span>
                            <span>${vehicleData.stats.mileage}<font>km</font></span>
                        </div>
                    </div>
                    <div class="vehicle-info-bot">
                        <div class="vehicle-info-bot-title">
                            <div class="info-bot-line"></div>
                            <span>${locales.fix}</span>
                            <div class="info-bot-line"></div>
                        </div>
                        <div class="vehicle-repair-list">
                            <span>${locales.engine}</span>
                            <ul>
                                ${engineParts.map((part, index) => `
                                <li>
                                    <span>${locales[part.part] || 'Set part name'}</span>
                                    <span>${part.count}<font>x</font></span>
                                </li>`).join('')}
                            </ul>
                            <span>${locales.body}</span>
                            <ul>
                                ${bodyParts.map((part, index) => `
                                <li>
                                    <span>${locales[part.part] || 'Set part name'}</span>
                                    <span>${part.count}<font>x</font></span>
                                </li>`).join('')}
                            </ul>
                        </div>
                        <div class="vehicle-info-btn" onclick="ShowHistory()">${locales.check_history}</div>
                        <div class="vehicle-info-desc">${locales.veh_info_toggle}</div>
                    </div>
                </div>`);
                $('.vehicle-history-wrapper').html(
                `<div class="vehicle-info-title">
                    <span>${locales['vehicle_history_ui']}</span>
                    <span>${vehicleData.label}</span>
                </div>
                <div class="vehicle-info-main">
                    <span>${locales['last_changes_ui']}</span>
                    <div class="vehicle-info-row">
                        <span>${locales['engineOil_ui']}</span>
                        <span>${vehicleData.history.engineOil ? `Przy ${Math.floor((vehicleData.history.engineOil * 1.33) / 1000)}<font>km</font>` : locales['not_changed_ui']}</span>
                    </div>
                    <div class="vehicle-info-row">
                        <span>${locales['gearOil_ui']}</span>
                        <span>${vehicleData.history.gearOil ? `Przy ${Math.floor((vehicleData.history.gearOil * 1.33) / 1000)}<font>km</font>` : locales['not_changed_ui']}</span>
                    </div>
                    <div class="vehicle-info-row">
                        <span>${locales['brakes_ui']}</span>
                        <span>${vehicleData.history.brakes ? `Przy ${Math.floor((vehicleData.history.brakes * 1.33) / 1000)}<font>km</font>` : locales['not_changed_ui']}</span>
                    </div>
                </div>
                <div class="vehicle-info-btn" onclick="HideHistory()">${locales['check_vehicle_ui']}</div>`);
                $('body').prepend($vehicleData);
                $vehicleData.animate({
                    right: '1rem',
                    opacity: '1.0'
                }, 800)
            } else {
                $('.vehicle-data-wrapper').animate({
                    right: '-40rem',
                    opacity: '0.0'
                }, 800);
                $('.vehicle-history-wrapper').animate({
                    right: '-40rem',
                    opacity: '0.0'
                }, 800);
            }
            break;
    }
})

document.onkeydown = ((e) => {
    if (e.key == 'g') {
        $.post('https://p_mechanicjob/offCursor');
    }
})