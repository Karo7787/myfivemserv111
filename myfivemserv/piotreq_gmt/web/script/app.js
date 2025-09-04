let activeTab = 'home';
let activePopup = '';
let activeDetails = '';
let activeOffenseCategory = 'all';
let allOffensesOptions = [];
let activeCitizenTab = '';
let playerInfo = [];
var activeWorker = [];
var dutyTimeInterval;
let playerAccess = [];
let inDispatch = false;
var activeAction = 1;
var activeCitizen = [];
var GMTLicenses = {};
let inFullScreen = false;
let loadedVehicles = false;
let antiSpam = new Date().getTime();
let isCardOpen = false;
let inCardPopup = false;
var injuryList = {};
let myIdentifier = null;
let locales = {};
let selectedCitizensCase = {},
selectedOfficersCase = {},
attachedPhotosCase = {};

const loadPopups = (() => {
    $('.gmt-popups-wrapper').html(`
        <div class="gmt-popup" id="manage-vehicle-popup" style="display: none;">
            <span>${locales['manage_vehicle']}</span>
            <div class="popup-input">
                <span>${locales['vehicle_model']}</span>
                <div class="popup-input-wrapper">
                    <input id="manage-vehicle-model" type="text" value="" disabled>
                </div>
            </div>
            <div class="popup-input">
                <span>${locales['plate']}</span>
                <div class="popup-input-wrapper">
                    <input id="manage-vehicle-plate" type="text" value="" disabled>
                </div>
            </div>
            <div class="popup-input">
                <span>${locales['current_driver']}</span>
                <div class="popup-input-wrapper">
                    <input id="manage-vehicle-driver" type="text" value="" disabled>
                </div>
            </div>
            <div class="popup-input">
                <span>${locales['new_driver']}</span>
                <div class="popup-input-wrapper">
                    <input id="manage-vehicle-new-driver" type="number" placeholder="${locales['enter_ssn']}">
                </div>
            </div>
            <div class="popup-bot">
                <div class="vehicle-btn" onclick="ClosePopup()">${locales['cancel']}</div>
                <div class="vehicle-btn" id="manage-vehicle-btn">${locales['confirm']}</div>
            </div>
        </div>
        <div class="gmt-popup" id="set-wheelchair-popup" style="display: none;">
            <span>${locales['set_wheelchair']}</span>
            <div class="popup-input">
                <span>${locales['wheelchair_ssn']}</span>
                <div class="popup-input-wrapper">
                    <input id="set-wheelchair-ssn" type="text" placeholder="${locales['enter_ssn']}">
                </div>
            </div>
            <div class="popup-input">
                <span>${locales['validity']}</span>
                <div class="popup-input-wrapper">
                    <input id="set-wheelchair-days" type="number" placeholder="${locales['wheelchair_days']}">
                </div>
            </div>
            <div class="popup-bot">
                <div class="vehicle-btn" onclick="ClosePopup()">${locales['cancel']}</div>
                <div class="vehicle-btn" onclick="AddWheelChair()">${locales['confirm']}</div>
            </div>
        </div>
        <div class="gmt-popup" id="remove-wheelchair-popup" style="display: none;">
            <span>${locales['remove_wheelchair']}</span>
            <div class="popup-input">
                <span>${locales['citizen_ssn']}</span>
                <div class="popup-input-wrapper">
                    <input id="remove-wheelchair-plate" type="text" value="George Gouda" disabled>
                </div>
            </div>
            <div class="popup-input">
                <span>${locales['wheelchair_id']}</span>
                <div class="popup-input-wrapper">
                    <input id="remove-wheelchair-id" type="text" value="#1" disabled>
                </div>
            </div>
            <div class="popup-bot">
                <div class="vehicle-btn" onclick="ClosePopup()">${locales['cancel']}</div>
                <div class="vehicle-btn" onclick="RemoveWheelChair()">${locales['confirm']}</div>
            </div>
        </div>
        <div class="gmt-popup" id="manage-wheelchair-popup" style="display: none;">
            <span>${locales['manage_wheelchair']}</span>
            <div class="popup-input">
                <span>${locales['citizen_ssn']}</span>
                <div class="popup-input-wrapper">
                    <input id="manage-wheelchair-name" type="text" value="George Gouda" disabled>
                </div>
            </div>
            <div class="popup-input">
                <span>${locales['wheelchair_id']}</span>
                <div class="popup-input-wrapper">
                    <input id="manage-wheelchair-id" type="text" value="#1" disabled>
                </div>
            </div>
            <div class="popup-input">
                <span>${locales['extend_validity']}</span>
                <div class="popup-input-wrapper">
                    <input id="manage-wheelchair-days" type="number" placeholder="${locales['enter_days']}">
                </div>
            </div>
            <div class="popup-bot">
                <div class="vehicle-btn" onclick="ClosePopup()">${locales['cancel']}</div>
                <div class="vehicle-btn" onclick="UpdateWheelChair()">${locales['confirm']}</div>
            </div>
        </div>
        <div class="gmt-popup" id="buy-vehicle-popup" style="display: none;">
            <span>${locales['buy_vehicle']}</span>
            <div class="popup-input">
                <span>${locales['select_model']}</span>
                <div class="popup-select">
                    <div class="popup-select-info" onclick="ToggleSelect('buy-vehicle')">
                        <span id="buy-vehicle-value">${locales['select_model']}</span>
                        <i id="buy-vehicle-arrow" class="fa-solid fa-chevron-up"></i>
                    </div>
                    <div class="popup-select-menu" id="buy-vehicle">
                    </div>
                </div>
            </div>
            <div class="popup-input">
                <span>${locales['price']}</span>
                <div class="popup-input-wrapper">
                    <input type="text" id="buy-vehicle-price" value="$ 0" disabled>
                </div>
            </div>
            <div class="popup-bot">
                <div class="vehicle-btn" onclick="ClosePopup()">${locales['cancel']}</div>
                <div class="vehicle-btn" onclick="BuyVehicle()">${locales['confirm']}</div>
            </div>
        </div>
        <div class="gmt-popup" id="create-patrol-popup" style="display: none;">
            <span>${locales['create_patrol']}</span>
            <div class="popup-input">
                <span>${locales['patrol_number']}</span>
                <div class="popup-input-wrapper">
                    <input type="number" id="create-patrol-number" maxlength="3" placeholder="${locales['enter_patrol_number']}">
                </div>
            </div>
            <div class="popup-input">
                <span>${locales['unit']}</span>
                <div class="popup-select">
                    <div class="popup-select-info" onclick="ToggleSelect('create-patrol-units')">
                        <span id="create-patrol-units-value">${locales['select_unit']}</span>
                        <i id="create-patrol-units-arrow" class="fa-solid fa-chevron-up"></i>
                    </div>
                    <div class="popup-select-menu" id="create-patrol-units">
                    </div>
                </div>
            </div>
            <div class="popup-bot">
                <div class="vehicle-btn" onclick="ClosePopup()">${locales['cancel']}</div>
                <div class="vehicle-btn" onclick="CreatePatrol()">${locales['create']}</div>
            </div>
        </div>
        <div class="gmt-popup" id="add-employee-popup" style="display: none;">
            <span>${locales['add_employee']}</span>
            <div class="popup-input">
                <span>${locales['id']}</span>
                <div class="popup-input-wrapper">
                    <input id="add-member-id" type="number" placeholder="${locales['enter_id']}">
                </div>
            </div>
            <div class="popup-input">
                <span>${locales['rank']}</span>
                <div class="popup-select">
                    <div class="popup-select-info" onclick="ToggleSelect('add-member')">
                        <span id="add-member-value">${locales['select_rank']}</span>
                        <i id="add-member-arrow" class="fa-solid fa-chevron-up"></i>
                    </div>
                    <div class="popup-select-menu" id="add-member">
                    </div>
                </div>
            </div>
            <div class="popup-bot">
                <div class="vehicle-btn" onclick="ClosePopup()">${locales['cancel']}</div>
                <div class="vehicle-btn" onclick="HireWorker()">${locales['add']}</div>
            </div>
        </div>
        <div class="gmt-popup" id="update-employee-popup" style="display: none;">
            <span>${locales['update_employee']}</span>
            <div class="popup-input">
                <span>${locales['name_surname']}</span>
                <div class="popup-input-wrapper">
                    <input id="change-grade-name" type="text" disabled>
                </div>
            </div>
            <div class="popup-input">
                <span>${locales['rank']}</span>
                <div class="popup-select">
                    <div class="popup-select-info" onclick="ToggleSelect('update-member')">
                        <span id="update-member-value">${locales['select_rank']}</span>
                        <i id="update-member-arrow" class="fa-solid fa-chevron-up"></i>
                    </div>
                    <div class="popup-select-menu" id="update-member"></div>
                </div>
            </div>
            <div class="popup-bot">
                <div class="vehicle-btn" onclick="ClosePopup()">${locales['cancel']}</div>
                <div class="vehicle-btn" onclick="UpdateWorker()">${locales['confirm']}</div>
            </div>
        </div>
        <div class="gmt-popup" id="fire-employee-popup" style="display: none;">
            <span>${locales['fire_employee']}</span>
            <div class="popup-input">
                <span>${locales['name_surname']}</span>
                <div class="popup-input-wrapper">
                    <input id="fire-employee-name" type="text" value="George Gouda" disabled>
                </div>
            </div>
            <div class="popup-input">
                <span>${locales['reason']}</span>
                <div class="popup-input-wrapper">
                    <textarea id="fire-employee-reason" placeholder="${locales['enter_reason']}"></textarea>
                </div>
            </div>
            <div class="popup-bot">
                <div class="vehicle-btn" onclick="ClosePopup()">${locales['cancel']}</div>
                <div class="vehicle-btn" onclick="FireWorker()">${locales['fire']}</div>
            </div>
        </div>
        <div class="gmt-popup" id="add-new-document-popup" style="display: none;">
            <span>${locales['add_document']}</span>
            <div class="popup-input">
                <span>${locales['citizen_ssn']}</span>
                <div class="popup-input-wrapper">
                    <input id="new-document-ssn" type="number" placeholder="${locales['enter_ssn']}">
                </div>
            </div>
            <div class="popup-input">
                <span>${locales['document_type']}</span>
                <div class="popup-select">
                    <div class="popup-select-info" onclick="ToggleSelect('new-document-select')">
                        <span id="new-document-select-value">${locales['select_type']}</span>
                        <i id="new-document-select-arrow" class="fa-solid fa-chevron-up"></i>
                    </div>
                    <div class="popup-select-menu" id="new-document-select">
                        <div class="popup-select-item">Licencja pilota</div>
                    </div>
                </div>
            </div>
            <div class="popup-input">
                <span>${locales['validity']}</span>
                <div class="popup-input-wrapper">
                    <input id="new-document-time" type="number" placeholder="${locales['enter_days']}">
                </div>
            </div>
            <div class="popup-bot">
                <div class="vehicle-btn" onclick="ClosePopup()">${locales['cancel']}</div>
                <div class="vehicle-btn" onclick="AddDocument()">${locales['confirm']}</div>
            </div>
        </div>
        <div class="gmt-popup" id="add-worker-license-popup" style="display: none;">
            <span>${locales['add_license']}</span>
            <div class="popup-input">
                <span>${locales['available_licenses']}</span>
                <div class="popup-select">
                    <div class="popup-select-info" onclick="ToggleSelect('add-worker-license')">
                        <span id="add-worker-license-value">${locales['select_license']}</span>
                        <i id="add-worker-license-arrow" class="fa-solid fa-chevron-up"></i>
                    </div>
                    <div class="popup-select-menu" id="add-worker-license">
                    </div>
                </div>
            </div>
            <div class="popup-bot">
                <div class="vehicle-btn" onclick="ClosePopup()">${locales['cancel']}</div>
                <div class="vehicle-btn" onclick="AddWorkerLicense()">${locales['add']}</div>
            </div>
        </div>
        <div class="gmt-popup" id="remove-worker-license-popup" style="display: none;">
            <span>${locales['remove_license']}</span>
            <div class="popup-input">
                <span>${locales['available_licenses']}</span>
                <div class="popup-select">
                    <div class="popup-select-info" onclick="ToggleSelect('remove-worker-license')">
                        <span id="remove-worker-license-value">${locales['select_license']}</span>
                        <i id="remove-worker-license-arrow" class="fa-solid fa-chevron-up"></i>
                    </div>
                    <div class="popup-select-menu" id="remove-worker-license">
                    </div>
                </div>
            </div>
            <div class="popup-bot">
                <div class="vehicle-btn" onclick="ClosePopup()">${locales['cancel']}</div>
                <div class="vehicle-btn" onclick="DeleteWorkerLicense()">${locales['remove_license']}</div>
            </div>
        </div>
        <div class="gmt-popup" id="change-badge-popup" style="display: none;">
            <span>${locales['change_badge']}</span>
            <div class="popup-input">
                <span>${locales['name_surname']}</span>
                <div class="popup-input-wrapper">
                    <input id="change-badge-name" type="text" value="" disabled>
                </div>
            </div>
            <div class="popup-input">
                <span>${locales['badge_number']}</span>
                <div class="popup-input-wrapper">
                    <input id="change-badge-value" type="number" value="0">
                </div>
            </div>
            <div class="popup-bot">
                <div class="vehicle-btn" onclick="ClosePopup()">${locales['cancel']}</div>
                <div class="vehicle-btn" onclick="ChangeEmployeeBadge()">${locales['confirm']}</div>
            </div>
        </div>
        <div class="gmt-popup" id="set-citizen-photo-popup" style="display: none;">
            <span>${locales['set_photo']}</span>
            <div class="popup-input">
                <span>${locales['photo_url']}</span>
                <div class="popup-input-wrapper">
                    <input type="text" id="set-citizen-photo-url" placeholder="${locales['paste_url']}">
                </div>
            </div>
            <div class="popup-bot">
                <div class="vehicle-btn" onclick="ClosePopup()">${locales['cancel']}</div>
                <div class="vehicle-btn" onclick="SetCitizenPhoto()">${locales['confirm']}</div>
            </div>
        </div>
        <div class="gmt-popup" id="set-employee-photo-popup" style="display: none;">
            <span>${locales['set_photo']}</span>
            <div class="popup-input">
                <span>${locales['photo_url']}</span>
                <div class="popup-input-wrapper">
                    <input type="text" id="set-employee-photo-url" placeholder="${locales['paste_url']}">
                </div>
            </div>
            <div class="popup-bot">
                <div class="vehicle-btn" onclick="ClosePopup()">${locales['cancel']}</div>
                <div class="vehicle-btn" onclick="SetEmployeePhoto()">${locales['confirm']}</div>
            </div>
        </div>
        <div class="gmt-popup" id="join-action-popup" style="display: none;">
            <span>${locales['join_action']}</span>
            <div class="popup-input">
                <span>${locales['unit']}</span>
                <div class="popup-select">
                    <div class="popup-select-info" onclick="ToggleSelect('action-unit')">
                        <span id="action-unit-value">${locales['select_unit']}</span>
                        <i id="action-unit-arrow" class="fa-solid fa-chevron-up"></i>
                    </div>
                    <div class="popup-select-menu" id="action-unit">
                        <div class="popup-select-item" onclick="SelectItem('action-unit', 'U1', 'U1')">U1</div>
                        <div class="popup-select-item" onclick="SelectItem('action-unit', 'U2', 'U2')">U2</div>
                        <div class="popup-select-item" onclick="SelectItem('action-unit', 'U3', 'U3')">U3</div>
                        <div class="popup-select-item" onclick="SelectItem('action-unit', 'U4', 'U4')">U4</div>
                        <div class="popup-select-item" onclick="SelectItem('action-unit', 'U5', 'U5')">U5</div>
                        <div class="popup-select-item" onclick="SelectItem('action-unit', 'U6', 'U6')">U6</div>
                        <div class="popup-select-item" onclick="SelectItem('action-unit', 'U7', 'U7')">U7</div>
                        <div class="popup-select-item" onclick="SelectItem('action-unit', 'U8', 'U8')">U8</div>
                    </div>
                </div>
            </div>
            <div class="popup-input">
                <span>${locales['vehicle_name']}</span>
                <div class="popup-input-wrapper">
                    <input id="join-action-veh" type="text" placeholder="${locales['enter_vehicle_name']}">
                </div>
            </div>
            <div class="popup-bot">
                <div class="vehicle-btn" onclick="ClosePopup()">${locales['cancel']}</div>
                <div class="vehicle-btn" id="join-action-btn">${locales['confirm']}</div>
            </div>
        </div>
        <div class="gmt-popup" id="add-employee-note-popup" style="display: none;">
            <span>${locales['add_note']}</span>
            <div class="popup-input">
                <span>${locales['note_title']}</span>
                <div class="popup-input-wrapper">
                    <input id="employee-note-title" type="text" placeholder="${locales['enter_title']}">
                </div>
            </div>
            <div class="popup-input">
                <span>${locales['note_content']}</span>
                <div class="popup-input-wrapper">
                    <textarea id="employee-note-text" placeholder="${locales['enter_content']}"></textarea>
                </div>
            </div>
            <div class="popup-input">
                <span>${locales['important']}</span>
                <div class="popup-switch">
                    <label class="switch">
                        <input type="checkbox" id="employee-note-important">
                        <span class="slider round"></span>
                    </label>
                </div>
            </div>
            <div class="popup-bot">
                <div class="vehicle-btn" onclick="ClosePopup()">${locales['cancel']}</div>
                <div class="vehicle-btn" onclick="AddEmployeeNote()">${locales['add']}</div>
            </div>
        </div>
        <div class="gmt-popup" id="reset-employee-time-popup" style="display: none;">
            <span>${locales['reset_time']}</span>
            <div class="popup-input">
                <span>${locales['name_surname']}</span>
                <div class="popup-input-wrapper">
                    <input id="reset-time-name" type="text" value="" disabled>
                </div>
            </div>
            <div class="popup-bot">
                <div class="vehicle-btn" onclick="ClosePopup()">${locales['cancel']}</div>
                <div class="vehicle-btn" onclick="ResetEmployeeTime()">${locales['reset_time']}</div>
            </div>
        </div>
        <div class="gmt-popup" id="reset-time-popup" style="display: none;">
            <span>${locales['reset_time']}</span>
            <div class="popup-input">
                <span>${locales['select_employees']}</span>
                <div class="popup-select">
                    <div class="popup-select-info" onclick="ToggleSelect('reset-time')">
                        <span id="reset-time-value">${locales['select_employees']}</span>
                        <i id="reset-time-arrow" class="fa-solid fa-chevron-up"></i>
                    </div>
                    <div class="popup-select-menu" id="reset-time">
                        <div class="popup-select-item" onclick="SelectItem('reset-time', 'all', '${locales['all']}')">${locales['all']}</div>
                        <div class="popup-select-item" onclick="SelectItem('reset-time', 'online', '${locales['online']}')">${locales['online']}</div>
                        <div class="popup-select-item" onclick="SelectItem('reset-time', 'offline', '${locales['offline']}')">${locales['offline']}</div>
                    </div>
                </div>
            </div>
            <div class="popup-bot">
                <div class="vehicle-btn" onclick="ClosePopup()">${locales['cancel']}</div>
                <div class="vehicle-btn" onclick="ResetAllTime()">${locales['reset_time']}</div>
            </div>
        </div>
        <div class="gmt-popup" id="announcement-popup" style="display: none;">
            <span>${locales['add_announcement']}</span>
            <div class="popup-input">
                <span>${locales['announcement_title']}</span>
                <div class="popup-input-wrapper">
                    <input id="add-announcement-title" type="text" placeholder="${locales['enter_title']}">
                </div>
            </div>
            <div class="popup-input">
                <span>${locales['announcement_content']}</span>
                <div class="popup-input-wrapper">
                    <textarea id="add-announcement-text" placeholder="${locales['enter_content']}"></textarea>
                </div>
            </div>
            <div class="popup-input">
                <span>${locales['important']}</span>
                <div class="popup-switch">
                    <label class="switch">
                        <input type="checkbox" id="add-announcement-check">
                        <span class="slider round"></span>
                    </label>
                </div>
            </div>
            <div class="popup-bot">
                <div class="vehicle-btn" onclick="ClosePopup()">${locales['cancel']}</div>
                <div class="vehicle-btn" onclick="AddAnnouncement()">${locales['add']}</div>
            </div>
        </div>
        <div class="gmt-popup" id="add-citizen-note-popup" style="display: none;">
            <span>${locales['add_note']}</span>
            <div class="popup-input">
                <span>${locales['note_title']}</span>
                <div class="popup-input-wrapper">
                    <input id="citizen-note-title" type="text" placeholder="${locales['enter_title']}">
                </div>
            </div>
            <div class="popup-input">
                <span>${locales['note_content']}</span>
                <div class="popup-input-wrapper">
                    <textarea id="citizen-note-text" placeholder="${locales['enter_content']}"></textarea>
                </div>
            </div>
            <div class="popup-input">
                <span>${locales['important']}</span>
                <div class="popup-switch">
                    <label class="switch">
                        <input type="checkbox" id="citizen-note-important">
                        <span class="slider round"></span>
                    </label>
                </div>
            </div>
            <div class="popup-bot">
                <div class="vehicle-btn" onclick="ClosePopup()">${locales['cancel']}</div>
                <div class="vehicle-btn" onclick="AddCitizenNote()">${locales['add']}</div>
            </div>
        </div>
        <div class="gmt-popup" id="add-citizen-procedure-popup" style="display: none;">
            <span>${locales['add_procedure']}</span>
            <div class="popup-input">
                <span>${locales['procedure_title']}</span>
                <div class="popup-input-wrapper">
                    <input id="citizen-procedure-title" type="text" placeholder="${locales['enter_title']}">
                </div>
            </div>
            <div class="popup-input">
                <span>${locales['procedure_content']}</span>
                <div class="popup-input-wrapper">
                    <textarea id="citizen-procedure-text" placeholder="${locales['enter_content']}"></textarea>
                </div>
            </div>
            <div class="popup-input">
                <span>${locales['important']}</span>
                <div class="popup-switch">
                    <label class="switch">
                        <input type="checkbox" id="citizen-procedure-important">
                        <span class="slider round"></span>
                    </label>
                </div>
            </div>
            <div class="popup-bot">
                <div class="vehicle-btn" onclick="ClosePopup()">${locales['cancel']}</div>
                <div class="vehicle-btn" onclick="AddCitizenProcedure()">${locales['add']}</div>
            </div>
        </div>
        <div class="gmt-popup" id="add-citizen-allergy-popup" style="display: none;">
            <span>${locales['add_allergy']}</span>
            <div class="popup-input">
                <span>${locales['allergy_title']}</span>
                <div class="popup-input-wrapper">
                    <input id="citizen-allergy-title" type="text" placeholder="${locales['enter_title']}">
                </div>
            </div>
            <div class="popup-input">
                <span>${locales['allergy_content']}</span>
                <div class="popup-input-wrapper">
                    <textarea id="citizen-allergy-text" placeholder="${locales['enter_content']}"></textarea>
                </div>
            </div>
            <div class="popup-input">
                <span>${locales['important']}</span>
                <div class="popup-switch">
                    <label class="switch">
                        <input type="checkbox" id="citizen-allergy-important">
                        <span class="slider round"></span>
                    </label>
                </div>
            </div>
            <div class="popup-bot">
                <div class="vehicle-btn" onclick="ClosePopup()">${locales['cancel']}</div>
                <div class="vehicle-btn" onclick="AddCitizenAllergy()">${locales['add']}</div>
            </div>
        </div>
        <div class="gmt-popup" id="add-citizen-blood-popup" style="display: none;">
            <span>${locales['add_blood_donation']}</span>
            <div class="popup-input">
                <span>${locales['description']}</span>
                <div class="popup-input-wrapper">
                    <textarea id="citizen-note-text" placeholder="${locales['enter_description']}"></textarea>
                </div>
            </div>
            <div class="popup-input">
                <span>${locales['important']}</span>
                <div class="popup-switch">
                    <label class="switch">
                        <input type="checkbox" id="citizen-blood-important">
                        <span class="slider round"></span>
                    </label>
                </div>
            </div>
            <div class="popup-bot">
                <div class="vehicle-btn" onclick="ClosePopup()">${locales['cancel']}</div>
                <div class="vehicle-btn" onclick="AddCitizenBlood()">${locales['add']}</div>
            </div>
        </div>
        <div class="gmt-popup" id="add-raport-photo-popup" style="display: none;">Dodaj zdjęcie</span>
            <div class="popup-input"><span>URL do zdjęcia</span>
                <div class="popup-input-wrapper"><input type="text" id="add-raport-photo-url" placeholder="URL do zdjęcia">
                </div>
            </div>
            <div class="popup-bot">
                <div class="vehicle-btn" onclick="ClosePopup()">${locales.cancel}</div>
                <div class="vehicle-btn" onclick="AddRaportPhoto()">${locales['add']}</div>
            </div>
        </div>
    `)
})

