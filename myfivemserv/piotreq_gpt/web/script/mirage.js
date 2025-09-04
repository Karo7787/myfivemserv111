let activeTab = "home",
  activePopup = "",
  activeDetails = "",
  activeOffenseCategory = "all",
  allOffensesOptions = [],
  activeCitizenTab = "",
  playerInfo = [];
var activeWorker = [],
  dutyTimeInterval;
let playerAccess = [],
  inDispatch = false;
var dangerCodes = [],
  activeAction = 1,
  activeCitizen = [],
  activeVehicle = [],
  gptLicenses = {},
  selectedCitizensCase = {},
  selectedVehiclesCase = {},
  selectedOfficersCase = {},
  attachedPhotosCase = {};
let inFullScreen = false,
  loadedVehicles = false,
  licensesSections = {},
  myLicenses = [];
var locales = {};
let antiSpam = new Date().getTime();
const loadPopups = () => {
    $(".gpt-popups-wrapper").html(
      '\n        <div class="gpt-popup" id="create-patrol-popup" style="display: none;">\n            <span>' +
        locales.create_patrol +
        '</span>\n            <div class="popup-input">\n                <span>' +
        locales.patrol_number +
        '</span>\n                <div class="popup-input-wrapper">\n                    <input type="number" id="create-patrol-number" maxlength="3" placeholder="' +
        locales.input_patrol_number +
        '">\n                </div>\n            </div>\n            <div class="popup-input">\n                <span>' +
        locales.unit +
        '</span>\n                <div class="popup-select">\n                    <div class="popup-select-info" onclick="ToggleSelect(\'create-patrol-units\')">\n                        <span id="create-patrol-units-value">' +
        locales.select_unit +
        '</span>\n                        <i id="create-patrol-units-arrow" class="fa-solid fa-chevron-up"></i>\n                    </div>\n                    <div class="popup-select-menu" id="create-patrol-units">\n                    </div>\n                </div>\n            </div>\n            <div class="popup-bot">\n                <div class="vehicle-btn" onclick="ClosePopup()">' +
        locales.cancel +
        '</div>\n                <div class="vehicle-btn" onclick="CreatePatrol()">' +
        locales.create +
        '</div>\n            </div>\n        </div>\n        <div class="gpt-popup" id="add-employee-popup" style="display: none;">\n            <span>' +
        locales.hire_worker +
        '</span>\n            <div class="popup-input">\n                <span>' +
        locales.id +
        '</span>\n                <div class="popup-input-wrapper">\n                    <input id="add-member-id" type="number" placeholder="' +
        locales.input_id +
        '">\n                </div>\n            </div>\n            <div class="popup-input">\n                <span>' +
        locales.grade +
        '</span>\n                <div class="popup-select">\n                    <div class="popup-select-info" onclick="ToggleSelect(\'add-member\')">\n                        <span id="add-member-value">' +
        locales.select_grade +
        '</span>\n                        <i id="add-member-arrow" class="fa-solid fa-chevron-up"></i>\n                    </div>\n                    <div class="popup-select-menu" id="add-member">\n                    </div>\n                </div>\n            </div>\n            <div class="popup-bot">\n                <div class="vehicle-btn" onclick="ClosePopup()">' +
        locales.cancel +
        '</div>\n                <div class="vehicle-btn" onclick="HireWorker()">' +
        locales.add +
        '</div>\n            </div>\n        </div>\n        <div class="gpt-popup" id="update-employee-popup" style="display: none;">\n            <span>' +
        locales.change_grade +
        '</span>\n            <div class="popup-input">\n                <span>' +
        locales.full_name +
        '</span>\n                <div class="popup-input-wrapper">\n                    <input id="change-grade-name" type="text" disabled>\n                </div>\n            </div>\n            <div class="popup-input">\n                <span>' +
        locales.grade +
        '</span>\n                <div class="popup-select">\n                    <div class="popup-select-info" onclick="ToggleSelect(\'update-member\')">\n                        <span id="update-member-value">' +
        locales.select_grade +
        '</span>\n                        <i id="update-member-arrow" class="fa-solid fa-chevron-up"></i>\n                    </div>\n                    <div class="popup-select-menu" id="update-member"></div>\n                </div>\n            </div>\n            <div class="popup-bot">\n                <div class="vehicle-btn" onclick="ClosePopup()">' +
        locales.cancel +
        '</div>\n                <div class="vehicle-btn" onclick="UpdateWorker()">' +
        locales.confirm +
        '</div>\n            </div>\n        </div>\n        <div class="gpt-popup" id="fire-employee-popup" style="display: none;">\n            <span>' +
        locales.fire_worker +
        '</span>\n            <div class="popup-input">\n                <span>' +
        locales.full_name +
        '</span>\n                <div class="popup-input-wrapper">\n                    <input id="fire-employee-name" type="text" value="" disabled>\n                </div>\n            </div>\n            <div class="popup-input">\n                <span>' +
        locales.reason +
        '</span>\n                <div class="popup-input-wrapper">\n                    <textarea id="fire-employee-reason" placeholder="' +
        locales.input_reason +
        '"></textarea>\n                </div>\n            </div>\n            <div class="popup-bot">\n                <div class="vehicle-btn" onclick="ClosePopup()">' +
        locales.cancel +
        '</div>\n                <div class="vehicle-btn" onclick="FireWorker()">' +
        locales.fire +
        '</div>\n            </div>\n        </div>\n        <div class="gpt-popup" id="add-citizen-license-popup" style="display: none;">\n            <span>' +
        locales.add_license +
        '</span>\n            <div class="popup-input">\n                <span>' +
        locales.full_name +
        '</span>\n                <div class="popup-input-wrapper">\n                    <input id="add-citizen-license-name" type="text" value="" disabled>\n                </div>\n            </div>\n            <div class="popup-input">\n                <span>' +
        locales.available_licenses +
        '</span>\n                <div class="popup-select">\n                    <div class="popup-select-info" onclick="ToggleSelect(\'add-license-citizen\')">\n                        <span id="add-license-citizen-value">' +
        locales.select_license +
        '</span>\n                        <i id="add-license-citizen-arrow" class="fa-solid fa-chevron-up"></i>\n                    </div>\n                    <div class="popup-select-menu" id="add-license-citizen">\n                    </div>\n                </div>\n            </div>\n            <div class="popup-bot">\n                <div class="vehicle-btn" onclick="ClosePopup()">' +
        locales.cancel +
        '</div>\n                <div class="vehicle-btn" onclick="AddCitizenLicense()">' +
        locales.add +
        '</div>\n            </div>\n        </div>\n        <div class="gpt-popup" id="add-worker-license-popup" style="display: none;">\n            <span>' +
        locales.add_license +
        '</span>\n            <div class="popup-input">\n                <span>' +
        locales.available_licenses +
        '</span>\n                <div class="popup-select">\n                    <div class="popup-select-info" onclick="ToggleSelect(\'add-worker-license\')">\n                        <span id="add-worker-license-value">' +
        locales.select_license +
        '</span>\n                        <i id="add-worker-license-arrow" class="fa-solid fa-chevron-up"></i>\n                    </div>\n                    <div class="popup-select-menu" id="add-worker-license">\n                    </div>\n                </div>\n            </div>\n            <div class="popup-bot">\n                <div class="vehicle-btn" onclick="ClosePopup()">' +
        locales.cancel +
        '</div>\n                <div class="vehicle-btn" onclick="AddWorkerLicense()">' +
        locales.add +
        '</div>\n            </div>\n        </div>\n        <div class="gpt-popup" id="remove-worker-license-popup" style="display: none;">\n            <span>' +
        locales.remove_license +
        '</span>\n            <div class="popup-input">\n                <span>' +
        locales.available_licenses +
        '</span>\n                <div class="popup-select">\n                    <div class="popup-select-info" onclick="ToggleSelect(\'remove-worker-license\')">\n                        <span id="remove-worker-license-value">' +
        locales.select_license +
        '</span>\n                        <i id="remove-worker-license-arrow" class="fa-solid fa-chevron-up"></i>\n                    </div>\n                    <div class="popup-select-menu" id="remove-worker-license">\n                    </div>\n                </div>\n            </div>\n            <div class="popup-bot">\n                <div class="vehicle-btn" onclick="ClosePopup()">' +
        locales.cancel +
        '</div>\n                <div class="vehicle-btn" onclick="DeleteWorkerLicense()">' +
        locales.remove +
        '</div>\n            </div>\n        </div>\n        <div class="gpt-popup" id="change-badge-popup" style="display: none;">\n            <span>' +
        locales.change_badge +
        '</span>\n            <div class="popup-input">\n                <span>' +
        locales.full_name +
        '</span>\n                <div class="popup-input-wrapper">\n                    <input id="change-badge-name" type="text" value="" disabled>\n                </div>\n            </div>\n            <div class="popup-input">\n                <span>' +
        locales.badge +
        '</span>\n                <div class="popup-input-wrapper">\n                    <input id="change-badge-value" type="number" value="0">\n                </div>\n            </div>\n            <div class="popup-bot">\n                <div class="vehicle-btn" onclick="ClosePopup()">' +
        locales.cancel +
        '</div>\n                <div class="vehicle-btn" onclick="ChangeEmployeeBadge()">' +
        locales.confirm +
        '</div>\n            </div>\n        </div>\n        <div class="gpt-popup" id="add-case-photo-popup" style="display: none;">\n            <span>' +
        locales.add_photo +
        '</span>\n            <div class="popup-input">\n                <span>' +
        locales.photo_url +
        '</span>\n                <div class="popup-input-wrapper">\n                    <input type="text" id="add-case-photo-url" placeholder="' +
        locales.paste_photo_url +
        '">\n                </div>\n            </div>\n            <div class="popup-bot">\n                <div class="vehicle-btn" onclick="ClosePopup()">' +
        locales.cancel +
        '</div>\n                <div class="vehicle-btn" onclick="AddCasePhoto()">' +
        locales.confirm +
        '</div>\n            </div>\n        </div>\n        <div class="gpt-popup" id="set-citizen-photo-popup" style="display: none;">\n            <span>' +
        locales.set_photo +
        '</span>\n            <div class="popup-input">\n                <span>' +
        locales.photo_url +
        '</span>\n                <div class="popup-input-wrapper">\n                    <input type="text" id="set-citizen-photo-url" placeholder="' +
        locales.paste_photo_url +
        '">\n                </div>\n            </div>\n            <div class="popup-bot">\n                <div class="vehicle-btn" onclick="ClosePopup()">' +
        locales.cancel +
        '</div>\n                <div class="vehicle-btn" onclick="SetCitizenPhoto()">' +
        locales.confirm +
        '</div>\n            </div>\n        </div>\n        <div class="gpt-popup" id="set-employee-photo-popup" style="display: none;">\n            <span>' +
        locales.set_photo +
        '</span>\n            <div class="popup-input">\n                <span>' +
        locales.photo_url +
        '</span>\n                <div class="popup-input-wrapper">\n                    <input type="text" id="set-employee-photo-url" placeholder="' +
        locales.paste_photo_url +
        '">\n                </div>\n            </div>\n            <div class="popup-bot">\n                <div class="vehicle-btn" onclick="ClosePopup()">' +
        locales.cancel +
        '</div>\n                <div class="vehicle-btn" onclick="SetEmployeePhoto()">' +
        locales.confirm +
        '</div>\n            </div>\n        </div>\n        <div class="gpt-popup" id="join-action-popup" style="display: none;">\n            <span>' +
        locales.join_to_action +
        '</span>\n            <div class="popup-input">\n                <span>' +
        locales.unit +
        '</span>\n                <div class="popup-select">\n                    <div class="popup-select-info" onclick="ToggleSelect(\'action-unit\')">\n                        <span id="action-unit-value">' +
        locales.select_unit +
        '</span>\n                        <i id="action-unit-arrow" class="fa-solid fa-chevron-up"></i>\n                    </div>\n                    <div class="popup-select-menu" id="action-unit">\n                        <div class="popup-select-item" onclick="SelectItem(\'action-unit\', \'' +
        locales.unit_1 +
        "', '" +
        locales.unit_1 +
        "')\">" +
        locales.unit_1 +
        "</div>\n                        <div class=\"popup-select-item\" onclick=\"SelectItem('action-unit', '" +
        locales.unit_2 +
        "', '" +
        locales.unit_2 +
        "')\">" +
        locales.unit_2 +
        "</div>\n                        <div class=\"popup-select-item\" onclick=\"SelectItem('action-unit', '" +
        locales.unit_3 +
        "', '" +
        locales.unit_3 +
        "')\">" +
        locales.unit_3 +
        "</div>\n                        <div class=\"popup-select-item\" onclick=\"SelectItem('action-unit', '" +
        locales.unit_4 +
        "', '" +
        locales.unit_4 +
        "')\">" +
        locales.unit_4 +
        "</div>\n                        <div class=\"popup-select-item\" onclick=\"SelectItem('action-unit', '" +
        locales.unit_5 +
        "', '" +
        locales.unit_5 +
        "')\">" +
        locales.unit_5 +
        "</div>\n                        <div class=\"popup-select-item\" onclick=\"SelectItem('action-unit', '" +
        locales.unit_6 +
        "', '" +
        locales.unit_6 +
        "')\">" +
        locales.unit_6 +
        "</div>\n                        <div class=\"popup-select-item\" onclick=\"SelectItem('action-unit', '" +
        locales.unit_7 +
        "', '" +
        locales.unit_7 +
        "')\">" +
        locales.unit_7 +
        "</div>\n                        <div class=\"popup-select-item\" onclick=\"SelectItem('action-unit', '" +
        locales.unit_8 +
        "', '" +
        locales.unit_8 +
        "')\">" +
        locales.unit_8 +
        '</div>\n                    </div>\n                </div>\n            </div>\n            <div class="popup-input">\n                <span>' +
        locales.vehicle +
        '</span>\n                <div class="popup-input-wrapper">\n                    <input id="join-action-veh" type="text" placeholder="' +
        locales.input_vehicle_name +
        '">\n                </div>\n            </div>\n            <div class="popup-bot">\n                <div class="vehicle-btn" onclick="ClosePopup()">' +
        locales.cancel +
        '</div>\n                <div class="vehicle-btn" id="join-action-btn">' +
        locales.confirm +
        '</div>\n            </div>\n        </div>\n        <div class="gpt-popup" id="add-employee-note-popup" style="display: none;">\n            <span>' +
        locales.add_note +
        '</span>\n            <div class="popup-input">\n                <span>' +
        locales.title +
        '</span>\n                <div class="popup-input-wrapper">\n                    <input id="employee-note-title" type="text" placeholder="' +
        locales.input_title +
        '">\n                </div>\n            </div>\n            <div class="popup-input">\n                <span>' +
        locales.text +
        '</span>\n                <div class="popup-input-wrapper">\n                    <textarea id="employee-note-text" placeholder="' +
        locales.input_text +
        '"></textarea>\n                </div>\n            </div>\n            <div class="popup-input">\n                <span>' +
        locales.important +
        '</span>\n                <div class="popup-switch">\n                    <label class="switch">\n                        <input type="checkbox" id="employee-note-important">\n                        <span class="slider round"></span>\n                    </label>\n                </div>\n            </div>\n            <div class="popup-bot">\n                <div class="vehicle-btn" onclick="ClosePopup()">' +
        locales.cancel +
        '</div>\n                <div class="vehicle-btn" onclick="AddEmployeeNote()">' +
        locales.add +
        '</div>\n            </div>\n        </div>\n        <div class="gpt-popup" id="reset-employee-time-popup" style="display: none;">\n            <span>' +
        locales.reset_time +
        '</span>\n            <div class="popup-input">\n                <span>' +
        locales.full_name +
        '</span>\n                <div class="popup-input-wrapper">\n                    <input id="reset-time-name" type="text" value="" disabled>\n                </div>\n            </div>\n            <div class="popup-bot">\n                <div class="vehicle-btn" onclick="ClosePopup()">' +
        locales.cancel +
        '</div>\n                <div class="vehicle-btn" onclick="ResetEmployeeTime()">' +
        locales.reset +
        '</div>\n            </div>\n        </div>\n        <div class="gpt-popup" id="reset-time-popup" style="display: none;">\n            <span>' +
        locales.reset_time +
        '</span>\n            <div class="popup-input">\n                <span>' +
        locales.workers +
        '</span>\n                <div class="popup-select">\n                    <div class="popup-select-info" onclick="ToggleSelect(\'reset-time\')">\n                        <span id="reset-time-value">' +
        locales.reset_time +
        '</span>\n                        <i id="reset-time-arrow" class="fa-solid fa-chevron-up"></i>\n                    </div>\n                    <div class="popup-select-menu" id="reset-time">\n                        <div class="popup-select-item" onclick="SelectItem(\'reset-time\', \'all\', \'' +
        locales.all_workers +
        "')\">" +
        locales.all_workers +
        "</div>\n                        <div class=\"popup-select-item\" onclick=\"SelectItem('reset-time', 'online', '" +
        locales.online +
        "')\">" +
        locales.online +
        "</div>\n                        <div class=\"popup-select-item\" onclick=\"SelectItem('reset-time', 'offline', '" +
        locales.offline +
        "')\">" +
        locales.offline +
        '</div>\n                    </div>\n                </div>\n            </div>\n            <div class="popup-bot">\n                <div class="vehicle-btn" onclick="ClosePopup()">' +
        locales.cancel +
        '</div>\n                <div class="vehicle-btn" onclick="ResetAllTime()">' +
        locales.reset +
        '</div>\n            </div>\n        </div>\n        <div class="gpt-popup" id="announcement-popup" style="display: none;">\n            <span>' +
        locales.add_announcement +
        '</span>\n            <div class="popup-input">\n                <span>' +
        locales.title +
        '</span>\n                <div class="popup-input-wrapper">\n                    <input id="add-announcement-title" type="text" placeholder="' +
        locales.input_title +
        '">\n                </div>\n            </div>\n            <div class="popup-input">\n                <span>' +
        locales.text +
        '</span>\n                <div class="popup-input-wrapper">\n                    <textarea id="add-announcement-text" placeholder="' +
        locales.input_text +
        '"></textarea>\n                </div>\n            </div>\n            <div class="popup-input">\n                <span>' +
        locales.important +
        '</span>\n                <div class="popup-switch">\n                    <label class="switch">\n                        <input type="checkbox" id="add-announcement-check">\n                        <span class="slider round"></span>\n                    </label>\n                </div>\n            </div>\n            <div class="popup-bot">\n                <div class="vehicle-btn" onclick="ClosePopup()">' +
        locales.cancel +
        '</div>\n                <div class="vehicle-btn" onclick="AddAnnouncement()">' +
        locales.add +
        '</div>\n            </div>\n        </div>\n        <div class="gpt-popup" id="add-citizen-note-popup" style="display: none;">\n            <span>' +
        locales.add_note +
        '</span>\n            <div class="popup-input">\n                <span>' +
        locales.title +
        '</span>\n                <div class="popup-input-wrapper">\n                    <input id="citizen-note-title" type="text" placeholder="' +
        locales.input_title +
        '">\n                </div>\n            </div>\n            <div class="popup-input">\n                <span>' +
        locales.text +
        '</span>\n                <div class="popup-input-wrapper">\n                    <textarea id="citizen-note-text" placeholder="' +
        locales.input_text +
        '"></textarea>\n                </div>\n            </div>\n            <div class="popup-input">\n                <span>' +
        locales.important +
        '</span>\n                <div class="popup-switch">\n                    <label class="switch">\n                        <input type="checkbox" id="citizen-note-important">\n                        <span class="slider round"></span>\n                    </label>\n                </div>\n            </div>\n            <div class="popup-bot">\n                <div class="vehicle-btn" onclick="ClosePopup()">' +
        locales.cancel +
        '</div>\n                <div class="vehicle-btn" onclick="AddCitizenNote()">' +
        locales.add +
        '</div>\n            </div>\n        </div>\n        <div class="gpt-popup" id="add-citizen-wanted-popup" style="display: none;">\n            <span>' +
        locales.add_wanted +
        '</span>\n            <div class="popup-input">\n                <span>' +
        locales.title +
        '</span>\n                <div class="popup-input-wrapper">\n                    <input id="citizen-wanted-title" type="text" placeholder="' +
        locales.input_title +
        '">\n                </div>\n            </div>\n            <div class="popup-input">\n                <span>' +
        locales.text +
        '</span>\n                <div class="popup-input-wrapper">\n                    <textarea id="citizen-wanted-text" placeholder="' +
        locales.input_text +
        '"></textarea>\n                </div>\n            </div>\n            <div class="popup-input">\n                <span>' +
        locales.to_when_active +
        '</span>\n                <div class="popup-input-wrapper">\n                    <input id="citizen-wanted-days" maxlength="3" type="number" placeholder="' +
        locales.input_days +
        '">\n                </div>\n            </div>\n            <div class="popup-input">\n                <span>' +
        locales.important +
        '</span>\n                <div class="popup-switch">\n                    <label class="switch">\n                        <input id="citizen-wanted-important" type="checkbox">\n                        <span class="slider round"></span>\n                    </label>\n                </div>\n            </div>\n            <div class="popup-bot">\n                <div class="vehicle-btn" onclick="ClosePopup()">' +
        locales.cancel +
        '</div>\n                <div class="vehicle-btn" onclick="AddCitizenWanted()">' +
        locales.add +
        '</div>\n            </div>\n        </div>\n        <div class="gpt-popup" id="add-vehicle-note-popup" style="display: none;">\n            <span>' +
        locales.add_note +
        '</span>\n            <div class="popup-input">\n                <span>' +
        locales.text +
        '</span>\n                <div class="popup-input-wrapper">\n                    <textarea id="add-vehicle-note-text" placeholder="' +
        locales.input_text +
        '"></textarea>\n                </div>\n            </div>\n            <div class="popup-input">\n                <span>' +
        locales.important +
        '</span>\n                <div class="popup-switch">\n                    <label class="switch">\n                        <input id="add-vehicle-note-important" type="checkbox">\n                        <span class="slider round"></span>\n                    </label>\n                </div>\n            </div>\n            <div class="popup-bot">\n                <div class="vehicle-btn" onclick="ClosePopup()">' +
        locales.cancel +
        '</div>\n                <div class="vehicle-btn" onclick="AddVehicleNote()">' +
        locales.add +
        '</div>\n            </div>\n        </div>\n        <div class="gpt-popup" id="add-vehicle-wanted-popup" style="display: none;">\n            <span>' +
        locales.add_wanted +
        '</span>\n            <div class="popup-input">\n                <span>' +
        locales.text +
        '</span>\n                <div class="popup-input-wrapper">\n                    <textarea id="add-vehicle-wanted-text" placeholder="' +
        locales.input_text +
        '"></textarea>\n                </div>\n            </div>\n            <div class="popup-input">\n                <span>' +
        locales.to_when_active +
        '</span>\n                <div class="popup-input-wrapper">\n                    <input id="add-vehicle-wanted-days" type="number" placeholder="' +
        locales.input_days +
        '">\n                </div>\n            </div>\n            <div class="popup-input">\n                <span>' +
        locales.important +
        '</span>\n                <div class="popup-switch">\n                    <label class="switch">\n                        <input id="add-vehicle-wanted-important" type="checkbox">\n                        <span class="slider round"></span>\n                    </label>\n                </div>\n            </div>\n            <div class="popup-bot">\n                <div class="vehicle-btn" onclick="ClosePopup()">' +
        locales.cancel +
        '</div>\n                <div class="vehicle-btn" onclick="AddVehicleWanted()">' +
        locales.add +
        '</div>\n            </div>\n        </div>\n        <div class="gpt-popup" id="confiscate-vehicle-popup" style="display: none;">\n            <span>' +
        locales.confiscate_vehicle +
        '</span>\n            <div class="popup-input">\n                <span>' +
        locales.plate +
        '</span>\n                <div class="popup-input-wrapper">\n                    <input id="confiscate-vehicle-plate" type="text" value="" disabled>\n                </div>\n            </div>\n            <div class="popup-input">\n                <span>' +
        locales.reason +
        '</span>\n                <div class="popup-input-wrapper">\n                    <textarea id="confiscate-vehicle-reason" placeholder="' +
        locales.input_reason +
        '"></textarea>\n                </div>\n            </div>\n            <div class="popup-input">\n                <span>' +
        locales.bail +
        '</span>\n                <div class="popup-input-wrapper">\n                    <input id="confiscate-vehicle-price" type="number" placeholder="' +
        locales.price +
        '">\n                </div>\n            </div>\n            <div class="popup-input">\n                <span>' +
        locales.to_when +
        '</span>\n                <div class="popup-input-wrapper">\n                    <input id="confiscate-vehicle-days" type="number" placeholder="' +
        locales.input_days +
        '">\n                </div>\n            </div>\n            <div class="popup-bot">\n                <div class="vehicle-btn" onclick="ClosePopup()">' +
        locales.cancel +
        '</div>\n                <div class="vehicle-btn" onclick="ConfiscateVehicle()">' +
        locales.confiscate +
        '</div>\n            </div>\n        </div>\n        <div class="gpt-popup" id="manage-vehicle-popup" style="display: none;">\n            <span>' +
        locales.change_driver +
        '</span>\n            <div class="popup-input">\n                <span>' +
        locales.vehicle_model +
        '</span>\n                <div class="popup-input-wrapper">\n                    <input id="manage-vehicle-model" type="text" value="" disabled>\n                </div>\n            </div>\n            <div class="popup-input">\n                <span>' +
        locales.plate +
        '</span>\n                <div class="popup-input-wrapper">\n                    <input id="manage-vehicle-plate" type="text" value="" disabled>\n                </div>\n            </div>\n            <div class="popup-input">\n                <span>' +
        locales.actual_driver +
        '</span>\n                <div class="popup-input-wrapper">\n                    <input id="manage-vehicle-driver" type="text" value="" disabled>\n                </div>\n            </div>\n            <div class="popup-input">\n                <span>' +
        locales.new_driver +
        '</span>\n                <div class="popup-input-wrapper">\n                    <input id="manage-vehicle-new-driver" type="number" placeholder="' +
        locales.input_ssn +
        '">\n                </div>\n            </div>\n            <div class="popup-bot">\n                <div class="vehicle-btn" onclick="ClosePopup()">' +
        locales.cancel +
        '</div>\n                <div class="vehicle-btn" id="manage-vehicle-btn">' +
        locales.confirm +
        '</div>\n            </div>\n        </div>\n        <div class="gpt-popup" id="buy-vehicle-popup" style="display: none;">\n            <span>' +
        locales.buy_vehicle +
        '</span>\n            <div class="popup-input">\n                <span>' +
        locales.vehicle_model +
        '</span>\n                <div class="popup-select">\n                    <div class="popup-select-info" onclick="ToggleSelect(\'buy-vehicle\')">\n                        <span id="buy-vehicle-value">' +
        locales.select_model +
        '</span>\n                        <i id="buy-vehicle-arrow" class="fa-solid fa-chevron-up"></i>\n                    </div>\n                    <div class="popup-select-menu" id="buy-vehicle">\n                    </div>\n                </div>\n            </div>\n            <div class="popup-input">\n                <span>' +
        locales.price +
        '</span>\n                <div class="popup-input-wrapper">\n                    <input type="text" id="buy-vehicle-price" value="$ 0" disabled>\n                </div>\n            </div>\n            <div class="popup-bot">\n                <div class="vehicle-btn" onclick="ClosePopup()">' +
        locales.cancel +
        '</div>\n                <div class="vehicle-btn" onclick="BuyVehicle()">' +
        locales.confirm +
        "</div>\n            </div>\n        </div>"
    );
  },
  SwitchCitizenTab = (_0xfa7740) => {
    let _0x154de7 = new Date().getTime();
    if (antiSpam > _0x154de7) {
      return;
    }
    if (_0xfa7740 == activeCitizenTab) {
      return;
    }
    antiSpam = _0x154de7 + 100;
    $("#citizen-" + activeCitizenTab).hide();
    $("#citizen-" + _0xfa7740).show();
    activeCitizenTab = _0xfa7740;
  },
  SwitchTab = (_0x5e035a) => {
    let _0x31efd1 = new Date().getTime();
    if (antiSpam > _0x31efd1) {
      return;
    }
    if (_0x5e035a == activeTab) {
      return;
    }
    antiSpam = _0x31efd1 + 250;
    activeDetails !== "" && CloseDetails();
    $("#" + activeTab + "-btn").removeClass("active-button");
    $("#" + _0x5e035a + "-btn").addClass("active-button");
    _0x5e035a == "judgements" &&
      ($("#judgment-jail").prop(
        "disabled",
        playerAccess.judgements && playerAccess.judgements.custom_jail
          ? false
          : true
      ),
      $("#judgment-fine").prop(
        "disabled",
        playerAccess.judgements && playerAccess.judgements.custom_fine
          ? false
          : true
      ));
    _0x5e035a !== "citizens" &&
      _0x5e035a !== "vehicles" &&
      _0x5e035a !== "weapons" &&
      (_0x5e035a == "patrols"
        ? $.post(
            "https://piotreq_gpt/fetchData",
            JSON.stringify({
              tab: _0x5e035a,
              action: activeAction,
            })
          ).then((_0x2609a3) => {
            loadTab({
              tab: _0x5e035a,
              tabData: _0x2609a3,
            });
            _0x2609a3.action.action.id = activeAction;
            loadAction(_0x2609a3.action);
          })
        : _0x5e035a == "radios" ?
          $.post(
            "https://piotreq_gpt/fetchRadioData",
            JSON.stringify({})
          ).then((_0x19aaf6) => {
            loadTab({
              tab: _0x5e035a,
              tabData: _0x19aaf6,
            });
          })
        : $.post(
            "https://piotreq_gpt/fetchData",
            JSON.stringify({ tab: _0x5e035a })
          ).then((_0x19aaf6) => {
            loadTab({
              tab: _0x5e035a,
              tabData: _0x19aaf6,
            });
          }));
    $("#" + activeTab).hide();
    $("#" + _0x5e035a).show();
    activeTab = _0x5e035a;
  },
  ToggleSelect = (_0x28b2a9) => {
    let _0x27c0ff = $("#" + _0x28b2a9);
    _0x27c0ff.css("max-height") == "0px"
      ? (_0x27c0ff.animate({ opacity: "1.0" }, 100),
        _0x27c0ff.css("max-height", "12.5rem"),
        _0x27c0ff.css("overflow-y", "scroll"),
        $("#" + _0x28b2a9 + "-arrow").css("transform", "rotate(180deg)"))
      : (_0x27c0ff.css("max-height", "0px"),
        $("#" + _0x28b2a9 + "-arrow").css("transform", "rotate(0deg)"),
        _0x27c0ff.css("overflow-y", "hidden"),
        _0x27c0ff.animate({ opacity: "0.0" }, 100));
  },
  formatDutyTime = (_0x4091d9) => {
    let _0x5c589c = Math.floor(_0x4091d9 / 3600)
        .toString()
        .padStart(2, "0"),
      _0x2d6c35 = Math.floor((_0x4091d9 - _0x5c589c * 3600) / 60)
        .toString()
        .padStart(2, "0"),
      _0x84671d = (_0x4091d9 - _0x5c589c * 3600 - _0x2d6c35 * 60)
        .toString()
        .padStart(2, "0");
    return _0x5c589c + ":" + _0x2d6c35 + ":" + _0x84671d;
  },
  SelectItem = (_0x4cdabf, _0x55c0fd, _0x47b0b2) => {
    $("#" + _0x4cdabf + "-value").text(_0x47b0b2);
    $("#" + _0x4cdabf + "-value").attr("data-value", _0x55c0fd);
    ToggleSelect(_0x4cdabf);
  },
  OpenPopup = (_0x3d1e4f, _0x289c99) => {
    if (_0x3d1e4f == "change-badge-popup") {
      $("#change-badge-name").val(activeWorker.name);
      $("#change-badge-value").val(
        typeof activeWorker.badge == "number" ? activeWorker.badge : ""
      );
    } else {
      if (_0x3d1e4f == "update-employee-popup") {
        $("#change-grade-name").val(activeWorker.name);
      } else {
        if (_0x3d1e4f == "reset-employee-time-popup") {
          $("#reset-time-name").val(activeWorker.name);
        } else {
          if (_0x3d1e4f == "fire-employee-popup") {
            $("#fire-employee-name").val(activeWorker.name);
          } else {
            if (_0x3d1e4f == "join-action-popup") {
              $("#join-action-btn").unbind();
              $("#join-action-btn").on("click", () => {
                let _0x28a186 = $("#action-unit-value").attr("data-value");
                if (!_0x28a186) {
                  return;
                }
                let _0x31dccf = $("#join-action-veh").val();
                if (_0x31dccf.length < 1 || _0x31dccf.includes("<script>")) {
                  return;
                }
                _0x31dccf = removeTags(_0x31dccf);
                JoinAction({
                  id: _0x289c99,
                  veh: _0x31dccf,
                  unit: _0x28a186,
                });
                $("#join-action-veh").val("");
                $("#action-unit-value").attr("data-value", null);
                $("#action-unit-value").text("Wybierz jednostke");
              });
            } else {
              if (_0x3d1e4f == "add-citizen-license-popup") {
                $("#add-citizen-license-name").val(_0x289c99);
              } else {
                if (_0x3d1e4f == "set-citizen-photo-popup") {
                  $("#set-citizen-photo-url").val(
                    _0x289c99 !== "undefined" ? _0x289c99 : ""
                  );
                } else {
                  if (_0x3d1e4f == "set-employee-photo-popup") {
                    $("#set-employee-photo-url").val(
                      _0x289c99 !== "undefined" ? _0x289c99 : ""
                    );
                  } else {
                    if (_0x3d1e4f == "manage-vehicle-popup") {
                      $("#manage-vehicle-model").val(_0x289c99.model);
                      $("#manage-vehicle-plate").val(_0x289c99.plate);
                      $("#manage-vehicle-driver").val(
                        _0x289c99.firstname
                          ? _0x289c99.firstname + " " + _0x289c99.lastname
                          : "Brak"
                      );
                      $("#manage-vehicle-btn").unbind();
                      $("#manage-vehicle-btn").on("click", () => {
                        let _0x4dc6c4 = $("#manage-vehicle-new-driver").val();
                        if (_0x4dc6c4.length < 1) {
                          return;
                        }
                        $.post(
                          "https://piotreq_gpt/actionData",
                          JSON.stringify({
                            action: "ChangeDriver",
                            ssn: _0x4dc6c4,
                            vin: _0x289c99.vin,
                          })
                        ).then((_0x2f544c) => {
                          _0x2f544c &&
                            (refreshGarage(_0x2f544c),
                            ClosePopup(),
                            $("#manage-vehicle-new-driver").val(""));
                        });
                      });
                    } else {
                      _0x3d1e4f == "confiscate-vehicle-popup" &&
                        $("#confiscate-vehicle-plate").val(_0x289c99);
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
    $("#" + _0x3d1e4f).show();
    $(".gpt-popups-wrapper").css("display", "flex");
    activePopup = _0x3d1e4f;
  },
  ClosePopup = () => {
    $("#" + activePopup).hide();
    $(".gpt-popups-wrapper").hide();
    activePopup = "";
  },
  OpenVehicle = (_0x4db1ab) => {
    $.post(
      "https://piotreq_gpt/fetchData",
      JSON.stringify({
        tab: "fullVehicle",
        vin: _0x4db1ab,
      })
    ).then((_0x1f277e) => {
      _0x1f277e && OpenDetails("vehicle-details", _0x1f277e);
    });
  },
  OpenCase = (_0x320d95) => {
    $.post(
      "https://piotreq_gpt/fetchData",
      JSON.stringify({
        tab: "case",
        id: _0x320d95,
      })
    ).then((_0xce7594) => {
      _0xce7594 && OpenDetails("case-details", _0xce7594);
    });
  },
  OpenDetails = (_0x329207, _0x991114) => {
    if (_0x329207 == activeDetails) {
      return;
    }
    activeDetails !== "" && $("#" + activeDetails).hide();
    activeCitizenTab = "";
    if (_0x329207 == "judgment-details") {
      let _0x41c565 = allOffensesOptions;
      activeOffenseCategory !== "all" &&
        (_0x41c565 = Judgments[activeOffenseCategory].options);
      let _0x38affd = 0,
        _0xebe56a = 0;
      for (const [_0x144c8d, _0xcc5922] of Object.entries(selectedOffenses)) {
        _0x38affd = _0x38affd + _0xcc5922.count * _0xcc5922.fine;
        _0xebe56a = _0xebe56a + _0xcc5922.count * _0xcc5922.jail;
      }
      $("#offense-fine-value").val("$ " + _0x38affd);
      $("#offense-months-value").val(_0xebe56a);
      loadOffenses(_0x41c565);
    } else {
      if (_0x329207 == "citizen-details") {
        $("#citizen-details").html(
          '<div class="loader-wrapper"><span class="loader"></span></div>'
        );
        setTimeout(() => {
          $.post(
            "https://piotreq_gpt/fetchData",
            JSON.stringify({
              tab: "citizen",
              identifier: _0x991114,
            })
          ).then((_0x1d8a38) => {
            $.post(
              "https://piotreq_gpt/getNationality",
              JSON.stringify({
                tab: "citizen",
                identifier: _0x991114,
              })
            ).then((playernation) => {
              activeCitizen = _0x1d8a38;
              setTimeout(() => {
                $.post(
                  "https://piotreq_gpt/SortVehicles",
                  JSON.stringify({ vehicles: _0x1d8a38.vehicles })
                ).then((_0x12b5c8) => {
                  let _0x29d9d4 = "",
                    _0x5b0b36 = "",
                    _0x98cf4d = "",
                    _0x3c6b1f = "",
                    _0x58fa70 = "",
                    _0x25a687 = "",
                    _0x4bba96 = locales.no_data;
                  if (licensesSections && licensesSections.cases) {
                    if (myLicenses[licensesSections.cases]) {
                      if (_0x1d8a38.cases) {
                        for (let _0x7d53bc in _0x1d8a38.cases) {
                          let _0x13cea5 = _0x1d8a38.cases[_0x7d53bc];
                          _0x58fa70 =
                            _0x58fa70 +
                            ('\n                                        <div class="citizen-vehicle" id="citizen-case">\n                                            <div class="citizen-vehicle-top">\n                                                <span><i class="fa-solid fa-folder-open"></i> ' +
                              locales.case +
                              " #" +
                              _0x13cea5.id +
                              '</span>\n                                                <i onclick="OpenCase(' +
                              _0x13cea5.id +
                              ')" class="fa-solid fa-chevron-right"></i>\n                                            </div>\n                                        </div>');
                        }
                      }
                    }
                  } else {
                    if (_0x1d8a38.cases) {
                      for (let _0x126595 in _0x1d8a38.cases) {
                        let _0x4724a9 = _0x1d8a38.cases[_0x126595];
                        _0x58fa70 =
                          _0x58fa70 +
                          ('\n                                    <div class="citizen-vehicle" id="citizen-case">\n                                        <div class="citizen-vehicle-top">\n                                            <span><i class="fa-solid fa-folder-open"></i> ' +
                            locales.case +
                            " #" +
                            _0x4724a9.id +
                            '</span>\n                                            <i onclick="OpenCase(' +
                            _0x4724a9.id +
                            ')" class="fa-solid fa-chevron-right"></i>\n                                        </div>\n                                    </div>');
                      }
                    }
                  }
                  let _0x4c0111 = false;
                  if (_0x1d8a38.wanted) {
                    for (let _0x2c760b in _0x1d8a38.wanted) {
                      let _0x35464a = _0x1d8a38.wanted[_0x2c760b];
                      if (_0x35464a) {
                        _0x4c0111 = true;
                        let _0x538d73 = new Date(_0x35464a.time * 1000),
                          _0x2bd083 = new Date(_0x35464a.expire * 1000);
                        _0x3c6b1f =
                          _0x3c6b1f +
                          ('\n                                    <div class="citizen-vehicle citizen-note ' +
                            (_0x35464a.important ? "important" : "") +
                            '" id="citizen-wanted-' +
                            _0x35464a.id +
                            '">\n                                        <div class="citizen-vehicle-top">\n                                            <span>' +
                            _0x35464a.title +
                            "</span>\n                                            " +
                            (playerAccess.citizens.delete_note
                              ? '<i onclick="DeleteCitizenWanted(' +
                                _0x35464a.id +
                                ')" class="fa-solid fa-trash-can"></i>'
                              : "") +
                            "\n                                        </div>\n                                        <span>" +
                            _0x35464a.text +
                            "</span>\n                                        <span>" +
                            _0x35464a.firstname +
                            " " +
                            _0x35464a.lastname +
                            " " +
                            formatTime(_0x538d73) +
                            ", " +
                            locales.to_when +
                            ": " +
                            formatTime(_0x2bd083) +
                            "</span>\n                                    </div>");
                      }
                    }
                  }
                  if (_0x1d8a38.notes) {
                    for (let _0x3b61c1 in _0x1d8a38.notes) {
                      let _0x267d00 = _0x1d8a38.notes[_0x3b61c1],
                        _0x47f157 = new Date(_0x267d00.time * 1000);
                      _0x98cf4d =
                        _0x98cf4d +
                        ('\n                                <div class="citizen-vehicle ' +
                          (_0x267d00.important ? "important" : "") +
                          ' citizen-note" id="citizen-note-' +
                          _0x267d00.id +
                          '">\n                                    <div class="citizen-vehicle-top">\n                                        <span>' +
                          _0x267d00.title +
                          "</span>\n                                        " +
                          (playerAccess.citizens.delete_note
                            ? '<i onclick="DeleteCitizenNote(' +
                              _0x267d00.id +
                              ')" class="fa-solid fa-trash-can"></i>'
                            : "") +
                          "\n                                    </div>\n                                    <span>" +
                          _0x267d00.text +
                          "</span>\n                                    <span>" +
                          _0x267d00.firstname +
                          " " +
                          _0x267d00.lastname +
                          " " +
                          formatTime(_0x47f157) +
                          "</span>\n                                </div>");
                    }
                  }
                  if (_0x1d8a38.licenses) {
                    for (let _0x44e023 in _0x1d8a38.licenses) {
                      let _0x3d81ba = _0x1d8a38.licenses[_0x44e023];
                      _0x5b0b36 =
                        _0x5b0b36 +
                        ('\n                                <div class="citizen-vehicle citizen-license" id="citizen-license-' +
                          _0x3d81ba.id +
                          '">\n                                    <div class="citizen-vehicle-top">\n                                        <span>' +
                          _0x3d81ba.name +
                          "</span>\n                                        " +
                          (playerAccess.citizens.delete_license
                            ? '<i onclick="DeleteCitizenLicense(' +
                              _0x3d81ba.id +
                              ')" class="fa-solid fa-trash-can"></i>'
                            : "") +
                          "\n                                    </div>\n                                </div>");
                    }
                  }
                  if (_0x1d8a38.judgements) {
                    for (let _0x1206d1 in _0x1d8a38.judgements) {
                      let _0x2a9505 = _0x1d8a38.judgements[_0x1206d1],
                        _0x55039a = new Date(_0x2a9505.time * 1000),
                        _0xe4786e = JSON.parse(_0x2a9505.offenses),
                        _0x130182 = _0x2a9505.jail,
                        _0x32aca8 = _0x2a9505.fine,
                        _0x34bb79 = "";
                      for (let _0x11a582 in _0xe4786e) {
                        _0x34bb79 == ""
                          ? (_0x34bb79 =
                              "x" +
                              _0xe4786e[_0x11a582].count +
                              " " +
                              _0xe4786e[_0x11a582].label)
                          : (_0x34bb79 =
                              _0x34bb79 +
                              (", x" +
                                _0xe4786e[_0x11a582].count +
                                " " +
                                _0xe4786e[_0x11a582].label));
                      }
                      _0x4bba96 = "" + formatTime(_0x55039a);
                      _0x29d9d4 =
                        '\n                                <div class="citizen-vehicle" id="citizen-judgement">\n                                    <div class="citizen-vehicle-top">\n                                        <span>#' +
                        (parseInt(_0x1206d1) + 1) +
                        "</span>\n                                    </div>\n                                    <span>" +
                        locales.officer +
                        ": <font>" +
                        _0x2a9505.firstname +
                        " " +
                        _0x2a9505.lastname +
                        "</font></span>\n                                    <span>" +
                        locales.months_amount +
                        ": <font>" +
                        _0x130182 +
                        "</font></span>\n                                    <span>" +
                        locales.fine +
                        ": <font>$ " +
                        _0x32aca8 +
                        "</font></span>\n                                    <span>" +
                        locales.offenses +
                        ": <font>" +
                        _0x34bb79 +
                        "</font></span>\n                                </div>" +
                        _0x29d9d4;
                    }
                  }
                  if (_0x12b5c8) {
                    for (let _0xb9488c in _0x12b5c8) {
                      let _0x1add1c = _0x12b5c8[_0xb9488c];
                      _0x25a687 =
                        _0x25a687 +
                        ('\n                                <div class="citizen-vehicle">\n                                    <div class="citizen-vehicle-top">\n                                        <span>' +
                          _0x1add1c.model +
                          "</span>\n                                        <i onclick=\"OpenVehicle('" +
                          _0x1add1c.vin +
                          '\')" class="fa-solid fa-chevron-right"></i>\n                                    </div>\n                                    <span>' +
                          locales.coowner +
                          ": <font>" +
                          (_0x1add1c.cofname
                            ? _0x1add1c.cofname + " " + _0x1add1c.colname
                            : locales.no_data) +
                          "</font></span>\n                                    <span>" +
                          locales.plate +
                          ": <font>" +
                          _0x1add1c.plate +
                          "</font></span>\n                                    <span>" +
                          locales.vin +
                          ": <font>" +
                          _0x1add1c.vin +
                          "</font></span>\n                                    <span>" +
                          locales.status +
                          ": <font>" +
                          (parseInt(_0x1add1c.state) == 2
                          ? locales.confiscated
                          : _0x1add1c.wanted
                          ? locales.wanted
                          : locales.not_wanted) +
                          "</font></span>\n                                </div>");
                    }
                  }
                  console.log(JSON.stringify(_0x1d8a38))
                  $("#citizen-details").html(
                    '\n                        <div class="top-bar">\n                            <div class="square-btn" onclick="CloseDetails()"><i class="fa-solid fa-chevron-left"></i></div>\n                            <span>' +
                      locales.citizen +
                      " - " +
                      _0x1d8a38.name +
                      '</span>\n                        </div>\n                        <div class="citizen-details-wrapper">\n                            <div class="citizen-details-main" ' +
                      (_0x1d8a38.blood || _0x1d8a38.finger
                        ? 'id="citizen-details-wrapper"'
                        : "") +
                      ">\n                                <div id=\"citizen-details-photo\" onclick=\"OpenPopup('set-citizen-photo-popup', '" +
                      _0x1d8a38.photo +
                      '\')" class="citizen-photo" ' +
                      (_0x1d8a38.photo
                        ? 'style="background: center / cover no-repeat url(' +
                          _0x1d8a38.photo +
                          ')"'
                        : "") +
                      '></div>\n                                <div class="citizen-info">\n                                    <div class="citizen-info-row">\n                                        <span>' +
                      locales.full_name +
                      "</span>\n                                        <span>" +
                      _0x1d8a38.name +
                      '</span>\n                                    </div>\n                                    <div class="citizen-info-row">\n                                        <span>' +
                      locales.job +
                      "</span>\n                                        <span>" +
                      _0x1d8a38.job +
                      '</span>\n                                    </div>\n                                    <div class="citizen-info-row">\n                                        <span>' +
                      locales.ssn +
                      "</span>\n                                        <span>" +
                      _0x1d8a38.ssn +
                      '</span>\n                                    </div>\n                                    <div class="citizen-info-row">\n                                        <span>' +
                      locales.wanted +
                      "</span>\n                                        <span>" +
                      (_0x4c0111 ? locales.yes : locales.no) +
                      '</span>\n                                    </div>\n                                    <div class="citizen-info-row">\n                                        <span>' +
                      locales.dateofbirth +
                      "</span>\n                                        <span>" +
                      _0x1d8a38.dob +
                      '</span>\n                                    </div>\n                                    <div class="citizen-info-row">\n                                        <span>' +
                      locales.last_judgment +
                      "</span>\n                                        <span>" +
                      _0x4bba96 +
                      '</span>\n                                    </div>\n                                    <div class="citizen-info-row">\n                                        <span>' +
                      locales.nationality +
                      "</span>\n                                        <span>" +
                      (playernation || "USA") +
                      '</span>\n                                    </div>\n                                    <div class="citizen-info-row" ' +
                      (!_0x1d8a38.blood ? 'style="display: none"' : "") +
                      ">\n                                        <span>" +
                      locales.blood +
                      "</span>\n                                        <span>" +
                      _0x1d8a38.blood +
                      '</span>\n                                    </div>\n                                    <div class="citizen-info-row" ' +
                      (!_0x1d8a38.finger ? 'style="display: none"' : "") +
                      ">\n                                        <span>" +
                      locales.fingerprint +
                      "</span>\n                                        <span>" +
                      _0x1d8a38.finger +
                      '</span>\n                                    </div>\n                                </div>\n                            </div>\n                            <div class="citizen-details-more">\n                                <div class="citizen-details-bar">\n                                    <div class="citizen-details-bar-btn" onclick="SwitchCitizenTab(\'vehicles\')">\n                                        <span>' +
                      locales.vehicles +
                      '</span>\n                                    </div>\n                                    <div class="citizen-details-bar-btn" onclick="SwitchCitizenTab(\'judgements\')">\n                                        <span>' +
                      locales.judgments +
                      '</span>\n                                    </div>\n                                    <div class="citizen-details-bar-btn" onclick="SwitchCitizenTab(\'licenses\')">\n                                        <span>' +
                      locales.licenses +
                      '</span>\n                                    </div>\n                                    <div class="citizen-details-bar-btn" onclick="SwitchCitizenTab(\'notes\')">\n                                        <span>' +
                      locales.notes +
                      '</span>\n                                    </div>\n                                    <div class="citizen-details-bar-btn" onclick="SwitchCitizenTab(\'wanted\')">\n                                        <span>' +
                      locales.wanteds +
                      '</span>\n                                    </div>\n                                    <div class="citizen-details-bar-btn" onclick="SwitchCitizenTab(\'cases\')">\n                                        <span>' +
                      locales.cases +
                      '</span>\n                                    </div>\n                                </div>\n                                <div class="citizen-details-more-main">\n                                    <div class="citizen-details-list" id="citizen-vehicles" style="display: none;">\n                                    ' +
                      _0x25a687 +
                      '\n                                    </div>\n                                    <div class="citizen-details-list" id="citizen-judgements" style="display: none;">\n                                    ' +
                      _0x29d9d4 +
                      '\n                                    </div>\n                                    <div class="citizen-notes-wrapper" id="citizen-licenses" style="display: none;">\n                                        <div class="vehicle-btn" style="width: fit-content;" onclick="OpenPopup(\'add-citizen-license-popup\', \'' +
                      _0x1d8a38.name +
                      "')\">" +
                      locales.add_license +
                      '</div>\n                                        <div class="citizen-details-list" id="citizen-licenses-list">\n                                        ' +
                      _0x5b0b36 +
                      '\n                                        </div>\n                                    </div>\n                                    <div class="citizen-notes-wrapper" id="citizen-notes" style="display: none;">\n                                        <div class="vehicle-btn" style="width: fit-content;" onclick="OpenPopup(\'add-citizen-note-popup\')">' +
                      locales.add_note +
                      '</div>\n                                        <div class="citizen-details-list" id="citizen-notes-list">\n                                        ' +
                      _0x98cf4d +
                      '\n                                        </div>\n                                    </div>\n                                    <div class="citizen-notes-wrapper" id="citizen-wanted" style="display: none;">\n                                        <div class="vehicle-btn" style="width: fit-content;" onclick="OpenPopup(\'add-citizen-wanted-popup\')">' +
                      locales.add_wanted +
                      '</div>\n                                        <div class="citizen-details-list" id="citizen-wanted-list">\n                                        ' +
                      _0x3c6b1f +
                      '\n                                        </div>\n                                    </div>\n                                    <div class="citizen-details-list" id="citizen-cases" style="display: none;">\n                                        ' +
                      _0x58fa70 +
                      "\n                                    </div>\n                                </div>\n                            </div>\n                        </div>"
                  );
                });
              }, 250);
            });
          });
        }, 450);
      } else {
        if (_0x329207 == "case-details" && _0x991114) {
          $("#case-details").html(
            '<div class="loader-wrapper"><span class="loader"></span></div>'
          );
          setTimeout(() => {
            $.post(
              "https://piotreq_gpt/SortVehicles",
              JSON.stringify({ vehicles: _0x991114.vehicles })
            ).then((_0x8a0909) => {
              let _0x4ece89 = "",
                _0xe78f2 = "",
                _0x47aa76 = "",
                _0x547d53 = "";
              for (let _0x57074e in _0x991114.citizens) {
                let _0x18a083 = _0x991114.citizens[_0x57074e];
                _0x18a083 &&
                  (_0x4ece89 =
                    _0x4ece89 +
                    ('\n                        <div class="judgment-list-item">\n                            <span>(' +
                      _0x18a083.ssn +
                      ") " +
                      _0x18a083.name +
                      "</span>\n                        </div>"));
              }
              for (let _0x29469f in _0x991114.officers) {
                let _0x4a073a = _0x991114.officers[_0x29469f];
                _0x4a073a &&
                  (_0xe78f2 =
                    _0xe78f2 +
                    ('\n                        <div class="judgment-list-item">\n                            <span>(' +
                      _0x4a073a.ssn +
                      ") " +
                      _0x4a073a.name +
                      " [" +
                      _0x4a073a.job +
                      "]</span>\n                        </div>"));
              }
              for (let _0xacbc15 in _0x991114.photos) {
                let _0x3ac036 = _0x991114.photos[_0xacbc15];
                _0x547d53 =
                  _0x547d53 +
                  ('\n                    <div class="judgment-list-item case-photo">\n                        <img onclick="FullScreenImage(\'' +
                    _0x3ac036 +
                    '\')" src="' +
                    _0x3ac036 +
                    '" alt="">\n                    </div>');
              }
              for (let _0x44f643 in _0x8a0909) {
                let _0x128c89 = _0x8a0909[_0x44f643];
                _0x128c89 &&
                  (_0x47aa76 =
                    _0x47aa76 +
                    ('\n                        <div class="judgment-list-item">\n                            <span>(' +
                      _0x128c89.plate +
                      ") " +
                      _0x128c89.model +
                      "</span>\n                        </div>"));
              }
              $("#case-details").html(
                '\n                        <div class="top-bar">\n                            <div class="square-btn" onclick="CloseDetails()"><i class="fa-solid fa-chevron-left"></i></div>\n                            <span>' +
                  locales.case +
                  " - #" +
                  _0x991114.id +
                  '</span>\n                        </div>\n                        <div class="vehicle-details-wrapper">\n                            <div class="vehicle-details-box" id="case-details-info">\n                                <div class="vehicle-details-row">\n                                    <span>' +
                  locales.title +
                  "</span>\n                                    <span>" +
                  _0x991114.title +
                  '</span>\n                                </div>\n                                <div class="vehicle-details-row">\n                                    <span>' +
                  locales.case_author +
                  "</span>\n                                    <span>" +
                  _0x991114.creatorName +
                  '</span>\n                                </div>\n                                <div class="vehicle-details-row">\n                                    <span>' +
                  locales.case_creation_date +
                  "</span>\n                                    <span>" +
                  _0x991114.create_date +
                  '</span>\n                                </div>\n                                <div class="vehicle-details-row">\n                                    <span>' +
                  locales.case_edit_date +
                  "</span>\n                                    <span>" +
                  _0x991114.edit_date +
                  '</span>\n                                </div>\n                                <div class="vehicle-details-row">\n                                    <span>' +
                  locales.case_status +
                  "</span>\n                                   " +
                  (_0x991114.status == 0
                    ? '<span class="case-status">' +
                      locales.case_unsolved +
                      "</span>"
                    : '<span class="case-status done">' +
                      locales.case_solved +
                      "</span>") +
                  '\n                                </div>\n                                <div class="vehicle-btn" id="edit-case-btn" style="width: fit-content; margin-top: .5rem;">' +
                  locales.case_edit +
                  '</div>\n                            </div>\n                            <div class="vehicle-details-box" id="case-desc-info">\n                                <span>' +
                  locales.case_description +
                  "</span>\n                                <span>" +
                  _0x991114.text +
                  '</span>\n                            </div>\n                            <div class="vehicle-details-box" id="vehicle-wanted">\n                                <span>' +
                  locales.case_related_citizens +
                  '</span>\n                                <div class="judgment-list">\n                                ' +
                  _0x4ece89 +
                  '\n                                </div>\n                            </div>\n                            <div class="vehicle-details-box" id="vehicle-wanted">\n                                <span>' +
                  locales.case_related_officers +
                  '</span>\n                                <div class="judgment-list">\n                                ' +
                  _0xe78f2 +
                  '\n                                </div>\n                            </div>\n                            <div class="vehicle-details-box" id="vehicle-wanted">\n                                <span>' +
                  locales.case_related_vehicles +
                  '</span>\n                                <div class="judgment-list">\n                                ' +
                  _0x47aa76 +
                  '\n                                </div>\n                            </div>\n                            <div class="vehicle-details-box" id="vehicle-wanted">\n                                <span>' +
                  locales.case_photos +
                  '</span>\n                                <div class="judgment-list">\n                                ' +
                  _0x547d53 +
                  "\n                                </div>\n                            </div>\n                        </div>"
              );
              $("#edit-case-btn").unbind();
              $("#edit-case-btn").on("click", () => {
                if (!playerAccess.cases || !playerAccess.cases.edit) {
                  $.post(
                    "https://piotreq_gpt/ShowNotification",
                    JSON.stringify({ text: locales.no_permission })
                  );
                  return;
                }
                CaseEditor(_0x991114, _0x8a0909);
              });
            });
          }, 250);
        } else {
          if (_0x329207 == "employee-details") {
            $("#employee-details").html(
              '<div class="loader-wrapper"><span class="loader"></span></div>'
            );
            setTimeout(() => {
              $.post(
                "https://piotreq_gpt/fetchData",
                JSON.stringify({
                  tab: "employee",
                  identifier: _0x991114,
                })
              ).then((_0x3b83cd) => {
                activeWorker = _0x3b83cd;
                let _0x5122a2 = "";
                for (let _0x397def in _0x3b83cd.notes) {
                  let _0x5ba5a6 = _0x3b83cd.notes[_0x397def],
                    _0x2f7928 = new Date(_0x5ba5a6.time * 1000);
                  _0x5122a2 =
                    _0x5122a2 +
                    ('\n                        <div class="employee-note ' +
                      (_0x5ba5a6.important == 1 ? "important" : "") +
                      '" id="employee-note-' +
                      _0x5ba5a6.id +
                      '">\n                            <div class="employee-note-info">\n                                <span>' +
                      _0x5ba5a6.title +
                      '</span>\n                                <i onclick="DeleteEmployeeNote(' +
                      _0x5ba5a6.id +
                      ')" class="fa-solid fa-trash-can"></i>\n                            </div>\n                            <span>' +
                      _0x5ba5a6.text +
                      "</span>\n                            <span>" +
                      locales.added_by +
                      ": " +
                      _0x5ba5a6.firstname +
                      " " +
                      _0x5ba5a6.lastname +
                      " " +
                      _0x2f7928.getHours() +
                      ":" +
                      _0x2f7928.getMinutes() +
                      " " +
                      _0x2f7928.getDate() +
                      "/" +
                      (_0x2f7928.getMonth() + 1) +
                      "/" +
                      _0x2f7928.getFullYear() +
                      "</span>\n                        </div>");
                }
                $("#remove-worker-license").empty();
                for (let _0x3f3fd9 in _0x3b83cd.licenses) {
                  let _0x5ab62e = _0x3b83cd.licenses[_0x3f3fd9];
                  $("#remove-worker-license").append(
                    '<div id="worker-license-' +
                      _0x5ab62e.type +
                      "\" onclick=\"SelectItem('remove-worker-license', '" +
                      _0x5ab62e.type +
                      "', '" +
                      _0x5ab62e.label +
                      '\')" class="popup-select-item">' +
                      _0x5ab62e.label +
                      "</div>"
                  );
                }
                $("#employee-details").html(
                  '\n                    <div class="top-bar">\n                        <div class="square-btn" onclick="CloseDetails()"><i class="fa-solid fa-chevron-left"></i></div>\n                        <span>' +
                    locales.worker +
                    " - " +
                    _0x3b83cd.name +
                    '</span>\n                    </div>\n                    <div class="citizen-details-wrapper">\n                        <div class="citizen-details-main">\n                            <div onclick="OpenPopup(\'set-employee-photo-popup\', \'' +
                    _0x3b83cd.photo +
                    '\')" id="employee-details-photo" ' +
                    (_0x3b83cd.photo
                      ? 'style="background: center / cover no-repeat url(' +
                        _0x3b83cd.photo +
                        ')"'
                      : "") +
                    ' class="citizen-photo"></div>\n                            <div class="employee-info">\n                                <div class="citizen-info-row">\n                                    <span>' +
                    locales.full_name +
                    "</span>\n                                    <span>" +
                    _0x3b83cd.name +
                    '</span>\n                                </div>\n                                <div class="citizen-info-row">\n                                    <span>' +
                    locales.unit +
                    "</span>\n                                    <span>" +
                    _0x3b83cd.job +
                    '</span>\n                                </div>\n                                <div class="citizen-info-row">\n                                    <span>' +
                    locales.ssn +
                    "</span>\n                                    <span>" +
                    _0x3b83cd.ssn +
                    '</span>\n                                </div>\n                                <div class="citizen-info-row">\n                                    <span>' +
                    locales.radio_channel +
                    "</span>\n                                    <span>" +
                    _0x3b83cd.radio +
                    '</span>\n                                </div>\n                                <div class="citizen-info-row">\n                                    <span>' +
                    locales.grade +
                    '</span>\n                                    <span id="employee-grade-info">' +
                    _0x3b83cd.grade_label +
                    '</span>\n                                </div>\n                                <div class="citizen-info-row">\n                                    <span>' +
                    locales.last_active +
                    "</span>\n                                    <span>" +
                    _0x3b83cd.lastActive +
                    '</span>\n                                </div>\n                                <div class="citizen-info-row">\n                                    <span>' +
                    locales.status +
                    "</span>\n                                    <span>" +
                    (_0x3b83cd.status == 0
                      ? locales.off_duty
                      : _0x3b83cd.status == 1
                      ? locales.on_duty
                      : locales.break) +
                    '</span>\n                                </div>\n                                <div class="citizen-info-row">\n                                    <span>' +
                    locales.last_issued_judgment_or_fine +
                    "</span>\n                                    <span>" +
                    _0x3b83cd.lastJudgment +
                    '</span>\n                                </div>\n                                <div class="citizen-info-row">\n                                    <span>' +
                    locales.joined_date +
                    "</span>\n                                    <span>" +
                    _0x3b83cd.jobJoined +
                    '</span>\n                                </div>\n                                <div class="citizen-info-row">\n                                    <span>' +
                    locales.duty_time +
                    '</span>\n                                    <span id="employee-time-info">' +
                    (playerAccess.home.duty_time
                      ? formatDutyTime(_0x3b83cd.dutyTime)
                      : locales.no_data) +
                    '</span>\n                                </div>\n                                <div class="citizen-info-row">\n                                    <span>' +
                    locales.badge +
                    '</span>\n                                    <span id="employee-badge-info">' +
                    _0x3b83cd.badge +
                    '</span>\n                                </div>\n                                <div class="citizen-info-row">\n                                    <span>' +
                    locales.assigned_vehicle +
                    "</span>\n                                    <span>" +
                    (_0x3b83cd.vehicle.model
                      ? _0x3b83cd.vehicle.model +
                        " (" +
                        _0x3b83cd.vehicle.plate +
                        ")"
                      : _0x3b83cd.vehicle) +
                    '</span>\n                                </div>\n                            </div>\n                        </div>\n                        <div class="employee-buttons">\n                            <div class="vehicle-btn" onclick="OpenPopup(\'add-worker-license-popup\')">' +
                    locales.add_license +
                    '</div>\n                            <div class="vehicle-btn" onclick="OpenPopup(\'remove-worker-license-popup\')">' +
                    locales.remove_license +
                    '</div>\n                            <div class="vehicle-btn" onclick="OpenPopup(\'change-badge-popup\')">' +
                    locales.change_badge +
                    '</div>\n                            <div class="vehicle-btn" onclick="OpenPopup(\'update-employee-popup\')">' +
                    locales.change_grade +
                    '</div>\n                            <div class="vehicle-btn" onclick="OpenPopup(\'fire-employee-popup\')">' +
                    locales.fire +
                    '</div>\n                            <div class="vehicle-btn" onclick="OpenPopup(\'add-employee-note-popup\')">' +
                    locales.add_note +
                    '</div>\n                            <div class="vehicle-btn" onclick="OpenPopup(\'reset-employee-time-popup\')">' +
                    locales.reset_time +
                    '</div>\n                            <div class="vehicle-btn" onclick="SendForBreak()">' +
                    locales.send_for_break +
                    '</div>\n                        </div>\n                        <div class="employee-notes-wrapper">\n                            <span>' +
                    locales.notes +
                    '</span>\n                            <div class="employee-note-list" id="employee-note-list">\n                            ' +
                    _0x5122a2 +
                    "\n                            </div>\n                        </div>\n                    </div>"
                );
              });
            }, 200);
          } else {
            _0x329207 == "vehicle-details" &&
              (_0x991114.citizenid && (_0x991114.owner = _0x991114.citizenid),
              (activeVehicle = _0x991114),
              $("#vehicle-details").html(
                '<div class="loader-wrapper"><span class="loader"></span></div>'
              ),
              setTimeout(() => {
                $.post(
                  "https://piotreq_gpt/fetchData",
                  JSON.stringify({
                    tab: "vehicle",
                    vin: _0x991114.vin,
                  })
                ).then((_0x18d68a) => {
                  let _0x230f33 = "",
                    _0x7d4c7c = "";
                  for (let _0x2e67e4 in _0x18d68a.notes) {
                    let _0xf18f2d = _0x18d68a.notes[_0x2e67e4],
                      _0x194054 = new Date(_0xf18f2d.time * 1000);
                    _0x230f33 =
                      _0x230f33 +
                      ('\n                    <div class="vehicle-details-note ' +
                        (_0xf18f2d.important ? "important" : "") +
                        '" id="vehicle-note-' +
                        _0xf18f2d.id +
                        '">\n                        <div>\n                            <span>' +
                        _0xf18f2d.firstname +
                        " " +
                        _0xf18f2d.lastname +
                        "</span>\n                            " +
                        (playerAccess.citizens.delete_note
                          ? '<i onclick="DeleteVehicleNote(' +
                            _0xf18f2d.id +
                            ')" class="fa-solid fa-trash-can"></i>'
                          : "") +
                        "\n                        </div>\n                        <span>" +
                        _0xf18f2d.text +
                        "</span>\n                        <span>" +
                        locales.added +
                        ": " +
                        formatTime(_0x194054) +
                        "</span>\n                    </div>");
                  }
                  for (let _0x4f39d9 in _0x18d68a.wanted) {
                    let _0xaaab53 = _0x18d68a.wanted[_0x4f39d9],
                      _0x490999 = new Date(_0xaaab53.expire * 1000);
                    _0x7d4c7c =
                      _0x7d4c7c +
                      ('\n                    <div class="vehicle-details-wanted ' +
                        (_0xaaab53.important ? "important" : "") +
                        '" id="vehicle-wanted-' +
                        _0xaaab53.id +
                        '">\n                        <div>\n                            <span>' +
                        _0xaaab53.firstname +
                        " " +
                        _0xaaab53.lastname +
                        "</span>\n                            " +
                        (playerAccess.vehicles.delete_wanted
                          ? '<i onclick="DeleteVehicleWanted(' +
                            _0xaaab53.id +
                            ')" class="fa-solid fa-trash-can"></i>'
                          : "") +
                        "\n                        </div>\n                        <span>" +
                        _0xaaab53.text +
                        "</span>\n                        <span>" +
                        locales.active_to +
                        ": " +
                        formatTime(_0x490999) +
                        "</span>\n                    </div>");
                  }
                  $("#vehicle-details").html(
                    '\n                <div class="top-bar">\n                    <div class="square-btn" onclick="CloseDetails()"><i class="fa-solid fa-chevron-left"></i></div>\n                    <span>' +
                      locales.vehicle +
                      " - " +
                      _0x991114.model +
                      '</span>\n                </div>\n                <div class="vehicle-details-wrapper">\n                    <div class="vehicle-details-box" id="vehicle-details-info">\n                        <span>' +
                      _0x991114.model +
                      '</span>\n                        <div class="vehicle-details-row">\n                            <span>' +
                      locales.plate +
                      "</span>\n                            <span>" +
                      _0x991114.plate +
                      '</span>\n                        </div>\n                        <div class="vehicle-details-row">\n                            <span>' +
                      locales.vin +
                      "</span>\n                            <span>" +
                      _0x991114.vin +
                      '</span>\n                        </div>\n                        <div class="vehicle-details-row" onclick="OpenDetails(\'citizen-details\')">\n                            <span>' +
                      locales.owner +
                      "</span>\n                            <span style=\"cursor: pointer\" onclick=\"OpenDetails('citizen-details', '" +
                      _0x991114.owner +
                      "')\">" +
                      _0x991114.ofname +
                      " " +
                      _0x991114.olname +
                      '</span>\n                        </div>\n                        <div class="vehicle-details-row">\n                            <span>' +
                      locales.coowner +
                      '</span>\n                            <span style="cursor: pointer" ' +
                      (_0x991114.co_owner
                        ? "onclick=\"OpenDetails('citizen-details', '" +
                          _0x991114.co_owner +
                          "')\""
                        : "") +
                      ">" +
                      (_0x991114.co_owner
                        ? _0x991114.cofname + " " + _0x991114.colname
                        : locales.no_data) +
                      '</span>\n                        </div>\n                        <div class="vehicle-details-row">\n                            <span>' +
                      locales.status +
                      '</span>\n                            <span id="vehicle-status">' +
                      (parseInt(_0x991114.state) == 2
                        ? locales.confiscated
                        : _0x991114.wanted
                        ? locales.wanted
                        : locales.not_wanted) +
                      '</span>\n                        </div>\n                        <div class="vehicle-buttons" style="margin-top: .5rem">\n                            <div class="vehicle-btn" onclick="OpenPopup(\'add-vehicle-note-popup\')">' +
                      locales.add_note +
                      '</div>\n                            <div class="vehicle-btn" onclick="OpenPopup(\'add-vehicle-wanted-popup\')">' +
                      locales.add_wanted +
                      "</div>\n                            <div class=\"vehicle-btn\" onclick=\"OpenPopup('confiscate-vehicle-popup', '" +
                      _0x991114.plate +
                      "')\">" +
                      locales.confiscate +
                      '</div>\n                        </div>\n                    </div>\n                    <div class="vehicle-details-box" id="vehicle-wanted-list">\n                        <span>' +
                      locales.wanteds +
                      "</span>\n                        " +
                      _0x7d4c7c +
                      '\n                    </div>\n                    <div class="vehicle-details-box" id="vehicle-notes-list">\n                        <span>' +
                      locales.notes +
                      "</span>\n                        " +
                      _0x230f33 +
                      "\n                    </div>\n                </div>"
                  );
                });
              }, 250));
          }
        }
      }
    }
    $("#" + activeTab).hide();
    $("#" + _0x329207).show();
    activeDetails = _0x329207;
  },
  EditCase = (_0x2b27f2) => {
    let _0x28682f = $("#edit-case-title").val();
    if (_0x28682f.length < 3 || _0x28682f.includes("<script>")) {
      $.post(
        "https://piotreq_gpt/ShowNotification",
        JSON.stringify({ text: locales.title_too_short })
      );
      return;
    }
    let _0x5bad0a = $("#edit-case-text").val();
    if (_0x5bad0a.length < 10 || _0x5bad0a.includes("<script>")) {
      $.post(
        "https://piotreq_gpt/ShowNotification",
        JSON.stringify({ text: locales.text_too_short })
      );
      return;
    }
    $.post(
      "https://piotreq_gpt/actionData",
      JSON.stringify({
        action: "EditCase",
        id: _0x2b27f2,
        title: _0x28682f,
        text: _0x5bad0a,
        citizens: selectedCitizensCase,
        vehicles: selectedVehiclesCase,
        officers: selectedOfficersCase,
        photos: attachedPhotosCase,
        status: $("#edit-case-status").attr("data-status"),
      })
    ).then((_0x5e7cfd) => {
      _0x5e7cfd &&
        (refreshCases(_0x5e7cfd), (Cases = _0x5e7cfd), CloseDetails());
    });
  },
  ToggleCaseStatus = () => {
    let _0x31b5b1 = $("#edit-case-status").attr("data-status");
    _0x31b5b1 == 0
      ? ((_0x31b5b1 = 1),
        $("#edit-case-status").attr("data-status", _0x31b5b1),
        $("#edit-case-status").text(locales.case_solved),
        $("#edit-case-status").addClass("done"))
      : ((_0x31b5b1 = 0),
        $("#edit-case-status").attr("data-status", _0x31b5b1),
        $("#edit-case-status").text(locales.case_unsolved),
        $("#edit-case-status").removeClass("done"));
  },
  CaseEditor = (_0x2b627f, _0x11e4a7) => {
    let _0x4e2e99 = "",
      _0x1ddd43 = "",
      _0x24cac6 = "",
      _0x565577 = "";
    selectedCitizensCase = _0x2b627f.citizens ? _0x2b627f.citizens : {};
    selectedOfficersCase = _0x2b627f.officers ? _0x2b627f.officers : {};
    selectedVehiclesCase = _0x2b627f.vehicles ? _0x2b627f.vehicles : {};
    attachedPhotosCase = _0x2b627f.photos ? _0x2b627f.photos : {};
    for (let _0x4120b1 in _0x2b627f.citizens) {
      let _0x5e2533 = _0x2b627f.citizens[_0x4120b1];
      _0x5e2533 &&
        (_0x4e2e99 =
          _0x4e2e99 +
          ('\n            <div class="judgment-list-item" id="selected-citizen-case-' +
            _0x5e2533.ssn +
            '">\n                <span>(' +
            _0x5e2533.ssn +
            ") " +
            _0x5e2533.name +
            "</span>\n                 <i onclick=\"RemoveCaseCitizen('" +
            _0x5e2533.ssn +
            '\')" class="fa-solid fa-trash-can" style="font-size: .75rem;"></i>\n            </div>'));
    }
    for (let _0x26cc38 in _0x2b627f.officers) {
      let _0x4c5e59 = _0x2b627f.officers[_0x26cc38];
      _0x4c5e59 &&
        (_0x1ddd43 =
          _0x1ddd43 +
          ('\n            <div class="judgment-list-item" id="selected-officer-case-' +
            _0x4c5e59.ssn +
            '">\n                <span>(' +
            _0x4c5e59.ssn +
            ") " +
            _0x4c5e59.name +
            " [" +
            _0x4c5e59.job +
            "]</span>\n                <i onclick=\"RemoveCaseOfficer('" +
            _0x4c5e59.ssn +
            '\')" class="fa-solid fa-trash-can" style="font-size: .75rem;"></i>\n            </div>'));
    }
    for (let _0x10b6fb in _0x2b627f.photos) {
      let _0x3ea555 = _0x2b627f.photos[_0x10b6fb];
      _0x565577 =
        _0x565577 +
        ('\n        <div class="judgment-list-item case-photo" id="case-photo-' +
          _0x10b6fb +
          '">\n            <span onclick="RemoveCasePhoto(\'' +
          _0x10b6fb +
          '\')"><i class="fa-solid fa-trash-can" style="font-size: .75rem;"></i></span>\n            <img src="' +
          _0x3ea555 +
          '" alt="">\n        </div>');
    }
    for (let _0x4d4986 in _0x11e4a7) {
      let _0x9cdf18 = _0x11e4a7[_0x4d4986];
      _0x9cdf18 &&
        (_0x24cac6 =
          _0x24cac6 +
          ('\n            <div class="judgment-list-item" id="selected-vehicle-case-' +
            _0x9cdf18.vin +
            '">\n                <span>(' +
            _0x9cdf18.plate +
            ") " +
            _0x9cdf18.model +
            "</span>\n                <i onclick=\"RemoveCaseVehicle('" +
            _0x9cdf18.vin +
            '\')" class="fa-solid fa-trash-can" style="font-size: .75rem;"></i>\n            </div>'));
    }
    $("#case-details").html(
      '\n        <div class="top-bar">\n            <div class="square-btn" onclick="CloseDetails()"><i class="fa-solid fa-chevron-left"></i></div>\n            <span>' +
        locales.case_editing +
        '</span>\n        </div>\n        <div class="vehicle-details-wrapper">\n                <div class="vehicle-details-box" id="case-details-info">\n                    <div class="vehicle-details-row">\n                        <span>' +
        locales.title +
        '</span>\n                        <input type="text" id="edit-case-title" value="' +
        _0x2b627f.title +
        '" placeholder="' +
        locales.case_title_placeholder +
        '">\n                    </div>\n                    <div class="vehicle-details-row">\n                        <span>' +
        locales.status +
        "</span>\n                        " +
        (_0x2b627f.status == 0
          ? '<span data-status="' +
            _0x2b627f.status +
            '" onclick="ToggleCaseStatus()" id="edit-case-status" class="case-status">' +
            locales.case_unsolved +
            "</span>"
          : '<span data-status="' +
            _0x2b627f.status +
            '" onclick="ToggleCaseStatus()" id="edit-case-status" class="case-status done">' +
            locales.case_solved +
            "</span>") +
        '\n                    </div>\n                    <div class="vehicle-btn" onclick="EditCase(' +
        _0x2b627f.id +
        ')" style="width: fit-content; margin-top: .5rem;">' +
        locales.save +
        '</div>\n                </div>\n                <div class="vehicle-details-box" id="case-desc-info">\n                    <span>' +
        locales.case_description +
        '</span>\n                    <textarea id="edit-case-text" placeholder="' +
        locales.case_description_placeholder +
        '">' +
        _0x2b627f.text +
        '</textarea>\n                </div>\n            <div class="vehicle-details-box" id="vehicle-wanted">\n                <span>' +
        locales.case_related_citizens +
        '</span>\n                <div class="judgment-list" id="create-case-citizens">\n                ' +
        _0x4e2e99 +
        '\n                </div>\n                <div class="gpt-input judgment-input">\n                    <input type="text" id="search-case-citizen" oninput="SearchCaseCitizen()" placeholder="' +
        locales.search_case_citizen_placeholder +
        '">\n                    <i class="fa-solid fa-user"></i>\n                    <div class="judgment-players" id="searched-case-citizens">\n                    </div>\n                </div>\n            </div>\n            <div class="vehicle-details-box" id="vehicle-wanted">\n                <span>' +
        locales.case_related_officers +
        '</span>\n                <div class="judgment-list" id="create-case-officers">\n                ' +
        _0x1ddd43 +
        '\n                </div>\n                <div class="gpt-input judgment-input">\n                    <input type="text" id="search-case-officer" oninput="SearchCaseOfficers()" placeholder="' +
        locales.search_case_officer_placeholder +
        '">\n                    <i class="fa-solid fa-user-police"></i>\n                    <div class="judgment-players" id="searched-case-officers">\n                    </div>\n                </div>\n            </div>\n            <div class="vehicle-details-box" id="vehicle-wanted">\n                <span>' +
        locales.case_related_vehicles +
        '</span>\n                <div class="judgment-list" id="create-case-vehicles">\n                ' +
        _0x24cac6 +
        '\n                </div>\n                <div class="gpt-input judgment-input">\n                    <input type="text" id="search-case-vehicle" oninput="SearchCaseVehicles()" placeholder="' +
        locales.search_case_vehicle_placeholder +
        '">\n                    <i class="fa-solid fa-cars"></i>\n                    <div class="judgment-players" id="searched-case-vehicles">\n                    </div>\n                </div>\n            </div>\n            <div class="vehicle-details-box" id="vehicle-wanted">\n                <span>' +
        locales.case_photos +
        '</span>\n                <div class="judgment-list" id="new-case-photos">\n                ' +
        _0x565577 +
        '\n                    <div class="judgment-list-item case-photo" onclick="OpenPopup(\'add-case-photo-popup\')">\n                        <i class="fa-thin fa-circle-plus" style="font-size: 5rem; opacity: 0.5"></i>\n                    </div>\n                </div>\n            </div>\n        </div>'
    );
  },
  CloseDetails = () => {
    $("#" + activeDetails).hide();
    $("#" + activeTab).show();
    activeDetails = "";
    selectedCitizensCase = {};
    selectedVehiclesCase = {};
    selectedOfficersCase = {};
    attachedPhotosCase = {};
    activeCitizen = {};
    activeVehicle = {};
  },
  CloseGPT = (_0x59b1e4) => {
    if (_0x59b1e4) {
      activePopup !== "" && ClosePopup();
      activeDetails !== "" && CloseDetails();
      clearInterval(dutyTimeInterval);
      $(".gpt-wrapper").hide();
      $.post("https://piotreq_gpt/CloseUI");
      return;
    }
    if (activePopup !== "") {
      ClosePopup();
      return;
    }
    if (activeDetails !== "") {
      CloseDetails();
      return;
    }
    clearInterval(dutyTimeInterval);
    $(".gpt-wrapper").hide();
    $.post("https://piotreq_gpt/CloseUI");
  };
document.onkeydown = (_0x55851c) => {
  if (_0x55851c.which == 27) {
    if (inFullScreen) {
      $(".full-screen").remove();
      inFullScreen = false;
      return;
    }
    if (inDispatch) {
      CloseDispatch();
      return;
    }
    CloseGPT(false);
  }
};
const FullScreenImage = (_0x5f121e) => {
    inFullScreen = true;
    $("body").prepend(
      '<div class="full-screen">\n        <div style="background: center / cover no-repeat url(\'' +
        _0x5f121e +
        '\')" class="full-image"></div>\n    </div>'
    );
  },
  loadTab = (_0x14a65b) => {
    if (_0x14a65b.tab == "home") {
      loadHome(_0x14a65b.tabData);
      return;
    }
    if (_0x14a65b.tab == "patrols") {
      loadPatrols(_0x14a65b.tabData);
      return;
    }
    if (_0x14a65b.tab == "evidence") {
      Evidences = _0x14a65b.tabData;
      refreshEvidences(_0x14a65b.tabData);
      return;
    }
    if (_0x14a65b.tab == "radios") {
      Radios = _0x14a65b.tabData;
      refreshRadios(_0x14a65b.tabData);
      return;
    }
    if (_0x14a65b.tab == "cases") {
      Cases = _0x14a65b.tabData;
      refreshCases(_0x14a65b.tabData);
      return;
    }
    if (_0x14a65b.tab == "announcements") {
      Announcements = _0x14a65b.tabData;
      refreshAnnouncements(_0x14a65b.tabData);
      return;
    }
    if (_0x14a65b.tab == "employees") {
      loadWorkers(_0x14a65b.tabData);
      return;
    }
    if (_0x14a65b.tab == "garage") {
      loadGarage(_0x14a65b.tabData);
      return;
    }
  },
  ImpoundVehicles = () => {
    if (!playerAccess.garage || !playerAccess.garage.impound) {
      $.post(
        "https://piotreq_gpt/ShowNotification",
        JSON.stringify({ text: locales.no_permission })
      );
      return;
    }
    $.post(
      "https://piotreq_gpt/actionData",
      JSON.stringify({ action: "ImpoundVehicles" })
    ).then((_0x204df4) => {
      _0x204df4 &&
        (refreshVehicles(_0x204df4),
        $("#search-garage").unbind(),
        $("#search-garage").on("input", () => {
          let _0x17ce78 = [],
            _0x42c5b4 = $("#search-garage").val().toLowerCase();
          for (let _0xc72e4f in _0x204df4) {
            let _0x153ec7 = _0x204df4[_0xc72e4f],
              _0x3323a2 = _0x153ec7.model.toLowerCase(),
              _0x341a21 = _0x153ec7.plate.toLowerCase(),
              _0x549273 = _0x153ec7.vin.toLowerCase(),
              _0x17c5ce = _0x153ec7.firstname
                ? (_0x153ec7.firstname + " " + _0x153ec7.lastname).toLowerCase()
                : null;
            (_0x3323a2.includes(_0x42c5b4) ||
              _0x341a21.includes(_0x42c5b4) ||
              _0x549273.includes(_0x42c5b4) ||
              (_0x17c5ce && _0x17c5ce.includes(_0x42c5b4))) &&
              _0x17ce78.push(_0x153ec7);
          }
          refreshGarage(_0x17ce78);
          _0x17ce78 = [];
        }));
    });
  },
  reloadGarage = () => {
    let _0x319aee = new Date().getTime();
    if (antiSpam > _0x319aee) {
      return;
    }
    antiSpam = _0x319aee + 500;
    $.post(
      "https://piotreq_gpt/fetchData",
      JSON.stringify({ tab: "garage" })
    ).then((_0x237534) => {
      refreshGarage(_0x237534);
      $("#search-garage").unbind();
      $("#search-garage").on("input", () => {
        let _0x47f534 = [],
          _0x1f5777 = $("#search-garage").val().toLowerCase();
        for (let _0x32d874 in _0x237534) {
          let _0x280102 = _0x237534[_0x32d874],
            _0x271a33 = _0x280102.model.toLowerCase(),
            _0x5a479e = _0x280102.plate.toLowerCase(),
            _0x3b481a = _0x280102.vin.toLowerCase(),
            _0x3fec97 = _0x280102.firstname
              ? (_0x280102.firstname + " " + _0x280102.lastname).toLowerCase()
              : null;
          (_0x271a33.includes(_0x1f5777) ||
            _0x5a479e.includes(_0x1f5777) ||
            _0x3b481a.includes(_0x1f5777) ||
            (_0x3fec97 && _0x3fec97.includes(_0x1f5777))) &&
            _0x47f534.push(_0x280102);
        }
        refreshGarage(_0x47f534);
        _0x47f534 = [];
      });
    });
  },
  loadGarage = (_0x178383) => {
    $("#garage").html(
      '\n        <div class="top-bar">\n            <span>' +
        locales.garage +
        '</span>\n        </div>\n        <div class="citizens-wrapper">\n            <div class="employees-top">\n                <div class="gpt-input" style="width: 55%;">\n                    <input type="text" id="search-garage" placeholder="' +
        locales.search_vehicle +
        '">\n                    <i class="fa-solid fa-magnifying-glass"></i>\n                </div>\n                <div class="employees-btn" onclick="reloadGarage()" style="width: 15%;">\n                    <i class="fa-regular fa-arrows-rotate"></i>\n                    <span>' +
        locales.refresh +
        '</span>\n                </div>\n                <div class="employees-btn" onclick="ImpoundVehicles()" style="width: 15%;">\n                    <i class="fa-regular fa-truck-tow"></i>\n                    <span>' +
        locales.tow +
        '</span>\n                </div>\n                <div class="employees-btn" style="width: 15%;" onclick="OpenPopup(\'buy-vehicle-popup\')">\n                    <i class="fa-regular fa-dollar-sign"></i>\n                    <span>' +
        locales.buy_vehicle +
        '</span>\n                </div>\n            </div>\n            <div class="citizens-list" id="garage-list-wrapper">\n                <table id="garage-list">\n                    <tr>\n                        <th>' +
        locales.model +
        "</th>\n                        <th>" +
        locales.driver +
        "</th>\n                        <th>" +
        locales.status +
        "</th>\n                        <th>" +
        locales.plate +
        "</th>\n                        <th>" +
        locales.vin +
        '</th>\n                        <th style="width: 6%;"></th>\n                    </tr>\n                </table>\n            </div>\n        </div>'
    );
    refreshGarage(_0x178383);
    $("#search-garage").unbind();
    $("#search-garage").on("input", () => {
      let _0x21c234 = [],
        _0x2f1a66 = $("#search-garage").val().toLowerCase();
      for (let _0x3037b0 in _0x178383) {
        let _0x5c688a = _0x178383[_0x3037b0],
          _0x436551 = _0x5c688a.model.toLowerCase(),
          _0x25d340 = _0x5c688a.plate.toLowerCase(),
          _0x59c6a9 = _0x5c688a.vin.toLowerCase(),
          _0x4e6a77 = _0x5c688a.firstname
            ? (_0x5c688a.firstname + " " + _0x5c688a.lastname).toLowerCase()
            : null;
        (_0x436551.includes(_0x2f1a66) ||
          _0x25d340.includes(_0x2f1a66) ||
          _0x59c6a9.includes(_0x2f1a66) ||
          (_0x4e6a77 && _0x4e6a77.includes(_0x2f1a66))) &&
          _0x21c234.push(_0x5c688a);
      }
      refreshGarage(_0x21c234);
      _0x21c234 = [];
    });
  },
  refreshGarage = (_0x3b66b1) => {
    $("#garage-list-wrapper").html(
      '<div class="loader-wrapper"><span class="loader"></span></div>'
    );
    setTimeout(() => {
      $("#garage-list-wrapper").html(
        '<table id="garage-list"><tr><th>' +
          locales.model +
          "</th><th>" +
          locales.driver +
          "</th><th>" +
          locales.status +
          "</th><th>" +
          locales.plate +
          "</th><th>" +
          locales.vin +
          '</th><th style="width: 6%;"></th></tr></table>'
      );
      for (let _0x5bc69d in _0x3b66b1) {
        let _0x564599 = _0x3b66b1[_0x5bc69d];
        $("#garage-list").append(
          "\n            <tr>\n                <td>" +
            _0x564599.model +
            "</td>\n                <td>" +
            (_0x564599.firstname
              ? _0x564599.firstname + " " + _0x564599.lastname
              : locales.no_data) +
            "</td>\n                <td>" +
            (_0x564599.state == 0
              ? '<div style="margin: auto; width: 8.5rem" class="player-status off-duty">' +
                locales.out_garage +
                "</div>"
              : '<div style="margin: auto; width: 8.5rem" class="player-status">' +
                locales.in_garage +
                "</div>") +
            "</td>\n                <td>" +
            _0x564599.plate +
            "</td>\n                <td>" +
            _0x564599.vin +
            '</td>\n                <td><div id="garage-veh-btn-' +
            _0x5bc69d +
            '" class="player-btn"><i class="fa-solid fa-gear"></i></div></td>\n            </tr>'
        );
        $("#garage-veh-btn-" + _0x5bc69d).unbind();
        $("#garage-veh-btn-" + _0x5bc69d).on("click", () => {
          if (!playerAccess.garage || !playerAccess.garage.manage) {
            $.post(
              "https://piotreq_gpt/ShowNotification",
              JSON.stringify({ text: locales.no_permission })
            );
            return;
          }
          OpenPopup("manage-vehicle-popup", _0x564599);
        });
      }
    }, 150);
  },
  SwitchDuty = (_0x336482) => {
    let _0xc455a0 = new Date().getTime();
    if (antiSpam > _0xc455a0) {
      return;
    }
    antiSpam = _0xc455a0 + 250;
    $.post(
      "https://piotreq_gpt/SwitchDuty",
      JSON.stringify({ duty: _0x336482 })
    );
    $("#duty-menu-value").html(
      "\n        " +
        (_0x336482 == 0
          ? '<span style="color: red;">' + locales.off_duty + "</span>"
          : _0x336482 == 1
          ? "<span>" + locales.on_duty + "</span>"
          : '<span style="color: orange;">' + locales.break + "</span>") +
        '\n        <i id="duty-menu-arrow" style="transform: rotate(180deg)" class="fa-solid fa-chevron-down"></i>\n    '
    );
    $("#my-status").html(
      _0x336482 == 0
        ? '<div class="player-status off-duty">' + locales.off_duty + "</div>"
        : _0x336482 == 1
        ? '<div class="player-status">' + locales.on_duty + "</div>"
        : '<div class="player-status on-break">' + locales.break + "</div>"
    );
    ToggleSelect("duty-menu");
    clearInterval(dutyTimeInterval);
    _0x336482 == 1 &&
      (dutyTimeInterval = setInterval(() => {
        playerInfo.dutyTime++;
        $("#welcome-message").text(
          locales.welcome +
            ", " +
            playerInfo.name +
            " - " +
            playerInfo.grade_label +
            " - " +
            formatDutyTime(playerInfo.dutyTime)
        );
      }, 1000));
  },
  SwitchCode = (_0x1a3f22, _0x5dbd91, _0x3dff7f) => {
    let _0x22742b = new Date().getTime();
    if (antiSpam > _0x22742b) {
      return;
    }
    antiSpam = _0x22742b + 250;
    $.post(
      "https://piotreq_gpt/SwitchCode",
      JSON.stringify({
        code: _0x1a3f22,
        label: _0x5dbd91,
        color: _0x3dff7f,
      })
    );
    $("#codes-menu-value").html(
      '\n        <span style="color: ' +
        _0x3dff7f +
        '">' +
        _0x5dbd91 +
        '</span>\n        <i id="codes-menu-arrow" style="transform: rotate(180deg)" class="fa-solid fa-chevron-down"></i>\n    '
    );
    ToggleSelect("codes-menu");
  },
  loadGrades = (_0x58333e) => {
    $("#update-member").empty();
    $("#add-member").empty();
    for (let _0x2c7c6e in _0x58333e) {
      let _0xd80ed4 = _0x58333e[_0x2c7c6e];
      $("#update-member").append(
        "<div onclick=\"SelectItem('update-member', '" +
          _0xd80ed4.grade +
          "', '" +
          _0xd80ed4.label +
          '\')" class="popup-select-item">' +
          _0xd80ed4.label +
          "</div>"
      );
      $("#add-member").append(
        "<div onclick=\"SelectItem('add-member', '" +
          _0xd80ed4.grade +
          "', '" +
          _0xd80ed4.label +
          '\')" class="popup-select-item">' +
          _0xd80ed4.label +
          "</div>"
      );
    }
  },
  loadHome = (_0x35a6df) => {
    let _0x3dc63f = "",
      _0xe4793d = "",
      _0x8c56c2 = "";
    for (let _0x16d7aa in _0x35a6df.mostActive) {
      let _0x47426c = _0x35a6df.mostActive[_0x16d7aa];
      _0x8c56c2 =
        _0x8c56c2 +
        ("\n            <div>\n                " +
          (playerAccess.home.most_active_employees
            ? "<span>" +
              _0x47426c.firstname +
              " " +
              _0x47426c.lastname +
              "</span><i onclick=\"OpenDetails('employee-details', '" +
              _0x47426c.identifier +
              '\')" class="fa-solid fa-chevron-right"></i>'
            : '<span>???</span><i style="opacity: 0.0" class="fa-solid fa-chevron-right"></i>') +
          "\n            </div>");
    }
    for (let _0x48a8c4 in _0x35a6df.wanted.citizens) {
      let _0x2989fa = _0x35a6df.wanted.citizens[_0x48a8c4];
      _0x3dc63f =
        _0x3dc63f +
        ("\n            <div>\n                " +
          (playerAccess.home.last_wanted_citizens
            ? "<span>" +
              _0x2989fa.firstname +
              " " +
              _0x2989fa.lastname +
              "</span><i onclick=\"OpenDetails('citizen-details', '" +
              _0x2989fa.player +
              '\')" class="fa-solid fa-chevron-right"></i>'
            : '<span>???</span><i style="opacity: 0.0" class="fa-solid fa-chevron-right"></i>') +
          "\n            </div>");
    }
    for (let _0x3a48b3 in _0x35a6df.wanted.vehicles) {
      let _0x1f4d2a = _0x35a6df.wanted.vehicles[_0x3a48b3];
      _0xe4793d =
        _0xe4793d +
        ("\n            <div>\n                " +
          (playerAccess.home.last_wanted_vehicles
            ? "<span>" +
              _0x1f4d2a.plate +
              "</span><i onclick=\"OpenVehicle('" +
              _0x1f4d2a.vin +
              '\')" class="fa-solid fa-chevron-right"></i>'
            : '<span>???</span><i style="opacity: 0.0" class="fa-solid fa-chevron-right"></i>') +
          "\n            </div>");
    }
    loadGrades(_0x35a6df.grades);
    playerInfo = _0x35a6df.playerInfo;
    $("#home").html(
      '\n        <div class="top-bar">\n            <span id="welcome-message">' +
        locales.welcome +
        ", " +
        _0x35a6df.playerInfo.name +
        " - " +
        _0x35a6df.playerInfo.grade_label +
        " - " +
        formatDutyTime(_0x35a6df.playerInfo.dutyTime) +
        '</span>\n            <div style="display: flex; align-items: center; gap: 1rem;">\n                <div class="custom-select">\n                    <div class="custom-select-info" id="codes-menu-value" ' +
        (playerAccess.home.change_code
          ? "onclick=\"ToggleSelect('codes-menu')\""
          : "") +
        ">\n                        <span>" +
        locales.green +
        '</span>\n                        <i id="codes-menu-arrow" class="fa-solid fa-chevron-down"></i>\n                    </div>\n                    <div class="custom-select-menu" id="codes-menu">\n                    </div>\n                </div>\n                <div class="custom-select">\n                <div class="custom-select-info" id="duty-menu-value" onclick="ToggleSelect(\'duty-menu\')">\n                    ' +
        (_0x35a6df.playerInfo.dutyStatus == 0
          ? '<span style="color: red;">' + locales.off_duty + "</span>"
          : _0x35a6df.playerInfo.dutyStatus == 1
          ? "<span>" + locales.on_duty + "</span>"
          : '<span style="color: orange;">' + locales.on_break + "</span>") +
        '\n                    <i id="duty-menu-arrow" class="fa-solid fa-chevron-down"></i>\n                </div>\n                <div class="custom-select-menu" id="duty-menu">\n                    <div class="custom-select-option" onclick="SwitchDuty(1)">' +
        locales.on_duty +
        '</div>\n                    <div class="custom-select-option" onclick="SwitchDuty(2)">' +
        locales.on_break +
        '</div>\n                    <div class="custom-select-option" onclick="SwitchDuty(0)">' +
        locales.off_duty +
        '</div>\n                </div>\n                </div>\n            </div>\n        </div>\n        <div class="section-main">\n            <div class="active-employees-wrapper">\n                <div class="active-employees-info">\n                    <span>' +
        locales.workers_on_duty +
        '</span>\n                    <span id="active-employees-count">0/0</span>\n                </div>\n                <div class="active-employees-list">\n                    <table id="active-employees-list">\n                        <tr>\n                            <th>' +
        locales.full_name +
        "</th>\n                            <th>" +
        locales.rank +
        "</th>\n                            <th>" +
        locales.status +
        "</th>\n                            <th>" +
        locales.radio +
        "</th>\n                            <th>" +
        locales.time_on_duty +
        "</th>\n                            <th>" +
        locales.last_active +
        '</th>\n                        </tr>\n                    </table>\n                </div>\n            </div>\n            <div class="last-items-wrapper">\n                <div class="last-items">\n                    <span>' +
        locales.citizen_searches +
        '</span>\n                    <div class="last-items-list">\n                        ' +
        _0x3dc63f +
        '\n                    </div>\n                </div>\n                <div class="last-items">\n                    <span>' +
        locales.vehicle_searches +
        '</span>\n                    <div class="last-items-list">\n                        ' +
        _0xe4793d +
        '\n                    </div>\n                </div>\n                <div class="last-items">\n                    <span>' +
        locales.most_active_on_duty +
        '</span>\n                    <div class="last-items-list">\n                        ' +
        _0x8c56c2 +
        "\n                    </div>\n                </div>\n            </div>\n        </div>\n    "
    );
    let _0x55e389 = 0;
    for (let _0x357189 in _0x35a6df.employees) {
      let _0x3876f0 = _0x35a6df.employees[_0x357189];
      _0x3876f0.status == 1 &&
        (_0x55e389++,
        $("#active-employees-list").append(
          "\n                <tr>\n                    <td>" +
            _0x3876f0.name +
            " " +
            (_0x3876f0.identifier == _0x35a6df.playerInfo.identifier
              ? locales.you
              : "") +
            "</td>\n                    <td>" +
            _0x3876f0.grade_label +
            "</td>\n                    <td " +
            (_0x3876f0.identifier == _0x35a6df.playerInfo.identifier
              ? 'id="my-status"'
              : "") +
            ">" +
            (_0x3876f0.status == 0
              ? '<div class="player-status off-duty">' +
                locales.off_duty +
                "</div>"
              : _0x3876f0.status == 1
              ? '<div class="player-status">' + locales.on_duty + "</div>"
              : '<div class="player-status on-break">' +
                locales.on_break +
                "</div>") +
            "</td>\n                    <td>" +
            _0x3876f0.radio +
            "</td>\n                    <td>" +
            (playerAccess.home.duty_time
              ? formatDutyTime(_0x3876f0.dutyTime)
              : locales.no_data) +
            "</td>\n                    <td>" +
            (playerAccess.home.last_active
              ? _0x3876f0.lastActive
              : locales.no_data) +
            '</td>\n                    <td><div id="active-employee-btn-' +
            _0x357189 +
            '" class="player-btn"><i class="fa-solid fa-chevron-right"></i></div></td>\n                </tr>'
        ),
        $("#active-employee-btn-" + _0x357189).unbind(),
        $("#active-employee-btn-" + _0x357189).on("click", () => {
          playerAccess.employees
            ? OpenDetails("employee-details", _0x3876f0.identifier)
            : $.post(
                "https://piotreq_gpt/ShowNotification",
                JSON.stringify({ text: locales.no_permission })
              );
        }));
    }
    $("#active-employees-count").text(
      _0x55e389 + "/" + _0x35a6df.employees.length
    );
    dangerCodes = _0x35a6df.codes;
    for (let _0x166858 in _0x35a6df.codes) {
      let _0x4699a5 = _0x35a6df.codes[_0x166858];
      _0x4699a5.name == _0x35a6df.dangerCode &&
        $("#codes-menu-value").html(
          '\n                <span style="color: ' +
            _0x4699a5.color +
            '">' +
            _0x4699a5.label +
            '</span>\n                <i id="codes-menu-arrow" class="fa-solid fa-chevron-down"></i>\n            '
        );
      $("#codes-menu").append(
        '<div class="custom-select-option" onclick="SwitchCode(\'' +
          _0x4699a5.name +
          "', '" +
          _0x4699a5.label +
          "', '" +
          _0x4699a5.color +
          "')\">" +
          _0x4699a5.label +
          "</div>"
      );
    }
    clearInterval(dutyTimeInterval);
    _0x35a6df.playerInfo.dutyStatus == 1 &&
      (dutyTimeInterval = setInterval(() => {
        playerInfo.dutyTime++;
        playerInfo = playerInfo;
        $("#welcome-message").text(
          locales.welcome +
            ", " +
            playerInfo.name +
            " - " +
            playerInfo.grade_label +
            " - " +
            formatDutyTime(playerInfo.dutyTime)
        );
      }, 1000));
  },
  DeleteWorkerLicense = () => {
    if (!activeWorker.identifier) {
      return;
    }
    let _0x293204 = $("#remove-worker-license-value").attr("data-value");
    if (!_0x293204) {
      $.post(
        "https://piotreq_gpt/ShowNotification",
        JSON.stringify({ text: locales.select_license_to_remove })
      );
      return;
    }
    $.post(
      "https://piotreq_gpt/actionData",
      JSON.stringify({
        action: "DeleteWorkerLicense",
        player: activeWorker.identifier,
        type: _0x293204,
      })
    ).then((_0x174765) => {
      if (_0x174765) {
        for (let _0x43fd26 in activeWorker.licenses) {
          if (activeWorker.licenses[_0x43fd26].type == _0x293204) {
            delete activeWorker.licenses[_0x43fd26];
            break;
          }
        }
        ClosePopup();
        $("#remove-worker-license-value").attr("data-value", null);
        $("#remove-worker-license-value").text(locales.select_license);
        $("#worker-license-" + _0x293204).remove();
      }
    });
  },
  AddWorkerLicense = () => {
    if (!activeWorker.identifier) {
      return;
    }
    let _0x92afeb = $("#add-worker-license-value").attr("data-value");
    if (!_0x92afeb) {
      $.post(
        "https://piotreq_gpt/ShowNotification",
        JSON.stringify({ text: locales.select_license_to_add })
      );
      return;
    }
    let _0x17f86c = false;
    for (let _0x1cdd15 in activeWorker.licenses) {
      let _0x1ee82b = activeWorker.licenses[_0x1cdd15];
      if (_0x1ee82b && _0x1ee82b.type == _0x92afeb) {
        _0x17f86c = true;
        break;
      }
    }
    if (_0x17f86c) {
      $.post(
        "https://piotreq_gpt/ShowNotification",
        JSON.stringify({ text: locales.license_already_assigned })
      );
      return;
    }
    let _0x14c04c = $("#add-worker-license-value").text();
    $.post(
      "https://piotreq_gpt/actionData",
      JSON.stringify({
        action: "AddWorkerLicense",
        player: activeWorker.identifier,
        type: _0x92afeb,
        label: _0x14c04c,
      })
    ).then((_0x319028) => {
      _0x319028 &&
        (activeWorker.licenses.push({
          type: _0x92afeb,
          label: _0x14c04c,
        }),
        ClosePopup(),
        $("#add-worker-license-value").attr("data-value", null),
        $("#add-worker-license-value").text(locales.select_license),
        $("#remove-worker-license").prepend(
          '<div id="worker-license-' +
            _0x92afeb +
            "\" onclick=\"SelectItem('remove-worker-license', '" +
            _0x92afeb +
            "', '" +
            _0x14c04c +
            '\')" class="popup-select-item">' +
            _0x14c04c +
            "</div>"
        ));
    });
  },
  SetEmployeePhoto = () => {
    if (!activeWorker.identifier) {
      return;
    }
    if (!playerAccess.employees || !playerAccess.employees.set_photo) {
      $.post(
        "https://piotreq_gpt/ShowNotification",
        JSON.stringify({ text: locales.no_permission })
      );
      return;
    }
    let _0x442361 = $("#set-employee-photo-url").val();
    if (_0x442361.length < 1 || _0x442361.includes("<script>")) {
      $.post(
        "https://piotreq_gpt/ShowNotification",
        JSON.stringify({ text: locales.link_too_short })
      );
      return;
    }
    _0x442361 = removeTags(_0x442361);
    $.post(
      "https://piotreq_gpt/actionData",
      JSON.stringify({
        action: "SetEmployeePhoto",
        player: activeWorker.identifier,
        photo: _0x442361,
      })
    ).then((_0x38e031) => {
      _0x38e031 &&
        ($("#employee-details-photo").css(
          "background",
          "center / cover no-repeat url(" + _0x442361 + ")"
        ),
        ClosePopup());
    });
  },
  HireWorker = () => {
    let _0xfcf028 = $("#add-member-id").val();
    if (_0xfcf028.length < 1) {
      return;
    }
    let _0xed3933 = $("#add-member-value").attr("data-value");
    if (!_0xed3933) {
      $.post(
        "https://piotreq_gpt/ShowNotification",
        JSON.stringify({ text: locales.select_grade_to_hire })
      );
      return;
    }
    if (!playerAccess.employees || !playerAccess.employees.add) {
      $.post(
        "https://piotreq_gpt/ShowNotification",
        JSON.stringify({ text: locales.no_permission })
      );
      return;
    }
    $.post(
      "https://piotreq_gpt/actionData",
      JSON.stringify({
        action: "HireWorker",
        id: _0xfcf028,
        grade: _0xed3933,
      })
    ).then((_0x4a340b) => {
      _0x4a340b &&
        ($("#add-member-value").text(locales.select_grade),
        $("#add-member-value").attr("data-value", null),
        $("#add-member-id").val(""),
        ClosePopup(),
        refreshWorkers(_0x4a340b));
    });
  },
  SendForBreak = () => {
    if (!playerAccess.employees || !playerAccess.employees.break) {
      $.post(
        "https://piotreq_gpt/ShowNotification",
        JSON.stringify({ text: locales.no_permission })
      );
      return;
    }
    if (activeWorker.status == 2 || activeWorker.status == 0) {
      $.post(
        "https://piotreq_gpt/ShowNotification",
        JSON.stringify({ text: locales.off_duty_or_on_break })
      );
      return;
    }
    $.post(
      "https://piotreq_gpt/actionData",
      JSON.stringify({
        action: "SendForBreak",
        identifier: activeWorker.identifier,
      })
    ).then((_0x51c974) => {
      _0x51c974 && $("#employee-status-info").text(locales.break);
    });
  },
  ResetAllTime = () => {
    let _0x2ee750 = $("#reset-time-value").attr("data-value");
    if (!_0x2ee750) {
      $.post(
        "https://piotreq_gpt/ShowNotification",
        JSON.stringify({ text: locales.select_employees_to_reset_time })
      );
      return;
    }
    if (!playerAccess.employees || !playerAccess.employees.reset_time_all) {
      $.post(
        "https://piotreq_gpt/ShowNotification",
        JSON.stringify({ text: locales.no_permission })
      );
      return;
    }
    $("#employees-list-wrapper").hide();
    let _0x5edeb8 = $(
      '<div class="loader-wrapper"><span class="loader"></span></div>'
    );
    $("#employees-wrapper").append(_0x5edeb8);
    ClosePopup();
    $.post(
      "https://piotreq_gpt/actionData",
      JSON.stringify({
        action: "ResetTime",
        type: _0x2ee750,
      })
    ).then((_0x503d42) => {
      _0x503d42 && (_0x5edeb8.remove(), refreshWorkers(_0x503d42));
    });
  },
  ResetEmployeeTime = () => {
    if (
      !playerAccess.employees ||
      !playerAccess.employees.reset_time_employee
    ) {
      $.post(
        "https://piotreq_gpt/ShowNotification",
        JSON.stringify({ text: locales.no_permission })
      );
      return;
    }
    $.post(
      "https://piotreq_gpt/actionData",
      JSON.stringify({
        action: "ResetTime",
        employee: true,
        identifier: activeWorker.identifier,
      })
    ).then((_0x22edb0) => {
      _0x22edb0 && (ClosePopup(), $("#employee-time-info").text("00:00:00"));
    });
  },
  FireWorker = () => {
    if (!playerAccess.employees || !playerAccess.employees.fire) {
      $.post(
        "https://piotreq_gpt/ShowNotification",
        JSON.stringify({ text: locales.no_permission })
      );
      return;
    }
    let _0x15bdb9 = $("#fire-employee-reason").val();
    if (_0x15bdb9.length < 1 || _0x15bdb9.includes("<script>")) {
      $.post(
        "https://piotreq_gpt/ShowNotification",
        JSON.stringify({ text: locales.reason_too_short_or_invalid })
      );
      return;
    }
    _0x15bdb9 = removeTags(_0x15bdb9);
    $.post(
      "https://piotreq_gpt/actionData",
      JSON.stringify({
        action: "FireWorker",
        identifier: activeWorker.identifier,
        name: activeWorker.name,
        reason: _0x15bdb9,
      })
    ).then((_0x30f37c) => {
      _0x30f37c && (refreshWorkers(_0x30f37c), ClosePopup(), CloseDetails());
    });
  },
  UpdateWorker = () => {
    if (!playerAccess.employees || !playerAccess.employees.update) {
      $.post(
        "https://piotreq_gpt/ShowNotification",
        JSON.stringify({ text: locales.no_permission })
      );
      return;
    }
    let _0x397fa1 = $("#update-member-value").attr("data-value");
    if (!_0x397fa1) {
      $.post(
        "https://piotreq_gpt/ShowNotification",
        JSON.stringify({ text: locales.select_grade_to_update })
      );
      return;
    }
    $.post(
      "https://piotreq_gpt/actionData",
      JSON.stringify({
        action: "UpdateWorker",
        identifier: activeWorker.identifier,
        grade: _0x397fa1,
      })
    ).then((_0x33a080) => {
      activeWorker.grade_label = _0x33a080;
      $("#employee-grade-info").text(_0x33a080);
      ClosePopup();
    });
  },
  ChangeEmployeeBadge = () => {
    if (!playerAccess.employees || !playerAccess.employees.change_badge) {
      $.post(
        "https://piotreq_gpt/ShowNotification",
        JSON.stringify({ text: locales.no_permission })
      );
      return;
    }
    let _0x368cb1 = $("#change-badge-value").val();
    if (_0x368cb1.length < 1) {
      $.post(
        "https://piotreq_gpt/ShowNotification",
        JSON.stringify({ text: locales.badge_minimum_characters })
      );
      return;
    }
    $.post(
      "https://piotreq_gpt/actionData",
      JSON.stringify({
        action: "ChangeBadge",
        identifier: activeWorker.identifier,
        badge: _0x368cb1,
      })
    ).then((_0x2e2b54) => {
      _0x2e2b54 &&
        ((activeWorker.badge = _0x368cb1),
        $("#employee-badge-info").text(_0x368cb1),
        ClosePopup());
    });
  },
  DeleteEmployeeNote = (_0x2785ef) => {
    if (!playerAccess.employees || !playerAccess.employees.delete_note) {
      $.post(
        "https://piotreq_gpt/ShowNotification",
        JSON.stringify({ text: locales.no_permission })
      );
      return;
    }
    $.post(
      "https://piotreq_gpt/actionData",
      JSON.stringify({
        action: "DeleteEmployeeNote",
        id: _0x2785ef,
      })
    ).then((_0x3a8cba) => {
      _0x3a8cba && $("#employee-note-" + _0x2785ef).remove();
    });
  },
  AddEmployeeNote = () => {
    if (!playerAccess.employees || !playerAccess.employees.add_note) {
      $.post(
        "https://piotreq_gpt/ShowNotification",
        JSON.stringify({ text: locales.no_permission })
      );
      return;
    }
    let _0x2396d3 = $("#employee-note-title").val();
    if (_0x2396d3.length < 1 || _0x2396d3.includes("<script>")) {
      $.post(
        "https://piotreq_gpt/ShowNotification",
        JSON.stringify({ text: locales.title_must_have_at_least_1_char })
      );
      return;
    }
    let _0x306b52 = $("#employee-note-text").val();
    if (_0x306b52.length < 1 || _0x306b52.includes("<script>")) {
      $.post(
        "https://piotreq_gpt/ShowNotification",
        JSON.stringify({ text: locales.text_must_have_at_least_1_char })
      );
      return;
    }
    _0x2396d3 = removeTags(_0x2396d3);
    _0x306b52 = removeTags(_0x306b52);
    let _0x1ed8ac = $("#employee-note-important").prop("checked");
    $.post(
      "https://piotreq_gpt/actionData",
      JSON.stringify({
        action: "AddEmployeeNote",
        title: _0x2396d3,
        text: _0x306b52,
        important: _0x1ed8ac,
        identifier: activeWorker.identifier,
      })
    ).then((_0x16be03) => {
      _0x16be03 &&
        ($("#employee-note-title").val(""),
        $("#employee-note-text").val(""),
        $("#employee-note-important").prop("checked", false),
        ClosePopup(),
        $("#employee-note-list").prepend(
          '\n                <div class="employee-note ' +
            (_0x1ed8ac ? "important" : "") +
            '" id="employee-note-' +
            _0x16be03.id +
            '">\n                    <div class="employee-note-info">\n                        <span>' +
            _0x2396d3 +
            '</span>\n                        <i onclick="DeleteEmployeeNote(' +
            _0x16be03.id +
            ')" class="fa-solid fa-trash-can"></i>\n                    </div>\n                    <span>' +
            _0x306b52 +
            "</span>\n                    <span>" +
            locales.added_by +
            ": " +
            _0x16be03.name +
            " " +
            _0x16be03.date +
            "</span>\n                </div>"
        ));
    });
  };
var Workers = [];
const SearchEmployee = () => {
    let _0x314f83 = [],
      _0x3daae8 = $("#search-employee").val().toLowerCase();
    if (_0x3daae8.length < 1) {
      refreshWorkers(Workers);
    } else {
      for (let _0x1182fa in Workers) {
        let _0x1e32bf = Workers[_0x1182fa].name.toLowerCase();
        _0x1e32bf.includes(_0x3daae8) && _0x314f83.push(Workers[_0x1182fa]);
      }
      refreshWorkers(_0x314f83);
      _0x314f83 = [];
    }
  },
  loadWorkers = (_0x2e053b) => {
    Workers = _0x2e053b;
    $("#employees").html(
      '\n                <div class="top-bar">\n                    <span>' +
        locales.workers +
        '</span>\n                    <span id="employees-count">0/0</span>\n                </div>\n                <div class="citizens-wrapper" id="employees-wrapper">\n                    <div class="employees-top">\n                        <div class="gpt-input">\n                            <input oninput="SearchEmployee()" id="search-employee" type="text" placeholder="' +
        locales.search_worker +
        '">\n                            <i class="fa-solid fa-magnifying-glass"></i>\n                        </div>\n                        <div class="employees-btn" onclick="OpenPopup(\'add-employee-popup\')">\n                            <i class="fa-regular fa-circle-plus"></i>\n                            <span>' +
        locales.hire_worker +
        '</span>\n                        </div>\n                        <div class="employees-btn" onclick="OpenPopup(\'reset-time-popup\')">\n                            <i class="fa-regular fa-clock"></i>\n                            <span>' +
        locales.reset_duty_time +
        '</span>\n                        </div>\n                    </div>\n                    <div class="citizens-list" id="employees-list-wrapper">\n                    </div>\n                </div>\n    '
    );
    refreshWorkers(_0x2e053b);
  },
  refreshWorkers = (_0x3d5e58) => {
    $("#employees-list-wrapper").hide();
    let _0x1bf56b = $(
      '<div class="loader-wrapper"><span class="loader"></span></div>'
    );
    $("#employees-wrapper").append(_0x1bf56b);
    $("#employees-list-wrapper").html(
      '\n    <table id="employees-list">\n        <tr>\n            <th>' +
        locales.full_name +
        "</th>\n            <th>" +
        locales.rank +
        "</th>\n            <th>" +
        locales.status +
        "</th>\n            <th>" +
        locales.badge +
        "</th>\n            <th>" +
        locales.time_on_duty +
        "</th>\n            <th>" +
        locales.last_active +
        '</th>\n            <th style="width: 6%;"></th>\n        </tr>\n    </table>'
    );
    let _0x3023a0 = 0;
    for (let _0xe711d8 in _0x3d5e58) {
      let _0x5b26e2 = _0x3d5e58[_0xe711d8];
      _0x5b26e2.status == 1 && _0x3023a0++;
      $("#employees-list").append(
        '\n        <tr id="worker-row-' +
          _0x5b26e2.ssn +
          '">\n            <td>' +
          _0x5b26e2.name +
          "</td>\n            <td>" +
          _0x5b26e2.grade_label +
          "</td>\n            <td>" +
          (_0x5b26e2.status == 0
            ? '<div class="player-status off-duty">' +
              locales.off_duty +
              "</div>"
            : _0x5b26e2.status == 1
            ? '<div class="player-status">' + locales.on_duty + "</div>"
            : '<div class="player-status on-break">' +
              locales.break +
              "</div>") +
          "</td>\n            <td>" +
          (_0x5b26e2.badge || locales.no_data) +
          "</td>\n            <td>" +
          (playerAccess.home.duty_time
            ? formatDutyTime(_0x5b26e2.dutyTime)
            : locales.no_data) +
          "</td>\n            <td>" +
          (playerAccess.home.last_active
            ? _0x5b26e2.lastActive
            : locales.no_data) +
          "</td>\n            <td><div onclick=\"OpenDetails('employee-details', '" +
          _0x5b26e2.identifier +
          '\')" class="player-btn"><i class="fa-solid fa-chevron-right"></i></div></td>\n        </tr>'
      );
    }
    $("#employees-count").text(_0x3023a0 + "/" + _0x3d5e58.length);
    setTimeout(() => {
      _0x1bf56b.remove();
      $("#employees-list-wrapper").show();
    }, 100);
  };
var Announcements = [];
const SearchAnnouncement = () => {
    let _0x17db19 = [],
      _0x3da400 = $("#search-announcement").val().toLowerCase();
    if (_0x3da400.length < 1) {
      refreshAnnouncements(Announcements);
    } else {
      for (let _0x3aba4c in Announcements) {
        let _0x1e543d = Announcements[_0x3aba4c],
          _0x2f9681 = _0x1e543d.title.toLowerCase();
        _0x2f9681.includes(_0x3da400) && _0x17db19.push(_0x1e543d);
      }
      refreshAnnouncements(_0x17db19);
      _0x17db19 = [];
    }
  },
  AddAnnouncement = () => {
    if (!playerAccess.announcements || !playerAccess.announcements.create) {
      $.post(
        "https://piotreq_gpt/ShowNotification",
        JSON.stringify({ text: locales.no_permission })
      );
      return;
    }
    let _0x4ce80b = $("#add-announcement-title").val();
    if (_0x4ce80b.length < 3 || _0x4ce80b.includes("<script>")) {
      $.post(
        "https://piotreq_gpt/ShowNotification",
        JSON.stringify({ text: locales.title_too_short })
      );
      return;
    }
    let _0xdf76fb = $("#add-announcement-text").val();
    if (_0xdf76fb.length < 5 || _0xdf76fb.includes("<script>")) {
      $.post(
        "https://piotreq_gpt/ShowNotification",
        JSON.stringify({ text: locales.text_too_short })
      );
      return;
    }
    let _0x3f4b22 = $("#add-announcement-check").prop("checked");
    $.post(
      "https://piotreq_gpt/actionData",
      JSON.stringify({
        action: "AddAnnouncement",
        title: _0x4ce80b,
        text: _0xdf76fb,
        important: _0x3f4b22,
      })
    ).then((_0x179b92) => {
      ClosePopup();
      Announcements = _0x179b92;
      refreshAnnouncements(_0x179b92);
    });
  },
  DeleteAnnouncement = (_0x39b82b) => {
    if (!playerAccess.announcements || !playerAccess.announcements.delete) {
      $.post(
        "https://piotreq_gpt/ShowNotification",
        JSON.stringify({ text: locales.no_permission })
      );
      return;
    }
    $.post(
      "https://piotreq_gpt/actionData",
      JSON.stringify({
        action: "DeleteAnnouncement",
        id: _0x39b82b,
      })
    ).then((_0x4478ac) => {
      _0x4478ac &&
        ((Announcements = _0x4478ac), refreshAnnouncements(_0x4478ac));
    });
  },
  refreshAnnouncements = (_0x8a50c5) => {
    $(".announcements-list").empty();
    for (let _0x2b7e9e in _0x8a50c5) {
      let _0x2f3985 = _0x8a50c5[_0x2b7e9e],
        _0x5a96d1 = new Date(_0x2f3985.time * 1000);
      $(".announcements-list").append(
        '\n        <div id="ann-' +
          _0x2f3985.id +
          '" class="announcement ' +
          (_0x2f3985.important == 1 ? "important" : "") +
          '">\n            <div class="announcement-top">\n                <span>' +
          _0x2f3985.title +
          "</span>\n                " +
          (playerAccess.announcements.delete
            ? '<div onclick="DeleteAnnouncement(' +
              _0x2f3985.id +
              ')" class="square-btn"><i class="fa-solid fa-trash-can"></i></div>'
            : "") +
          "\n            </div>\n            <span>" +
          _0x2f3985.text +
          "</span>\n            <span>" +
          _0x2f3985.firstname +
          " " +
          _0x2f3985.lastname +
          ", " +
          formatTime(_0x5a96d1) +
          "</span>\n        </div>"
      );
    }
  };
var selectedCitizensJudgment = {};
const CopyJudge = () => {
    if (Object.keys(selectedOffenses).length < 1) {
      return;
    }
    $.post(
      "https://piotreq_gpt/copyJudge",
      JSON.stringify({ offenses: selectedOffenses })
    );
  },
  ConfirmJudge = () => {
    if (Object.keys(selectedCitizensJudgment).length < 1) {
      return;
    }
    if (Object.keys(selectedOffenses).length < 1) {
      return;
    }
    !playerAccess.judgements &&
      $.post(
        "https://piotreq_gpt/ShowNotification",
        JSON.stringify({ text: locales.no_permission })
      );
    !playerAccess.judgements.fine &&
      parseInt($("#judgment-fine").val()) > 0 &&
      $.post(
        "https://piotreq_gpt/ShowNotification",
        JSON.stringify({ text: locales.no_permission_to_impose_fine })
      );
    !playerAccess.judgements.jail &&
      parseInt($("#judgment-jail").val()) > 0 &&
      $.post(
        "https://piotreq_gpt/ShowNotification",
        JSON.stringify({ text: locales.no_permission_to_impose_jail })
      );
    $.post(
      "https://piotreq_gpt/actionData",
      JSON.stringify({
        action: "ConfirmJudge",
        citizens: selectedCitizensJudgment,
        offenses: selectedOffenses,
        jail: $("#judgment-jail").val(),
        fine: $("#judgment-fine").val(),
      })
    ).then((_0x2ac405) => {
      _0x2ac405 &&
        ((selectedCitizensJudgment = {}),
        (selectedOffenses = {}),
        $("#judgment-players-selected").empty(),
        $("#offenses-list").html(
          '<div class="judgment-list-item"><span>' +
            locales.no_data +
            "...</span></div>"
        ),
        $("#judgment-fine").val(0),
        $("#judgment-jail").val(0));
    });
  },
  RemoveJudgmentCitizen = (_0x3b73bc) => {
    if (!selectedCitizensJudgment[_0x3b73bc]) {
      return;
    }
    delete selectedCitizensJudgment[_0x3b73bc];
    $("#selected-citizen-judgment-" + _0x3b73bc).remove();
  },
  SearchJudgmentCitizen = () => {
    let _0x3f6de6 = $("#search-judgment-citizen").val();
    if (_0x3f6de6.length < 1 || _0x3f6de6.includes("<script>")) {
      $("#judgment-players-list").hide();
      return;
    }
    $.post(
      "https://piotreq_gpt/fetchData",
      JSON.stringify({
        tab: "citizens",
        value: _0x3f6de6,
      })
    ).then((_0x17f9fa) => {
      $("#judgment-players-list").empty();
      if (_0x17f9fa) {
        let _0x2024b2 = 0;
        for (let _0x1d5b0e in _0x17f9fa) {
          _0x2024b2++;
          let _0x4f6edf = _0x17f9fa[_0x1d5b0e],
            _0x88a415 = _0x4f6edf.ssn.toString(),
            _0x4919b3 = $(
              '\n                <div class="judgment-player">\n                    <span>(' +
                _0x88a415 +
                ") " +
                _0x4f6edf.firstname +
                " " +
                _0x4f6edf.lastname +
                "</span>\n                </div>"
            );
          $("#judgment-players-list").prepend(_0x4919b3);
          _0x4919b3.on("click", () => {
            $("#search-judgment-citizen").val("");
            $("#judgment-players-list").css("display", "none");
            selectedCitizensJudgment[_0x88a415] = {
              ssn: _0x4f6edf.ssn,
              identifier: _0x4f6edf.identifier,
              name: _0x4f6edf.firstname + " " + _0x4f6edf.lastname,
            };
            $("#judgment-players-selected").append(
              '\n                    <div class="judgment-list-item" id="selected-citizen-judgment-' +
                _0x88a415 +
                '">\n                        <span>(' +
                _0x88a415 +
                ") " +
                _0x4f6edf.firstname +
                " " +
                _0x4f6edf.lastname +
                "</span>\n                        <i onclick=\"RemoveJudgmentCitizen('" +
                _0x88a415 +
                '\')" class="fa-solid fa-trash-can" style="font-size: .75rem;"></i>\n                    </div>'
            );
          });
        }
        $("#judgment-players-list").css(
          "display",
          _0x2024b2 > 0 ? "flex" : "none"
        );
      }
    });
  };
var Cases = [];
const SearchCases = () => {
    let _0x1aebef = [],
      _0x123a33 = $("#search-case").val().toLowerCase();
    if (_0x123a33.length < 1) {
      refreshCases(Cases);
    } else {
      for (let _0x2f3bb8 in Cases) {
        let _0x3dd22f = Cases[_0x2f3bb8],
          _0x348cfe = _0x3dd22f.title.toLowerCase();
        _0x348cfe.includes(_0x123a33) && _0x1aebef.push(_0x3dd22f);
      }
      refreshCases(_0x1aebef);
      _0x1aebef = [];
    }
  },
  refreshCases = (_0x22058d) => {
    _0x22058d.reverse();
    $("#cases-list-wrapper").html(
      '\n    <table id="cases-list">\n        <tr>\n            <th>' +
        locales.title +
        "</th>\n            <th>" +
        locales.case_number +
        "</th>\n            <th>" +
        locales.case_author +
        "</th>\n            <th>" +
        locales.case_status +
        "</th>\n            <th>" +
        locales.case_creation_date +
        "</th>\n            <th>" +
        locales.case_edit_date +
        '</th>\n            <th style="width: 6%;"></th>\n        </tr>\n    </table>'
    );
    for (let _0x5e98e2 in _0x22058d) {
      let _0x12a476 = _0x22058d[_0x5e98e2];
      $("#cases-list").append(
        "\n        <tr>\n            <td>" +
          _0x12a476.title +
          "</td>\n            <td>#" +
          _0x12a476.id +
          "</td>\n            <td>" +
          _0x12a476.creatorName +
          "</td>\n            <td>" +
          (_0x12a476.status == 0
            ? '<div class="player-status off-duty">' +
              locales.case_unsolved +
              "</div>"
            : '<div class="player-status">' + locales.case_solved + "</div>") +
          "</td>\n            <td>" +
          _0x12a476.create_date +
          "</td>\n            <td>" +
          _0x12a476.edit_date +
          '</td>\n            <td><div id="case-details-' +
          _0x12a476.id +
          '" class="player-btn"><i class="fa-solid fa-chevron-right"></i></div></td>\n        </tr>'
      );
      $("#case-details-" + _0x12a476.id).unbind();
      $("#case-details-" + _0x12a476.id).on("click", () => {
        OpenDetails("case-details", _0x12a476);
      });
    }
  },
  CreateCase = () => {
    if (!playerAccess.cases || !playerAccess.cases.create) {
      return;
    }
    let _0x51faf7 = $("#new-case-title").val();
    if (_0x51faf7.length < 3 || _0x51faf7.includes("<script>")) {
      return;
    }
    let _0x1fa2ea = $("#new-case-text").val();
    if (_0x1fa2ea.length < 10 || _0x1fa2ea.includes("<script>")) {
      return;
    }
    _0x51faf7 = removeTags(_0x51faf7);
    _0x1fa2ea = removeTags(_0x1fa2ea);
    $.post(
      "https://piotreq_gpt/actionData",
      JSON.stringify({
        action: "CreateCase",
        title: _0x51faf7,
        text: _0x1fa2ea,
        citizens: selectedCitizensCase,
        vehicles: selectedVehiclesCase,
        officers: selectedOfficersCase,
        photos: attachedPhotosCase,
      })
    ).then((_0x42c191) => {
      _0x42c191 &&
        (refreshCases(_0x42c191), (Cases = _0x42c191), CloseDetails());
    });
  },
  RemoveCaseCitizen = (_0x729550) => {
    selectedCitizensCase[_0x729550] &&
      (delete selectedCitizensCase[_0x729550],
      $("#selected-citizen-case-" + _0x729550).remove());
  },
  SearchCaseCitizen = () => {
    let _0x514156 = $("#search-case-citizen").val();
    if (_0x514156.length < 3 || _0x514156.includes("<script>")) {
      $("#searched-case-citizens").hide();
      return;
    }
    $.post(
      "https://piotreq_gpt/fetchData",
      JSON.stringify({
        tab: "citizens",
        value: _0x514156,
      })
    ).then((_0x1aaa44) => {
      $("#searched-case-citizens").empty();
      if (_0x1aaa44) {
        let _0x4684ab = 0;
        for (let _0x1f0d9c in _0x1aaa44) {
          _0x4684ab++;
          let _0xa91a6 = _0x1aaa44[_0x1f0d9c],
            _0x3beaf3 = _0xa91a6.ssn.toString(),
            _0x413fae = $(
              '\n                <div class="judgment-player">\n                    <span>(' +
                _0x3beaf3 +
                ") " +
                _0xa91a6.firstname +
                " " +
                _0xa91a6.lastname +
                "</span>\n                </div>"
            );
          $("#searched-case-citizens").prepend(_0x413fae);
          _0x413fae.on("click", () => {
            if (selectedCitizensCase[_0x3beaf3]) {
              return;
            }
            $("#search-case-citizen").val("");
            $("#searched-case-citizens").css("display", "none");
            selectedCitizensCase[_0x3beaf3] = {
              ssn: _0xa91a6.ssn,
              identifier: _0xa91a6.identifier,
              name: _0xa91a6.firstname + " " + _0xa91a6.lastname,
            };
            $("#create-case-citizens").append(
              '\n                    <div class="judgment-list-item" id="selected-citizen-case-' +
                _0x3beaf3 +
                '">\n                        <span>(' +
                _0x3beaf3 +
                ") " +
                _0xa91a6.firstname +
                " " +
                _0xa91a6.lastname +
                "</span>\n                        <i onclick=\"RemoveCaseCitizen('" +
                _0x3beaf3 +
                '\')" class="fa-solid fa-trash-can" style="font-size: .75rem;"></i>\n                    </div>'
            );
          });
        }
        $("#searched-case-citizens").css(
          "display",
          _0x4684ab > 0 ? "flex" : "none"
        );
      }
    });
  },
  RemoveCaseOfficer = (_0x27c6d1) => {
    selectedOfficersCase[_0x27c6d1] &&
      (delete selectedOfficersCase[_0x27c6d1],
      $("#selected-officer-case-" + _0x27c6d1).remove());
  },
  SearchCaseOfficers = () => {
    let _0x3a7771 = $("#search-case-officer").val();
    if (_0x3a7771.length < 3 || _0x3a7771.includes("<script>")) {
      $("#searched-case-officers").hide();
      return;
    }
    $.post(
      "https://piotreq_gpt/fetchData",
      JSON.stringify({
        tab: "employees",
        value: _0x3a7771,
      })
    ).then((_0x4e0940) => {
      $("#searched-case-officers").empty();
      if (_0x4e0940) {
        let _0x2c6120 = 0;
        for (let _0x3d0928 in _0x4e0940) {
          _0x2c6120++;
          let _0x2f7380 = _0x4e0940[_0x3d0928],
            _0x141a53 = _0x2f7380.ssn.toString(),
            _0x1095c8 = $(
              '\n                <div class="judgment-player">\n                    <span>(' +
                _0x141a53 +
                ") " +
                _0x2f7380.firstname +
                " " +
                _0x2f7380.lastname +
                " [" +
                _0x2f7380.job +
                "]</span>\n                </div>"
            );
          $("#searched-case-officers").prepend(_0x1095c8);
          _0x1095c8.on("click", () => {
            if (selectedOfficersCase[_0x141a53]) {
              return;
            }
            $("#search-case-officer").val("");
            $("#searched-case-officers").css("display", "none");
            selectedOfficersCase[_0x141a53] = {
              ssn: _0x2f7380.ssn,
              identifier: _0x2f7380.identifier,
              name: _0x2f7380.firstname + " " + _0x2f7380.lastname,
            };
            $("#create-case-officers").append(
              '\n                    <div class="judgment-list-item" id="selected-officer-case-' +
                _0x141a53 +
                '">\n                        <span>(' +
                _0x141a53 +
                ") " +
                _0x2f7380.firstname +
                " " +
                _0x2f7380.lastname +
                " [" +
                _0x2f7380.job +
                "]</span>\n                        <i onclick=\"RemoveCaseOfficer('" +
                _0x141a53 +
                '\')" class="fa-solid fa-trash-can" style="font-size: .75rem;"></i>\n                    </div>'
            );
          });
        }
        $("#searched-case-officers").css(
          "display",
          _0x2c6120 > 0 ? "flex" : "none"
        );
      }
    });
  },
  RemoveCaseVehicle = (_0x402aaf) => {
    selectedVehiclesCase[_0x402aaf] &&
      (delete selectedVehiclesCase[_0x402aaf],
      $("#selected-vehicle-case-" + _0x402aaf).remove());
  },
  SearchCaseVehicles = () => {
    let _0x3a55e3 = $("#search-case-vehicle").val();
    if (_0x3a55e3.length < 3 || _0x3a55e3.includes("<script>")) {
      $("#searched-case-vehicles").hide();
      return;
    }
    $.post(
      "https://piotreq_gpt/fetchData",
      JSON.stringify({
        tab: "vehicles",
        value: _0x3a55e3,
        isCase: true,
      })
    ).then((_0x31accd) => {
      $("#searched-case-vehicles").empty();
      if (_0x31accd) {
        let _0x44115d = 0;
        for (let _0x523676 in _0x31accd) {
          _0x44115d++;
          let _0x17172f = _0x31accd[_0x523676],
            _0x119f71 = $(
              '\n                <div class="judgment-player">\n                    <span>(' +
                _0x17172f.plate +
                ") " +
                _0x17172f.model +
                "</span>\n                </div>"
            );
          $("#searched-case-vehicles").prepend(_0x119f71);
          _0x119f71.on("click", () => {
            if (selectedVehiclesCase[_0x17172f.vin]) {
              return;
            }
            $("#search-case-vehicle").val("");
            $("#searched-case-vehicles").css("display", "none");
            selectedVehiclesCase[_0x17172f.vin] = {
              vin: _0x17172f.vin,
              plate: _0x17172f.plate,
            };
            $("#create-case-vehicles").append(
              '\n                    <div class="judgment-list-item" id="selected-vehicle-case-' +
                _0x17172f.vin +
                '">\n                        <span>(' +
                _0x17172f.plate +
                ") " +
                _0x17172f.model +
                "</span>\n                        <i onclick=\"RemoveCaseVehicle('" +
                _0x17172f.vin +
                '\')" class="fa-solid fa-trash-can" style="font-size: .75rem;"></i>\n                    </div>'
            );
          });
        }
        $("#searched-case-vehicles").css(
          "display",
          _0x44115d > 0 ? "flex" : "none"
        );
      }
    });
  };
let casePhotoId = 0;
const RemoveCasePhoto = (_0x6f0dc3) => {
    _0x6f0dc3 = _0x6f0dc3.toString();
    if (!attachedPhotosCase[_0x6f0dc3]) {
      return;
    }
    delete attachedPhotosCase[_0x6f0dc3];
    $("#case-photo-" + _0x6f0dc3).remove();
  },
  AddCasePhoto = () => {
    let _0x2f93eb = $("#add-case-photo-url").val();
    if (_0x2f93eb.length < 1 || _0x2f93eb.includes("<script>")) {
      return;
    }
    casePhotoId++;
    attachedPhotosCase[casePhotoId.toString()] = _0x2f93eb;
    $("#new-case-photos").prepend(
      '\n    <div class="judgment-list-item case-photo" id="case-photo-' +
        casePhotoId +
        '">\n        <span onclick="RemoveCasePhoto(\'' +
        casePhotoId +
        '\')"><i class="fa-solid fa-trash-can"></i></span>\n        <img src="' +
        _0x2f93eb +
        '" alt="">\n    </div>'
    );
    $("#add-case-photo-url").val("");
    ClosePopup();
  },
  CaseCreator = () => {
    if (!playerAccess.cases || !playerAccess.cases.create) {
      $.post(
        "https://piotreq_gpt/ShowNotification",
        JSON.stringify({ text: locales.no_permission })
      );
      return;
    }
    $("#case-details").html(
      '\n    <div class="top-bar">\n        <div class="square-btn" onclick="CloseDetails()"><i class="fa-solid fa-chevron-left"></i></div>\n        <span>' +
        locales.create_case +
        '</span>\n    </div>\n    <div class="vehicle-details-wrapper">\n            <div class="vehicle-details-box" id="case-details-info">\n                <div class="vehicle-details-row">\n                    <span>' +
        locales.title +
        '</span>\n                    <input type="text" id="new-case-title" placeholder="' +
        locales.case_title_placeholder +
        '">\n                </div>\n                <div class="vehicle-btn" onclick="CreateCase()" style="width: fit-content; margin-top: .5rem;">' +
        locales.create +
        '</div>\n            </div>\n            <div class="vehicle-details-box" id="case-desc-info">\n                <span>' +
        locales.case_description +
        '</span>\n                <textarea id="new-case-text" placeholder="' +
        locales.case_description_placeholder +
        '"></textarea>\n            </div>\n        <div class="vehicle-details-box" id="vehicle-wanted">\n            <span>' +
        locales.case_related_citizens +
        '</span>\n            <div class="judgment-list" id="create-case-citizens">\n            </div>\n            <div class="gpt-input judgment-input">\n                <input type="text" id="search-case-citizen" oninput="SearchCaseCitizen()" placeholder="' +
        locales.search_case_citizen_placeholder +
        '">\n                <i class="fa-solid fa-user"></i>\n                <div class="judgment-players" id="searched-case-citizens">\n                </div>\n            </div>\n        </div>\n        <div class="vehicle-details-box" id="vehicle-wanted">\n            <span>' +
        locales.case_related_officers +
        '</span>\n            <div class="judgment-list" id="create-case-officers">\n            </div>\n            <div class="gpt-input judgment-input">\n                <input type="text" id="search-case-officer" oninput="SearchCaseOfficers()" placeholder="' +
        locales.search_case_officer_placeholder +
        '">\n                <i class="fa-solid fa-user-police"></i>\n                <div class="judgment-players" id="searched-case-officers">\n                </div>\n            </div>\n        </div>\n        <div class="vehicle-details-box" id="vehicle-wanted">\n            <span>' +
        locales.case_related_vehicles +
        '</span>\n            <div class="judgment-list" id="create-case-vehicles">\n            </div>\n            <div class="gpt-input judgment-input">\n                <input type="text" id="search-case-vehicle" oninput="SearchCaseVehicles()" placeholder="' +
        locales.search_case_vehicle_placeholder +
        '">\n                <i class="fa-solid fa-cars"></i>\n                <div class="judgment-players" id="searched-case-vehicles">\n                </div>\n            </div>\n        </div>\n        <div class="vehicle-details-box" id="vehicle-wanted">\n            <span>' +
        locales.case_photos +
        '</span>\n            <div class="judgment-list" id="new-case-photos">\n                <div class="judgment-list-item case-photo" onclick="OpenPopup(\'add-case-photo-popup\')">\n                    <i class="fa-thin fa-circle-plus" style="font-size: 5rem; opacity: 0.5"></i>\n                </div>\n            </div>\n        </div>\n    </div>'
    );
    OpenDetails("case-details");
  };
var Radios = {};
refreshRadios = (radios) => {
  $("#radios-list").hide();
  let _0x1bf56b = $(
    '<div class="loader-wrapper"><span class="loader"></span></div>'
  );
  $("#radios-wrapper").append(_0x1bf56b);
  radios.sort((a, b) => {
    if (a.owner === b.owner) {
      return a.channel - b.channel; // sort descending by channel
    }
    return a.owner ? -1 : 1;
  })
  $("#radio-list").html(`<tbody id="radiolist" style="position: relative; top: -20px">
    <tr style="opacity: 0;">
          <th style="width: 12%;"></th>
          <th></th>
          <th style="width: 6%;"></th>
      </tr>
  </tbody>`);
  for (let radio in radios) {
    let radiodata = radios[radio];
    $("#radiolist").append(`
      <tr style="height: 2vh">
          <th style="text-align: left">${radiodata.name}</th>
      </tr>  
    `);
    radiodata.users.forEach((user) => {
      $("#radiolist").append(`
        <tr>
            <td style="display:flex; gap:5px;">
              <div class="player-btn" style="width: fit-content;"><span style="margin-left: 5px;margin-right: 5px;">${user.job}</span></div>
              <div class="player-btn"  style="width: fit-content;"><span style="margin-left: 5px;margin-right: 5px;">${user.badge}</span></div>
            </td>
            <td  style="text-align: left">${user.name}</td>
            <td></td>
        </tr>
      `);
    })
  }
  setTimeout(() => {
    _0x1bf56b.remove();
    $("#radios-list").show();
  }, 100);
};
var Evidences = [];
const searchEvidence = () => {
    let _0x54a046 = [],
      _0x10daf4 = $("#search-evidence").val().toLowerCase();
    if (_0x10daf4.length < 1) {
      refreshEvidences(Evidences);
    } else {
      for (let _0x188c8b in Evidences) {
        let _0x27e036 = Evidences[_0x188c8b],
          _0x420817 = _0x27e036.type.toLowerCase(),
          _0x1c87ad = _0x27e036.data.toLowerCase();
        (_0x420817.includes(_0x10daf4) || _0x1c87ad.includes(_0x10daf4)) &&
          _0x54a046.push(_0x27e036);
      }
      refreshEvidences(_0x54a046);
      _0x54a046 = [];
    }
  },
  reloadEvidences = () => {
    $.post(
      "https://piotreq_gpt/fetchData",
      JSON.stringify({ tab: "evidence" })
    ).then((_0x1b173c) => {
      Evidences = _0x1b173c;
      refreshEvidences(_0x1b173c);
    });
  },
  refreshEvidences = (_0x205c63) => {
    _0x205c63.reverse();
    $("#evidence-list-wrapper").html(
      '\n    <table id="evidences-list">\n        <tr>\n            <th>' +
        locales.evidence_type +
        "</th>\n            <th>" +
        locales.evidence_data +
        "</th>\n            <th>" +
        locales.evidence_identifier +
        "</th>\n            <th>" +
        locales.evidence_added_date +
        "</th>\n        </tr>\n    </table>"
    );
    for (let _0x41e7f6 in _0x205c63) {
      let _0x6f5204 = _0x205c63[_0x41e7f6];
      $("#evidences-list").append(
        "\n            <tr>\n                <td>" +
          _0x6f5204.type +
          "</td>\n                <td>" +
          _0x6f5204.data +
          "</td>\n                <td>" +
          _0x6f5204.serial +
          "</td>\n                <td>" +
          formatTime(_0x6f5204.time * 1000) +
          "</td>\n            </tr>"
      );
    }
  },
  SearchWeapons = () => {
    let _0x3700c9 = $("#weapons-search").val();
    if (_0x3700c9.length < 3) {
      return;
    }
    $("#weapons-list-wrapper").html(
      '\n        <div class="loader-wrapper">\n            <span class="loader"></span>\n        </div>'
    );
    setTimeout(() => {
      $.post(
        "https://piotreq_gpt/fetchData",
        JSON.stringify({
          tab: "weapons",
          value: _0x3700c9,
        })
      ).then((_0x1aa913) => {
        $("#weapons-list-wrapper").html(
          '\n            <table id="weapons-list">\n                <tr>\n                    <th>' +
            locales.model +
            "</th>\n                    <th>" +
            locales.owner +
            "</th>\n                    <th>" +
            locales.serial_number +
            "</th>\n                    <th>" +
            locales.release_date +
            '</th>\n                    <th style="width: 6%;"></th>\n                </tr>\n            </table>'
        );
        refreshWeapons(_0x1aa913);
      });
    }, 250);
  },
  refreshWeapons = (_0x66b1be) => {
    for (let _0x3cee2d in _0x66b1be) {
      let _0x5bf6c0 = _0x66b1be[_0x3cee2d];
      $("#weapons-list").append(
        "\n            <tr>\n                <td>" +
          _0x5bf6c0.model +
          "</td>\n                <td>" +
          _0x5bf6c0.firstname +
          " " +
          _0x5bf6c0.lastname +
          "</td>\n                <td>" +
          _0x5bf6c0.serial +
          "</td>\n                <td>" +
          formatTime(_0x5bf6c0.time * 1000) +
          "</td>\n                <td><div onclick=\"OpenDetails('citizen-details', '" +
          _0x5bf6c0.owner +
          '\')" class="player-btn"><i class="fa-solid fa-chevron-right"></i></div></td>\n            </tr>'
      );
    }
  },
  ConfiscateVehicle = () => {
    if (!activeVehicle.vin) {
      return;
    }
    let _0x1e67d0 = $("#confiscate-vehicle-reason").val();
    if (_0x1e67d0.length < 1 || _0x1e67d0.includes("<script>")) {
      return;
    }
    let _0x226ae3 = parseInt($("#confiscate-vehicle-price").val());
    if (_0x226ae3 < 1) {
      return;
    }
    let _0x5ee165 = parseInt($("#confiscate-vehicle-days").val());
    if (_0x5ee165 < 1) {
      return;
    }
    _0x1e67d0 = removeTags(_0x1e67d0);
    $.post(
      "https://piotreq_gpt/actionData",
      JSON.stringify({
        action: "ConfiscateVehicle",
        vin: activeVehicle.vin,
        reason: _0x1e67d0,
        price: _0x226ae3,
        days: _0x5ee165,
      })
    ).then((_0x51bff9) => {
      $("#vehicle-status").text(locales.confiscated);
      ClosePopup();
      $(
        "#confiscate-vehicle-reason, #confiscate-vehicle-price, #confiscate-vehicle-days"
      ).val("");
    });
  },
  SearchVehicles = () => {
    let _0x2b8262 = $("#vehicles-search").val();
    if (_0x2b8262.length < 3) {
      return;
    }
    $("#vehicles-list-wrapper").html(
      '\n        <div class="loader-wrapper">\n            <span class="loader"></span>\n        </div>'
    );
    setTimeout(() => {
      $.post(
        "https://piotreq_gpt/fetchData",
        JSON.stringify({
          tab: "vehicles",
          value: _0x2b8262,
        })
      ).then((_0x51909a) => {
        $("#vehicles-list-wrapper").html(
          '\n            <table id="vehicles-list">\n                <tr>\n                    <th>' +
            locales.model +
            "</th>\n                    <th>" +
            locales.owner +
            "</th>\n                    <th>" +
            locales.coowner +
            "</th>\n                    <th>" +
            locales.vin +
            "</th>\n                    <th>" +
            locales.plate +
            "</th>\n                    <th>" +
            locales.wanted +
            '</th>\n                    <th style="width: 6%;"></th>\n                </tr>\n            </table>'
        );
        refreshVehicles(_0x51909a);
      });
    }, 250);
  },
  DeleteVehicleWanted = (_0x6a527b) => {
    $.post(
      "https://piotreq_gpt/actionData",
      JSON.stringify({
        action: "DeleteVehicleWanted",
        id: _0x6a527b,
      })
    ).then((_0x3bbd88) => {
      _0x3bbd88 && $("#vehicle-wanted-" + _0x6a527b).remove();
    });
  },
  AddVehicleWanted = () => {
    if (!activeVehicle.vin) {
      return;
    }
    let _0x34f5f5 = $("#add-vehicle-wanted-text").val();
    if (_0x34f5f5.length < 1 || _0x34f5f5.includes("<script>")) {
      return;
    }
    let _0x5e1d0c = parseInt($("#add-vehicle-wanted-days").val());
    if (_0x5e1d0c < 1) {
      return;
    }
    let _0x3c48e2 = $("#add-vehicle-wanted-important").prop("checked");
    _0x34f5f5 = removeTags(_0x34f5f5);
    $.post(
      "https://piotreq_gpt/actionData",
      JSON.stringify({
        action: "AddVehicleWanted",
        vin: activeVehicle.vin,
        days: _0x5e1d0c,
        text: _0x34f5f5,
        important: _0x3c48e2,
      })
    ).then((_0x472926) => {
      if (_0x472926) {
        let _0x2ab7b9 = new Date(),
          _0x1b220d = $(
            '\n            <div class="vehicle-details-wanted ' +
              (_0x3c48e2 ? "important" : "") +
              '" id="vehicle-wanted-' +
              _0x472926.id +
              '">\n                <div>\n                    <span>' +
              _0x472926.name +
              "</span>\n                    " +
              (playerAccess.vehicles.delete_wanted
                ? '<i onclick="DeleteVehicleWanted(' +
                  _0x472926.id +
                  ')" class="fa-solid fa-trash-can"></i>'
                : "") +
              "\n                </div>\n                <span>" +
              _0x34f5f5 +
              "</span>\n                <span>" +
              locales.added +
              ": " +
              formatTime(_0x2ab7b9) +
              ", " +
              locales.active_to +
              ": " +
              formatTime(_0x472926.expire * 1000) +
              "</span>\n            </div>"
          );
        _0x1b220d.insertAfter("#vehicle-wanted-list > span");
      }
      ClosePopup();
      $("#add-vehicle-note-title").val("");
      $("#add-vehicle-note-text").val("");
      $("#add-vehicle-note-important").prop("checked", false);
    });
  },
  DeleteVehicleNote = (_0x28f0d4) => {
    $.post(
      "https://piotreq_gpt/actionData",
      JSON.stringify({
        action: "DeleteVehicleNote",
        id: _0x28f0d4,
      })
    ).then((_0x325388) => {
      _0x325388 && $("#vehicle-note-" + _0x28f0d4).remove();
    });
  },
  AddVehicleNote = () => {
    if (!activeVehicle.vin) {
      return;
    }
    let _0x223fce = $("#add-vehicle-note-text").val();
    if (_0x223fce.length < 1 || _0x223fce.includes("<script>")) {
      return;
    }
    let _0x50014b = $("#add-vehicle-note-important").prop("checked");
    _0x223fce = removeTags(_0x223fce);
    $.post(
      "https://piotreq_gpt/actionData",
      JSON.stringify({
        action: "AddVehicleNote",
        vin: activeVehicle.vin,
        text: _0x223fce,
        important: _0x50014b,
      })
    ).then((_0x3d46c2) => {
      if (_0x3d46c2) {
        let _0x5dfec6 = new Date(),
          _0x58a559 = $(
            '\n            <div class="vehicle-details-note ' +
              (_0x50014b ? "important" : "") +
              '" id="vehicle-note-' +
              _0x3d46c2.id +
              '">\n                <div>\n                    <span>' +
              _0x3d46c2.name +
              "</span>\n                     " +
              (playerAccess.vehicles.delete_note
                ? '<i onclick="DeleteVehicleNote(' +
                  _0x3d46c2.id +
                  ')" class="fa-solid fa-trash-can"></i>'
                : "") +
              "\n                </div>\n                <span>" +
              _0x223fce +
              "</span>\n                <span>" +
              locales.added +
              ": " +
              formatTime(_0x5dfec6) +
              "</span>\n            </div>"
          );
        _0x58a559.insertAfter("#vehicle-notes-list > span");
      }
      ClosePopup();
      $("#add-vehicle-note-title, #add-vehicle-note-text").val("");
      $("#add-vehicle-note-important").prop("checked", false);
    });
  },
  refreshVehicles = (_0x178193) => {
    for (let _0x191e12 in _0x178193) {
      let _0x517119 = _0x178193[_0x191e12];
      $("#vehicles-list").append(
        "\n            <tr>\n                <td>" +
          _0x517119.model +
          "</td>\n                <td>" +
          _0x517119.ofname +
          " " +
          _0x517119.olname +
          "</td>\n                <td>" +
          (_0x517119.co_owner
            ? _0x517119.cofname + " " + _0x517119.colname
            : locales.no_data) +
          "</td>\n                <td>" +
          _0x517119.vin +
          "</td>\n                <td>" +
          _0x517119.plate +
          "</td>\n                <td>" +
          (_0x517119.wanted
            ? '<div class="citizen-wanted wanted">' + locales.yes + "</div>"
            : '<div class="citizen-wanted">' + locales.no + "</div>") +
          '</td>\n                <td><div id="vehicle-open-details-' +
          _0x191e12 +
          '" class="player-btn"><i class="fa-solid fa-chevron-right"></i></div></td>\n            </tr>'
      );
      $("#vehicle-open-details-" + _0x191e12).unbind();
      $("#vehicle-open-details-" + _0x191e12).on("click", () => {
        OpenDetails("vehicle-details", _0x517119);
      });
    }
  },
  SetCitizenPhoto = () => {
    if (!activeCitizen.identifier) {
      return;
    }
    if (!playerAccess.citizens || !playerAccess.citizens.set_photo) {
      $.post(
        "https://piotreq_gpt/ShowNotification",
        JSON.stringify({ text: locales.no_permission })
      );
      return;
    }
    let _0x4a7df2 = $("#set-citizen-photo-url").val();
    if (_0x4a7df2.length < 1 || _0x4a7df2.includes("<script>")) {
      return;
    }
    _0x4a7df2 = removeTags(_0x4a7df2);
    $.post(
      "https://piotreq_gpt/actionData",
      JSON.stringify({
        action: "SetCitizenPhoto",
        player: activeCitizen.identifier,
        photo: _0x4a7df2,
      })
    ).then((_0x387624) => {
      _0x387624 &&
        $("#citizen-details-photo").css(
          "background",
          "center / cover no-repeat url(" + _0x4a7df2 + ")"
        );
    });
  },
  DeleteCitizenLicense = (_0x3b984c) => {
    $.post(
      "https://piotreq_gpt/actionData",
      JSON.stringify({
        action: "DeleteCitizenLicense",
        id: _0x3b984c,
      })
    ).then((_0x2fb845) => {
      if (_0x2fb845) {
        for (let _0x1d362d in activeCitizen.licenses) {
          let _0x41f303 = activeCitizen.licenses[_0x1d362d];
          if (_0x41f303 && _0x41f303.id && _0x41f303.id == _0x3b984c) {
            delete activeCitizen.licenses[_0x1d362d];
            break;
          }
        }
        $("#citizen-license-" + _0x3b984c).remove();
      }
    });
  },
  AddCitizenLicense = () => {
    if (!activeCitizen.identifier) {
      return;
    }
    if (!playerAccess.citizens || !playerAccess.citizens.add_license) {
      $.post(
        "https://piotreq_gpt/ShowNotification",
        JSON.stringify({ text: locales.no_permission })
      );
      return;
    }
    let _0x1ec4df = $("#add-license-citizen-value").attr("data-value");
    if (!_0x1ec4df) {
      return;
    }
    let _0x89d073 = gptLicenses.citizen[_0x1ec4df];
    if (!_0x89d073) {
      console.log("[ERROR] License " + _0x1ec4df + " don't have a name");
      return;
    }
    let _0x44b180 = false;
    for (let _0x5ae8a7 in activeCitizen.licenses) {
      let _0xe59475 = activeCitizen.licenses[_0x5ae8a7];
      if (_0xe59475 && _0xe59475.type && _0xe59475.type == _0x1ec4df) {
        _0x44b180 = true;
        break;
      }
    }
    if (_0x44b180) {
      $.post(
        "https://piotreq_gpt/ShowNotification",
        JSON.stringify({ text: locales.player_has_this_license })
      );
      return;
    }
    $.post(
      "https://piotreq_gpt/actionData",
      JSON.stringify({
        action: "AddCitizenLicense",
        license: _0x1ec4df,
        name: _0x89d073.label,
        player: activeCitizen.identifier,
      })
    ).then((_0x411324) => {
      _0x411324 &&
        (activeCitizen.licenses.push({
          id: _0x411324.id,
          type: _0x1ec4df,
          label: _0x89d073.label,
        }),
        $("#citizen-licenses-list").prepend(
          '\n            <div class="citizen-vehicle citizen-license" id="citizen-license-' +
            _0x411324.id +
            '">\n                <div class="citizen-vehicle-top">\n                    <span>' +
            _0x89d073.label +
            "</span>\n                    " +
            (playerAccess.citizens.delete_license
              ? '<i onclick="DeleteCitizenLicense(' +
                _0x411324.id +
                ')" class="fa-solid fa-trash-can"></i>'
              : "") +
            "\n                </div>\n            </div>"
        ));
      ClosePopup();
      $("#add-license-citizen-value").attr("data-value", null);
      $("#add-license-citizen-value").text(locales.select_license);
    });
  },
  DeleteCitizenWanted = (_0x446e45) => {
    if (!playerAccess.citizens || !playerAccess.citizens.delete_wanted) {
      $.post(
        "https://piotreq_gpt/ShowNotification",
        JSON.stringify({ text: locales.no_permission })
      );
      return;
    }
    $.post(
      "https://piotreq_gpt/actionData",
      JSON.stringify({
        action: "DeleteCitizenWanted",
        id: _0x446e45,
      })
    ).then((_0x1a397b) => {
      _0x1a397b && $("#citizen-wanted-" + _0x446e45).remove();
    });
  },
  AddCitizenWanted = () => {
    if (!activeCitizen.identifier) {
      return;
    }
    if (!playerAccess.citizens || !playerAccess.citizens.add_wanted) {
      $.post(
        "https://piotreq_gpt/ShowNotification",
        JSON.stringify({ text: locales.no_permission })
      );
      return;
    }
    let _0x179562 = $("#citizen-wanted-title").val();
    if (_0x179562.length < 3 || _0x179562.includes("<script>")) {
      $.post(
        "https://piotreq_gpt/ShowNotification",
        JSON.stringify({ text: locales.title_too_short })
      );
      return;
    }
    let _0x25f53e = $("#citizen-wanted-text").val();
    if (_0x179562.length < 5 || _0x179562.includes("<script>")) {
      $.post(
        "https://piotreq_gpt/ShowNotification",
        JSON.stringify({ text: locales.text_too_short })
      );
      return;
    }
    let _0x23665b = $("#citizen-wanted-days").val();
    if (_0x23665b.length < 1 || _0x23665b < 1) {
      return;
    }
    let _0x469620 = $("#citizen-wanted-important").prop("checked");
    _0x179562 = removeTags(_0x179562);
    _0x25f53e = removeTags(_0x25f53e);
    $.post(
      "https://piotreq_gpt/actionData",
      JSON.stringify({
        action: "AddCitizenWanted",
        player: activeCitizen.identifier,
        title: _0x179562,
        text: _0x25f53e,
        important: _0x469620,
        days: _0x23665b,
      })
    ).then((_0x2029a6) => {
      if (_0x2029a6) {
        let _0x423ca2 = new Date(),
          _0x3ff92b = new Date(_0x2029a6.expire);
        $("#citizen-wanted-list").prepend(
          '\n            <div class="citizen-vehicle citizen-note ' +
            (_0x469620 ? "important" : "") +
            '" id="citizen-wanted-' +
            _0x2029a6.id +
            '">\n                <div class="citizen-vehicle-top">\n                    <span>' +
            _0x179562 +
            "</span>\n                    " +
            (playerAccess.citizens.delete_note
              ? '<i onclick="DeleteCitizenWanted(' +
                _0x2029a6.id +
                ')" class="fa-solid fa-trash-can"></i>'
              : "") +
            "\n                </div>\n                <span>" +
            _0x25f53e +
            "</span>\n                <span>" +
            _0x2029a6.name +
            " " +
            formatTime(_0x423ca2) +
            ", " +
            locales.to_when +
            ": " +
            formatTime(_0x3ff92b) +
            "</span>\n            </div>"
        );
      }
    });
    $("#citizen-wanted-title, #citizen-wanted-text, #citizen-wanted-days").val(
      ""
    );
    $("#citizen-wanted-important").prop("checked", false);
    ClosePopup();
  },
  DeleteCitizenNote = (_0x2f8765) => {
    if (!playerAccess.citizens || !playerAccess.citizens.delete_note) {
      $.post(
        "https://piotreq_gpt/ShowNotification",
        JSON.stringify({ text: locales.no_permission })
      );
      return;
    }
    $.post(
      "https://piotreq_gpt/actionData",
      JSON.stringify({
        action: "DeleteCitizenNote",
        id: _0x2f8765,
      })
    ).then((_0x434d55) => {
      _0x434d55 && $("#citizen-note-" + _0x2f8765).remove();
    });
  },
  AddCitizenNote = () => {
    if (!activeCitizen.identifier) {
      return;
    }
    if (!playerAccess.citizens || !playerAccess.citizens.add_note) {
      $.post(
        "https://piotreq_gpt/ShowNotification",
        JSON.stringify({ text: locales.no_permission })
      );
      return;
    }
    let _0x42b036 = $("#citizen-note-title").val();
    if (_0x42b036.length < 3 || _0x42b036.includes("<script>")) {
      $.post(
        "https://piotreq_gpt/ShowNotification",
        JSON.stringify({ text: locales.title_too_short })
      );
      return;
    }
    let _0x432efe = $("#citizen-note-text").val();
    if (_0x42b036.length < 5 || _0x42b036.includes("<script>")) {
      $.post(
        "https://piotreq_gpt/ShowNotification",
        JSON.stringify({ text: locales.text_too_short })
      );
      return;
    }
    let _0x1acdef = $("#citizen-note-important").prop("checked");
    _0x42b036 = removeTags(_0x42b036);
    _0x432efe = removeTags(_0x432efe);
    $.post(
      "https://piotreq_gpt/actionData",
      JSON.stringify({
        action: "AddCitizenNote",
        player: activeCitizen.identifier,
        title: _0x42b036,
        text: _0x432efe,
        important: _0x1acdef,
      })
    ).then((_0x161476) => {
      if (_0x161476) {
        let _0x384839 = new Date();
        $("#citizen-notes-list").prepend(
          '\n            <div class="citizen-vehicle ' +
            (_0x1acdef ? "important" : "") +
            ' citizen-note" id="citizen-note-' +
            _0x161476.id +
            '">\n                <div class="citizen-vehicle-top">\n                    <span>' +
            _0x42b036 +
            "</span>\n                    " +
            (playerAccess.citizens.delete_note
              ? '<i onclick="DeleteCitizenNote(' +
                _0x161476.id +
                ')" class="fa-solid fa-trash-can"></i>'
              : "") +
            "\n                </div>\n                <span>" +
            _0x432efe +
            "</span>\n                <span>" +
            _0x161476.name +
            " " +
            formatTime(_0x384839) +
            "</span>\n            </div>"
        );
      }
    });
    $("#citizen-note-title, #citizen-note-text").val("");
    $("#citizen-note-important").prop("checked", false);
    ClosePopup();
  },
  SearchCitizens = () => {
    let _0x50096a = $("#citizens-search").val();
    if (_0x50096a.length < 1) {
      return;
    }
    $("#citizens-list-wrapper").html(
      '\n        <div class="loader-wrapper">\n            <span class="loader"></span>\n        </div>'
    );
    setTimeout(() => {
      $.post(
        "https://piotreq_gpt/fetchData",
        JSON.stringify({
          tab: "citizens",
          value: _0x50096a,
        })
      ).then((_0x53381f) => {
        $("#citizens-list-wrapper").html(
          '\n            <table id="citizens-list">\n                <tr>\n                    <th>' +
            locales.full_name +
            "</th>\n                    <th>" +
            locales.ssn +
            "</th>\n                    <th>" +
            locales.dateofbirth +
            "</th>\n                    <th>" +
            locales.job +
            "</th>\n                    <th>" +
            locales.wanted +
            '</th>\n                    <th style="width: 6%;"></th>\n                </tr>\n            </table>'
        );
        refreshCitizens(_0x53381f);
      });
    }, 250);
  },
  refreshCitizens = (_0x57a06a) => {
    for (let _0x57f0ca in _0x57a06a) {
      let _0x133037 = _0x57a06a[_0x57f0ca];
      $("#citizens-list").append(
        '\n        <tr>\n            <td class="citizen-name"><div class="citizen-avatar" ' +
          (_0x133037.photo
            ? 'style="background: center / cover no-repeat url(' +
              _0x133037.photo +
              ')"'
            : "") +
          "></div>" +
          _0x133037.firstname +
          " " +
          _0x133037.lastname +
          "</td>\n            <td>" +
          _0x133037.ssn +
          "</td>\n            <td>" +
          _0x133037.dob +
          "</td>\n            <td>" +
          _0x133037.job +
          "</td>\n            <td>" +
          (_0x133037.wanted
            ? '<div class="citizen-wanted wanted">' + locales.yes + "</div>"
            : '<div class="citizen-wanted">' + locales.no + "</div>") +
          "</td>\n            <td><div onclick=\"OpenDetails('citizen-details', '" +
          _0x133037.identifier +
          '\')" class="player-btn"><i class="fa-solid fa-chevron-right"></i></div></td>\n        </tr>'
      );
    }
  },
  KickPatrol = (_0x27d050) => {
    $.post(
      "https://piotreq_gpt/actionData",
      JSON.stringify({
        action: "KickPatrol",
        member: _0x27d050,
      })
    );
  },
  JoinPatrol = (_0x30b5eb) => {
    if (!playerAccess.patrols || !playerAccess.patrols.join) {
      $.post(
        "https://piotreq_gpt/ShowNotification",
        JSON.stringify({ text: locales.no_permission })
      );
      return;
    }
    $.post(
      "https://piotreq_gpt/actionData",
      JSON.stringify({
        action: "JoinPatrol",
        owner: _0x30b5eb,
      })
    );
  },
  LeavePatrol = () => {
    $.post(
      "https://piotreq_gpt/actionData",
      JSON.stringify({ action: "LeavePatrol" })
    );
  },
  TogglePatrol = () => {
    $.post(
      "https://piotreq_gpt/actionData",
      JSON.stringify({ action: "TogglePatrol" })
    );
  },
  CreatePatrol = () => {
    if (!playerAccess.patrols || !playerAccess.patrols.create) {
      $.post(
        "https://piotreq_gpt/ShowNotification",
        JSON.stringify({ text: locales.no_permission })
      );
      return;
    }
    let _0x41d50c = $("#create-patrol-units-value").attr("data-value");
    if (!_0x41d50c) {
      return;
    }
    let _0x1f3029 = $("#create-patrol-number").val();
    if (_0x1f3029.length < 1) {
      return;
    }
    $.post(
      "https://piotreq_gpt/actionData",
      JSON.stringify({
        action: "CreatePatrol",
        unit: _0x41d50c,
        number: _0x1f3029,
      })
    ).then((_0x4d4421) => {
      _0x4d4421 &&
        (ClosePopup(),
        $("#create-patrol-units-value").attr("data-value", null),
        $("#create-patrol-units-value").text("Wybierz jednostke"),
        $("#create-patrol-number").val(""));
    });
  },
  loadPatrols = (_0x1d975a) => {
    $("#create-patrol-units").empty();
    for (let _0x2d14b8 in _0x1d975a.units) {
      $("#create-patrol-units").append(
        "<div onclick=\"SelectItem('create-patrol-units', '" +
          _0x1d975a.units[_0x2d14b8] +
          "', '" +
          _0x1d975a.units[_0x2d14b8] +
          '\')" class="popup-select-item">' +
          _0x1d975a.units[_0x2d14b8] +
          "</div>"
      );
    }
    $("#patrols").html(
      '\n    <div class="top-bar">\n        <span>' +
        locales.patrols +
        '</span>\n    </div>\n    <div class="section-main">\n        <div class="patrols-wrapper">\n            <div class="patrols-top">\n                <div class="gpt-input">\n                    <input type="text" id="search-patrol" placeholder="' +
        locales.search_patrol +
        '">\n                    <i class="fa-solid fa-magnifying-glass"></i>\n                </div>\n                <div class="patrol-btn" onclick="OpenPopup(\'create-patrol-popup\')">' +
        locales.create +
        '</div>\n            </div>\n            <div class="patrols-list">\n            </div>\n        </div>\n        <div class="actions-wrapper">\n            <div class="employees-top">\n                <div class="employees-btn" onclick="SwitchAction(1)">' +
        locales.action_1 +
        '</div>\n                <div class="employees-btn" onclick="SwitchAction(2)">' +
        locales.action_2 +
        '</div>\n                <div class="employees-btn" onclick="SwitchAction(3)">' +
        locales.action_3 +
        '</div>\n                <div class="employees-btn" onclick="SwitchAction(4)">' +
        locales.action_4 +
        '</div>\n            </div>\n            <div class="action-info">\n            </div>\n        </div>\n    </div>'
    );
    $("#search-patrol").unbind();
    $("#search-patrol").on("input", () => {
      let _0x3342f3 = $("#search-patrol").val().toLowerCase(),
        _0xed6cbf = [];
      for (let _0x33d229 in _0x1d975a.patrols) {
        let _0x1faac2 = _0x1d975a.patrols[_0x33d229],
          _0x1b887d = _0x1faac2.number.toString().toLowerCase();
        _0x1b887d.includes(_0x3342f3) &&
          _0x1faac2.job == playerInfo.jobName &&
          _0xed6cbf.push(_0x1faac2);
      }
      refreshPatrols(_0xed6cbf);
      _0xed6cbf = [];
    });
    refreshPatrols(_0x1d975a.patrols);
  },
  refreshPatrols = (_0x5ac063) => {
    $(".patrols-list").hide();
    let _0x262881 = $(
      '<div class="loader-wrapper"><span class="loader"></span></div>'
    );
    $(".patrols-wrapper").append(_0x262881);
    let _0x3b9547 = "";
    for (let _0x226eda in _0x5ac063) {
      let _0x359b89 = _0x5ac063[_0x226eda];
      if (_0x359b89.job == playerInfo.jobName) {
        let _0x59c0ac = false;
        playerInfo.identifier == _0x359b89.owner && (_0x59c0ac = true);
        let _0x475345 = "";
        for (let _0x387700 in _0x359b89.members) {
          let _0x2e9e6e = _0x359b89.members[_0x387700];
          _0x2e9e6e.identifier == playerInfo.identifier && (_0x59c0ac = true);
          _0x475345 =
            _0x475345 +
            ('<div class="patrol-member">\n                    <span class="patrol-member-name">' +
              _0x2e9e6e.name +
              "</span>\n                    <span>" +
              _0x2e9e6e.badge +
              "</span>\n                    <span>" +
              (_0x2e9e6e.radio !== locales.no_data
                ? "#" + _0x2e9e6e.radio
                : locales.no_data) +
              "</span>\n                    " +
              (_0x359b89.owner == _0x2e9e6e.identifier
                ? '<i style="color: yellow" class="fa-solid fa-crown"></i>'
                : playerInfo.identifier == _0x359b89.owner &&
                  playerInfo.identifier !== _0x2e9e6e.identifier
                ? "<i onclick=\"KickPatrol('" +
                  _0x2e9e6e.identifier +
                  '\')" class="fa-solid fa-trash-can"></i>'
                : '<i class="fa-solid fa-user"></i>') +
              "\n                </div>");
        }
        _0x3b9547 =
          _0x3b9547 +
          ('\n            <div class="patrol">\n                <div class="patrol-info">\n                    <span>' +
            locales.patrol +
            " " +
            _0x359b89.unit +
            " #" +
            _0x359b89.number +
            '</span>\n                    <div class="patrol-manage">\n                        ' +
            (playerInfo.identifier == _0x359b89.owner
              ? _0x359b89.status == 1
                ? '<div onclick="TogglePatrol()" class="patrol-btn">' +
                  locales.open +
                  "</div>"
                : '<div onclick="TogglePatrol()" class="patrol-btn">' +
                  locales.close +
                  "</div>"
              : "") +
            "\n                        " +
            (_0x59c0ac
              ? '<div onclick="LeavePatrol()" class="patrol-btn">' +
                locales.leave +
                "</div>"
              : "<div onclick=\"JoinPatrol('" +
                _0x359b89.owner +
                '\')" class="patrol-btn">' +
                locales.join +
                "</div>") +
            "\n                    </div>\n                </div>\n                " +
            _0x475345 +
            "\n            </div>");
      }
    }
    setTimeout(() => {
      $(".patrols-list").html(_0x3b9547);
      _0x262881.remove();
      $(".patrols-list").css("display", "flex");
    }, 100);
  };
var selectedOffenses = {};
const loadOffenses = (_0x1e3929, _0x7ad38) => {
    $(".offenses-list").empty();
    for (let _0x4bb4cd in _0x1e3929) {
      let _0x394d53 = _0x1e3929[_0x4bb4cd];
      $(".offenses-list").append(
        '\n        <div class="offense" id="offense-' +
          _0x394d53.name +
          '">\n            <div class="offense-count">\n                <span id="offense-count">' +
          (selectedOffenses[_0x394d53.name]
            ? selectedOffenses[_0x394d53.name].count
            : "0") +
          '</span>\n                <div class="offense-buttons">\n                    <div class="offense-btn" onclick="OffenseCount(\'' +
          _0x394d53.name +
          "', " +
          _0x394d53.jail +
          ", " +
          _0x394d53.fine +
          ", '" +
          _0x394d53.label +
          '\', \'minus\')"><i class="fa-solid fa-minus"></i></div>\n                    <div class="offense-btn" onclick="OffenseCount(\'' +
          _0x394d53.name +
          "', " +
          _0x394d53.jail +
          ", " +
          _0x394d53.fine +
          ", '" +
          _0x394d53.label +
          '\', \'plus\')"><i class="fa-solid fa-plus"></i></div>\n                </div>\n             </div>\n             <div class="offense-info">\n                <span>' +
          _0x394d53.label +
          "</span>\n                <span>" +
          _0x394d53.jail +
          " " +
          locales.months +
          "</span>\n                <span>$ " +
          _0x394d53.fine +
          "</span>\n            </div>\n        </div>"
      );
    }
    if (!_0x7ad38) {
      return;
    }
    $("#search-offense").on("input", () => {
      let _0x4028e4 = [],
        _0x4fcae9 = $("#search-offense").val().toLowerCase();
      if (_0x4fcae9.length < 1) {
        loadOffenses(_0x1e3929);
      } else {
        for (let _0x29cb4f in _0x1e3929) {
          let _0x146a74 = _0x1e3929[_0x29cb4f],
            _0x410355 = _0x146a74.label.toLowerCase();
          _0x410355.includes(_0x4fcae9) && _0x4028e4.push(_0x146a74);
        }
        loadOffenses(_0x4028e4);
        _0x4028e4 = [];
      }
    });
  },
  SaveOffenses = () => {
    let _0x5686e0 = 0,
      _0x1e00f4 = 0;
    $("#offenses-list").empty();
    for (const [_0xf9ebae, _0x267f19] of Object.entries(selectedOffenses)) {
      _0x1e00f4 = _0x1e00f4 + _0x267f19.count * _0x267f19.jail;
      _0x5686e0 = _0x5686e0 + _0x267f19.count * _0x267f19.fine;
      $("#offenses-list").append(
        '\n        <div class="judgment-list-item" id="offense-selected-' +
          _0xf9ebae +
          '">\n            <span>x' +
          _0x267f19.count +
          " " +
          _0x267f19.label +
          '</span>\n            <i class="fa-solid fa-trash-can" onclick="RemoveOffense(\'' +
          _0xf9ebae +
          "')\"></i>\n        </div>"
      );
    }
    $("#judgment-jail").val(_0x1e00f4);
    $("#judgment-fine").val(_0x5686e0);
    CloseDetails();
  },
  RemoveOffense = (_0x2cc0b5) => {
    let _0x4084b8 = 0,
      _0x6d7b6d = 0;
    delete selectedOffenses[_0x2cc0b5];
    $("#offense-selected-" + _0x2cc0b5).remove();
    for (const [_0x5961a7, _0x2757a2] of Object.entries(selectedOffenses)) {
      _0x6d7b6d = _0x6d7b6d + _0x2757a2.count * _0x2757a2.jail;
      _0x4084b8 = _0x4084b8 + _0x2757a2.count * _0x2757a2.fine;
    }
    $("#judgment-jail").val(_0x6d7b6d);
    $("#judgment-fine").val(_0x4084b8);
  },
  OffenseCount = (_0x4973d1, _0x5d924c, _0x5520be, _0xd958d4, _0x4eb8f2) => {
    if (_0x4eb8f2 == "minus") {
      if (!selectedOffenses[_0x4973d1]) {
        return;
      }
      let _0x18a258 = parseInt(
        $("#offense-fine-value").val().replace("$ ", "")
      );
      _0x18a258 = _0x18a258 - _0x5520be;
      $("#offense-fine-value").val("$ " + _0x18a258);
      if (_0x5d924c > 0) {
        let _0x108e96 = parseInt($("#offense-months-value").val());
        _0x108e96 = _0x108e96 - _0x5d924c;
        $("#offense-months-value").val(_0x108e96);
      }
      selectedOffenses[_0x4973d1].count--;
      $("#offense-" + _0x4973d1 + " #offense-count").text(
        selectedOffenses[_0x4973d1].count
      );
      selectedOffenses[_0x4973d1].count < 1 &&
        delete selectedOffenses[_0x4973d1];
    } else {
      !selectedOffenses[_0x4973d1]
        ? (selectedOffenses[_0x4973d1] = {
            count: 1,
            jail: _0x5d924c,
            fine: _0x5520be,
            label: _0xd958d4,
          })
        : selectedOffenses[_0x4973d1].count++;
      let _0x19a8f4 = parseInt(
        $("#offense-fine-value").val().replace("$ ", "")
      );
      _0x19a8f4 = _0x19a8f4 + _0x5520be;
      $("#offense-fine-value").val("$ " + _0x19a8f4);
      if (_0x5d924c > 0) {
        let _0x30351f = parseInt(
          $("#offense-months-value").val().replace(locales.months, "")
        );
        _0x30351f = _0x30351f + _0x5d924c;
        $("#offense-months-value").val(_0x30351f + (" " + locales.months));
      }
      $("#offense-" + _0x4973d1 + " #offense-count").text(
        selectedOffenses[_0x4973d1].count
      );
    }
  };
window.onload = () => {
  setTimeout(() => {
    $.post("https://piotreq_gpt/loadLocales").then((_0x41401d) => {
      locales = _0x41401d;
      for (const [_0x3689c0, _0x99c405] of Object.entries(_0x41401d)) {
        _0x3689c0.includes("ui_") &&
          ($("." + _0x3689c0.replace("ui_", "")).text(_0x99c405),
          $("." + _0x3689c0.replace("ui_", "")).attr("placeholder", _0x99c405));
      }
      loadPopups();
      $("#offense-categories").empty();
      $(".offenses-list").empty();
      for (const [_0x3d7427, _0xf75aa9] of Object.entries(Judgments)) {
        let _0x23a7a8 = $("<span>" + _0xf75aa9.label + "</span>");
        $("#offense-categories").append(_0x23a7a8);
        _0x23a7a8.on("click", () => {
          loadOffenses(_0xf75aa9.options, true);
          activeOffenseCategory = _0x3d7427;
        });
        for (let _0x2a7554 in _0xf75aa9.options) {
          let _0x4d08bb = _0xf75aa9.options[_0x2a7554];
          allOffensesOptions.push(_0x4d08bb);
          $(".offenses-list").append(
            '\n                    <div class="offense" id="offense-' +
              _0x4d08bb.name +
              '">\n                        <div class="offense-count">\n                            <span id="offense-count">0</span>\n                            <div class="offense-buttons">\n                            <div class="offense-btn" onclick="OffenseCount(\'' +
              _0x4d08bb.name +
              "', " +
              _0x4d08bb.jail +
              ", " +
              _0x4d08bb.fine +
              ", '" +
              _0x4d08bb.label +
              '\', \'minus\')"><i class="fa-solid fa-minus"></i></div>\n                            <div class="offense-btn" onclick="OffenseCount(\'' +
              _0x4d08bb.name +
              "', " +
              _0x4d08bb.jail +
              ", " +
              _0x4d08bb.fine +
              ", '" +
              _0x4d08bb.label +
              '\', \'plus\')"><i class="fa-solid fa-plus"></i></div>\n                            </div>\n                         </div>\n                         <div class="offense-info">\n                            <span>' +
              _0x4d08bb.label +
              "</span>\n                            <span>" +
              _0x4d08bb.jail +
              " " +
              locales.months +
              "</span>\n                            <span>$ " +
              _0x4d08bb.fine +
              "</span>\n                        </div>\n                    </div>"
          );
        }
      }
      let _0x414a54 = $("<span>" + locales.all + "</span>");
      $("#offense-categories").prepend(_0x414a54);
      _0x414a54.on("click", () => {
        loadOffenses(allOffensesOptions);
        activeOffenseCategory = "all";
      });
      $("#search-offense").on("input", () => {
        let _0x4f9376 = [],
          _0x1a6300 = $("#search-offense").val().toLowerCase();
        if (_0x1a6300.length < 1) {
          loadOffenses(allOffensesOptions);
        } else {
          for (let _0x40e342 in allOffensesOptions) {
            let _0x336c0e = allOffensesOptions[_0x40e342],
              _0x1f38d4 = _0x336c0e.label.toLowerCase();
            _0x1f38d4.includes(_0x1a6300) && _0x4f9376.push(_0x336c0e);
          }
          loadOffenses(_0x4f9376);
          _0x4f9376 = [];
        }
      });
    });
  }, 100);
};
const loadAction = (_0x483f72) => {
    let _0x1bb352 = "",
      _0x7c8eee = false;
    _0x483f72.action.members[_0x483f72.identifier] &&
      _0x483f72.action.members[_0x483f72.identifier].visor &&
      (_0x7c8eee = true);
    for (let _0xecfd6d in _0x483f72.action.members) {
      let _0x3eb600 = _0x483f72.action.members[_0xecfd6d],
        _0xd090d0 =
          '\n        <div class="action-officer">\n            <span>' +
          _0x3eb600.unit +
          "</span>\n            <span>" +
          _0x3eb600.name +
          " [" +
          _0x3eb600.badge +
          "]</span>\n            <span>" +
          _0x3eb600.vehicle +
          "</span>\n            " +
          (_0x7c8eee && _0xecfd6d !== _0x483f72.identifier
            ? "<i onclick=\"ChangeVisor('" +
              _0x483f72.action.id +
              "', '" +
              _0xecfd6d +
              '\')" class="fa-solid fa-bullhorn square-btn"></i>'
            : _0x3eb600.visor
            ? "[" + locales.supervisor + "]"
            : '<i class="fa-solid fa-user"></i>') +
          "\n        </div>";
      _0x1bb352 = _0x3eb600.visor
        ? _0xd090d0 + _0x1bb352
        : _0x1bb352 + _0xd090d0;
    }
    $(".action-info").html(
      '\n    <div class="action-buttons">\n        ' +
        (_0x483f72.onAction
          ? "<div onclick=\"LeaveAction('" +
            _0x483f72.action.id +
            '\')" class="vehicle-btn" style="width: fit-content;">' +
            locales.leave +
            "</div>"
          : '<div class="vehicle-btn" style="width: fit-content;" onclick="OpenPopup(\'join-action-popup\', \'' +
            _0x483f72.action.id +
            "')\">" +
            locales.join +
            "</div>") +
        "\n        <div onclick=\"UpdateAction('" +
        _0x483f72.action.id +
        "', " +
        _0x483f72.action.code +
        ')" class="vehicle-btn action-code-btn" style="width: fit-content; background-color: ' +
        dangerCodes[_0x483f72.action.code - 1].color +
        '; margin-left: auto;">' +
        dangerCodes[_0x483f72.action.code - 1].label +
        "</div>\n    </div>\n    " +
        _0x1bb352
    );
  },
  ChangeVisor = (_0x173f34, _0x2a6696) => {
    $(".action-info").html(
      '<div class="loader-wrapper"><span class="loader"></span></div>'
    );
    setTimeout(() => {
      $.post(
        "https://piotreq_gpt/actionData",
        JSON.stringify({
          action: "ChangeVisor",
          id: _0x173f34,
          player: _0x2a6696,
        })
      ).then((_0x363836) => {
        _0x363836 && ((_0x363836.action.id = _0x173f34), loadAction(_0x363836));
      });
    }, 150);
  },
  SwitchAction = (_0x2ceaaa) => {
    activeAction = _0x2ceaaa;
    $(".action-info").html(
      '<div class="loader-wrapper"><span class="loader"></span></div>'
    );
    setTimeout(() => {
      $.post(
        "https://piotreq_gpt/fetchData",
        JSON.stringify({
          tab: "actionTab",
          id: _0x2ceaaa,
        })
      ).then((_0x1906c0) => {
        _0x1906c0 && ((_0x1906c0.action.id = _0x2ceaaa), loadAction(_0x1906c0));
      });
    }, 350);
  },
  JoinAction = (_0x31dd3e) => {
    $.post(
      "https://piotreq_gpt/actionData",
      JSON.stringify({
        action: "JoinAction",
        id: _0x31dd3e.id,
        veh: _0x31dd3e.veh,
        unit: _0x31dd3e.unit,
      })
    ).then((_0x1c3645) => {
      _0x1c3645 &&
        ((_0x1c3645.action.id = _0x31dd3e.id),
        loadAction(_0x1c3645),
        ClosePopup());
    });
  },
  LeaveAction = (_0x3aefa5) => {
    $.post(
      "https://piotreq_gpt/actionData",
      JSON.stringify({
        action: "LeaveAction",
        id: _0x3aefa5,
      })
    ).then((_0x3285ac) => {
      _0x3285ac && ((_0x3285ac.action.id = _0x3aefa5), loadAction(_0x3285ac));
    });
  },
  UpdateAction = (_0x306370, _0x487a67) => {
    $.post(
      "https://piotreq_gpt/actionData",
      JSON.stringify({
        action: "UpdateAction",
        id: _0x306370,
        code: _0x487a67,
      })
    ).then((_0x3730f0) => {
      _0x3730f0 && ((_0x3730f0.action.id = _0x306370), loadAction(_0x3730f0));
    });
  };
function removeTags(_0xd2531a) {
  return (
    (_0xd2531a = _0xd2531a.toString()), _0xd2531a.replace(/(<([^>]+)>)/gi, "")
  );
}
function formatTime(_0x18e06) {
  let _0x2c8314 = new Date(_0x18e06);
  return (
    _0x2c8314.getHours().toString().padStart(2, "0") +
    ":" +
    _0x2c8314.getMinutes().toString().padStart(2, "0") +
    " " +
    _0x2c8314.getDate().toString().padStart(2, "0") +
    "/" +
    (_0x2c8314.getMonth() + 1).toString().padStart(2, "0") +
    "/" +
    _0x2c8314.getFullYear()
  );
}
const ReportNotification = (_0x23b0e8) => {
    let _0x594372 = "";
    for (let _0x511fc1 in _0x23b0e8.info) {
      _0x594372 =
        _0x594372 +
        ('\n        <div class="report-info-row">\n            <i class="' +
          _0x23b0e8.info[_0x511fc1].icon +
          '"></i>\n            <span>' +
          _0x23b0e8.info[_0x511fc1].data +
          "</span>\n        </div>");
    }
    let _0x3c15c3 = $(
      '\n    <div class="dispatch-report notify-report ' +
        (_0x23b0e8.type ? _0x23b0e8.type : "normal") +
        '">\n        <div class="report-top">\n            <i class="' +
        _0x23b0e8.icon +
        '"></i>\n            <span>' +
        _0x23b0e8.title +
        '</span>\n            <div class="report-box outline-box">' +
        _0x23b0e8.code +
        '</div>\n            <div class="report-box outline-box">#' +
        _0x23b0e8.id +
        '</div>\n        </div>\n        <div class="report-main">\n        ' +
        _0x594372 +
        '\n        </div>\n        <div class="report-bot">\n            <div class="report-bot-flex">\n                <div class="report-box clickable">' +
        locales.react +
        '</div>\n                <div class="report-box clickable">' +
        locales.location +
        "</div>\n                " +
        (_0x23b0e8.canAnswer
          ? '<div class="report-box clickable">' + locales.answer + "</div>"
          : "") +
        '\n            </div>\n            <div class="report-bot-flex">\n                <div class="report-box outline-box">' +
        _0x23b0e8.officers.length +
        "/" +
        _0x23b0e8.maxOfficers +
        '</div>\n                <div class="report-box"><i class="fa-solid fa-chevron-down"></i></div>\n            </div>\n        </div>\n    </div>'
    );
    $(".dispatch-notify-wrapper").prepend(_0x3c15c3);
    setTimeout(() => {
      _0x3c15c3.css({
        transform: "translateX(0)",
        opacity: "1.0",
      });
      setTimeout(() => {
        _0x3c15c3.css({
          transform: "translateX(200%)",
          opacity: "0.0",
        });
        setTimeout(() => {
          _0x3c15c3.remove();
        }, 500);
      }, _0x23b0e8.timeout || 5500);
    }, 200);
  },
  OpenDispatch = () => {
    inDispatch = true;
    $(".dispatch-notify-wrapper").hide();
    $(".dispatch").css("display", "flex");
  },
  CloseDispatch = () => {
    $(".dispatch-notify-wrapper").css("display", "flex");
    $(".dispatch").hide();
    inDispatch = false;
    $.post("https://piotreq_gpt/CloseUI");
  };
var toggledOfficers = {};
const ToggleOfficers = (_0x23d89a, _0xb2a1fb) => {
    let _0x1de54f = $("#report-dropdown-" + _0x23d89a);
    _0x1de54f.css("max-height") == "0px"
      ? ((toggledOfficers[_0x23d89a] = true),
        $(_0xb2a1fb).children("i").css("transform", "rotate(180deg)"),
        _0x1de54f.css("display", "flex"),
        setTimeout(() => {
          _0x1de54f.css("max-height", _0x1de54f.prop("scrollHeight"));
        }, 10))
      : ((toggledOfficers[_0x23d89a] = null),
        $(_0xb2a1fb).children("i").css("transform", "rotate(0)"),
        _0x1de54f.css("max-height", "0px"),
        setTimeout(() => {
          _0x1de54f.hide();
        }, 115));
  },
  loadDispatch = (_0xcd3157) => {
    $(".dispatch").html(
      '<div class="reports-wrapper"><span>' +
        locales.actual_reports +
        '</span><div class="reports-wrapper-list" id="actual-reports"></div></div>'
    );
    for (let _0x4983c4 in _0xcd3157.dispatch) {
      let _0x2ba965 = _0xcd3157.dispatch[_0x4983c4],
        _0x59ae42 = false,
        _0x157f1e = _0x2ba965.officers,
        _0x5c4c73 = true;
      _0x2ba965.jobs &&
        !_0x2ba965.jobs[_0xcd3157.job.name] &&
        (_0x5c4c73 = false);
      if (_0x5c4c73) {
        let _0x1db925 = "";
        for (let _0x4cff24 in _0x2ba965.info) {
          _0x1db925 =
            _0x1db925 +
            ('\n                <div class="report-info-row">\n                    <i class="' +
              _0x2ba965.info[_0x4cff24].icon +
              '"></i>\n                    <span>' +
              _0x2ba965.info[_0x4cff24].data +
              "</span>\n                </div>");
        }
        if (_0x157f1e.length > 0) {
          for (let _0x8a154b in _0x157f1e) {
            let _0xac03bb = _0x157f1e[_0x8a154b];
            if (_0xac03bb.identifier == _0xcd3157.identifier) {
              _0x59ae42 = true;
              $(".dispatch").prepend(
                '<div class="reports-wrapper"><span>' +
                  locales.active_reports +
                  '</span><div class="reports-wrapper-list" id="active-reports"></div></div>'
              );
              break;
            }
          }
        }
        let _0x37da1a = "";
        for (let _0x5c20aa in _0x157f1e) {
          let _0x472f06 = _0x157f1e[_0x5c20aa];
          _0x37da1a =
            _0x37da1a +
            ('<div class="report-officer">\n                    <i class="fa-regular fa-badge-sheriff"></i>\n                    <span>[' +
              _0x472f06.badge +
              "] <font>" +
              _0x472f06.name +
              "</font> [" +
              _0x472f06.job +
              "]</span>\n                </div>");
        }
        _0x59ae42
          ? $("#active-reports").prepend(
              '\n                    <div class="dispatch-report ' +
                (_0x2ba965.type ? _0x2ba965.type : "normal") +
                '">\n                        <div class="report-top">\n                            <i class="' +
                _0x2ba965.icon +
                '"></i>\n                            <span>' +
                _0x2ba965.title +
                '</span>\n                            <div class="report-box outline-box">' +
                _0x2ba965.code +
                '</div>\n                            <div class="report-box outline-box">#' +
                _0x2ba965.id +
                '</div>\n                        </div>\n                        <div class="report-main">\n                        ' +
                _0x1db925 +
                '\n                        </div>\n                        <div class="report-bot">\n                            <div class="report-bot-flex">\n                                <div onclick="CancelReport(' +
                _0x2ba965.id +
                ')" class="report-box clickable">' +
                locales.finish +
                '</div>\n                                <div onclick="LocateReport(' +
                _0x2ba965.coords.x +
                ", " +
                _0x2ba965.coords.y +
                ')" class="report-box clickable">' +
                locales.location +
                "</div>\n                                " +
                (_0x2ba965.canAnswer
                  ? '<div onclick="AnswerReport(' +
                    _0x2ba965.sender +
                    ')" class="report-box clickable">' +
                    locales.answer +
                    "</div>"
                  : "") +
                '\n                            </div>\n                            <div class="report-bot-flex">\n                                <div class="report-box outline-box">' +
                _0x157f1e.length +
                "/" +
                _0x2ba965.maxOfficers +
                "</div>\n                                <div onclick=\"ToggleOfficers('" +
                _0x2ba965.id +
                '\', $(this))" class="report-box"><i ' +
                (toggledOfficers[_0x2ba965.id]
                  ? 'style="transform: rotate(180deg)"'
                  : "") +
                ' class="fa-solid fa-chevron-down"></i></div>\n                            </div>\n                        </div>\n                        <div class="report-officers" ' +
                (toggledOfficers[_0x2ba965.id]
                  ? 'style="display: flex; max-height: fit-content"'
                  : "") +
                ' id="report-dropdown-' +
                _0x2ba965.id +
                '">\n                        ' +
                _0x37da1a +
                "\n                        </div>\n                    </div>"
            )
          : $("#actual-reports").prepend(
              '\n                    <div class="dispatch-report ' +
                (_0x2ba965.type ? _0x2ba965.type : "normal") +
                '">\n                        <div class="report-top">\n                            <i class="' +
                _0x2ba965.icon +
                '"></i>\n                            <span>' +
                _0x2ba965.title +
                '</span>\n                            <div class="report-box outline-box">' +
                _0x2ba965.code +
                '</div>\n                            <div class="report-box outline-box">#' +
                _0x2ba965.id +
                '</div>\n                        </div>\n                        <div class="report-main">\n                        ' +
                _0x1db925 +
                '\n                        </div>\n                        <div class="report-bot">\n                            <div class="report-bot-flex">\n                                <div onclick="ReactReport(' +
                _0x2ba965.id +
                ')" class="report-box clickable">' +
                locales.react +
                '</div>\n                                <div onclick="LocateReport(' +
                _0x2ba965.coords.x +
                ", " +
                _0x2ba965.coords.y +
                ')" class="report-box clickable">' +
                locales.location +
                "</div>\n                                " +
                (_0x2ba965.canAnswer
                  ? '<div onclick="AnswerReport(' +
                    _0x2ba965.sender +
                    ')" class="report-box clickable">' +
                    locales.answer +
                    "</div>"
                  : "") +
                '\n                            </div>\n                            <div class="report-bot-flex">\n                                <div class="report-box outline-box">' +
                _0x157f1e.length +
                "/" +
                _0x2ba965.maxOfficers +
                "</div>\n                                <div onclick=\"ToggleOfficers('" +
                _0x2ba965.id +
                '\', $(this))" class="report-box"><i ' +
                (toggledOfficers[_0x2ba965.id]
                  ? 'style="transform: rotate(180deg)"'
                  : "") +
                ' class="fa-solid fa-chevron-down"></i></div>\n                            </div>\n                        </div>\n                        <div class="report-officers" ' +
                (toggledOfficers[_0x2ba965.id]
                  ? 'style="display: flex; max-height: fit-content"'
                  : "") +
                ' id="report-dropdown-' +
                _0x2ba965.id +
                '">\n                        ' +
                _0x37da1a +
                "\n                        </div>\n                    </div>"
            );
      }
    }
  },
  AnswerReport = (_0x45694e) => {
    $.post(
      "https://piotreq_gpt/AnswerReport",
      JSON.stringify({ sender: _0x45694e })
    );
  },
  ReactReport = (_0xa2bbb4) => {
    $.post(
      "https://piotreq_gpt/ReactReport",
      JSON.stringify({ id: _0xa2bbb4 })
    );
  },
  CancelReport = (_0x1bed33) => {
    $.post(
      "https://piotreq_gpt/CancelReport",
      JSON.stringify({ id: _0x1bed33 })
    );
  },
  LocateReport = (_0x293606, _0x57fc37) => {
    $.post(
      "https://piotreq_gpt/LocateReport",
      JSON.stringify({
        x: _0x293606,
        y: _0x57fc37,
      })
    );
  },
  loadLicenses = (_0x5a87ae) => {
    $("#add-license-citizen").empty();
    $("#add-worker-license").empty();
    for (let _0x4cd1d6 in _0x5a87ae.citizen) {
      let _0xbf37cd = _0x5a87ae.citizen[_0x4cd1d6];
      $("#add-license-citizen").append(
        "<div onclick=\"SelectItem('add-license-citizen', '" +
          _0x4cd1d6 +
          "', '" +
          _0xbf37cd.label +
          '\')" class="popup-select-item">' +
          _0xbf37cd.label +
          "</div>"
      );
    }
    for (let _0x2365a1 in _0x5a87ae.police) {
      let _0x311d9e = _0x5a87ae.police[_0x2365a1];
      $("#add-worker-license").append(
        "<div onclick=\"SelectItem('add-worker-license', '" +
          _0x2365a1 +
          "', '" +
          _0x311d9e.label +
          '\')" class="popup-select-item">' +
          _0x311d9e.label +
          "</div>"
      );
    }
  },
  BuyVehicle = () => {
    if (!playerAccess.garage || !playerAccess.garage.buy) {
      $.post(
        "https://piotreq_gpt/ShowNotification",
        JSON.stringify({ text: locales.no_permission })
      );
      return;
    }
    let _0x140769 = $("#buy-vehicle-value").attr("data-value");
    if (!_0x140769) {
      return;
    }
    $.post(
      "https://piotreq_gpt/actionData",
      JSON.stringify({
        action: "BuyVehicle",
        model: _0x140769,
      })
    ).then((_0x4415c3) => {
      _0x4415c3 &&
        (refreshGarage(_0x4415c3),
        ClosePopup(),
        $("#buy-vehicle-value").attr("data-value", null));
    });
  },
  loadVehicles = (_0x24bf2b) => {
    $("#buy-vehicle").empty();
    for (let _0x1d6988 in _0x24bf2b) {
      let _0x4baa77 = _0x24bf2b[_0x1d6988],
        _0x318e4e = $(
          '<div class="popup-select-item">' + _0x4baa77.label + "</div>"
        );
      $("#buy-vehicle").append(_0x318e4e);
      _0x318e4e.on("click", () => {
        SelectItem("buy-vehicle", _0x1d6988, _0x4baa77.label);
        $("#buy-vehicle-price").val(
          "$ " + moneyFormat.format(_0x4baa77.price).replace("$", "")
        );
      });
    }
  };
var moneyFormat = new Intl.NumberFormat("en-US", {
  style: "currency",
  currency: "USD",
  minimumFractionDigits: 0,
});
window.addEventListener("message", (_0x261403) => {
  let _0x543177 = _0x261403.data;
  switch (_0x543177.action) {
    case "OpenGPT":
      (licensesSections = _0x543177.licensesSections),
        (myLicenses = _0x543177.tabData.licenses);
      !loadedVehicles &&
        ((loadedVehicles = true), loadVehicles(_0x543177.vehicles));
      Object.keys(gptLicenses).length < 1 &&
        (loadLicenses(_0x543177.licenses), (gptLicenses = _0x543177.licenses));
      playerAccess = _0x543177.access;
      const _0x2eeb43 = document.querySelectorAll(".side-buttons > .side-btn");
      _0x2eeb43.forEach((_0x1b88c2) => {
        if ($(_0x1b88c2).attr("id")) {
          let _0x5e1c23 = $(_0x1b88c2).attr("id").replace("-btn", "");
          _0x5e1c23 !== "off" &&
            (licensesSections[_0x5e1c23]
              ? $("#" + _0x5e1c23 + "-btn").css(
                  "display",
                  myLicenses[licensesSections[_0x5e1c23]] ? "flex" : "none"
                )
              : $("#" + _0x5e1c23 + "-btn").css(
                  "display",
                  playerAccess[_0x5e1c23] ? "flex" : "none"
                ));
          $("#" + _0x5e1c23 + "-btn > span").text(locales[_0x5e1c23]);
        }
      }),
        $(":root")
          .get(0)
          .style.setProperty("--main-color", _0x543177.colors.mainColor),
        $(":root")
          .get(0)
          .style.setProperty(
            "--main-color-hover",
            _0x543177.colors.mainColorHover
          ),
        $(":root")
          .get(0)
          .style.setProperty("--main-bg", _0x543177.colors.bgColor),
        $(".gpt-logo").css(
          "background",
          "center / cover no-repeat url('" + _0x543177.colors.image + "')"
        ),
        (activeTab == "radios") ? $.post(
          "https://piotreq_gpt/fetchRadioData",
          JSON.stringify({})
        ).then((_0x19aaf6) => {
          loadTab({
            tab: "radios",
            tabData: _0x19aaf6,
          });
        }): loadTab(_0x543177),
        $(".gpt-wrapper").css("display", "flex");
      break;
    case "OpenDispatch":
      OpenDispatch();
      break;
    case "LoadDispatch":
      loadDispatch(_0x543177);
      break;
    case "ReportNotification":
      ReportNotification(_0x543177.alert);
      break;
    case "RefreshPatrols":
      if (activeTab !== "patrols") {
        return;
      }
      $("#search-patrol").unbind(),
        $("#search-patrol").on("input", () => {
          let _0x29236c = $("#search-patrol").val().toLowerCase(),
            _0x5bcbc0 = [];
          for (let _0x2a90d2 in _0x543177.patrols) {
            let _0x33c501 = _0x543177.patrols[_0x2a90d2],
              _0x1b8129 = _0x33c501.number.toString().toLowerCase();
            _0x1b8129.includes(_0x29236c) &&
              _0x33c501.job == playerInfo.jobName &&
              _0x5bcbc0.push(_0x33c501);
          }
          refreshPatrols(_0x5bcbc0);
          _0x5bcbc0 = [];
        }),
        refreshPatrols(_0x543177.patrols);
      break;
  }
});