const SwitchCitizenTab = ((tab) => {
    let nowDate = new Date().getTime();
    if (antiSpam > nowDate) return;
    if (tab == activeCitizenTab) return;

    antiSpam = nowDate + 100;
    $(`#citizen-${activeCitizenTab}`).hide();
    $(`#citizen-${tab}`).show();
    activeCitizenTab = tab;
})

const SwitchTab = ((tab) => {
    let nowDate = new Date().getTime();
    if (antiSpam > nowDate) return;

    if (tab == activeTab) return;

    antiSpam = nowDate + 250;
    if (activeDetails !== '') {
        CloseDetails();
    }
    $(`#${activeTab}-btn`).removeClass('active-button');
    $(`#${tab}-btn`).addClass('active-button');
    if (tab !== 'citizens') {
        if (tab == 'patrols') {
            $.post('https://piotreq_gmt/fetchData', JSON.stringify({ tab: tab, action: activeAction })).then(data => {
                loadTab({ tab: tab, tabData: data });
                data.action.action.id = activeAction;
                loadAction(data.action);
            })
        }else if (tab == 'raports') {
            $.post('https://piotreq_gmt/fetchRaports', JSON.stringify({ tab: tab })).then(data => {
                loadTab({ tab: tab, tabData: data });
            })
        } else {
            $.post('https://piotreq_gmt/fetchData', JSON.stringify({ tab: tab })).then(data => {
                loadTab({ tab: tab, tabData: data });
            })
        }
    }
    $(`#${activeTab}`).hide();
    $(`#${tab}`).show();
    activeTab = tab;
})

const ToggleSelect = ((id) => {
    let menu = $(`#${id}`);
    if (menu.css('max-height') == '0px') {
        menu.animate({
            opacity: '1.0'
        }, 100)
        menu.css('max-height', '12.5rem');
        menu.css('overflow-y', 'scroll');
        $(`#${id}-arrow`).css('transform', 'rotate(180deg)');
    } else {
        menu.css('max-height', '0px');
        $(`#${id}-arrow`).css('transform', 'rotate(0deg)');
        menu.css('overflow-y', 'hidden');
        menu.animate({
            opacity: '0.0'
        }, 100)
    }
})

const formatDutyTime = ((time) => {
    let hours = (Math.floor(time / 3600)).toString().padStart(2, '0');
    let minutes = (Math.floor((time - (hours * 3600)) / 60)).toString().padStart(2, '0');
    let seconds = (time - (hours * 3600) - (minutes * 60)).toString().padStart(2, '0');
    return `${hours}:${minutes}:${seconds}`;
})

const SelectItem = ((id, value, label) => {
    $(`#${id}-value`).text(label);
    $(`#${id}-value`).attr('data-value', value);
    ToggleSelect(id);
})

const OpenPopup = ((id, data, addon) => {
    if (id == 'change-badge-popup') {
        $('#change-badge-name').val(activeWorker.name);
        $('#change-badge-value').val(typeof activeWorker.badge == 'number' ? activeWorker.badge : "")
    } else if (id == 'update-employee-popup') {
        $('#change-grade-name').val(activeWorker.name);
    } else if (id == 'reset-employee-time-popup') {
        $('#reset-time-name').val(activeWorker.name);
    } else if (id == 'fire-employee-popup') {
        $('#fire-employee-name').val(activeWorker.name);
    } else if (id == 'join-action-popup') {
        $('#join-action-btn').unbind();
        $('#join-action-btn').on('click', () => {
            let unit = $('#action-unit-value').attr('data-value');
            if (!unit) {
                $.post('https://piotreq_gmt/ShowNotification', JSON.stringify({ text: locales['select_unit'] }));
                return;
            };;

            let veh = $('#join-action-veh').val();

            if (veh.length < 1 || veh.includes('<script>')) return;

            veh = removeTags(veh);
            JoinAction({ id: data, veh: veh, unit: unit });
            $('#join-action-veh').val('');
            $('#action-unit-value').attr('data-value', null);
            $('#action-unit-value').text(locales['select_unit']);
        })
    } else if (id == 'add-citizen-license-popup') {
        $('#add-citizen-license-name').val(data);
    } else if (id == 'set-citizen-photo-popup') {
        $('#set-citizen-photo-url').val(data !== 'undefined' ? data : '');
    } else if (id == 'set-employee-photo-popup') {
        $('#set-employee-photo-url').val(data !== 'undefined' ? data : '');
    } else if (id == 'manage-vehicle-popup') {
        $('#manage-vehicle-model').val(data.model);
        $('#manage-vehicle-plate').val(data.plate);
        $('#manage-vehicle-driver').val(data.firstname ? `${data.firstname} ${data.lastname}` : locales['no_data']);
        $('#manage-vehicle-btn').unbind();
        $('#manage-vehicle-btn').on('click', () => {
            let newSSN = $('#manage-vehicle-new-driver').val();
            if (newSSN.length < 1) return;

            $.post('https://piotreq_gmt/actionData', JSON.stringify({ action: 'ChangeDriver', ssn: newSSN, vin: data.vin })).then(data => {
                if (data) {
                    refreshGarage(data);
                    ClosePopup();
                    $('#manage-vehicle-new-driver').val('');
                }
            })
        })
    } else if (id == 'confiscate-vehicle-popup') {
        $('#confiscate-vehicle-plate').val(data);
    } else if (id == 'remove-wheelchair-popup') {
        $('#remove-wheelchair-plate').val(data);
        $('#remove-wheelchair-id').val(addon);
    }
    $(`#${id}`).show();
    $(`.gmt-popups-wrapper`).css('display', 'flex');
    activePopup = id;
})

const ClosePopup = (() => {
    $(`#${activePopup}`).hide();
    $(`.gmt-popups-wrapper`).hide();
    activePopup = '';
})

const OpenDetails = ((id, data) => {
    if (id == activeDetails) return;

    if (activeDetails !== '') {
        $(`#${activeDetails}`).hide();
    }
    if (id == 'raport-details' && data) {
        $('#raport-details').html(`<div class="loader-wrapper"><span class="loader"></span></div>`);
        setTimeout(() => {
            let citizens = "",
            officers = "",
            photos = "";
            for (let citizen in data.citizens) {
                let citizendata = data.citizens[citizen];
                citizendata &&
                (citizens =
                    citizens +
                    (`<div class="judgment-list-item">
                        <span>(${citizendata.ssn}) ${citizendata.name}</span>
                    </div>`)
                );
              }
              for (let officer in data.officers) {
                let officerdata = data.officers[officer];
                officerdata &&
                (officers =
                    officers +
                    (`<div class="judgment-list-item">
                        <span>(${officerdata.ssn}) ${officerdata.name} [${officerdata.job}]</span>
                    </div>`)
                );
              }
              for (let photo in data.photos) {
                let photodata = data.photos[photo];
                console.log(photodata)
                photos =
                    photos +
                    (`<div class="judgment-list-item case-photo">
                        <img onclick="FullScreenImage('${photodata}')" src="${photodata}" alt="">
                    </div>`);
              }
              $("#raport-details").html(
                `
                <div class="top-bar">
                    <div class="square-btn" onclick="CloseDetails()">
                        <i class="fa-solid fa-chevron-left"></i>
                    </div>
                    <span>Raport - #${data.id}</span>
                </div>
                <div class="vehicle-details-wrapper">
                    <div class="vehicle-details-box" id="case-details-info">
                        <div class="vehicle-details-row">
                            <span>Tytuł</span>
                            <span>${data.title}</span>
                        </div>
                        <div class="vehicle-details-row">
                            <span>Autor</span>
                            <span>${data.creatorName}</span>
                        </div>
                    <div class="vehicle-details-row">
                        <span>Data utworzenia</span>
                        <span>${data.create_date}</span>
                    </div>
                    <div class="vehicle-details-row">
                        <span>Data edycji</span>
                        <span>${data.edit_date}</span>
                    </div>
                    <div class="vehicle-details-row">
                        <span>Status</span>
                        ${(data.status == 0
                            ? '<span class="case-status">Niezamknięty</span>'
                            : '<span class="case-status done">Zamknięty</span>'
                        )}
                   </div>
                   <div class="vehicle-btn" id="edit-raport-btn" style="width: fit-content; margin-top: .5rem;">Edytuj</div>
                </div>
                <div class="vehicle-details-box" id="case-desc-info">
                    <span>Opis raportu</span>
                    <span>${data.text}</span>
                </div>
                <div class="vehicle-details-box" id="vehicle-wanted">
                    <span>Powiązani pacjęci</span>
                    <div class="judgment-list">${citizens}</div>
                </div>
                <div class="vehicle-details-box" id="vehicle-wanted">
                    <span>Powiązani ratownicy</span>
                    <div class="judgment-list">${officers}</div>
                </div>
                <div class="vehicle-details-box" id="vehicle-wanted">
                    <span>Zdjęcia</span>
                    <div class="judgment-list">${photos}</div>
                    </div>
                </div>`
              );
              $("#edit-raport-btn").unbind();
              $("#edit-raport-btn").on("click", () => {
                if (!playerAccess.raports) {
                  $.post(
                    "https://piotreq_gmt/ShowNotification",
                    JSON.stringify({ text: locales.no_permission })
                  );
                  return;
                }
                RaportEditor(data);
              });
        }, 200)
    }else if (id == 'employee-details') {
        $('#employee-details').html(`<div class="loader-wrapper"><span class="loader"></span></div>`);
        setTimeout(() => {
            $.post('https://piotreq_gmt/fetchData', JSON.stringify({ tab: 'employee', identifier: data })).then(data2 => {
                activeWorker = data2;
                let notesList = ``;
                for (let i in data2.notes) {
                    let note = data2.notes[i];
                    let time = new Date(note.time * 1000);
                    notesList = notesList + `
                        <div class="employee-note ${note.important == 1 ? 'important' : ''}" id="employee-note-${note.id}">
                            <div class="employee-note-info">
                                <span>${note.title}</span>
                                <i onclick="DeleteEmployeeNote(${note.id})" class="fa-solid fa-trash-can"></i>
                            </div>
                            <span>${note.text}</span>
                            <span>${locales['added_by']}: ${note.firstname} ${note.lastname} ${time.getHours()}:${time.getMinutes()} ${time.getDate()}/${time.getMonth() + 1}/${time.getFullYear()}</span>
                        </div>`
                }

                $('#remove-worker-license').empty();
                for (let i in data2.licenses) {
                    let license = data2.licenses[i];
                    $('#remove-worker-license').append(`<div id="worker-license-${license.type}" onclick="SelectItem('remove-worker-license', '${license.type}', '${license.label}')" class="popup-select-item">${license.label}</div>`);
                }
                $('#employee-details').html(`
                    <div class="top-bar">
                        <div class="square-btn" onclick="CloseDetails()"><i class="fa-solid fa-chevron-left"></i></div>
                        <span>${locales['employee']} - ${data2.name}</span>
                    </div>
                    <div class="citizen-details-wrapper">
                        <div class="citizen-details-main">
                            <div onclick="OpenPopup('set-employee-photo-popup', '${data2.photo}')" id="employee-details-photo" ${data2.photo ? `style="background: center / cover no-repeat url(${data2.photo})"` : ``} class="citizen-photo"></div>
                            <div class="employee-info">
                                <div class="citizen-info-row">
                                    <span>${locales['name_surname']}</span>
                                    <span>${data2.name}</span>
                                </div>
                                <div class="citizen-info-row">
                                    <span>SSN</span>
                                    <span>${data2.ssn}</span>
                                </div>
                                <div class="citizen-info-row">
                                    <span>${locales['radio_channel']}</span>
                                    <span>${data2.radio}</span>
                                </div>
                                <div class="citizen-info-row">
                                    <span>${locales['rank']}</span>
                                    <span id="employee-grade-info">${data2.grade_label}</span>
                                </div>
                                <div class="citizen-info-row">
                                    <span>${locales['last_active']}</span>
                                    <span>${data2.lastActive}</span>
                                </div>
                                <div class="citizen-info-row">
                                    <span>${locales['status']}</span>
                                    <span>${data2.status == 0 ? locales['off_duty'] : data2.status == 1 ? locales['on_duty'] : locales['on_break']}</span>
                                </div>
                                <div class="citizen-info-row">
                                    <span>${locales['join_date']}</span>
                                    <span>${data2.jobJoined}</span>
                                </div>
                                <div class="citizen-info-row">
                                    <span>${locales['duty_time']}</span>
                                    <span id="employee-time-info">${playerAccess['home']['duty_time'] ? formatDutyTime(data2.dutyTime) : locales['no_data']}</span>
                                </div>
                                <div class="citizen-info-row">
                                    <span>${locales['badge']}</span>
                                    <span id="employee-badge-info">${data2.badge}</span>
                                </div>
                                <div class="citizen-info-row">
                                    <span>${locales['assigned_vehicle']}</span>
                                    <span>${data2.vehicle.model ? `${data2.vehicle.model} (${data2.vehicle.plate})` : data2.vehicle}</span>
                                </div>
                            </div>
                        </div>
                        <div class="employee-buttons">
                            <div class="vehicle-btn" onclick="OpenPopup('add-worker-license-popup')">${locales['add_license']}</div>
                            <div class="vehicle-btn" onclick="OpenPopup('remove-worker-license-popup')">${locales['remove_license']}</div>
                            <div class="vehicle-btn" onclick="OpenPopup('change-badge-popup')">${locales['change_badge']}</div>
                            <div class="vehicle-btn" onclick="OpenPopup('update-employee-popup')">${locales['update_rank']}</div>
                            <div class="vehicle-btn" onclick="OpenPopup('fire-employee-popup')">${locales['fire_employee']}</div>
                            <div class="vehicle-btn" onclick="OpenPopup('add-employee-note-popup')">${locales['add_note']}</div>
                            <div class="vehicle-btn" onclick="OpenPopup('reset-employee-time-popup')">${locales['reset_time']}</div>
                            <div class="vehicle-btn" onclick="SendForBreak()">${locales['send_for_break']}</div>
                        </div>
                        <div class="employee-notes-wrapper">
                            <span>${locales['notes']}</span>
                            <div class="employee-note-list" id="employee-note-list">
                            ${notesList}
                            </div>
                        </div>
                    </div>`)
            })
        }, 200);
    } else if (id == 'citizen-details') {
        $('#citizen-details').html(`<div class="loader-wrapper"><span class="loader"></span></div>`);
        setTimeout(() => {
            $.post('https://piotreq_gmt/fetchData', JSON.stringify({ tab: 'citizen', identifier: data })).then(citizenData => {
                activeCitizen = citizenData;
                let notesList = ``;
                let proceduresList = ``;
                let allergiesList = ``;

                if (citizenData.notes) {
                    for (let i in citizenData.notes) {
                        let note = citizenData.notes[i];
                        let time = new Date(note.time * 1000);
                        notesList = notesList + `
                        <div class="citizen-vehicle ${note.important ? 'important' : ''} citizen-note" id="citizen-note-${note.id}">
                            <div class="citizen-vehicle-top">
                                <span>${note.title}</span>
                                ${playerAccess['citizens']['delete_note'] ? `<i onclick="DeleteCitizenNote(${note.id})" class="fa-solid fa-trash-can"></i>` : ''}
                            </div>
                            <span>${note.text}</span>
                            <span>${note.firstname} ${note.lastname} ${formatTime(time)}</span>
                        </div>`
                    }
                }

                if (citizenData.procedures) {
                    for (let i in citizenData.procedures) {
                        let procedure = citizenData.procedures[i];
                        let time = new Date(procedure.time * 1000);
                        proceduresList = proceduresList + `
                        <div class="citizen-vehicle ${procedure.important ? 'important' : ''} citizen-note" id="citizen-procedure-${procedure.id}">
                            <div class="citizen-vehicle-top">
                                <span>${procedure.title}</span>
                                ${playerAccess['citizens']['delete_procedure'] ? `<i onclick="DeleteCitizenProcedure(${procedure.id})" class="fa-solid fa-trash-can"></i>` : ''}
                            </div>
                            <span>${procedure.text}</span>
                            <span>${procedure.firstname} ${procedure.lastname} ${formatTime(time)}</span>
                        </div>`
                    }
                }

                if (citizenData.allergies) {
                    for (let i in citizenData.allergies) {
                        let allergy = citizenData.allergies[i];
                        let time = new Date(allergy.time * 1000);
                        allergiesList = allergiesList + `
                        <div class="citizen-vehicle ${allergy.important ? 'important' : ''} citizen-note" id="citizen-allergy-${allergy.id}">
                            <div class="citizen-vehicle-top">
                                <span>${allergy.title}</span>
                                ${playerAccess['citizens']['delete_allergy'] ? `<i onclick="DeleteCitizenAllergy(${allergy.id})" class="fa-solid fa-trash-can"></i>` : ''}
                            </div>
                            <span>${allergy.text}</span>
                            <span>${allergy.firstname} ${allergy.lastname} ${formatTime(time)}</span>
                        </div>`
                    }
                }

                $('#citizen-details').html(`
                <div class="top-bar">
                    <div class="square-btn" onclick="CloseDetails()"><i class="fa-solid fa-chevron-left"></i></div>
                    <span>${locales['citizen']} - ${citizenData.name}</span>
                </div>
                <div class="citizen-details-wrapper">
                    <div class="citizen-details-main">
                        <div id="citizen-details-photo" onclick="OpenPopup('set-citizen-photo-popup', '${citizenData.photo}')" class="citizen-photo" ${citizenData.photo ? `style="background: center / cover no-repeat url(${citizenData.photo})"` : ``}></div>
                        <div class="citizen-info">
                            <div class="citizen-info-row">
                                <span>${locales['name_surname']}</span>
                                <span>${citizenData.name}</span>
                            </div>
                            <div class="citizen-info-row">
                                <span>SSN</span>
                                <span>${citizenData.ssn}</span>
                            </div>
                            <div class="citizen-info-row">
                                <span>${locales['dob']}</span>
                                <span>${citizenData.dob}</span>
                            </div>
                            <div class="citizen-info-row">
                                <span>${locales['last_hospital_visit']}</span>
                                <span>${citizenData.lastSeen ? formatTime(new Date(citizenData.lastSeen * 1000)) : locales['no_data']}</span>
                            </div>
                            <div class="citizen-info-row">
                                <span>${locales['assigned_wheelchair']}</span>
                                <span>${citizenData.plate || locales['none']}</span>
                            </div>
                        </div>
                    </div>
                    <div class="citizen-details-more">
                        <div class="citizen-details-bar">
                            <div class="citizen-details-bar-btn" onclick="SwitchCitizenTab('procedures')">
                                <span>${locales['procedures']}</span>
                            </div>
                            <div class="citizen-details-bar-btn" onclick="SwitchCitizenTab('allergies')">
                                <span>${locales['allergies']}</span>
                            </div>
                            <div class="citizen-details-bar-btn" onclick="SwitchCitizenTab('notes')">
                                <span>${locales['notes']}</span>
                            </div>
                        </div>
                        <div class="citizen-details-more-main">
                            <div class="citizen-notes-wrapper" id="citizen-procedures" style="display: none;">
                                <div class="vehicle-btn" style="width: fit-content;" onclick="OpenPopup('add-citizen-procedure-popup')">${locales['add_procedure']}</div>
                                <div class="citizen-details-list" id="citizen-procedures-list">
                                    ${proceduresList}
                                </div>
                            </div>
                            <div class="citizen-notes-wrapper" id="citizen-allergies" style="display: none;">
                                <div class="vehicle-btn" style="width: fit-content;" onclick="OpenPopup('add-citizen-allergy-popup')">${locales['add_allergy']}</div>
                                <div class="citizen-details-list" id="citizen-allergies-list">
                                ${allergiesList}
                                </div>
                            </div>
                            <div class="citizen-notes-wrapper" id="citizen-notes" style="display: none;">
                                <div class="vehicle-btn" style="width: fit-content;" onclick="OpenPopup('add-citizen-note-popup')">${locales['add_note']}</div>
                                <div class="citizen-details-list" id="citizen-notes-list">
                                    ${notesList}
                                </div>
                            </div>
                        </div>
                    </div>
                </div>`);
            })
        }, 450);
    }

    activeCitizenTab = '';

    $(`#${activeTab}`).hide();
    $(`#${id}`).show();
    activeDetails = id;
})

const SearchProcedure = ((data) => {
    $('#procedure-search').unbind();
    $('#procedure-search').on('input', () => {
        let value = ($('#procedure-search').val()).toLowerCase();
        if (value.length < 1) {
            loadProcedures(data, false);
        } else {
            let searchedProcedures = [];
            for (let i in data) {
                let procedure = data[i];
                let name = (procedure.patient.name).toLowerCase();
                let id = (procedure.id).toString().toLowerCase();
                if (name.includes(value) || id.includes(value)) {
                    searchedProcedures.push(procedure);
                }
            }
            loadProcedures(searchedProcedures, false);
            searchedProcedures = [];
        }
    })
})

const FinishProcedure = ((id) => {
    if (!playerAccess['procedures'] || !playerAccess['procedures']['finish']) {
        $.post('https://piotreq_gmt/ShowNotification', JSON.stringify({ text: locales['no_permissions'] }));
        return;
    }

    $.post('https://piotreq_gmt/actionData', JSON.stringify({
        action: 'FinishProcedure', id: id
    })).then(data => {
        if (data) {
            loadProcedures(data, true);
            CloseDetails();
        }
    })
})

const SaveProcedure = ((id) => {
    let title = $('#procedure-title').val();
    if (!title || title.length < 2 || title.includes('<script>')) return;

    let comment = $('#procedure-comment').val();
    if (comment.includes('<script>')) return;

    comment = removeTags(comment);
    $.post('https://piotreq_gmt/actionData', JSON.stringify({
        action: 'SaveProcedure', id: id, comment: comment, title: title
    })).then(data => {
        if (data) {
            loadProcedures(data, true);
        }
    })
})

const JoinProcedure = ((id) => {
    $.post('https://piotreq_gmt/actionData', JSON.stringify({
        action: 'JoinProcedure', id: id
    })).then(data => {
        if (data) {
            loadProcedures(data.procedures, true);
            const joinBtn = document.getElementById('join-procedure-btn');
            joinBtn.onclick = (() => { LeaveProcedure(id) });
            $('#join-procedure-btn').text(locales['leave_procedure']);
            $('#personel-details-list').empty();
            for (let i in data.personel) {
                $('#personel-details-list').append(`
                <div class="judgment-list-item" style="padding: .55rem .85rem;">
                    <span>${data.personel[i].name}</span>
                </div>`);
            }
        }
    })
})

const LeaveProcedure = ((id) => {
    $.post('https://piotreq_gmt/actionData', JSON.stringify({
        action: 'LeaveProcedure', id: id
    })).then(data => {
        if (data) {
            loadProcedures(data.procedures, true);
            const leaveBtn = document.getElementById('join-procedure-btn');
            leaveBtn.onclick = (() => { JoinProcedure(id) });
            $('#join-procedure-btn').text(locales['join_procedure']);
            $('#personel-details-list').empty();
            for (let i in data.personel) {
                $('#personel-details-list').append(`
                <div class="judgment-list-item" style="padding: .55rem .85rem;">
                    <span>${data.personel[i].name}</span>
                </div>`);
            }
        }
    })
})

const CloseDetails = (() => {
    $(`#${activeDetails}`).hide();
    $(`#${activeTab}`).show();
    activeDetails = '';
    selectedCitizensCase = {};  selectedOfficersCase = {}; attachedPhotosCase = {};
    activeCitizen = {};
})

const CloseGMT = ((state) => {
    if (state) {
        if (activePopup !== '') {
            ClosePopup();
        }

        if (activeDetails !== '') {
            CloseDetails();
        }

        clearInterval(dutyTimeInterval);
        $('.gmt-wrapper').hide();
        $.post('https://piotreq_gmt/CloseUI');
        return;
    }

    if (activePopup !== '') {
        ClosePopup();
        return;
    }

    if (activeDetails !== '') {
        CloseDetails();
        return;
    }

    clearInterval(dutyTimeInterval);
    $('.gmt-wrapper').hide();
    $.post('https://piotreq_gmt/CloseUI');
})

document.onkeydown = ((e) => {
    if (e.which == 27) {
        if (inFullScreen) {
            $('.full-screen').remove();
            inFullScreen = false;
            return;
        }

        if (inDispatch) {
            CloseDispatch();
            return;
        }

        CloseGMT(false);
    }
})

const FullScreenImage = ((url) => {
    inFullScreen = true;
    $('body').prepend(`<div class="full-screen">
        <div style="background: center / cover no-repeat url('${url}')" class="full-image"></div>
    </div>`);
})

var Raports = [];
const SearchRaport = () => {
    let data = [],
    search = $("#search-raport").val().toLowerCase();
    if (search.length < 1) {
        refreshRaports([...Raports]);
    } else {
      for (let raportId in Raports) {
        let raport = Raports[raportId];
        let title = raport.title?.toLowerCase() || "";
        let creator = raport.creatorName?.toLowerCase() || "";
        let idStr = raport.id?.toString() || "";

        if (
            title.includes(search) ||
            creator.includes(search) ||
            idStr.includes(search)
        ) {
            data.push(raport);
        }
      }
      refreshRaports([...data]);
      data = [];
    }
  },
  refreshRaports = (data) => {
    data.reverse();
    $("#raports-list-wrapper").html(`
        <table id="raports-list">
            <tr>
                <th>Tytuł raportu</th>
                <th>Numer raportu</th>
                <th>Autor</th>
                <th>Status</th>
                <th>Data utworzenia</th>
                <th>Data edycji</th>
                <th style="width: 6%;"></th>
            </tr>
        </table>
    `);
    for (let RaportId in data) {
      let raport = Raports[RaportId];
      $("#raports-list").append(
        "\n        <tr>\n            <td>" +
            raport.title +
            "</td>\n            <td>#" +
            raport.id +
            "</td>\n            <td>" +
            raport.creatorName +
            "</td>\n            <td>" +
            (raport.status == 0
                ? '<div class="player-status off-duty">' +
                "Niezamknięty"+
                "</div>"
                : '<div class="player-status">' + "Zamknięty" + "</div>") +
            "</td>\n            <td>" +
            raport.create_date +
            "</td>\n            <td>" +
            raport.edit_date +
            '</td>\n            <td><div id="raport-details-' +
            raport.id +
            '" class="player-btn"><i class="fa-solid fa-chevron-right"></i></div></td>\n        </tr>'
      );
      $("#raport-details-" + raport.id).unbind();
      $("#raport-details-" + raport.id).on("click", () => {
        OpenDetails("raport-details", raport);
      });
    }
  },
  CreateRaport = () => {
    if (!playerAccess.raports) {
      return;
    }
    let title = $("#new-raport-title").val();
    if (title.length < 3 || title.includes("<script>")) {
      return;
    }
    let text = $("#new-raport-text").val();
    if (text.length < 10 || text.includes("<script>")) {
      return;
    }
    title = removeTags(title);
    text = removeTags(text);
    $.post(
      "https://piotreq_gmt/createRaport",
      JSON.stringify({
        title: title,
        text: text,
        citizens: selectedCitizensCase,
        officers: selectedOfficersCase,
        photos: attachedPhotosCase,
      })
    ).then((data) => {
        if(data){
            CloseDetails()
            $.post('https://piotreq_gmt/fetchRaports', JSON.stringify({ tab: "raports" })).then(data => {
                loadTab({ tab: "raports", tabData: data });
            })
        }
    });
  },
  RemoveRaportCitizen = (data) => {
    selectedCitizensCase[data] &&
      (delete selectedCitizensCase[data],
      $("#selected-citizen-raport-" + data).remove());
  },
  SearchRaportCitizen = () => {
    let data = $("#search-raport-citizen").val();
    if (data.length < 3 || data.includes("<script>")) {
      $("#searched-raport-citizens").hide();
      return;
    }
    $.post(
      "https://piotreq_gmt/fetchData",
      JSON.stringify({
        tab: "citizens",
        value: data,
      })
    ).then((response) => {
      $("#searched-raport-citizens").empty();
      if (response) {
        let users = 0;
        for (let user in response) {
            users++;
          let userdata = response[user],
            ssn = userdata.ssn.toString(),
            object = $(
              '\n                <div class="judgment-player">\n                    <span>(' +
              ssn +
                ") " +
                userdata.firstname +
                " " +
                userdata.lastname +
                "</span>\n                </div>"
            );
          $("#searched-raport-citizens").prepend(object);
          object.on("click", () => {
            if (selectedCitizensCase[ssn]) {
              return;
            }
            $("#search-raport-citizen").val("");
            $("#searched-raport-citizens").css("display", "none");
            selectedCitizensCase[ssn] = {
              ssn: userdata.ssn,
              identifier: userdata.identifier,
              name: userdata.firstname + " " + userdata.lastname,
            };
            $("#create-raport-citizens").append(
              '\n                    <div class="judgment-list-item" id="selected-citizen-raport-' +
                ssn +
                '">\n                        <span>(' +
                ssn +
                ") " +
                userdata.firstname +
                " " +
                userdata.lastname +
                "</span>\n                        <i onclick=\"RemoveRaportCitizen('" +
                ssn +
                '\')" class="fa-solid fa-trash-can" style="font-size: .75rem;"></i>\n                    </div>'
            );
          });
        }
        $("#searched-raport-citizens").css(
          "display",
          users > 0 ? "flex" : "none"
        );
      }
    });
  },
  RemoveRaportOfficer = (data) => {
    selectedOfficersCase[data] &&
      (delete selectedOfficersCase[data],
      $("#selected-raport-case-" + data).remove());
  },
  SearchRaportOfficers = () => {
    let data = $("#search-raport-officer").val();
    if (data.length < 3 || data.includes("<script>")) {
      $("#searched-raport-officers").hide();
      return;
    }
    $.post(
      "https://piotreq_gmt/fetchData",
      JSON.stringify({
        tab: "citizens",
        value: data,
      })
    ).then((response) => {
      $("#searched-raport-officers").empty();
      if (response) {
        let officers = 0;
        for (let officer in response) {
            officers++;
          let officerdata = response[officer],
            ssn = officerdata.ssn.toString(),
            object = $(
              '\n                <div class="judgment-player">\n                    <span>(' +
                ssn +
                ") " +
                officerdata.firstname +
                " " +
                officerdata.lastname +
                " [" +
                officerdata.job +
                "]</span>\n                </div>"
            );
          $("#searched-raport-officers").prepend(object);
          object.on("click", () => {
            if (selectedOfficersCase[ssn]) {
              return;
            }
            $("#search-raport-officer").val("");
            $("#searched-raport-officers").css("display", "none");
            selectedOfficersCase[ssn] = {
              ssn: officerdata.ssn,
              identifier: officerdata.identifier,
              name: officerdata.firstname + " " + officerdata.lastname,
            };
            $("#create-raport-officers").append(
              '\n                    <div class="judgment-list-item" id="selected-officer-raport-' +
                ssn +
                '">\n                        <span>(' +
                ssn +
                ") " +
                officerdata.firstname +
                " " +
                officerdata.lastname +
                " [" +
                officerdata.job +
                "]</span>\n                        <i onclick=\"RemoveRaportOfficer('" +
                ssn +
                '\')" class="fa-solid fa-trash-can" style="font-size: .75rem;"></i>\n                    </div>'
            );
          });
        }
        $("#searched-raport-officers").css(
          "display",
          officers > 0 ? "flex" : "none"
        );
      }
    });
  }
let casePhotoId = 0;
const RemoveRaportPhoto = (data) => {
    data = data.toString();
    if (!attachedPhotosCase[data]) {
      return;
    }
    delete attachedPhotosCase[data];
    $("#raport-photo-" + data).remove();
  },
  AddRaportPhoto = () => {
    let data = $("#add-raport-photo-url").val();
    if (data.length < 1 || data.includes("<script>")) {
      return;
    }
    casePhotoId++;
    attachedPhotosCase[casePhotoId.toString()] = data;
    $("#new-raport-photos").prepend(
      '\n    <div class="judgment-list-item case-photo" id="raport-photo-' +
        casePhotoId +
        '">\n        <span onclick="RemoveRaportPhoto(\'' +
        casePhotoId +
        '\')"><i class="fa-solid fa-trash-can"></i></span>\n        <img src="' +
        data +
        '" alt="">\n    </div>'
    );
    $("#add-raport-photo-url").val("");
    ClosePopup();
  },
  EditRaport = (id) => {
    let title = $("#edit-raport-title").val();
    if (title.length < 3 || title.includes("<script>")) {
      $.post(
        "https://piotreq_gmt/ShowNotification",
        JSON.stringify({ text: locales.title_too_short })
      );
      return;
    }
    let text = $("#edit-raport-text").val();
    if (text.length < 10 || text.includes("<script>")) {
      $.post(
        "https://piotreq_gmt/ShowNotification",
        JSON.stringify({ text: locales.text_too_short })
      );
      return;
    }
    $.post(
      "https://piotreq_gmt/editRaport",
      JSON.stringify({
        id: id,
        title: title,
        text: text,
        citizens: selectedCitizensCase,
        officers: selectedOfficersCase,
        photos: attachedPhotosCase,
        status: $("#edit-raport-status").attr("data-status"),
      })
    ).then((data) => {
        if(data){
            CloseDetails()
            $.post('https://piotreq_gmt/fetchRaports', JSON.stringify({ tab: "raports" })).then(data => {
                loadTab({ tab: "raports", tabData: data });
            })
        }
    });
  },
  ToggleRaportStatus = () => {
    let status = $("#edit-raport-status").attr("data-status");
    status == 0
      ? ((status = 1),
        $("#edit-raport-status").attr("data-status", status),
        $("#edit-raport-status").text("Zamknięty"),
        $("#edit-raport-status").addClass("done"))
      : ((status = 0),
        $("#edit-raport-status").attr("data-status", status),
        $("#edit-raport-status").text("Niezamknięty"),
        $("#edit-raport-status").removeClass("done"));
  },
  RaportEditor = (data) => {
    let citizens = "",
      officers = "",
      photos = "";
    selectedCitizensCase = data.citizens ? data.citizens : {};
    selectedOfficersCase = data.officers ? data.officers : {};
    attachedPhotosCase = data.photos ? data.photos : {};
    for (let citizen in data.citizens) {
      let userdata = data.citizens[citizen];
      userdata &&
        (citizens =
            citizens +
          ('\n            <div class="judgment-list-item" id="selected-citizen-case-' +
            userdata.ssn +
            '">\n                <span>(' +
            userdata.ssn +
            ") " +
            userdata.name +
            "</span>\n                 <i onclick=\"RemoveRaportCitizen('" +
            userdata.ssn +
            '\')" class="fa-solid fa-trash-can" style="font-size: .75rem;"></i>\n            </div>'));
    }
    for (let officer in data.officers) {
      let officerdata = data.officers[officer];
      officerdata &&
        (officers =
            officers +
          ('\n            <div class="judgment-list-item" id="selected-officer-case-' +
            officerdata.ssn +
            '">\n                <span>(' +
            officerdata.ssn +
            ") " +
            officerdata.name +
            " [" +
            officerdata.job +
            "]</span>\n                <i onclick=\"RemoveRaportOfficer('" +
            officerdata.ssn +
            '\')" class="fa-solid fa-trash-can" style="font-size: .75rem;"></i>\n            </div>'));
    }
    for (let photo in data.photos) {
      let photodata = data.photos[photo];
      photos =
        photos +
        ('\n        <div class="judgment-list-item case-photo" id="case-photo-' +
          photo +
          '">\n            <span onclick="RemoveRaportPhoto(\'' +
          photo +
          '\')"><i class="fa-solid fa-trash-can" style="font-size: .75rem;"></i></span>\n            <img src="' +
          photodata +
          '" alt="">\n        </div>');
    }
    $("#raport-details").html(` 
        <div class="top-bar">
            <div class="square-btn" onclick="CloseDetails()"><i class="fa-solid fa-chevron-left"></i></div>
            <span>Edytowanie Raportu</span>
        </div>
        <div class="vehicle-details-wrapper">
            <div class="vehicle-details-box" id="raport-details-info">
                <div class="vehicle-details-row">
                    <span>Tytuł</span>
                    <input type="text" id="edit-raport-title" value="${data.title}" placeholder="Tytuł Raportu">
                </div>
                <div class="vehicle-details-row">
                    <span>Status</span>
                    ${(data.status == 0
                        ? '<span data-status="' +
                          data.status +
                          '" onclick="ToggleRaportStatus()" id="edit-raport-status" class="case-status">Niezamknięty</span>'
                        : '<span data-status="' +
                          data.status +
                          '" onclick="ToggleRaportStatus()" id="edit-raport-status" class="case-status done">Zamknięty</span>')}
                </div>
                <div class="vehicle-btn" onclick="EditRaport(${data.id})" style="width: fit-content; margin-top: .5rem;">Zapisz</div>
            </div>
            <div class="vehicle-details-box" id="raport-desc-info">
                <span>Opis raportu</span>
                <textarea id="edit-raport-text" placeholder="Opis raportu">${data.text}</textarea>
            </div>
            <div class="vehicle-details-box" id="vehicle-wanted">
                <span>Powiązani pacjęci</span>
                <div class="judgment-list">${citizens}</div>
                <div class="gmt-input judgment-input">
                    <input type="text" id="search-raport-citizen" oninput="SearchRaportCitizen()" placeholder="Imię / Nazwisko / SSN obywatela...">
                    <i class="fa-solid fa-user"></i>
                    <div class="judgment-players" id="searched-raport-citizens"></div>
                </div>
            </div>
            <div class="vehicle-details-box" id="vehicle-wanted">
                <span>Powiązani ratownicy</span>
                <div class="judgment-list">${officers}</div>
                <div class="gmt-input judgment-input">
                    <input type="text" id="search-raport-officer" oninput="SearchRaportOfficers()" placeholder="Imię / Nazwisko / SSN ratownika...">
                    <i class="fa-solid fa-user-police"></i>
                    <div class="judgment-players" id="searched-raport-officers">
                    </div>
                </div>
            </div>
            <div class="vehicle-details-box" id="vehicle-wanted">
                <span>Zdjęcia</span>
                <div class="judgment-list" id="new-raport-photos">
                    ${photos}
                    <div class="judgment-list-item case-photo" onclick="OpenPopup('add-raport-photo-popup')">
                        <i class="fa-thin fa-circle-plus" style="font-size: 5rem; opacity: 0.5"></i>
                    </div>
                </div>
            </div>
        </div>`
    );
  },
  RaportCreator = () => {
    if (!playerAccess.raports) {
      $.post(
        "https://piotreq_gmt/ShowNotification",
        JSON.stringify({ text: locales.no_permission })
      );
      return;
    }
    $("#raport-details").html(
      `<div class="top-bar">
            <div class="square-btn" onclick="CloseDetails()">
                <i class="fa-solid fa-chevron-left"></i>
            </div>        
            <span>Utwórz Raport</span>
        </div>    
        <div class="vehicle-details-wrapper">
            <div class="vehicle-details-box" id="raport-details-info">
                <div class="vehicle-details-row">
                    <span>
                        Tytuł
                    </span>
                    <input type="text" id="new-raport-title" placeholder="Nazwa Raportu">
                </div>
            <div class="vehicle-btn" onclick="CreateRaport()" style="width: fit-content; margin-top: .5rem;">Stwórz</div>
        </div>
        <div class="vehicle-details-box" id="raport-desc-info">
            <span>Opis Raportu</span>
            <textarea id="new-raport-text" placeholder="Opis Raportu"></textarea>
        </div>
        <div class="vehicle-details-box" id="vehicle-wanted">
            <span>Powiązani pacjęci</span>
            <div class="judgment-list" id="create-raport-citizens">
            </div>
            <div class="gmt-input judgment-input">
                <input type="text" id="search-raport-citizen" oninput="SearchRaportCitizen()" placeholder="Imię / Nazwisko / SSN obywatela...">
                <i class="fa-solid fa-user"></i>
                <div class="judgment-players" id="searched-raport-citizens">
                </div>
            </div>
        </div>
        <div class="vehicle-details-box" id="vehicle-wanted">
            <span>Powiązani Ratownicy</span>
            <div class="judgment-list" id="create-raport-officers">
            </div>
            <div class="gmt-input judgment-input"><input type="text" id="search-raport-officer" oninput="SearchRaportOfficers()" placeholder="Imię / Nazwisko / SSN ratownika...">
                <i class="fa-solid fa-user-police"></i>
                <div class="judgment-players" id="searched-raport-officers">
                </div>
            </div>
        </div>
        <div class="vehicle-details-box" id="vehicle-wanted">
            <span>Zdjęcia</span>
            <div class="judgment-list" id="new-raport-photos">
                <div class="judgment-list-item case-photo" onclick="OpenPopup('add-raport-photo-popup')">
                    <i class="fa-thin fa-circle-plus" style="font-size: 5rem; opacity: 0.5"></i>
                </div>
            </div>
        </div>`
    );
    OpenDetails("raport-details");
};

// MAIN

const loadTab = ((data) => {
    if (data.tab == 'home') {
        loadHome(data.tabData); return;
    }
    if (data.tab == 'patrols') {
        loadPatrols(data.tabData); return;
    }
    if (data.tab == 'documents') {
        loadDocuments(data.tabData, true); return;
    }
    if (data.tab == 'raports') {
        Raports = data.tabData
        refreshRaports(data.tabData, true); return;
    }
    if (data.tab == 'announcements') {
        Announcements = data.tabData;
        refreshAnnouncements(data.tabData); return;
    }
    if (data.tab == 'employees') {
        loadWorkers(data.tabData); return;
    }
    if (data.tab == 'garage') {
        loadGarage(data.tabData); return;
    }
    if (data.tab == 'wheelchairs') {
        loadWheelchairs(data.tabData, true); return;
    }
})

const AddWheelChair = (() => {
    let ssn = $('#set-wheelchair-ssn').val();
    if (ssn.length < 1) return;

    let days = $('#set-wheelchair-days').val();
    if (days.length < 1) return;

    days = parseInt(days);
    $.post('https://piotreq_gmt/actionData', JSON.stringify({
        action: 'AddWheelChair', ssn: ssn, days: days
    })).then(data => {
        if (data) {
            loadWheelchairs(data, true);
        }
    })
    ClosePopup();
})

const RemoveWheelChair = (() => {
    let plate = $('#remove-wheelchair-plate').val();
    if (plate.length < 1) return;
    $.post('https://piotreq_gmt/actionData', JSON.stringify({
        action: 'RemoveWheelChair', plate: plate
    })).then(data => {
        if (data) {
            loadWheelchairs(data, true);
        }
    })
    ClosePopup();
})

const loadWheelchairs = ((data, update) => {
    $('#wheelchairs-list').html(`
    <tr>
        <th>${locales['citizen']}</th>
        <th>${locales['wheelchair_id']}</th>
        <th>${locales['status']}</th>
        <th>${locales['validity']}</th>
        <th style="width: 6%;"></th>
    </tr>`);
    for (let i in data) {
        let wheelchair = data[i];
        let expire = formatTime(new Date(wheelchair.wheelchairTime * 1000));
        $('#wheelchairs-list').append(`
        <tr>
            <td>${wheelchair.firstname} ${wheelchair.lastname}</td>
            <td>#${parseInt(i) + 1}</td>
            <td><div class="player-status">${wheelchair.status == 0 ? locales['out_of_garage'] : locales['in_garage']}</div></td>
            <td>${expire}</td>
            <td><div style="display: flex; align-items: center; gap: .75rem;"><div onclick="OpenPopup('remove-wheelchair-popup', '${wheelchair.plate}', '${parseInt(i) + 1}')" class="player-btn"><i class="fa-solid fa-trash-can"></i></div></div></td>
        </tr>`)
    }
})

const AddDocument = (() => {
    let ssn = $('#new-document-ssn').val();
    if (ssn.length < 1) return;

    let type = $('#new-document-select-value').attr('data-value');
    if (!type) return;

    let days = $('#new-document-time').val();
    if (days.length < 1) return;

    days = parseInt(days);

    $.post('https://piotreq_gmt/actionData', JSON.stringify({
        action: 'AddDocument', type: type, ssn: ssn, days: days
    })).then(data => {
        if (data) {
            loadDocuments(data, true);
        }
    })
    ClosePopup();
})

let documentsData = [];
const loadDocuments = ((data, update) => {
    $('#documents-list-wrapper').html(`
    <table class="citizens-list" id="documents-list">
        <tr>
            <th>${locales['citizen']}</th>
            <th>${locales['added_by']}</th>
            <th>${locales['document_type']}</th>
            <th>${locales['join_date']}</th>
            <th>${locales['validity']}</th>
            <th style="width: 2%;"></th>
        </tr>
    </table>`);
    for (let i in data) {
        let document = data[i];
        let expireTime = formatTime(new Date(document.expireTime * 1000));
        let time = formatTime(new Date(document.time * 1000));
        $('#documents-list').append(`
        <tr>
            <td>${document.ownerFname} ${document.ownerLname}</td>
            <td>${document.workerFname} ${document.workerLname}</td>
            <td>${document.label}</td>
            <td>${time}</td>
            <td>${expireTime}</td>
            <td><div onclick="RemoveDocument('${document.id}')" class="player-btn"><i class="fa-solid fa-trash-can"></i></div></td>
        </tr>`)
    }
    if (update) {
        documentsData = data;
    }
})

const RemoveDocument = ((id) => {
    $.post('https://piotreq_gmt/actionData', JSON.stringify({
        action: 'RemoveDocument', id: id
    })).then(data => {
        if (data) {
            loadDocuments(data, true);
        }
    })
})

const SearchDocuments = (() => {
    let value = $('#search-document').val().toLowerCase();
    if (value.length < 1) {
        loadDocuments(documentsData, false);
    } else {
        let tempTable = [];
        for (let i in documentsData) {
            let document = documentsData[i];
            let owner = `${document.ownerFname} ${document.ownerLname}`.toLowerCase();
            let worker = `${document.workerFname} ${document.workerLname}`.toLowerCase();
            if (owner.includes(value) || worker.includes(value)) {
                tempTable.push(document);
            }
        }
        loadDocuments(tempTable, false);
        tempTable = [];
    }

})

const ImpoundVehicles = (() => {
    if (!playerAccess['garage'] || !playerAccess['garage']['impound']) {
        $.post('https://piotreq_gmt/ShowNotification', JSON.stringify({ text: locales['no_permissions'] }));
        return;
    };

    $.post('https://piotreq_gmt/actionData', JSON.stringify({ action: 'ImpoundVehicles' })).then(data => {
        if (data) {
            refreshVehicles(data);
            $('#search-garage').unbind();
            $('#search-garage').on('input', () => {
                let searchedGarage = [];
                let value = ($('#search-garage').val()).toLowerCase();
                for (let i in data) {
                    let veh = data[i];
                    let model = (veh.model).toLowerCase();
                    let plate = (veh.plate).toLowerCase();
                    let vin = (veh.vin).toLowerCase();
                    let name = veh.firstname ? (veh.firstname + ' ' + veh.lastname).toLowerCase() : null;
                    if (model.includes(value) || plate.includes(value) || vin.includes(value) || (name && name.includes(value))) {
                        searchedGarage.push(veh);
                    }
                }
                refreshGarage(searchedGarage);
                searchedGarage = [];
            })
        }
    })
})

const reloadGarage = (() => {
    let nowDate = new Date().getTime();
    if (antiSpam > nowDate) return;

    antiSpam = nowDate + 500;
    $.post('https://piotreq_gmt/fetchData', JSON.stringify({ tab: 'garage' })).then(data => {
        refreshGarage(data);
        $('#search-garage').unbind();
        $('#search-garage').on('input', () => {
            let searchedGarage = [];
            let value = ($('#search-garage').val()).toLowerCase();
            for (let i in data) {
                let veh = data[i];
                let model = (veh.model).toLowerCase();
                let plate = (veh.plate).toLowerCase();
                let vin = (veh.vin).toLowerCase();
                let name = veh.firstname ? (veh.firstname + ' ' + veh.lastname).toLowerCase() : null;
                if (model.includes(value) || plate.includes(value) || vin.includes(value) || (name && name.includes(value))) {
                    searchedGarage.push(veh);
                }
            }
            refreshGarage(searchedGarage);
            searchedGarage = [];
        })
    })
})

const loadGarage = ((data) => {
    $('#garage').html(`
        <div class="top-bar">
            <span>${locales['garage']}</span>
        </div>
        <div class="citizens-wrapper">
            <div class="employees-top">
                <div class="gmt-input" style="width: 55%;">
                    <input type="text" id="search-garage" placeholder="${locales['search_vehicle']}">
                    <i class="fa-solid fa-magnifying-glass"></i>
                </div>
                <div class="employees-btn" onclick="reloadGarage()" style="width: 15%;">
                    <i class="fa-regular fa-arrows-rotate"></i>
                    <span>${locales['refresh']}</span>
                </div>
                <div class="employees-btn" onclick="ImpoundVehicles()" style="width: 15%;">
                    <i class="fa-regular fa-truck-tow"></i>
                    <span>${locales['impound']}</span>
                </div>
                <div class="employees-btn" style="width: 15%;" onclick="OpenPopup('buy-vehicle-popup')">
                    <i class="fa-regular fa-dollar-sign"></i>
                    <span>${locales['buy_vehicle']}</span>
                </div>
            </div>
            <div class="citizens-list" id="garage-list-wrapper">
                <table id="garage-list">
                    <tr>
                        <th>${locales['model']}</th>
                        <th>${locales['driver']}</th>
                        <th>${locales['status']}</th>
                        <th>${locales['plate']}</th>
                        <th>${locales['vin']}</th>
                        <th style="width: 6%;"></th>
                    </tr>
                </table>
            </div>
        </div>`);
    refreshGarage(data);
    $('#search-garage').unbind();
    $('#search-garage').on('input', () => {
        let searchedGarage = [];
        let value = ($('#search-garage').val()).toLowerCase();
        for (let i in data) {
            let veh = data[i];
            let model = (veh.model).toLowerCase();
            let plate = (veh.plate).toLowerCase();
            let vin = (veh.vin).toLowerCase();
            let name = veh.firstname ? (veh.firstname + ' ' + veh.lastname).toLowerCase() : null;
            if (model.includes(value) || plate.includes(value) || vin.includes(value) || (name && name.includes(value))) {
                searchedGarage.push(veh);
            }
        }
        refreshGarage(searchedGarage);
        searchedGarage = [];
    })
})

const refreshGarage = ((data) => {
    $('#garage-list-wrapper').html(`<div class="loader-wrapper"><span class="loader"></span></div>`);
    setTimeout(() => {
        $('#garage-list-wrapper').html(`<table id="garage-list"><tr><th>${locales['model']}</th><th>${locales['driver']}</th><th>${locales['status']}</th><th>${locales['plate']}</th><th>${locales['vin']}</th><th style="width: 6%;"></th></tr></table>`);
        for (let i in data) {
            let vehicle = data[i];
            $('#garage-list').append(`
            <tr>
                <td>${vehicle.model}</td>
                <td>${vehicle.firstname ? `${vehicle.firstname} ${vehicle.lastname}` : locales['no_data']}</td>
                <td>${vehicle.state == 0 ? '<div style="margin: auto; width: 8.5rem" class="player-status off-duty">' + locales['out_of_garage'] + '</div>' : '<div style="margin: auto; width: 8.5rem" class="player-status">' + locales['in_garage'] + '</div>'}</td>
                <td>${vehicle.plate}</td>
                <td>${vehicle.vin}</td>
                <td><div id="garage-veh-btn-${i}" class="player-btn"><i class="fa-solid fa-gear"></i></div></td>
            </tr>`);
            $(`#garage-veh-btn-${i}`).unbind();
            $(`#garage-veh-btn-${i}`).on('click', () => {
                if (!playerAccess['garage'] || !playerAccess['garage']['manage']) {
                    $.post('https://piotreq_gmt/ShowNotification', JSON.stringify({ text: locales['no_permissions'] }));
                    return;
                };

                OpenPopup('manage-vehicle-popup', vehicle);
            })
        }
    }, 150);
})

const SwitchDuty = ((duty) => {
    let nowDate = new Date().getTime();
    if (antiSpam > nowDate) return;

    antiSpam = nowDate + 250;
    $.post('https://piotreq_gmt/SwitchDuty', JSON.stringify({ duty: duty }));
    $('#duty-menu-value').html(`
        ${duty == 0 ? `<span style="color: red;">${locales['off_duty']}</span>` : duty == 1 ? `<span>${locales['on_duty']}</span>` : `<span style="color: orange;">${locales['on_break']}</span>`}
        <i id="duty-menu-arrow" style="transform: rotate(180deg)" class="fa-solid fa-chevron-down"></i>
    `);
    $(`#my-status`).html(duty == 0 ? `<div class="player-status off-duty">${locales['off_duty']}</div>` : duty == 1 ? `<div class="player-status">${locales['on_duty']}</div>` : `<div class="player-status on-break">${locales['on_break']}</div>`);
    ToggleSelect('duty-menu');
    clearInterval(dutyTimeInterval);
    if (duty == 1) {
        dutyTimeInterval = setInterval(() => {
            playerInfo.dutyTime++;
            $(`#welcome-message`).text(`${locales['welcome']}, ${playerInfo.name} - ${playerInfo.grade_label} - ${formatDutyTime(playerInfo.dutyTime)}`);
        }, 1000);
    }
})

const loadGrades = ((data) => {
    $('#update-member').empty();
    $('#add-member').empty();
    for (let i in data) {
        let grade = data[i];
        $('#update-member').append(`<div onclick="SelectItem('update-member', '${grade.grade}', '${grade.label}')" class="popup-select-item">${grade.label}</div>`);
        $('#add-member').append(`<div onclick="SelectItem('add-member', '${grade.grade}', '${grade.label}')" class="popup-select-item">${grade.label}</div>`);
    }
})

const loadHome = ((data) => {
    let citizensList = ``;
    let vehiclesList = ``;
    let mostActiveList = ``;
    for (let i in data.mostActive) {
        let employee = data.mostActive[i];
        mostActiveList = mostActiveList + `
            <div>
                ${playerAccess['home']['most_active_employees'] ? `<span>${employee.firstname} ${employee.lastname}</span><i onclick="OpenDetails('employee-details', '${employee.identifier}')" class="fa-solid fa-chevron-right"></i>` : `<span>???</span><i style="opacity: 0.0" class="fa-solid fa-chevron-right"></i>`}
            </div>`
    }

    for (let i in data.wanted.citizens) {
        let citizen = data.wanted.citizens[i];
        citizensList = citizensList + `
            <div>
                ${playerAccess['home']['last_procedures'] ? `<span>${citizen.firstname} ${citizen.lastname}</span><i style="opacity: 0.0" class="fa-solid fa-chevron-right"></i>` : `<span>???</span><i style="opacity: 0.0" class="fa-solid fa-chevron-right"></i>`}
            </div>`
    }

    for (let i in data.wanted.vehicles) {
        let vehicle = data.wanted.vehicles[i];
        vehiclesList = vehiclesList + `
            <div>
                ${playerAccess['home']['last_assigned_wheelchairs'] ? `<span>${vehicle.plate}</span><i style="opacity: 0.0" class="fa-solid fa-chevron-right"></i>` : `<span>???</span><i style="opacity: 0.0" class="fa-solid fa-chevron-right"></i>`}
            </div>`
    }
    loadGrades(data.grades);
    playerInfo = data.playerInfo;
    $('#home').html(`
        <div class="top-bar">
            <span id="welcome-message">${locales['welcome']}, ${data.playerInfo.name} - ${data.playerInfo.grade_label} - ${formatDutyTime(data.playerInfo.dutyTime)}</span>
            <div style="display: flex; align-items: center; gap: 1rem;">
                <div class="custom-select">
                <div class="custom-select-info" id="duty-menu-value" onclick="ToggleSelect('duty-menu')">
                    ${data.playerInfo.dutyStatus == 0 ? `<span style="color: red;">${locales['off_duty']}</span>` : data.playerInfo.dutyStatus == 1 ? `<span>${locales['on_duty']}</span>` : `<span style="color: orange;">${locales['on_break']}</span>`}
                    <i id="duty-menu-arrow" class="fa-solid fa-chevron-down"></i>
                </div>
                <div class="custom-select-menu" id="duty-menu">
                    <div class="custom-select-option" onclick="SwitchDuty(1)">${locales['on_duty']}</div>
                    <div class="custom-select-option" onclick="SwitchDuty(2)">${locales['on_break']}</div>
                    <div class="custom-select-option" onclick="SwitchDuty(0)">${locales['off_duty']}</div>
                </div>
                </div>
            </div>
        </div>
        <div class="section-main">
            <div class="active-employees-wrapper">
                <div class="active-employees-info">
                    <span>${locales['on_duty']}</span>
                    <span id="active-employees-count">0/0</span>
                </div>
                <div class="active-employees-list">
                    <table id="active-employees-list">
                        <tr>
                            <th>${locales['name_surname']}</th>
                            <th>${locales['rank']}</th>
                            <th>${locales['status']}</th>
                            <th>${locales['radio_channel']}</th>
                            <th>${locales['duty_time']}</th>
                            <th>${locales['last_active']}</th>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="last-items-wrapper">
                <div class="last-items">
                    <span>${locales['last_procedures']}</span>
                    <div class="last-items-list">
                        ${citizensList}
                    </div>
                </div>
                <div class="last-items">
                    <span>${locales['last_assigned_wheelchairs']}</span>
                    <div class="last-items-list">
                        ${vehiclesList}
                    </div>
                </div>
                <div class="last-items">
                    <span>${locales['most_active_employees']}</span>
                    <div class="last-items-list">
                        ${mostActiveList}
                    </div>
                </div>
            </div>
        </div>
    `);
    let activeEmployeesCount = 0;
    for (let i in data.employees) {
        let employee = data.employees[i];
        if (employee.status == 1) {
            activeEmployeesCount++;
            $('#active-employees-list').append(`
                <tr>
                    <td>${employee.name} ${employee.identifier == data.playerInfo.identifier ? `(${locales['you']})` : ''}</td>
                    <td>${employee.grade_label}</td>
                    <td ${employee.identifier == data.playerInfo.identifier ? 'id="my-status"' : ''}>${employee.status == 0 ? `<div class="player-status off-duty">${locales['off_duty']}</div>` : employee.status == 1 ? `<div class="player-status">${locales['on_duty']}</div>` : `<div class="player-status on-break">${locales['on_break']}</div>`}</td>
                    <td>${employee.radio}</td>
                    <td>${playerAccess['home']['duty_time'] ? formatDutyTime(employee.dutyTime) : `${locales['no_data']}`}</td>
                    <td>${playerAccess['home']['last_active'] ? employee.lastActive : locales['no_data']}</td>
                    <td><div id="active-employee-btn-${i}" class="player-btn"><i class="fa-solid fa-chevron-right"></i></div></td>
                </tr>`);
            $(`#active-employee-btn-${i}`).unbind();
            $(`#active-employee-btn-${i}`).on('click', () => {
                if (playerAccess['employees']) {
                    OpenDetails('employee-details', employee.identifier);
                } else {
                    $.post('https://piotreq_gmt/ShowNotification', JSON.stringify({ text: locales['no_permissions'] }));
                }
            })
        }
    }
    $('#active-employees-count').text(`${activeEmployeesCount}/${data.employees.length}`);

    dangerCodes = data.codes;
    for (let i in data.codes) {
        let code = data.codes[i];
        if (code.name == data.dangerCode) {
            $('#codes-menu-value').html(`
                <span style="color: ${code.color}">${code.label}</span>
                <i id="codes-menu-arrow" class="fa-solid fa-chevron-down"></i>
            `);
        }
        $(`#codes-menu`).append(`<div class="custom-select-option" onclick="SwitchCode('${code.name}', '${code.label}', '${code.color}')">${code.label}</div>`);
    }

    clearInterval(dutyTimeInterval);
    if (data.playerInfo.dutyStatus == 1) {
        dutyTimeInterval = setInterval(() => {
            playerInfo.dutyTime++;
            playerInfo = playerInfo;
            $(`#welcome-message`).text(`${locales['welcome']}, ${playerInfo.name} - ${playerInfo.grade_label} - ${formatDutyTime(playerInfo.dutyTime)}`);
        }, 1000);
    }
})

// WORKERS
const DeleteWorkerLicense = (() => {
    if (!activeWorker.identifier) return;

    let license = $('#remove-worker-license-value').attr('data-value');
    if (!license) return;

    $.post('https://piotreq_gmt/actionData', JSON.stringify({
        action: 'DeleteWorkerLicense', player: activeWorker.identifier, type: license
    })).then(data => {
        if (data) {
            for (let i in activeWorker.licenses) {
                if (activeWorker.licenses[i].type == license) {
                    delete activeWorker.licenses[i];
                    break;
                }
            }

            ClosePopup();
            $('#remove-worker-license-value').attr('data-value', null);
            $('#remove-worker-license-value').text(locales['set_license']);
            $(`#worker-license-${license}`).remove();
        }
    })
})

const AddWorkerLicense = (() => {
    if (!activeWorker.identifier) return;

    let license = $('#add-worker-license-value').attr('data-value');
    if (!license) return;

    let hasLicense = false;
    for (let i in activeWorker.licenses) {
        let activeLicense = activeWorker.licenses[i];
        if (activeLicense && activeLicense.type == license) {
            hasLicense = true;
            break;
        }
    }

    if (hasLicense) {
        $.post('https://piotreq_gmt/ShowNotification', JSON.stringify({ text: locales['this_worker_has_this_license'] }));
        return;
    };

    let label = $('#add-worker-license-value').text();

    $.post('https://piotreq_gmt/actionData', JSON.stringify({
        action: 'AddWorkerLicense', player: activeWorker.identifier, type: license, label: label
    })).then(data => {
        if (data) {
            activeWorker.licenses.push({ type: license, label: label });
            ClosePopup();
            $('#add-worker-license-value').attr('data-value', null);
            $('#add-worker-license-value').text(locales['select_license']);
            $('#remove-worker-license').prepend(`<div id="worker-license-${license}" onclick="SelectItem('remove-worker-license', '${license}', '${label}')" class="popup-select-item">${label}</div>`);
        }
    })
})

const SetEmployeePhoto = (() => {
    if (!activeWorker.identifier) return;

    if (!playerAccess['employees'] || !playerAccess['employees']['set_photo']) {
        $.post('https://piotreq_gmt/ShowNotification', JSON.stringify({ text: locales['no_permissions'] }));
        return;
    }
    let photo = $('#set-employee-photo-url').val();
    if (photo.length < 1 || photo.includes('<script>')) {
        $.post('https://piotreq_gmt/ShowNotification', JSON.stringify({ text: locales['too_short_link'] }));
        return;
    };

    photo = removeTags(photo);
    $.post('https://piotreq_gmt/actionData', JSON.stringify({
        action: 'SetEmployeePhoto', player: activeWorker.identifier, photo: photo
    })).then(data => {
        if (data) {
            $(`#employee-details-photo`).css('background', `center / cover no-repeat url(${photo})`);
            ClosePopup();
        }
    });
})

const HireWorker = (() => {
    let id = $('#add-member-id').val();
    if (id.length < 1) return;

    let grade = $('#add-member-value').attr('data-value');
    if (!grade) return;

    if (!playerAccess['employees'] || !playerAccess['employees']['add']) {
        $.post('https://piotreq_gmt/ShowNotification', JSON.stringify({ text: locales['no_permissions'] }));
        return;
    };

    $.post('https://piotreq_gmt/actionData', JSON.stringify({
        action: 'HireWorker', id: id, grade: grade
    })).then(data => {
        if (data) {
            $('#add-member-value').text('Wybierz stopień');
            $('#add-member-value').attr('data-value', null);
            $('#add-member-id').val('');
            ClosePopup();
            refreshWorkers(data);
        }
    })
})

const SendForBreak = (() => {
    if (!playerAccess['employees'] || !playerAccess['employees']['break']) {
        $.post('https://piotreq_gmt/ShowNotification', JSON.stringify({ text: locales['no_permissions'] }));
        return;
    };

    if (activeWorker.status == 2 || activeWorker.status == 0) {
        $.post('https://piotreq_gmt/ShowNotification', JSON.stringify({ text: locales['player_is_off_duty_or_on_break'] }));
        return;
    };

    $.post('https://piotreq_gmt/actionData', JSON.stringify({
        action: 'SendForBreak', identifier: activeWorker.identifier
    })).then(data => {
        if (data) {
            $('#employee-status-info').text('Przerwa');
        }
    })
})

const ResetAllTime = (() => {
    let type = $('#reset-time-value').attr('data-value');
    if (!type) {
        $.post('https://piotreq_gmt/ShowNotification', JSON.stringify({ text: locales['select_workers_to_reset'] }));
        return;
    };;

    if (!playerAccess['employees'] || !playerAccess['employees']['reset_time_all']) {
        $.post('https://piotreq_gmt/ShowNotification', JSON.stringify({ text: locales['no_permissions'] }));
        return;
    };;

    $('#employees-list-wrapper').hide();
    let $loader = $(`<div class="loader-wrapper"><span class="loader"></span></div>`);
    $('#employees-wrapper').append($loader);
    ClosePopup();
    $.post('https://piotreq_gmt/actionData', JSON.stringify({
        action: 'ResetTime', type: type
    })).then(data => {
        if (data) {
            $loader.remove();
            refreshWorkers(data);
        }
    })
})

const ResetEmployeeTime = (() => {
    if (!playerAccess['employees'] || !playerAccess['employees']['reset_time_employee']) {
        $.post('https://piotreq_gmt/ShowNotification', JSON.stringify({ text: locales['no_permissions'] }));
        return;
    }
    $.post('https://piotreq_gmt/actionData', JSON.stringify({
        action: 'ResetTime', employee: true, identifier: activeWorker.identifier
    })).then(data => {
        if (data) {
            ClosePopup();
            $('#employee-time-info').text('00:00:00');
        }
    })
})

const FireWorker = (() => {
    if (!playerAccess['employees'] || !playerAccess['employees']['fire']) {
        $.post('https://piotreq_gmt/ShowNotification', JSON.stringify({ text: locales['no_permissions'] }));
        return;
    }

    let reason = $('#fire-employee-reason').val();
    if (reason.length < 1 || reason.includes('<script>')) return;

    reason = removeTags(reason);
    $.post('https://piotreq_gmt/actionData', JSON.stringify({
        action: 'FireWorker', identifier: activeWorker.identifier, name: activeWorker.name, reason: reason
    })).then(data => {
        if (data) {
            refreshWorkers(data);
            ClosePopup();
            CloseDetails();
        }
    })
})

const UpdateWorker = (() => {
    if (!playerAccess['employees'] || !playerAccess['employees']['update']) {
        $.post('https://piotreq_gmt/ShowNotification', JSON.stringify({ text: locales['no_permissions'] }));
        return;
    }

    let grade = $('#update-member-value').attr('data-value');
    if (!grade) return;

    $.post('https://piotreq_gmt/actionData', JSON.stringify({
        action: 'UpdateWorker', identifier: activeWorker.identifier, grade: grade
    })).then(data => {
        activeWorker.grade_label = data;
        $(`#employee-grade-info`).text(data);
        ClosePopup();
    })
})
const ChangeEmployeeBadge = (() => {
    if (!playerAccess['employees'] || !playerAccess['employees']['change_badge']) {
        $.post('https://piotreq_gmt/ShowNotification', JSON.stringify({ text: locales['no_permissions'] }));
        return;
    }

    let badge = $('#change-badge-value').val();
    if (badge.length < 1) return;
    $.post('https://piotreq_gmt/actionData', JSON.stringify({ action: 'ChangeBadge', identifier: activeWorker.identifier, badge: badge })).then(data => {
        if (data) {
            activeWorker.badge = badge;
            $(`#employee-badge-info`).text(badge);
            ClosePopup();
        }
    })
})

const DeleteEmployeeNote = ((id) => {
    if (!playerAccess['employees'] || !playerAccess['employees']['delete_note']) {
        $.post('https://piotreq_gmt/ShowNotification', JSON.stringify({ text: locales['no_permissions'] }));
        return;
    }

    $.post('https://piotreq_gmt/actionData', JSON.stringify({ action: 'DeleteEmployeeNote', id: id })).then(data => {
        if (data) {
            $(`#employee-note-${id}`).remove();
        }
    })
})

const AddEmployeeNote = (() => {
    if (!playerAccess['employees'] || !playerAccess['employees']['add_note']) {
        $.post('https://piotreq_gmt/ShowNotification', JSON.stringify({ text: locales['no_permissions'] }));
        return;
    }

    let title = $('#employee-note-title').val();
    if (title.length < 1 || title.includes('<script>')) return;

    let text = $('#employee-note-text').val();
    if (text.length < 1 || text.includes('<script>')) return;

    title = removeTags(title); text = removeTags(text);
    let important = $('#employee-note-important').prop('checked');
    $.post('https://piotreq_gmt/actionData', JSON.stringify({
        action: 'AddEmployeeNote',
        title: title, text: text, important: important, identifier: activeWorker.identifier
    })).then(data => {
        if (data) {
            $('#employee-note-title').val('');
            $('#employee-note-text').val('');
            $('#employee-note-important').prop('checked', false);
            ClosePopup();
            $('#employee-note-list').prepend(`
                <div class="employee-note ${important ? 'important' : ''}" id="employee-note-${data.id}">
                    <div class="employee-note-info">
                        <span>${title}</span>
                        <i onclick="DeleteEmployeeNote(${data.id})" class="fa-solid fa-trash-can"></i>
                    </div>
                    <span>${text}</span>
                    <span>${locales['added_by']}: ${data.name} ${data.date}</span>
                </div>`);
        }
    })
})

var Workers = [];
const SearchEmployee = (() => {
    let searched = [];
    let value = ($('#search-employee').val()).toLowerCase();
    if (value.length < 1) {
        refreshWorkers(Workers);
    } else {
        for (let i in Workers) {
            let name = (Workers[i].name).toLowerCase();
            if (name.includes(value)) {
                searched.push(Workers[i]);
            }
        }
        refreshWorkers(searched);
        searched = [];
    }
})

const loadWorkers = ((data) => {
    Workers = data;
    $('#employees').html(`
                <div class="top-bar">
                    <span>${locales['employee']}</span>
                    <span id="employees-count">0/0</span>
                </div>
                <div class="citizens-wrapper" id="employees-wrapper">
                    <div class="employees-top">
                        <div class="gmt-input">
                            <input oninput="SearchEmployee()" id="search-employee" type="text" placeholder="${locales['search_employee']}">
                            <i class="fa-solid fa-magnifying-glass"></i>
                        </div>
                        <div class="employees-btn" onclick="OpenPopup('add-employee-popup')">
                            <i class="fa-regular fa-circle-plus"></i>
                            <span>${locales['add_employee']}</span>
                        </div>
                        <div class="employees-btn" onclick="OpenPopup('reset-time-popup')">
                            <i class="fa-regular fa-clock"></i>
                            <span>${locales['reset_time']}</span>
                        </div>
                    </div>
                    <div class="citizens-list" id="employees-list-wrapper">
                    </div>
                </div>
    `)
    refreshWorkers(data);
})

const refreshWorkers = ((data) => {
    $('#employees-list-wrapper').hide();
    let $loader = $(`<div class="loader-wrapper"><span class="loader"></span></div>`);
    $('#employees-wrapper').append($loader);
    $('#employees-list-wrapper').html(`
    <table id="employees-list">
        <tr>
            <th>${locales['name_surname']}</th>
            <th>${locales['rank']}</th>
            <th>${locales['status']}</th>
            <th>${locales['badge']}</th>
            <th>${locales['duty_time']}</th>
            <th>${locales['last_active']}</th>
            <th style="width: 6%;"></th>
        </tr>
    </table>`);
    let activeCount = 0;
    for (let i in data) {
        let worker = data[i];
        if (worker.status == 1) {
            activeCount++;
        }
        $('#employees-list').append(`
        <tr id="worker-row-${worker.ssn}">
            <td>${worker.name}</td>
            <td>${worker.grade_label}</td>
            <td>${worker.status == 0 ? `<div class="player-status off-duty">${locales['off_duty']}</div>` : worker.status == 1 ? `<div class="player-status">${locales['on_duty']}</div>` : `<div class="player-status on-break">${locales['on_break']}</div>`}</td>
            <td>${worker.badge || locales['no_data']}</td>
            <td>${playerAccess['home']['duty_time'] ? formatDutyTime(worker.dutyTime) : locales['no_data']}</td>
            <td>${playerAccess['home']['last_active'] ? worker.lastActive : locales['no_data']}</td>
            <td><div onclick="OpenDetails('employee-details', '${worker.identifier}')" class="player-btn"><i class="fa-solid fa-chevron-right"></i></div></td>
        </tr>`);
    }
    $('#employees-count').text(`${activeCount}/${data.length}`);
    setTimeout(() => {
        $loader.remove();
        $('#employees-list-wrapper').show();
    }, 100);
})

// ANNOUNCEMENTS

var Announcements = [];
const SearchAnnouncement = (() => {
    let searchedAnn = [];
    let value = ($('#search-announcement').val()).toLowerCase();
    if (value.length < 1) {
        refreshAnnouncements(Announcements);
    } else {
        for (let i in Announcements) {
            let ann = Announcements[i];
            let title = (ann.title).toLowerCase();
            if (title.includes(value)) {
                searchedAnn.push(ann);
            }
        }
        refreshAnnouncements(searchedAnn);
        searchedAnn = [];
    }
})

const AddAnnouncement = (() => {
    if (!playerAccess['announcements'] || !playerAccess['announcements']['create']) {
        $.post('https://piotreq_gmt/ShowNotification', JSON.stringify({ text: locales['no_permissions'] }));
        return;
    };

    let title = $('#add-announcement-title').val();
    if (title.length < 2 || title.includes('<script>')) return;

    let text = $('#add-announcement-text').val();
    if (text.length < 2 || text.includes('<script>')) return;

    let important = $('#add-announcement-check').prop('checked');
    $.post('https://piotreq_gmt/actionData', JSON.stringify({
        action: 'AddAnnouncement', title: title, text: text, important: important
    })).then(data => {
        ClosePopup();
        Announcements = data;
        refreshAnnouncements(data);
    })
})

const DeleteAnnouncement = ((id) => {
    if (!playerAccess['announcements'] || !playerAccess['announcements']['delete']) {
        $.post('https://piotreq_gmt/ShowNotification', JSON.stringify({ text: locales['no_permissions'] }));
        return;
    };

    $.post('https://piotreq_gmt/actionData', JSON.stringify({
        action: 'DeleteAnnouncement', id: id
    })).then(data => {
        if (data) {
            Announcements = data;
            refreshAnnouncements(data);
        }
    })
})

const refreshAnnouncements = ((data) => {
    $('.announcements-list').empty();
    for (let i in data) {
        let ann = data[i];
        let time = new Date(ann.time * 1000);
        $('.announcements-list').append(`
        <div id="ann-${ann.id}" class="announcement ${ann.important == 1 ? 'important' : ''}">
            <div class="announcement-top">
                <span>${ann.title}</span>
                ${playerAccess['announcements']['delete'] ? `<div onclick="DeleteAnnouncement(${ann.id})" class="square-btn"><i class="fa-solid fa-trash-can"></i></div>` : ``}
            </div>
            <span>${ann.text}</span>
            <span>${ann.firstname} ${ann.lastname}, ${formatTime(time)}</span>
        </div>`);
    }
})

const SetCitizenPhoto = (() => {
    if (!activeCitizen.identifier) return;

    if (!playerAccess['citizens'] || !playerAccess['citizens']['set_photo']) {
        $.post('https://piotreq_gmt/ShowNotification', JSON.stringify({ text: locales['no_permissions'] }));
        return;
    };

    let photo = $('#set-citizen-photo-url').val();
    if (photo.length < 1 || photo.includes('<script>')) return;

    photo = removeTags(photo);
    $.post('https://piotreq_gmt/actionData', JSON.stringify({
        action: 'SetCitizenPhoto', player: activeCitizen.identifier, photo: photo
    })).then(data => {
        if (data) {
            $(`#citizen-details-photo`).css('background', `center / cover no-repeat url(${photo})`);
        }
    });
})

const DeleteCitizenNote = ((id) => {
    if (!playerAccess['citizens'] || !playerAccess['citizens']['delete_note']) {
        $.post('https://piotreq_gmt/ShowNotification', JSON.stringify({ text: locales['no_permissions'] }));
        return;
    };

    $.post('https://piotreq_gmt/actionData', JSON.stringify({
        action: 'DeleteCitizenNote', id: id
    })).then(data => {
        if (data) {
            $(`#citizen-note-${id}`).remove();
        }
    });
})

const DeleteCitizenAllergy = ((id) => {
    if (!playerAccess['citizens'] || !playerAccess['citizens']['delete_allergy']) {
        $.post('https://piotreq_gmt/ShowNotification', JSON.stringify({ text: locales['no_permissions'] }));
        return;
    };

    $.post('https://piotreq_gmt/actionData', JSON.stringify({
        action: 'DeleteCitizenAllergy', id: id
    })).then(data => {
        if (data) {
            $(`#citizen-allergy-${id}`).remove();
        }
    });
})

const DeleteCitizenProcedure = ((id) => {
    if (!playerAccess['citizens'] || !playerAccess['citizens']['delete_procedure']) {
        $.post('https://piotreq_gmt/ShowNotification', JSON.stringify({ text: locales['no_permissions'] }));
        return;
    };

    $.post('https://piotreq_gmt/actionData', JSON.stringify({
        action: 'DeleteCitizenProcedure', id: id
    })).then(data => {
        if (data) {
            $(`#citizen-procedure-${id}`).remove();
        }
    });
})


const AddCitizenAllergy = (() => {
    if (!activeCitizen.identifier) return;
    let title = $('#citizen-allergy-title').val();
    if (title.length < 1 || title.includes('<script>')) return;

    let text = $('#citizen-allergy-text').val();
    if (text.length < 1 || text.includes('<script>')) return;

    let important = $('#citizen-allergy-important').prop('checked');
    text = removeTags(text);
    $.post('https://piotreq_gmt/actionData', JSON.stringify({
        action: 'AddCitizenAllergy', player: activeCitizen.identifier, text: text, title: title, important: important
    })).then(data => {
        if (data) {
            let time = new Date();
            $('#citizen-allergies-list').prepend(`
            <div class="citizen-vehicle ${important ? 'important' : ''} citizen-note" id="citizen-allergy-${data.id}">
                <div class="citizen-vehicle-top">
                    <span>${title}</span>
                    ${playerAccess['citizens']['delete_allergy'] ? `<i onclick="DeleteCitizenAllergy(${data.id})" class="fa-solid fa-trash-can"></i>` : ''}
                </div>
                <span>${text}</span>
                <span>${data.name} ${formatTime(time)}</span>
            </div>`);
        }
    })
    $('#citizen-allergy-text').val('');
    $('#citizen-allergy-important').prop('checked', false);
    ClosePopup();
})

const AddCitizenProcedure = (() => {
    if (!activeCitizen.identifier) return;
    let title = $('#citizen-procedure-title').val();
    if (title.length < 1 || title.includes('<script>')) return

    let text = $('#citizen-procedure-text').val();
    if (text.length < 1 || text.includes('<script>')) return

    let important = $('#citizen-procedure-important').prop('checked');
    text = removeTags(text);
    $.post('https://piotreq_gmt/actionData', JSON.stringify({
        action: 'AddCitizenProcedure', player: activeCitizen.identifier, title: title, text: text, important: important
    })).then(data => {
        if (data) {
            let time = new Date();
            $('#citizen-procedures-list').prepend(`
            <div class="citizen-vehicle ${important ? 'important' : ''} citizen-note" id="citizen-procedure-${data.id}">
                <div class="citizen-vehicle-top">
                    <span>${title}</span>
                    ${playerAccess['citizens']['delete_procedure'] ? `<i onclick="DeleteCitizenProcedure(${data.id})" class="fa-solid fa-trash-can"></i>` : ''}
                </div>
                <span>${text}</span>
                <span>${data.name} ${formatTime(time)}</span>
            </div>`);
        }
    })
    $('#citizen-procedure-text').val('');
    $('#citizen-procedure-important').prop('checked', false);
    ClosePopup();
})

const AddCitizenNote = (() => {
    if (!activeCitizen.identifier) return;

    if (!playerAccess['citizens'] || !playerAccess['citizens']['add_note']) {
        $.post('https://piotreq_gmt/ShowNotification', JSON.stringify({ text: locales['no_permissions'] }));
        return;
    };

    let title = $('#citizen-note-title').val();
    if (title.length < 1 || title.includes('<script>')) return

    let text = $('#citizen-note-text').val();
    if (title.length < 1 || title.includes('<script>')) return

    let important = $('#citizen-note-important').prop('checked');
    title = removeTags(title);
    text = removeTags(text);
    $.post('https://piotreq_gmt/actionData', JSON.stringify({
        action: 'AddCitizenNote', player: activeCitizen.identifier, title: title, text: text, important: important
    })).then(data => {
        if (data) {
            let time = new Date();
            $('#citizen-notes-list').prepend(`
            <div class="citizen-vehicle ${important ? 'important' : ''} citizen-note" id="citizen-note-${data.id}">
                <div class="citizen-vehicle-top">
                    <span>${title}</span>
                    ${playerAccess['citizens']['delete_note'] ? `<i onclick="DeleteCitizenNote(${data.id})" class="fa-solid fa-trash-can"></i>` : ''}
                </div>
                <span>${text}</span>
                <span>${data.name} ${formatTime(time)}</span>
            </div>`);
        }
    })
    $('#citizen-note-title, #citizen-note-text').val('');
    $('#citizen-note-important').prop('checked', false);
    ClosePopup();
})

const SearchCitizens = (() => {
    let value = $('#citizens-search').val();
    if (Number.isInteger(value.length) == false && value.length < 3) return;

    $('#citizens-list-wrapper').html(`
        <div class="loader-wrapper">
            <span class="loader"></span>
        </div>`);
    setTimeout(() => {
        $.post('https://piotreq_gmt/fetchData', JSON.stringify({ tab: 'citizens', value: value })).then(data => {
            $('#citizens-list-wrapper').html(`
            <table id="citizens-list">
                <tr>
                    <th>${locales['name_surname']}</th>
                    <th>SSN</th>
                    <th>${locales['dob']}</th>
                    <th>${locales['last_hospital_visit']}</th>
                    <th style="width: 6%;"></th>
                </tr>
            </table>`);
            refreshCitizens(data);
        })
    }, 250);
})

const refreshCitizens = ((data) => {
    for (let i in data) {
        let citizen = data[i];
        $('#citizens-list').append(`
        <tr>
            <td class="citizen-name"><div class="citizen-avatar" ${citizen.photo ? `style="background: center / cover no-repeat url(${citizen.photo})"` : ``}></div>${citizen.firstname} ${citizen.lastname}</td>
            <td>${citizen.ssn}</td>
            <td>${citizen.dob}</td>
            <td>${citizen.lastSeen ? format(new Date(citizen.lastSeen * 1000)) : 'Brak danych'}</td>
            <td><div onclick="OpenDetails('citizen-details', '${citizen.identifier}')" class="player-btn"><i class="fa-solid fa-chevron-right"></i></div></td>
        </tr>`);
    }
})

// PATROLS

const KickPatrol = ((member) => {
    $.post('https://piotreq_gmt/actionData', JSON.stringify({ action: 'KickPatrol', member: member }));
})

const JoinPatrol = ((owner) => {
    if (!playerAccess['patrols'] || !playerAccess['patrols']['join']) {
        $.post('https://piotreq_gmt/ShowNotification', JSON.stringify({ text: locales['no_permissions'] }));
        return;
    };

    $.post('https://piotreq_gmt/actionData', JSON.stringify({ action: 'JoinPatrol', owner: owner }));
})

const LeavePatrol = (() => {
    $.post('https://piotreq_gmt/actionData', JSON.stringify({ action: 'LeavePatrol' }));
})

const TogglePatrol = (() => {
    $.post('https://piotreq_gmt/actionData', JSON.stringify({ action: 'TogglePatrol' }));
})

const CreatePatrol = (() => {
    if (!playerAccess['patrols'] || !playerAccess['patrols']['create']) {
        $.post('https://piotreq_gmt/ShowNotification', JSON.stringify({ text: locales['no_permissions'] }));
        return;
    };

    let unit = $('#create-patrol-units-value').attr('data-value');
    if (!unit) return;

    let number = $('#create-patrol-number').val();
    if (number.length < 1) return;

    $.post('https://piotreq_gmt/actionData', JSON.stringify({ action: 'CreatePatrol', unit: unit, number: number })).then(data => {
        if (data) {
            ClosePopup();
            $('#create-patrol-units-value').attr('data-value', null);
            $('#create-patrol-units-value').text(locales['select_unit']);
            $('#create-patrol-number').val('');
        }
    })
})

const loadPatrols = ((data) => {
    $('#create-patrol-units').empty();
    for (let i in data.units) {
        $('#create-patrol-units').append(`<div onclick="SelectItem('create-patrol-units', '${data.units[i]}', '${data.units[i]}')" class="popup-select-item">${data.units[i]}</div>`);
    }

    $('#patrols').html(`
    <div class="top-bar">
        <span>${locales['patrols']}</span>
    </div>
    <div class="section-main">
        <div class="patrols-wrapper">
            <div class="patrols-top">
                <div class="gmt-input">
                    <input type="text" id="search-patrol" placeholder="${locales['search_patrol']}">
                    <i class="fa-solid fa-magnifying-glass"></i>
                </div>
                <div class="patrol-btn" onclick="OpenPopup('create-patrol-popup')">${locales['create']}</div>
            </div>
            <div class="patrols-list">
            </div>
        </div>
        <div class="actions-wrapper">
            <div class="employees-top">
                <div class="employees-btn" onclick="SwitchAction(1)">${locales['action']} 1</div>
                <div class="employees-btn" onclick="SwitchAction(2)">${locales['action']} 2</div>
                <div class="employees-btn" onclick="SwitchAction(3)">${locales['action']} 3</div>
                <div class="employees-btn" onclick="SwitchAction(4)">${locales['action']} 4</div>
            </div>
            <div class="action-info">
            </div>
        </div>
    </div>`);
    $('#search-patrol').unbind();
    $('#search-patrol').on('input', () => {
        let value = ($('#search-patrol').val()).toLowerCase();
        let searchedPatrols = [];
        for (let i in data.patrols) {
            let patrol = data.patrols[i];
            let number = (patrol.number).toString().toLowerCase();
            if (number.includes(value) && patrol.job == playerInfo.jobName) {
                searchedPatrols.push(patrol);
            }
        }
        refreshPatrols(searchedPatrols);
        searchedPatrols = [];
    })
    refreshPatrols(data.patrols);
})

const refreshPatrols = ((data) => {
    $('.patrols-list').hide();
    let $loader = $(`<div class="loader-wrapper"><span class="loader"></span></div>`);
    $('.patrols-wrapper').append($loader);
    let patrolList = ``;
    for (let i in data) {
        let patrol = data[i];
        if (patrol.job == playerInfo.jobName) {
            let inPatrol = false;
            if (playerInfo.identifier == patrol.owner) {
                inPatrol = true;
            }

            let patrolMembers = ``;
            for (let j in patrol.members) {
                let member = patrol.members[j];
                if (member.identifier == playerInfo.identifier) {
                    inPatrol = true;
                }

                patrolMembers = patrolMembers + `<div class="patrol-member">
                    <span class="patrol-member-name">${member.name}</span>
                    <span>${member.badge}</span>
                    <span>${member.radio !== locales['no_data'] ? `#${member.radio}` : locales['no_data']}</span>
                    ${patrol.owner == member.identifier ? `<i style="color: yellow" class="fa-solid fa-crown"></i>` : playerInfo.identifier == patrol.owner && playerInfo.identifier !== member.identifier ? `<i onclick="KickPatrol('${member.identifier}')" class="fa-solid fa-trash-can"></i>` : `<i class="fa-solid fa-user"></i>`}
                </div>`
            }
            patrolList = patrolList + `
            <div class="patrol">
                <div class="patrol-info">
                    <span>${locales['patrol']} ${patrol.unit} #${patrol.number}</span>
                    <div class="patrol-manage">
                        ${playerInfo.identifier == patrol.owner ? patrol.status == 1 ? `<div onclick="TogglePatrol()" class="patrol-btn">${locales['open']}</div>` : `<div onclick="TogglePatrol()" class="patrol-btn">${locales['close']}</div>` : ''}
                        ${inPatrol ? `<div onclick="LeavePatrol()" class="patrol-btn">${locales['leave']}</div>` : `<div onclick="JoinPatrol('${patrol.owner}')" class="patrol-btn">${locales['join']}</div>`}
                    </div>
                </div>
                ${patrolMembers}
            </div>`;
        }
    }
    setTimeout(() => {
        $('.patrols-list').html(patrolList);
        $loader.remove();
        $('.patrols-list').css('display', 'flex');
    }, 100);
})

// ACTIONS

const loadAction = ((data) => {
    let membersList = ``;
    let isSourceVisor = false;
    if (data.action.members[data.identifier] && data.action.members[data.identifier].visor) {
        isSourceVisor = true;
    }
    for (let i in data.action.members) {
        let member = data.action.members[i];
        let newMember = `
        <div class="action-officer">
            <span>${member.unit}</span>
            <span>${member.name} [${member.badge}]</span>
            <span>${member.vehicle}</span>
            ${isSourceVisor && i !== data.identifier ? `<i onclick="ChangeVisor('${data.action.id}', '${i}')" class="fa-solid fa-bullhorn square-btn"></i>` : member.visor ? '[SV]' : '<i class="fa-solid fa-user"></i>'}
        </div>`;
        membersList = member.visor ? newMember + membersList : membersList + newMember;
    }
    $('.action-info').html(`
    <div class="action-buttons">
        ${data.onAction ? `<div onclick="LeaveAction('${data.action.id}')" class="vehicle-btn" style="width: fit-content;">${locales['leave']}</div>` : `<div class="vehicle-btn" style="width: fit-content;" onclick="OpenPopup('join-action-popup', '${data.action.id}')">${locales['join']}</div>`}
    </div>
    ${membersList}`);
})

const ChangeVisor = ((id, player) => {
    $('.action-info').html(`<div class="loader-wrapper"><span class="loader"></span></div>`);
    setTimeout(() => {
        $.post('https://piotreq_gmt/actionData', JSON.stringify({ action: 'ChangeVisor', id: id, player: player })).then(data => {
            if (data) {
                data.action.id = id;
                loadAction(data);
            }
        })
    }, 150);
})


const SwitchAction = ((id) => {
    // if (id == activeAction) return;
    activeAction = id;
    $('.action-info').html(`<div class="loader-wrapper"><span class="loader"></span></div>`);
    setTimeout(() => {
        $.post('https://piotreq_gmt/fetchData', JSON.stringify({ tab: 'actionTab', id: id })).then(data => {
            if (data) {
                data.action.id = id;
                loadAction(data);
            }
        })
    }, 350);
})

const JoinAction = ((data) => {
    $.post('https://piotreq_gmt/actionData', JSON.stringify({ action: 'JoinAction', id: data.id, veh: data.veh, unit: data.unit })).then(cbData => {
        if (cbData) {
            cbData.action.id = data.id;
            loadAction(cbData);
            ClosePopup();
        }
    })
})

const LeaveAction = ((id) => {
    $.post('https://piotreq_gmt/actionData', JSON.stringify({ action: 'LeaveAction', id: id })).then(data => {
        if (data) {
            data.action.id = id;
            loadAction(data);
        }
    })
})

const UpdateAction = ((id, code) => {
    $.post('https://piotreq_gmt/actionData', JSON.stringify({ action: 'UpdateAction', id: id, code: code })).then(data => {
        if (data) {
            data.action.id = id;
            loadAction(data);
        }
    })
})

function removeTags(str) {
    str = str.toString();
    return str.replace(/(<([^>]+)>)/ig, '');
}

function formatTime(time) {
    let date = new Date(time);
    return `${(date.getHours()).toString().padStart(2, '0')}:${(date.getMinutes()).toString().padStart(2, '0')} ${(date.getDate()).toString().padStart(2, '0')}/${(date.getMonth() + 1).toString().padStart(2, '0')}/${(date.getFullYear())}`
}

// DISPATCH

const ReportNotification = ((data) => {
    let mainInfo = ``;
    for (let i in data.info) {
        mainInfo = mainInfo + `
        <div class="report-info-row">
            <i class="${data.info[i].icon}"></i>
            <span>${data.info[i].data}</span>
        </div>`
    }
    let $newNotify = $(`
    <div class="dispatch-report notify-report ${data.type ? data.type : 'normal'}">
        <div class="report-top">
            <i class="${data.icon}"></i>
            <span>${data.title}</span>
            <div class="report-box outline-box">${data.code}</div>
            <div class="report-box outline-box">#${data.id}</div>
        </div>
        <div class="report-main">
        ${mainInfo}
        </div>
        <div class="report-bot">
            <div class="report-bot-flex">
                <div class="report-box clickable">${locales['react']}</div>
                <div class="report-box clickable">${locales['location']}</div>
                ${data.canAnswer ? `<div class="report-box clickable">${locales['answer']}</div>` : ''}
            </div>
            <div class="report-bot-flex">
                <div class="report-box outline-box">${data.officers.length}/${data.maxOfficers}</div>
                <div class="report-box"><i class="fa-solid fa-chevron-down"></i></div>
            </div>
        </div>
    </div>`);
    $('.dispatch-notify-wrapper').prepend($newNotify);
    setTimeout(() => {
        $newNotify.css({
            transform: 'translateX(0)',
            opacity: '1.0'
        })
        setTimeout(() => {
            $newNotify.css({
                transform: 'translateX(200%)',
                opacity: '0.0'
            })
            setTimeout(() => {
                $newNotify.remove();
            }, 500);
        }, data.timeout || 5500);
    }, 200);
})

const OpenDispatch = (() => {
    inDispatch = true;
    $('.dispatch-notify-wrapper').hide();
    $('.dispatch').css('display', 'flex');
})

const CloseDispatch = (() => {
    $('.dispatch-notify-wrapper').css('display', 'flex');
    $('.dispatch').hide();
    inDispatch = false;
    $.post('https://piotreq_gmt/CloseUI');
})

var toggledOfficers = {};
const ToggleOfficers = ((id, el) => {
    let dropdown = $(`#report-dropdown-${id}`);
    if (dropdown.css('max-height') == '0px') {
        toggledOfficers[id] = true;
        $(el).children('i').css('transform', `rotate(180deg)`);
        dropdown.css('display', 'flex');
        setTimeout(() => {
            dropdown.css('max-height', dropdown.prop('scrollHeight'));
        }, 10);
    } else {
        toggledOfficers[id] = null;
        $(el).children('i').css('transform', `rotate(0)`);
        dropdown.css('max-height', '0px');
        setTimeout(() => {
            dropdown.hide();
        }, 115);
    }
})

const loadDispatch = ((data) => {
    $('.dispatch').html(`<div class="reports-wrapper"><span>${locales['current_reports']}</span><div class="reports-wrapper-list" id="actual-reports"></div></div>`);
    for (let i in data.dispatch) {
        let report = data.dispatch[i];
        let isActive = false;
        let officers = report.officers;
        let canAdd = true;
        if (report.jobs && !report.jobs[data.job.name]) {
            canAdd = false;
        }

        if (canAdd) {
            let mainInfo = ``;
            for (let j in report.info) {
                mainInfo = mainInfo + `
                <div class="report-info-row">
                    <i class="${report.info[j].icon}"></i>
                    <span>${report.info[j].data}</span>
                </div>`
            }

            if (officers.length > 0) {
                for (let j in officers) {
                    let officer = officers[j];
                    if (officer.identifier == data.identifier) {
                        isActive = true;
                        $('.dispatch').prepend(`<div class="reports-wrapper"><span>${locales['active_report']}</span><div class="reports-wrapper-list" id="active-reports"></div></div>`);
                        break;
                    }
                }
            }

            let officersList = ``;
            for (let i in officers) {
                let officer = officers[i];
                officersList = officersList +
                    `<div class="report-officer">
                    <i class="fa-regular fa-badge-sheriff"></i>
                    <span>[${officer.badge}] <font>${officer.name}</font> [${officer.job}]</span>
                </div>`
            }
            if (isActive) {
                $('#active-reports').prepend(`
                    <div class="dispatch-report ${report.type ? report.type : 'normal'}">
                        <div class="report-top">
                            <i class="${report.icon}"></i>
                            <span>${report.title}</span>
                            <div class="report-box outline-box">${report.code}</div>
                            <div class="report-box outline-box">#${report.id}</div>
                        </div>
                        <div class="report-main">
                        ${mainInfo}
                        </div>
                        <div class="report-bot">
                            <div class="report-bot-flex">
                                <div onclick="CancelReport(${report.id})" class="report-box clickable">${locales['end']}</div>
                                <div onclick="LocateReport(${report.coords.x}, ${report.coords.y})" class="report-box clickable">${locales['location']}</div>
                                ${report.canAnswer ? `<div onclick="AnswerReport(${report.sender})" class="report-box clickable">${locales['answer']}</div>` : ''}
                            </div>
                            <div class="report-bot-flex">
                                <div class="report-box outline-box">${officers.length}/${report.maxOfficers}</div>
                                <div onclick="ToggleOfficers('${report.id}', $(this))" class="report-box"><i ${toggledOfficers[report.id] ? `style="transform: rotate(180deg)"` : ``} class="fa-solid fa-chevron-down"></i></div>
                            </div>
                        </div>
                        <div class="report-officers" ${toggledOfficers[report.id] ? `style="display: flex; max-height: fit-content"` : ``} id="report-dropdown-${report.id}">
                        ${officersList}
                        </div>
                    </div>`);
            } else {
                $('#actual-reports').prepend(`
                    <div class="dispatch-report ${report.type ? report.type : 'normal'}">
                        <div class="report-top">
                            <i class="${report.icon}"></i>
                            <span>${report.title}</span>
                            <div class="report-box outline-box">${report.code}</div>
                            <div class="report-box outline-box">#${report.id}</div>
                        </div>
                        <div class="report-main">
                        ${mainInfo}
                        </div>
                        <div class="report-bot">
                            <div class="report-bot-flex">
                                <div onclick="ReactReport(${report.id})" class="report-box clickable">${locales['react']}</div>
                                <div onclick="LocateReport(${report.coords.x}, ${report.coords.y})" class="report-box clickable">${locales['location']}</div>
                                ${report.canAnswer ? `<div onclick="AnswerReport(${report.sender})" class="report-box clickable">${locales['answer']}</div>` : ''}
                            </div>
                            <div class="report-bot-flex">
                                <div class="report-box outline-box">${officers.length}/${report.maxOfficers}</div>
                                <div onclick="ToggleOfficers('${report.id}', $(this))" class="report-box"><i ${toggledOfficers[report.id] ? `style="transform: rotate(180deg)"` : ``} class="fa-solid fa-chevron-down"></i></div>
                            </div>
                        </div>
                        <div class="report-officers" ${toggledOfficers[report.id] ? `style="display: flex; max-height: fit-content"` : ``} id="report-dropdown-${report.id}">
                        ${officersList}
                        </div>
                    </div>`);
            }
        }
    }
})

const AnswerReport = ((sender) => {
    $.post('https://piotreq_gmt/AnswerReport', JSON.stringify({ sender: sender }));
})

const ReactReport = ((id) => {
    $.post('https://piotreq_gmt/ReactReport', JSON.stringify({ id: id }));
})

const CancelReport = ((id) => {
    $.post('https://piotreq_gmt/CancelReport', JSON.stringify({ id: id }));
})

const LocateReport = ((x, y) => {
    $.post('https://piotreq_gmt/LocateReport', JSON.stringify({ x: x, y: y }));
})

const loadLicenses = ((data) => {
    $('#add-worker-license').empty();
    for (let type in data.police) {
        let license = data.police[type];
        if(license.access[playerData.jobName] != undefined){
            $('#add-worker-license').append(`<div onclick="SelectItem('add-worker-license', '${type}', '${license.label}')" class="popup-select-item">${license.label}</div>`);
        }
    }

    $('#new-document-select').empty();
    for (let type in data.citizen) {
        let license = data.citizen[type];
        $('#new-document-select').append(`<div onclick="SelectItem('new-document-select', '${type}', '${license.label}')" class="popup-select-item">${license.label}</div>`);
    }
})

const BuyVehicle = (() => {
    if (!playerAccess['garage'] || !playerAccess['garage']['buy']) {
        $.post('https://piotreq_gmt/ShowNotification', JSON.stringify({ text: locales['no_permissions'] }));
        return;
    };

    let model = $('#buy-vehicle-value').attr('data-value');
    if (!model) return;

    $.post('https://piotreq_gmt/actionData', JSON.stringify({ action: 'BuyVehicle', model: model })).then(data => {
        if (data) {
            refreshGarage(data);
            ClosePopup();
            $('#buy-vehicle-value').attr('data-value', null);
        }
    })
})
playerData = {}
const loadVehicles = ((data) => {
    $('#buy-vehicle').empty();

    for (let model in data) {
        let veh = data[model];
        if(veh.access.includes(playerData.jobName)){
            let $newVeh = $(`<div class="popup-select-item">${veh.label}</div>`);
            $('#buy-vehicle').append($newVeh);
            $newVeh.on('click', () => {
                SelectItem('buy-vehicle', model, veh.label);
                $('#buy-vehicle-price').val('$ ' + moneyFormat.format(veh.price).replace('$', ''));
            })
        }
    }
})

var moneyFormat = new Intl.NumberFormat('en-US', {
    style: 'currency',
    currency: 'USD',
    minimumFractionDigits: 0
})

window.addEventListener("message", (e) => {
    let data = e.data;
    switch (data.action) {
        case 'OpenGMT':
            myIdentifier = data.id;
            playerData = data.tabData.playerInfo;
            if (!loadedVehicles) {
                loadedVehicles = true;
                loadVehicles(data.vehicles);
            }

            if (Object.keys(GMTLicenses).length < 1) {
                loadLicenses(data.licenses);
                GMTLicenses = data.licenses;
            }

            playerAccess = data.access;
            const buttons = document.querySelectorAll('.side-buttons > .side-btn');
            buttons.forEach(button => {
                if ($(button).attr('id')) {
                    let id = ($(button).attr('id')).replace('-btn', '');
                    if (id !== 'off') {
                        $(`#${id}-btn`).css('display', playerAccess[id] ? 'flex' : 'none');
                    }
                    $(`#${id}-btn > span`).text(locales[id]);
                }
            })
            $(":root").get(0).style.setProperty("--main-color", data.colors.mainColor);
            $(":root").get(0).style.setProperty("--main-color-hover", data.colors.mainColorHover);
            $(":root").get(0).style.setProperty("--main-bg", data.colors.bgColor);
            $('.gmt-logo').css('background', `center / cover no-repeat url('${data.colors.image}')`);
            loadTab(data);
            $('.gmt-wrapper').css('display', 'flex');
            break;
        case 'OpenDispatch':
            OpenDispatch();
            break;
        case 'LoadDispatch':
            loadDispatch(data);
            break;
        case 'ReportNotification':
            ReportNotification(data.alert);
            break;
        case 'RefreshPatrols':
            if (activeTab !== 'patrols') return;

            $('#search-patrol').unbind();
            $('#search-patrol').on('input', () => {
                let value = ($('#search-patrol').val()).toLowerCase();
                let searchedPatrols = [];
                for (let i in data.patrols) {
                    let patrol = data.patrols[i];
                    let number = (patrol.number).toString().toLowerCase();
                    if (number.includes(value) && patrol.job == playerInfo.jobName) {
                        searchedPatrols.push(patrol);
                    }
                }
                refreshPatrols(searchedPatrols);
                searchedPatrols = [];
            })
            refreshPatrols(data.patrols);
            break;
    }
})

var selectedOffenses = {};
const loadOffenses = ((data, updateInput) => {
    $('.offenses-list').empty();
    for (let i in data) {
        let option = data[i];
        $('.offenses-list').append(`
        <div class="offense" id="offense-${option.name}">
            <div class="offense-count">
                <span id="offense-count">${selectedOffenses[option.name] ? selectedOffenses[option.name].count : '0'}</span>
                <div class="offense-buttons">
                    <div class="offense-btn" onclick="OffenseCount('${option.name}', ${option.fine}, '${option.label}', 'minus')"><i class="fa-solid fa-minus"></i></div>
                    <div class="offense-btn" onclick="OffenseCount('${option.name}', ${option.fine}, '${option.label}', 'plus')"><i class="fa-solid fa-plus"></i></div>
                </div>
             </div>
             <div class="offense-info">
                <span>${option.label}</span>
                <span>$ ${option.fine}</span>
            </div>
        </div>`);
    }
    if (!updateInput) return;

    $('#search-offense').on('input', () => {
        let searchedOffenses = [];
        let value = ($('#search-offense').val()).toLowerCase();
        if (value.length < 1) {
            loadOffenses(data);
        } else {
            for (let i in data) {
                let option = data[i];
                let label = (option.label).toLowerCase();
                if (label.includes(value)) {
                    searchedOffenses.push(option);
                }
            }
            loadOffenses(searchedOffenses);
            searchedOffenses = [];
        }
    })
})

const SaveOffenses = (() => {
    let totalFine = 0;
    $('#offenses-list').empty();
    for (const [name, data] of Object.entries(selectedOffenses)) {
        totalFine = totalFine + (data.count * data.fine)
        $(`#offenses-list`).append(`
        <div class="judgment-list-item" id="offense-selected-${name}">
            <span>x${data.count} ${data.label}</span>
            <i class="fa-solid fa-trash-can" onclick="RemoveOffense('${name}')"></i>
        </div>`);
    }
    $('#judgment-fine').val(totalFine);
    CloseDetails();
})

const RemoveOffense = ((name) => {
    let totalFine = 0;
    let totalJail = 0;
    delete selectedOffenses[name];
    $(`#offense-selected-${name}`).remove();
    for (const [name, data] of Object.entries(selectedOffenses)) {
        totalFine = totalFine + (data.count * data.fine)
    }
    $('#judgment-fine').val(totalFine);
})

const OffenseCount = ((name, fine, label, type) => {
    if (type == 'minus') {
        if (!selectedOffenses[name]) return;
        let nowFine = parseInt(($(`#offense-fine-value`).val()).replace('$ ', ''));
        nowFine = nowFine - fine;
        $(`#offense-fine-value`).val('$ ' + nowFine);
        selectedOffenses[name].count--;
        $(`#offense-${name} #offense-count`).text(selectedOffenses[name].count);
        if (selectedOffenses[name].count < 1) {
            delete selectedOffenses[name];
        }
    } else {
        if (!selectedOffenses[name]) {
            selectedOffenses[name] = {
                count: 1,
                fine: fine,
                label: label
            }
        } else {
            selectedOffenses[name].count++;
        }
        let nowFine = parseInt(($(`#offense-fine-value`).val()).replace('$ ', ''));
        nowFine = nowFine + fine;
        $(`#offense-fine-value`).val('$ ' + nowFine);
        $(`#offense-${name} #offense-count`).text(selectedOffenses[name].count);
    }
})

window.onload = (() => {
    $.post('https://piotreq_gmt/loadLocales').then(data => {
        locales = data;
        loadPopups();

        $('#offense-categories').empty();
        $('.offenses-list').empty();
        for (const [category, data] of Object.entries(Judgments)) {
            let $newCategory = $(`<span>${data.label}</span>`);
            $('#offense-categories').append($newCategory);
            $newCategory.on('click', () => { loadOffenses(data.options, true), activeOffenseCategory = category });
            for (let i in data.options) {
                let option = data.options[i];
                allOffensesOptions.push(option);
                $('.offenses-list').append(`
                <div class="offense" id="offense-${option.name}">
                    <div class="offense-count">
                        <span id="offense-count">0</span>
                        <div class="offense-buttons">
                        <div class="offense-btn" onclick="OffenseCount('${option.name}', ${option.fine}, '${option.label}', 'minus')"><i class="fa-solid fa-minus"></i></div>
                        <div class="offense-btn" onclick="OffenseCount('${option.name}', ${option.fine}, '${option.label}', 'plus')"><i class="fa-solid fa-plus"></i></div>
                        </div>
                     </div>
                     <div class="offense-info">
                        <span>${option.label}</span>
                        <span>$ ${option.fine}</span>
                    </div>
                </div>`);
            }
        }
        let $allCategory = $(`<span>${locales['all_category']}</span>`);
        $('#offense-categories').prepend($allCategory);
        $allCategory.on('click', () => { loadOffenses(allOffensesOptions), activeOffenseCategory = 'all' });
        $('#search-offense').on('input', () => {
            let searchedOffenses = [];
            let value = ($('#search-offense').val()).toLowerCase();
            if (value.length < 1) {
                loadOffenses(allOffensesOptions);
            } else {
                for (let i in allOffensesOptions) {
                    let option = allOffensesOptions[i];
                    let label = (option.label).toLowerCase();
                    if (label.includes(value)) {
                        searchedOffenses.push(option);
                    }
                }
                loadOffenses(searchedOffenses);
                searchedOffenses = [];
            }
        })

        $('#citizens').html(`
            <div class="top-bar">
                <span>${locales['citizens']}</span>
            </div>
            <div class="citizens-wrapper">
                <div class="employees-top">
                <div class="gmt-input">
                    <input type="text" id="citizens-search" placeholder="${locales['search-judgment-citizen']}">
                    <i class="fa-solid fa-magnifying-glass"></i>
                </div>
                <div class="employees-btn" style="width: 20%;" onclick="SearchCitizens()">
                    <i class="fa-solid fa-magnifying-glass"></i>
                    <span>${locales['search']}</span>
                </div>
                </div>
                <div class="citizens-list" id="citizens-list-wrapper">
                </div>
            </div>`);
        $("#documents").html(`
            <div class="top-bar">
                <span>${locales['documents']}</span>
            </div>
            <div class="citizens-wrapper">
                <div class="employees-top">
                <div class="gmt-input" style="width: 100%;">
                    <input type="text" id="search-document" oninput="SearchDocuments()" placeholder="${locales['search_document']}">
                    <i class="fa-solid fa-magnifying-glass"></i>
                </div>
                <div class="employees-btn" onclick="OpenPopup('add-new-document-popup')" style="width: 20%;">
                    <i class="fa-regular fa-circle-plus"></i>
                    <span>${locales['add_document']}</span>
                </div>
                </div>
                <div class="citizens-list" id="documents-list-wrapper">
                </div>
            </div>`);

        $('#wheelchairs').html(`
            <div class="top-bar">
                <span>${locales['wheelchairs']}</span>
            </div>
            <div class="citizens-wrapper">
                <div class="employees-top">
                <div class="gmt-input" style="width: 80%;">
                    <input type="text" placeholder="${locales['search']}">
                    <i class="fa-solid fa-magnifying-glass"></i>
                </div>
                <div class="employees-btn" style="width: 20%;" onclick="OpenPopup('set-wheelchair-popup')">
                    <i class="fa-regular fa-wheelchair"></i>
                    <span>${locales['set_wheelchair']}</span>
                </div>
                </div>
                <div class="citizens-list">
                <table id="wheelchairs-list">
                </table>
                </div>
            </div>`);
        $('#notepad').html(`
            <div class="top-bar">
                <span>${locales['notepad']}</span>
            </div>
            <div class="citizens-wrapper">
                <textarea style="margin-top: .5rem; background-color: #ffffff0a; height: 100%; border-radius: .5rem;" name="" id=""></textarea>
            </div>`);
        $('#announcements').html(`
                <div class="top-bar">
                    <span>${locales['announcements']}</span>
                </div>
                <div class="announcements-wrapper">
                    <div class="employees-top">
                        <div class="gmt-input">
                            <input oninput="SearchAnnouncement()" id="search-announcement" type="text" placeholder="${locales['search']}">
                            <i class="fa-solid fa-magnifying-glass"></i>
                        </div>
                        <div class="employees-btn" onclick="OpenPopup('announcement-popup')" style="width: 25%;">
                            <i class="fa-regular fa-circle-plus"></i>
                            <span>${locales['add_annoucement']}</span>
                        </div>
                    </div>
                    <div class="announcements-list">
                    </div>
                </div>`);
        $('#judgements').html(`
            <div class="top-bar">
            <span>${locales['judgements']}</span>
            </div>
            <div class="judgment-wrapper">
            <span style="font-weight: 600;">${locales['players_getting_invoice']}</span>
            <div class="judgment-list" id="judgment-players-selected">
            </div>
            <div class="gmt-input judgment-input">
                <input oninput="SearchJudgmentCitizen()" id="search-judgment-citizen" type="text" placeholder="${locales['search-judgment-citizen']}">
                <i class="fa-solid fa-gavel"></i>
                <div class="judgment-players" id="judgment-players-list">
                </div>
            </div>
            <span style="margin-top: 1rem; font-weight: 600;">${locales['invoice']}</span>
            <div class="judgment-list" id="offenses-list">
                <div class="judgment-list-item">
                <span>${locales['no_data']}</span>
                </div>
            </div>
            <div class="judgment-btn" onclick="OpenDetails('judgment-details')">${locales['edit_invoice']}</div>
            <div class="judgment-bot">
                <div>
                <span>${locales['amount_due']}</span>
                <div class="gmt-input">
                    <input id="judgment-fine" type="number" value="0">
                    <i class="fa-solid fa-dollar-sign"></i>
                </div>
                </div>
            </div>
            <div class="judgment-btn" onclick="ConfirmJudge()">${locales['issue_invoice']}</div>
            </div>`)
    })
})

var selectedCitizensJudgment = {};

const ConfirmJudge = (() => {
    if (Object.keys(selectedCitizensJudgment).length < 1) return;
    if (Object.keys(selectedOffenses).length < 1) return;

    if (!playerAccess['judgements']) {
        $.post('https://piotreq_gmt/ShowNotification', JSON.stringify({ text: locales['no_permissions'] }));
    }

    $.post('https://piotreq_gmt/actionData', JSON.stringify({
        action: 'ConfirmJudge', citizens: selectedCitizensJudgment, offenses: selectedOffenses,
        fine: $('#judgment-fine').val()
    })).then(data => {
        if (data) {
            selectedCitizensJudgment = {};
            selectedOffenses = {};
            $('#judgment-players-selected').empty();
            $('#offenses-list').html(`<div class="judgment-list-item"><span>${locales['no_data']}</span></div>`);
            $('#judgment-fine').val(0);
        }
    })
})

const RemoveJudgmentCitizen = ((ssn) => {
    if (!selectedCitizensJudgment[ssn]) return;

    delete selectedCitizensJudgment[ssn];
    $(`#selected-citizen-judgment-${ssn}`).remove();
})

const SearchJudgmentCitizen = (() => {
    let value = $('#search-judgment-citizen').val();
    if (Number.isInteger(value.length) == false && (value.length < 3 || value.includes('<script>'))) {
        $('#judgment-players-list').hide();
        return;
    }

    $.post('https://piotreq_gmt/fetchData', JSON.stringify({ tab: 'citizens', value: value })).then(data => {
        $('#judgment-players-list').empty();
        if (data) {
            let amount = 0;
            for (let i in data) {
                amount++;
                let citizen = data[i];
                let ssn = (citizen.ssn).toString();
                let $searched = $(`
                <div class="judgment-player">
                    <span>(${ssn}) ${citizen.firstname} ${citizen.lastname}</span>
                </div>`);
                $('#judgment-players-list').prepend($searched);
                $searched.on('click', () => {
                    $('#search-judgment-citizen').val('');
                    $('#judgment-players-list').css('display', 'none');
                    selectedCitizensJudgment[ssn] = {
                        ssn: citizen.ssn,
                        identifier: citizen.identifier,
                        name: citizen.firstname + ' ' + citizen.lastname
                    }
                    $('#judgment-players-selected').append(`
                    <div class="judgment-list-item" id="selected-citizen-judgment-${ssn}">
                        <span>(${ssn}) ${citizen.firstname} ${citizen.lastname}</span>
                        <i onclick="RemoveJudgmentCitizen('${ssn}')" class="fa-solid fa-trash-can" style="font-size: .75rem;"></i>
                    </div>`);
                })
            }
            $('#judgment-players-list').css('display', amount > 0 ? 'flex' : 'none');
        }
    })
})