let activeTab = 'home',
  activePopup = '',
  activeDetails = '',
  activeCitizenTab = '',
  playerInfo = []
var activeWorker = [],
  dutyTimeInterval
let playerAccess = [],
  inDispatch = false
var activeAction = 1,
  activeCitizen = [],
  LSTLicenses = {}
let inFullScreen = false,
  loadedVehicles = false,
  antiSpam = new Date().getTime(),
  isCardOpen = false,
  inCardPopup = false
var injuryList = {}
let myIdentifier = null
var locales = {}
window.onload = () => {
  setTimeout(() => {
    $.post('https://piotreq_lst/loadLocales').then((_0x46a75a) => {
      locales = _0x46a75a
      for (const [_0x513cce, _0x228ac1] of Object.entries(_0x46a75a)) {
        _0x513cce.includes('ui_') &&
          ($('.' + _0x513cce.replace('ui_', '')).text(_0x228ac1),
          $('.' + _0x513cce.replace('ui_', '')).attr('placeholder', _0x228ac1))
      }
      loadPopups()
    })
  }, 100)
}
const loadPopups = () => {
    $('.lst-popups-wrapper').html(
      '\n        <div class="lst-popup" id="create-repair-popup" style="display: none;">\n            <span>' +
        locales.add_repair +
        '</span>\n            <div class="popup-input">\n                <span>' +
        locales.player_id +
        '</span>\n                <div class="popup-input-wrapper">\n                    <input type="number" id="create-repair-player" maxlength="3" placeholder="' +
        locales.input_player_id +
        '">\n                </div>\n            </div>\n            <div class="popup-input">\n                <span>' +
        locales.price +
        '</span>\n                <div class="popup-input-wrapper">\n                    <input type="number" id="create-repair-price" maxlength="3" placeholder="' +
        locales.input_price +
        '">\n                </div>\n            </div>\n            <div class="popup-input">\n                <span>' +
        locales.title +
        '</span>\n                <div class="popup-input-wrapper">\n                    <textarea id="create-repair-title" placeholder="' +
        locales.input_text +
        '"></textarea>\n                </div>\n            </div>\n            <div class="popup-bot">\n                <div class="vehicle-btn" onclick="ClosePopup()">' +
        locales.cancel +
        '</div>\n                <div class="vehicle-btn" onclick="CreateRepair()">' +
        locales.add +
        '</div>\n            </div>\n        </div>\n        <div class="lst-popup" id="add-employee-popup" style="display: none;">\n            <span>' +
        locales.add_worker +
        '</span>\n            <div class="popup-input">\n                <span>' +
        locales.player_id +
        '</span>\n                <div class="popup-input-wrapper">\n                    <input id="add-member-id" type="number" placeholder="' +
        locales.input_player_id +
        '">\n                </div>\n            </div>\n            <div class="popup-input">\n                <span>' +
        locales.grade +
        '</span>\n                <div class="popup-select">\n                    <div class="popup-select-info" onclick="ToggleSelect(\'add-member\')">\n                        <span id="add-member-value">' +
        locales.select_grade +
        '</span>\n                        <i id="add-member-arrow" class="fa-solid fa-chevron-up"></i>\n                    </div>\n                    <div class="popup-select-menu" id="add-member">\n                    </div>\n                </div>\n            </div>\n            <div class="popup-bot">\n                <div class="vehicle-btn" onclick="ClosePopup()">' +
        locales.cancel +
        '</div>\n                <div class="vehicle-btn" onclick="HireWorker()">' +
        locales.add +
        '</div>\n            </div>\n        </div>\n        <div class="lst-popup" id="update-employee-popup" style="display: none;">\n            <span>' +
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
        '</div>\n            </div>\n        </div>\n        <div class="lst-popup" id="fire-employee-popup" style="display: none;">\n            <span>' +
        locales.fire_worker +
        '</span>\n            <div class="popup-input">\n                <span>' +
        locales.full_name +
        '</span>\n                <div class="popup-input-wrapper">\n                    <input id="fire-employee-name" type="text" value="George Gouda" disabled>\n                </div>\n            </div>\n            <div class="popup-input">\n                <span>' +
        locales.reason +
        '</span>\n                <div class="popup-input-wrapper">\n                    <textarea id="fire-employee-reason" placeholder="' +
        locales.input_reason +
        '"></textarea>\n                </div>\n            </div>\n            <div class="popup-bot">\n                <div class="vehicle-btn" onclick="ClosePopup()">' +
        locales.cancel +
        '</div>\n                <div class="vehicle-btn" onclick="FireWorker()">' +
        locales.confirm +
        '</div>\n            </div>\n        </div>\n        <div class="lst-popup" id="add-worker-license-popup" style="display: none;">\n            <span>' +
        locales.add_license +
        '</span>\n            <div class="popup-input">\n                <span>' +
        locales.available_licenses +
        '</span>\n                <div class="popup-select">\n                    <div class="popup-select-info" onclick="ToggleSelect(\'add-worker-license\')">\n                        <span id="add-worker-license-value">' +
        locales.select_license +
        '</span>\n                        <i id="add-worker-license-arrow" class="fa-solid fa-chevron-up"></i>\n                    </div>\n                    <div class="popup-select-menu" id="add-worker-license">\n                    </div>\n                </div>\n            </div>\n            <div class="popup-bot">\n                <div class="vehicle-btn" onclick="ClosePopup()">' +
        locales.cancel +
        '</div>\n                <div class="vehicle-btn" onclick="AddWorkerLicense()">' +
        locales.add +
        '</div>\n            </div>\n        </div>\n        <div class="lst-popup" id="remove-worker-license-popup" style="display: none;">\n            <span>' +
        locales.remove_license +
        '</span>\n            <div class="popup-input">\n                <span>' +
        locales.available_licenses +
        '</span>\n                <div class="popup-select">\n                    <div class="popup-select-info" onclick="ToggleSelect(\'remove-worker-license\')">\n                        <span id="remove-worker-license-value">' +
        locales.select_license +
        '</span>\n                        <i id="remove-worker-license-arrow" class="fa-solid fa-chevron-up"></i>\n                    </div>\n                    <div class="popup-select-menu" id="remove-worker-license">\n                    </div>\n                </div>\n            </div>\n            <div class="popup-bot">\n                <div class="vehicle-btn" onclick="ClosePopup()">' +
        locales.cancel +
        '</div>\n                <div class="vehicle-btn" onclick="DeleteWorkerLicense()">' +
        locales.delete +
        '</div>\n            </div>\n        </div>\n        <div class="lst-popup" id="change-badge-popup" style="display: none;">\n            <span>' +
        locales.change_badge +
        '</span>\n            <div class="popup-input">\n                <span>' +
        locales.full_name +
        '</span>\n                <div class="popup-input-wrapper">\n                    <input id="change-badge-name" type="text" value="" disabled>\n                </div>\n            </div>\n            <div class="popup-input">\n                <span>' +
        locales.badge_number +
        '</span>\n                <div class="popup-input-wrapper">\n                    <input id="change-badge-value" type="number" value="0">\n                </div>\n            </div>\n            <div class="popup-bot">\n                <div class="vehicle-btn" onclick="ClosePopup()">' +
        locales.cancel +
        '</div>\n                <div class="vehicle-btn" onclick="ChangeEmployeeBadge()">' +
        locales.confirm +
        '</div>\n            </div>\n        </div>\n        <div class="lst-popup" id="set-employee-photo-popup" style="display: none;">\n            <span>' +
        locales.set_photo +
        '</span>\n            <div class="popup-input">\n                <span>' +
        locales.photo_url +
        '</span>\n                <div class="popup-input-wrapper">\n                    <input type="text" id="set-employee-photo-url" placeholder="' +
        locales.paste_photo_url +
        '">\n                </div>\n            </div>\n            <div class="popup-bot">\n                <div class="vehicle-btn" onclick="ClosePopup()">' +
        locales.cancel +
        '</div>\n                <div class="vehicle-btn" onclick="SetEmployeePhoto()">' +
        locales.confirm +
        '</div>\n            </div>\n        </div>\n        <div class="lst-popup" id="add-employee-note-popup" style="display: none;">\n            <span>' +
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
        '</div>\n            </div>\n        </div>\n        <div class="lst-popup" id="reset-employee-time-popup" style="display: none;">\n            <span>' +
        locales.reset_time +
        '</span>\n            <div class="popup-input">\n                <span>' +
        locales.full_name +
        '</span>\n                <div class="popup-input-wrapper">\n                    <input id="reset-time-name" type="text" value="" disabled>\n                </div>\n            </div>\n            <div class="popup-bot">\n                <div class="vehicle-btn" onclick="ClosePopup()">' +
        locales.cancel +
        '</div>\n                <div class="vehicle-btn" onclick="ResetEmployeeTime()">' +
        locales.confirm +
        '</div>\n            </div>\n        </div>\n        <div class="lst-popup" id="reset-time-popup" style="display: none;">\n            <span>' +
        locales.reset_time +
        '</span>\n            <div class="popup-input">\n                <span>' +
        locales.workers +
        '</span>\n                <div class="popup-select">\n                    <div class="popup-select-info" onclick="ToggleSelect(\'reset-time\')">\n                        <span id="reset-time-value">' +
        locales.select_workers +
        '</span>\n                        <i id="reset-time-arrow" class="fa-solid fa-chevron-up"></i>\n                    </div>\n                    <div class="popup-select-menu" id="reset-time">\n                        <div class="popup-select-item" onclick="SelectItem(\'reset-time\', \'all\', \'Wszyscy\')">' +
        locales.all +
        "</div>\n                        <div class=\"popup-select-item\" onclick=\"SelectItem('reset-time', 'online', 'Dostępni')\">" +
        locales.online +
        "</div>\n                        <div class=\"popup-select-item\" onclick=\"SelectItem('reset-time', 'offline', 'Niedostępni')\">" +
        locales.offline +
        '</div>\n                    </div>\n                </div>\n            </div>\n            <div class="popup-bot">\n                <div class="vehicle-btn" onclick="ClosePopup()">' +
        locales.cancel +
        '</div>\n                <div class="vehicle-btn" onclick="ResetAllTime()">' +
        locales.confirm +
        '</div>\n            </div>\n        </div>\n        <div class="lst-popup" id="announcement-popup" style="display: none;">\n            <span>' +
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
        '</div>\n            </div>\n        </div>\n        <div class="lst-popup" id="manage-vehicle-popup" style="display: none;">\n            <span>' +
        locales.change_driver +
        '</span>\n            <div class="popup-input">\n                <span>' +
        locales.vehicle_model +
        '</span>\n                <div class="popup-input-wrapper">\n                    <input id="manage-vehicle-model" type="text" value="ELEGY RETRO" disabled>\n                </div>\n            </div>\n            <div class="popup-input">\n                <span>' +
        locales.plate +
        '</span>\n                <div class="popup-input-wrapper">\n                    <input id="manage-vehicle-plate" type="text" value="PIOTREQ69" disabled>\n                </div>\n            </div>\n            <div class="popup-input">\n                <span>' +
        locales.actual_driver +
        '</span>\n                <div class="popup-input-wrapper">\n                    <input id="manage-vehicle-driver" type="text" value="George Gouda" disabled>\n                </div>\n            </div>\n            <div class="popup-input">\n                <span>' +
        locales.new_driver +
        '</span>\n                <div class="popup-input-wrapper">\n                    <input id="manage-vehicle-new-driver" type="number" placeholder="' +
        locales.input_ssn +
        '">\n                </div>\n            </div>\n            <div class="popup-bot">\n                <div class="vehicle-btn" onclick="ClosePopup()">' +
        locales.cancel +
        '</div>\n                <div class="vehicle-btn" id="manage-vehicle-btn">' +
        locales.confirm +
        '</div>\n            </div>\n        </div>\n        <div class="lst-popup" id="buy-vehicle-popup" style="display: none;">\n            <span>' +
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
        '</div>\n            </div>\n        </div>'
    )
  },
  SwitchCitizenTab = (_0x3e2a15) => {
    let _0x13771e = new Date().getTime()
    if (antiSpam > _0x13771e) {
      return
    }
    if (_0x3e2a15 == activeCitizenTab) {
      return
    }
    antiSpam = _0x13771e + 100
    $('#citizen-' + activeCitizenTab).hide()
    $('#citizen-' + _0x3e2a15).show()
    activeCitizenTab = _0x3e2a15
  },
  SwitchTab = (_0x5a7ccf) => {
    let _0x3d5a18 = new Date().getTime()
    if (antiSpam > _0x3d5a18) {
      return
    }
    if (_0x5a7ccf == activeTab) {
      return
    }
    antiSpam = _0x3d5a18 + 250
    activeDetails !== '' && CloseDetails()
    $('#' + activeTab + '-btn').removeClass('active-button')
    $('#' + _0x5a7ccf + '-btn').addClass('active-button')
    _0x5a7ccf !== 'citizens' &&
      (_0x5a7ccf == 'patrols'
        ? $.post(
            'https://piotreq_lst/fetchData',
            JSON.stringify({
              tab: _0x5a7ccf,
              action: activeAction,
            })
          ).then((_0x520107) => {
            loadTab({
              tab: _0x5a7ccf,
              tabData: _0x520107,
            })
            _0x520107.action.action.id = activeAction
            loadAction(_0x520107.action)
          })
        : $.post(
            'https://piotreq_lst/fetchData',
            JSON.stringify({ tab: _0x5a7ccf })
          ).then((_0x1c8cb0) => {
            loadTab({
              tab: _0x5a7ccf,
              tabData: _0x1c8cb0,
            })
          }))
    $('#' + activeTab).hide()
    $('#' + _0x5a7ccf).show()
    activeTab = _0x5a7ccf
  },
  ToggleSelect = (_0x2a959e) => {
    let _0x28a9e1 = $('#' + _0x2a959e)
    _0x28a9e1.css('max-height') == '0px'
      ? (_0x28a9e1.animate({ opacity: '1.0' }, 100),
        _0x28a9e1.css('max-height', '12.5rem'),
        _0x28a9e1.css('overflow-y', 'scroll'),
        $('#' + _0x2a959e + '-arrow').css('transform', 'rotate(180deg)'))
      : (_0x28a9e1.css('max-height', '0px'),
        $('#' + _0x2a959e + '-arrow').css('transform', 'rotate(0deg)'),
        _0x28a9e1.css('overflow-y', 'hidden'),
        _0x28a9e1.animate({ opacity: '0.0' }, 100))
  },
  formatDutyTime = (_0x4ab936) => {
    let _0x27ed44 = Math.floor(_0x4ab936 / 3600)
        .toString()
        .padStart(2, '0'),
      _0xe15386 = Math.floor((_0x4ab936 - _0x27ed44 * 3600) / 60)
        .toString()
        .padStart(2, '0'),
      _0x531098 = (_0x4ab936 - _0x27ed44 * 3600 - _0xe15386 * 60)
        .toString()
        .padStart(2, '0')
    return _0x27ed44 + ':' + _0xe15386 + ':' + _0x531098
  },
  SelectItem = (_0x197698, _0x4dcc7a, _0x19626e) => {
    $('#' + _0x197698 + '-value').text(_0x19626e)
    $('#' + _0x197698 + '-value').attr('data-value', _0x4dcc7a)
    ToggleSelect(_0x197698)
  },
  OpenPopup = (_0x2db82f, _0x3fc8ca) => {
    if (_0x2db82f == 'change-badge-popup') {
      $('#change-badge-name').val(activeWorker.name)
      $('#change-badge-value').val(
        typeof activeWorker.badge == 'number' ? activeWorker.badge : ''
      )
    } else {
      if (_0x2db82f == 'update-employee-popup') {
        $('#change-grade-name').val(activeWorker.name)
      } else {
        if (_0x2db82f == 'reset-employee-time-popup') {
          $('#reset-time-name').val(activeWorker.name)
        } else {
          if (_0x2db82f == 'fire-employee-popup') {
            $('#fire-employee-name').val(activeWorker.name)
          } else {
            if (_0x2db82f == 'add-citizen-license-popup') {
              $('#add-citizen-license-name').val(_0x3fc8ca)
            } else {
              if (_0x2db82f == 'set-citizen-photo-popup') {
                $('#set-citizen-photo-url').val(
                  _0x3fc8ca !== 'undefined' ? _0x3fc8ca : ''
                )
              } else {
                if (_0x2db82f == 'set-employee-photo-popup') {
                  $('#set-employee-photo-url').val(
                    _0x3fc8ca !== 'undefined' ? _0x3fc8ca : ''
                  )
                } else {
                  if (_0x2db82f == 'manage-vehicle-popup') {
                    $('#manage-vehicle-model').val(_0x3fc8ca.model)
                    $('#manage-vehicle-plate').val(_0x3fc8ca.plate)
                    $('#manage-vehicle-driver').val(
                      _0x3fc8ca.firstname
                        ? _0x3fc8ca.firstname + ' ' + _0x3fc8ca.lastname
                        : locales.no_data
                    )
                    $('#manage-vehicle-btn').unbind()
                    $('#manage-vehicle-btn').on('click', () => {
                      let _0x278d37 = $('#manage-vehicle-new-driver').val()
                      if (_0x278d37.length < 1) {
                        $.post(
                          'https://piotreq_lst/ShowNotification',
                          JSON.stringify({ text: locales.input_ssn_new_driver })
                        )
                        return
                      }
                      $.post(
                        'https://piotreq_lst/actionData',
                        JSON.stringify({
                          action: 'ChangeDriver',
                          ssn: _0x278d37,
                          vin: _0x3fc8ca.vin,
                        })
                      ).then((_0x325fe4) => {
                        _0x325fe4 &&
                          (refreshGarage(_0x325fe4),
                          ClosePopup(),
                          $('#manage-vehicle-new-driver').val(''))
                      })
                    })
                  } else {
                    _0x2db82f == 'confiscate-vehicle-popup' &&
                      $('#confiscate-vehicle-plate').val(_0x3fc8ca)
                  }
                }
              }
            }
          }
        }
      }
    }
    $('#' + _0x2db82f).show()
    $('.lst-popups-wrapper').css('display', 'flex')
    activePopup = _0x2db82f
  },
  ClosePopup = () => {
    $('#' + activePopup).hide()
    $('.lst-popups-wrapper').hide()
    activePopup = ''
  },
  OpenDetails = (_0x3ae846, _0xd3e0c7) => {
    if (_0x3ae846 == activeDetails) {
      return
    }
    activeDetails !== '' && $('#' + activeDetails).hide()
    _0x3ae846 == 'employee-details' &&
      ($('#employee-details').html(
        '<div class="loader-wrapper"><span class="loader"></span></div>'
      ),
      setTimeout(() => {
        $.post(
          'https://piotreq_lst/fetchData',
          JSON.stringify({
            tab: 'employee',
            identifier: _0xd3e0c7,
          })
        ).then((_0x1f2eb0) => {
          activeWorker = _0x1f2eb0
          let _0x5274cf = ''
          for (let _0x17abeb in _0x1f2eb0.notes) {
            let _0x44df3c = _0x1f2eb0.notes[_0x17abeb],
              _0x346b2e = new Date(_0x44df3c.time * 1000)
            _0x5274cf =
              _0x5274cf +
              ('\n                        <div class="employee-note ' +
                (_0x44df3c.important == 1 ? 'important' : '') +
                '" id="employee-note-' +
                _0x44df3c.id +
                '">\n                            <div class="employee-note-info">\n                                <span>' +
                _0x44df3c.title +
                '</span>\n                                <i onclick="DeleteEmployeeNote(' +
                _0x44df3c.id +
                ')" class="fa-solid fa-trash-can"></i>\n                            </div>\n                            <span>' +
                _0x44df3c.text +
                '</span>\n                            <span>' +
                locales.added_by +
                ': ' +
                _0x44df3c.firstname +
                ' ' +
                _0x44df3c.lastname +
                ' ' +
                _0x346b2e.getHours() +
                ':' +
                _0x346b2e.getMinutes() +
                ' ' +
                _0x346b2e.getDate() +
                '/' +
                (_0x346b2e.getMonth() + 1) +
                '/' +
                _0x346b2e.getFullYear() +
                '</span>\n                        </div>')
          }
          $('#remove-worker-license').empty()
          for (let _0x1f76e7 in _0x1f2eb0.licenses) {
            let _0x15f220 = _0x1f2eb0.licenses[_0x1f76e7]
            $('#remove-worker-license').append(
              '<div id="worker-license-' +
                _0x15f220.type +
                "\" onclick=\"SelectItem('remove-worker-license', '" +
                _0x15f220.type +
                "', '" +
                _0x15f220.label +
                '\')" class="popup-select-item">' +
                _0x15f220.label +
                '</div>'
            )
          }
          $('#employee-details').html(
            '\n                    <div class="top-bar">\n                        <div class="square-btn" onclick="CloseDetails()"><i class="fa-solid fa-chevron-left"></i></div>\n                        <span>' +
              locales.worker +
              ' - ' +
              _0x1f2eb0.name +
              '</span>\n                    </div>\n                    <div class="citizen-details-wrapper">\n                        <div class="citizen-details-main">\n                            <div onclick="OpenPopup(\'set-employee-photo-popup\', \'' +
              _0x1f2eb0.photo +
              '\')" id="employee-details-photo" ' +
              (_0x1f2eb0.photo
                ? 'style="background: center / cover no-repeat url(' +
                  _0x1f2eb0.photo +
                  ')"'
                : '') +
              ' class="citizen-photo"></div>\n                            <div class="employee-info">\n                                <div class="citizen-info-row">\n                                    <span>' +
              locales.full_name +
              '</span>\n                                    <span>' +
              _0x1f2eb0.name +
              '</span>\n                                </div>\n                                <div class="citizen-info-row">\n                                    <span>' +
              locales.ssn +
              '</span>\n                                    <span>' +
              _0x1f2eb0.ssn +
              '</span>\n                                </div>\n                                <div class="citizen-info-row">\n                                    <span>' +
              locales.radio_channel +
              '</span>\n                                    <span>' +
              _0x1f2eb0.radio +
              '</span>\n                                </div>\n                                <div class="citizen-info-row">\n                                    <span>' +
              locales.grade +
              '</span>\n                                    <span id="employee-grade-info">' +
              _0x1f2eb0.grade_label +
              '</span>\n                                </div>\n                                <div class="citizen-info-row">\n                                    <span>' +
              locales.last_active +
              '</span>\n                                    <span>' +
              _0x1f2eb0.lastActive +
              '</span>\n                                </div>\n                                <div class="citizen-info-row">\n                                    <span>' +
              locales.status +
              '</span>\n                                    <span>' +
              (_0x1f2eb0.status == 0
                ? locales.off_duty
                : _0x1f2eb0.status == 1
                ? locales.on_duty
                : locales.on_break) +
              '</span>\n                                </div>\n                                <div class="citizen-info-row">\n                                    <span>' +
              locales.last_invoiced +
              '</span>\n                                    <span>' +
              _0x1f2eb0.lastRepair +
              '</span>\n                                </div>\n                                <div class="citizen-info-row">\n                                    <span>' +
              locales.joined_date +
              '</span>\n                                    <span>' +
              _0x1f2eb0.jobJoined +
              '</span>\n                                </div>\n                                <div class="citizen-info-row">\n                                    <span>' +
              locales.duty_time +
              '</span>\n                                    <span id="employee-time-info">' +
              (playerAccess.home.duty_time
                ? formatDutyTime(_0x1f2eb0.dutyTime)
                : locales.no_data) +
              '</span>\n                                </div>\n                                <div class="citizen-info-row">\n                                    <span>' +
              locales.badge_number +
              '</span>\n                                    <span id="employee-badge-info">' +
              _0x1f2eb0.badge +
              '</span>\n                                </div>\n                                <div class="citizen-info-row">\n                                    <span>' +
              locales.assigned_vehicle +
              '</span>\n                                    <span>' +
              (_0x1f2eb0.vehicle.model
                ? _0x1f2eb0.vehicle.model + ' (' + _0x1f2eb0.vehicle.plate + ')'
                : _0x1f2eb0.vehicle) +
              '</span>\n                                </div>\n                            </div>\n                        </div>\n                        <div class="employee-buttons">\n                            <div class="vehicle-btn" onclick="OpenPopup(\'add-worker-license-popup\')">' +
              locales.add_license +
              '</div>\n                            <div class="vehicle-btn" onclick="OpenPopup(\'remove-worker-license-popup\')">' +
              locales.remove_license +
              '</div>\n                            <div class="vehicle-btn" onclick="OpenPopup(\'change-badge-popup\')">' +
              locales.change_badge +
              '</div>\n                            <div class="vehicle-btn" onclick="OpenPopup(\'update-employee-popup\')">' +
              locales.change_grade +
              '</div>\n                            <div class="vehicle-btn" onclick="OpenPopup(\'fire-employee-popup\')">' +
              locales.fire_player +
              '</div>\n                            <div class="vehicle-btn" onclick="OpenPopup(\'add-employee-note-popup\')">' +
              locales.add_note +
              '</div>\n                            <div class="vehicle-btn" onclick="OpenPopup(\'reset-employee-time-popup\')">' +
              locales.reset_time +
              '</div>\n                            <div class="vehicle-btn" onclick="SendForBreak()">' +
              locales.send_for_break +
              '</div>\n                        </div>\n                        <div class="employee-notes-wrapper">\n                            <span>' +
              locales.notes +
              '</span>\n                            <div class="employee-note-list" id="employee-note-list">\n                            ' +
              _0x5274cf +
              '\n                            </div>\n                        </div>\n                    </div>'
          )
        })
      }, 200))
    activeCitizenTab = ''
    $('#' + activeTab).hide()
    $('#' + _0x3ae846).show()
    activeDetails = _0x3ae846
  },
  CloseDetails = () => {
    $('#' + activeDetails).hide()
    $('#' + activeTab).show()
    activeDetails = ''
    selectedCitizensCase = {}
    selectedVehiclesCase = {}
    selectedOfficersCase = {}
    attachedPhotosCase = {}
    activeCitizen = {}
    activeVehicle = {}
  },
  CloseLST = (_0x3584d6) => {
    if (_0x3584d6) {
      activePopup !== '' && ClosePopup()
      activeDetails !== '' && CloseDetails()
      clearInterval(dutyTimeInterval)
      $('.lst-wrapper').hide()
      $.post('https://piotreq_lst/CloseUI')
      return
    }
    if (activePopup !== '') {
      ClosePopup()
      return
    }
    if (activeDetails !== '') {
      CloseDetails()
      return
    }
    clearInterval(dutyTimeInterval)
    $('.lst-wrapper').hide()
    $.post('https://piotreq_lst/CloseUI')
  }
document.onkeydown = (_0x3277a5) => {
  if (_0x3277a5.which == 27) {
    if (inFullScreen) {
      $('.full-screen').remove()
      inFullScreen = false
      return
    }
    if (inDispatch) {
      CloseDispatch()
      return
    }
    CloseLST(false)
  }
}
const FullScreenImage = (_0x55d893) => {
    inFullScreen = true
    $('body').prepend(
      '<div class="full-screen">\n        <div style="background: center / cover no-repeat url(\'' +
        _0x55d893 +
        '\')" class="full-image"></div>\n    </div>'
    )
  },
  loadTab = (_0x15548b) => {
    if (_0x15548b.tab == 'home') {
      loadHome(_0x15548b.tabData)
      return
    }
    if (_0x15548b.tab == 'announcements') {
      Announcements = _0x15548b.tabData
      refreshAnnouncements(_0x15548b.tabData)
      return
    }
    if (_0x15548b.tab == 'employees') {
      loadWorkers(_0x15548b.tabData)
      return
    }
    if (_0x15548b.tab == 'garage') {
      loadGarage(_0x15548b.tabData)
      return
    }
    if (_0x15548b.tab == 'orders') {
      loadOrders(_0x15548b.tabData, true)
      return
    }
    if (_0x15548b.tab == 'repairs') {
      loadRepairs(_0x15548b.tabData, true)
      return
    }
  },
  CreateRepair = () => {
    let _0x2215a8 = $('#create-repair-player').val()
    if (_0x2215a8.length < 1) {
      return
    }
    let _0x248d6d = $('#create-repair-price').val()
    if (_0x248d6d.length < 1) {
      return
    }
    let _0x47ac4a = $('#create-repair-title').val()
    if (_0x47ac4a.length < 1) {
      return
    }
    $.post(
      'https://piotreq_lst/actionData',
      JSON.stringify({
        action: 'CreateRepair',
        playerId: parseInt(_0x2215a8),
        price: parseInt(_0x248d6d),
        title: _0x47ac4a,
      })
    ).then((_0x4377d9) => {
      _0x4377d9 &&
        (loadRepairs(_0x4377d9, true),
        ClosePopup(),
        $(
          '#create-repair-player, #create-repair-price, #create-repair-title'
        ).val(''))
    })
  },
  loadRepairs = (_0x4a900f, _0x5e4033) => {
    $('#repairs-list').html(
      '\n    <tr>\n        <th style="text-align: left;">' +
        locales.customer +
        '</th>\n        <th>' +
        locales.worker +
        '</th>\n        <th>' +
        locales.service +
        '</th>\n        <th>' +
        locales.price +
        '</th>\n        <th>' +
        locales.date +
        '</th>\n    </tr>'
    )
    for (let _0x5ab8e0 in _0x4a900f) {
      let _0x5f3133 = _0x4a900f[_0x5ab8e0],
        _0x19b5f4 = new Date(_0x5f3133.time * 1000)
      $('#repairs-list').append(
        '\n        <tr>\n            <td style="text-align: left;">' +
          _0x5f3133.customer +
          '</td>\n            <td>' +
          _0x5f3133.employee +
          '</td>\n            <td>' +
          _0x5f3133.title +
          '</td>\n            <td>$' +
          _0x5f3133.price +
          '</td>\n            <td>' +
          _0x19b5f4.getDate().toString().padStart(2, '0') +
          '/' +
          _0x19b5f4.getMonth().toString().padStart(2, '0') +
          '/' +
          _0x19b5f4.getFullYear() +
          ' ' +
          _0x19b5f4.getHours().toString().padStart(2, '0') +
          ':' +
          _0x19b5f4.getMinutes().toString().padStart(2, '0') +
          '</td>\n        </tr>\n        '
      )
    }
    if (_0x5e4033) {
      let _0x5c69f5 = []
      $('#repair-search').unbind()
      $('#repair-search').on('input', () => {
        let _0x5ab108 = $('#repair-search').val().toLowerCase()
        for (let _0x5e3080 in _0x4a900f) {
          let _0x2471c2 = _0x4a900f[_0x5e3080],
            _0x243e28 = _0x2471c2.customer.toLowerCase(),
            _0x432b53 = _0x2471c2.employee.toString().toLowerCase()
          ;(_0x243e28.includes(_0x5ab108) || _0x432b53.includes(_0x5ab108)) &&
            _0x5c69f5.push(_0x2471c2)
        }
        loadRepairs(_0x5c69f5, false)
        _0x5c69f5 = []
      })
    }
  },
  loadOrders = (_0x5c5e48, _0x5e5274) => {
    $('#orders-list').html(
      '\n    <tr>\n        <th>' +
        locales.order_id +
        '</th>\n        <th>' +
        locales.orderer +
        '</th>\n        <th>' +
        locales.status +
        '</th>\n        <th>' +
        locales.order_date +
        '</th>\n    </tr>'
    )
    for (let _0x171ad4 in _0x5c5e48) {
      let _0x13b0b5 = _0x5c5e48[_0x171ad4],
        _0x4bb9d3 = new Date(_0x13b0b5.time * 1000)
      $('#orders-list').append(
        '\n        <tr>\n            <td>#' +
          _0x13b0b5.id.toString().padStart(5, '0') +
          '</td>\n            <td>' +
          _0x13b0b5.player +
          '</td>\n            <td style="width: 15%;"><div class="player-status">' +
          (_0x13b0b5.status == 0 ? locales.in_realization : locales.delivered) +
          '</div></td>\n            <td>' +
          _0x4bb9d3.getDate().toString().padStart(2, '0') +
          '/' +
          _0x4bb9d3.getMonth().toString().padStart(2, '0') +
          '/' +
          _0x4bb9d3.getFullYear() +
          ' ' +
          _0x4bb9d3.getHours().toString().padStart(2, '0') +
          ':' +
          _0x4bb9d3.getMinutes().toString().padStart(2, '0') +
          '</td>\n        </tr>'
      )
    }
    if (_0x5e5274) {
      let _0x2f4dd8 = []
      $('#search-order').unbind()
      $('#search-order').on('input', () => {
        let _0x11aabd = $('#search-order').val().toLowerCase()
        for (let _0x3311bc in _0x5c5e48) {
          let _0x297f8a = _0x5c5e48[_0x3311bc],
            _0x35fcac = _0x297f8a.player.toLowerCase(),
            _0x471a2e = _0x297f8a.id.toString().toLowerCase()
          ;(_0x35fcac.includes(_0x11aabd) || _0x471a2e.includes(_0x11aabd)) &&
            _0x2f4dd8.push(_0x297f8a)
        }
        loadOrders(_0x2f4dd8, false)
        _0x2f4dd8 = []
      })
    }
  },
  ImpoundVehicles = () => {
    if (!playerAccess.garage || !playerAccess.garage.impound) {
      $.post(
        'https://piotreq_lst/ShowNotification',
        JSON.stringify({ text: locales.no_permission })
      )
      return
    }
    $.post(
      'https://piotreq_lst/actionData',
      JSON.stringify({ action: 'ImpoundVehicles' })
    ).then((_0x8c2140) => {
      _0x8c2140 &&
        (refreshVehicles(_0x8c2140),
        $('#search-garage').unbind(),
        $('#search-garage').on('input', () => {
          let _0x4e238e = [],
            _0x466cfd = $('#search-garage').val().toLowerCase()
          for (let _0x486e29 in _0x8c2140) {
            let _0x2c9a26 = _0x8c2140[_0x486e29],
              _0x1fa46f = _0x2c9a26.model.toLowerCase(),
              _0x17b0e3 = _0x2c9a26.plate.toLowerCase(),
              _0x5caf3e = _0x2c9a26.vin.toLowerCase(),
              _0x328aca = _0x2c9a26.firstname
                ? (_0x2c9a26.firstname + ' ' + _0x2c9a26.lastname).toLowerCase()
                : null
            ;(_0x1fa46f.includes(_0x466cfd) ||
              _0x17b0e3.includes(_0x466cfd) ||
              _0x5caf3e.includes(_0x466cfd) ||
              (_0x328aca && _0x328aca.includes(_0x466cfd))) &&
              _0x4e238e.push(_0x2c9a26)
          }
          refreshGarage(_0x4e238e)
          _0x4e238e = []
        }))
    })
  },
  reloadGarage = () => {
    let _0x5edb03 = new Date().getTime()
    if (antiSpam > _0x5edb03) {
      return
    }
    antiSpam = _0x5edb03 + 500
    $.post(
      'https://piotreq_lst/fetchData',
      JSON.stringify({ tab: 'garage' })
    ).then((_0x506dc3) => {
      refreshGarage(_0x506dc3)
      $('#search-garage').unbind()
      $('#search-garage').on('input', () => {
        let _0xd2aa90 = [],
          _0xa1b2c6 = $('#search-garage').val().toLowerCase()
        for (let _0x439950 in _0x506dc3) {
          let _0x1eb2cb = _0x506dc3[_0x439950],
            _0xf92c73 = _0x1eb2cb.model.toLowerCase(),
            _0x2eeb60 = _0x1eb2cb.plate.toLowerCase(),
            _0x5224e5 = _0x1eb2cb.vin.toLowerCase(),
            _0x509fa0 = _0x1eb2cb.firstname
              ? (_0x1eb2cb.firstname + ' ' + _0x1eb2cb.lastname).toLowerCase()
              : null
          ;(_0xf92c73.includes(_0xa1b2c6) ||
            _0x2eeb60.includes(_0xa1b2c6) ||
            _0x5224e5.includes(_0xa1b2c6) ||
            (_0x509fa0 && _0x509fa0.includes(_0xa1b2c6))) &&
            _0xd2aa90.push(_0x1eb2cb)
        }
        refreshGarage(_0xd2aa90)
        _0xd2aa90 = []
      })
    })
  },
  loadGarage = (_0x355e74) => {
    $('#garage').html(
      '\n        <div class="top-bar">\n            <span>' +
        locales.garage +
        '</span>\n        </div>\n        <div class="citizens-wrapper">\n            <div class="employees-top">\n                <div class="lst-input" style="width: 55%;">\n                    <input type="text" id="search-garage" placeholder="' +
        locales.search_vehicle +
        '">\n                    <i class="fa-solid fa-magnifying-glass"></i>\n                </div>\n                <div class="employees-btn" onclick="reloadGarage()" style="width: 15%;">\n                    <i class="fa-regular fa-arrows-rotate"></i>\n                    <span>' +
        locales.refresh +
        '</span>\n                </div>\n                <div class="employees-btn" onclick="ImpoundVehicles()" style="width: 15%;">\n                    <i class="fa-regular fa-truck-tow"></i>\n                    <span>' +
        locales.tow_vehicle +
        '</span>\n                </div>\n                <div class="employees-btn" style="width: 15%;" onclick="OpenPopup(\'buy-vehicle-popup\')">\n                    <i class="fa-regular fa-dollar-sign"></i>\n                    <span>' +
        locales.buy_vehicle +
        '</span>\n                </div>\n            </div>\n            <div class="citizens-list" id="garage-list-wrapper">\n                <table id="garage-list">\n                    <tr>\n                        <th>' +
        locales.model +
        '</th>\n                        <th>' +
        locales.driver +
        '</th>\n                        <th>' +
        locales.status +
        '</th>\n                        <th>' +
        locales.plate +
        '</th>\n                        <th>' +
        locales.vin +
        '</th>\n                        <th style="width: 6%;"></th>\n                    </tr>\n                </table>\n            </div>\n        </div>'
    )
    refreshGarage(_0x355e74)
    $('#search-garage').unbind()
    $('#search-garage').on('input', () => {
      let _0x99b56d = [],
        _0x139735 = $('#search-garage').val().toLowerCase()
      for (let _0x5affda in _0x355e74) {
        let _0x1ef470 = _0x355e74[_0x5affda],
          _0x378577 = _0x1ef470.model.toLowerCase(),
          _0x5f33b9 = _0x1ef470.plate.toLowerCase(),
          _0x45b345 = _0x1ef470.vin.toLowerCase(),
          _0x4d6951 = _0x1ef470.firstname
            ? (_0x1ef470.firstname + ' ' + _0x1ef470.lastname).toLowerCase()
            : null
        ;(_0x378577.includes(_0x139735) ||
          _0x5f33b9.includes(_0x139735) ||
          _0x45b345.includes(_0x139735) ||
          (_0x4d6951 && _0x4d6951.includes(_0x139735))) &&
          _0x99b56d.push(_0x1ef470)
      }
      refreshGarage(_0x99b56d)
      _0x99b56d = []
    })
  },
  refreshGarage = (_0x3e6959) => {
    $('#garage-list-wrapper').html(
      '<div class="loader-wrapper"><span class="loader"></span></div>'
    )
    setTimeout(() => {
      $('#garage-list-wrapper').html(
        '<table id="garage-list"><tr><th>' +
          locales.model +
          '</th><th>' +
          locales.driver +
          '</th><th>' +
          locales.status +
          '</th><th>' +
          locales.plate +
          '</th><th>' +
          locales.vin +
          '</th><th style="width: 6%;"></th></tr></table>'
      )
      for (let _0x2d3ce0 in _0x3e6959) {
        let _0x36040d = _0x3e6959[_0x2d3ce0]
        $('#garage-list').append(
          '\n            <tr>\n                <td>' +
            _0x36040d.model +
            '</td>\n                <td>' +
            (_0x36040d.firstname
              ? _0x36040d.firstname + ' ' + _0x36040d.lastname
              : locales.no_data) +
            '</td>\n                <td>' +
            (_0x36040d.state == 0
              ? '<div style="margin: auto; width: 8.5rem" class="player-status off-duty">' +
                locales.out_garage +
                '</div>'
              : '<div style="margin: auto; width: 8.5rem" class="player-status">' +
                locales.in_garage +
                '</div>') +
            '</td>\n                <td>' +
            _0x36040d.plate +
            '</td>\n                <td>' +
            _0x36040d.vin +
            '</td>\n                <td><div id="garage-veh-btn-' +
            _0x2d3ce0 +
            '" class="player-btn"><i class="fa-solid fa-gear"></i></div></td>\n            </tr>'
        )
        $('#garage-veh-btn-' + _0x2d3ce0).unbind()
        $('#garage-veh-btn-' + _0x2d3ce0).on('click', () => {
          if (!playerAccess.garage || !playerAccess.garage.manage) {
            $.post(
              'https://piotreq_lst/ShowNotification',
              JSON.stringify({ text: locales.no_permission })
            )
            return
          }
          OpenPopup('manage-vehicle-popup', _0x36040d)
        })
      }
    }, 150)
  },
  SwitchDuty = (_0x7f48df) => {
    let _0xf35750 = new Date().getTime()
    if (antiSpam > _0xf35750) {
      return
    }
    antiSpam = _0xf35750 + 250
    $.post(
      'https://piotreq_lst/SwitchDuty',
      JSON.stringify({ duty: _0x7f48df })
    )
    $('#duty-menu-value').html(
      '\n        ' +
        (_0x7f48df == 0
          ? '<span style="color: red;">' + locales.off_duty + '</span>'
          : _0x7f48df == 1
          ? '<span>' + locales.on_duty + '</span>'
          : '<span style="color: orange;">' + locales.on_break + '</span>') +
        '\n        <i id="duty-menu-arrow" style="transform: rotate(180deg)" class="fa-solid fa-chevron-down"></i>\n    '
    )
    $('#my-status').html(
      _0x7f48df == 0
        ? '<div class="player-status off-duty">' + locales.off_duty + '</div>'
        : _0x7f48df == 1
        ? '<div class="player-status">' + locales.on_duty + '</div>'
        : '<div class="player-status on-break">' + locales.break + '</div>'
    )
    ToggleSelect('duty-menu')
    clearInterval(dutyTimeInterval)
    _0x7f48df == 1 &&
      (dutyTimeInterval = setInterval(() => {
        playerInfo.dutyTime++
        $('#welcome-message').text(
          locales.welcome +
            ', ' +
            playerInfo.name +
            ' - ' +
            playerInfo.grade_label +
            ' - ' +
            formatDutyTime(playerInfo.dutyTime)
        )
      }, 1000))
  },
  loadGrades = (_0x59fb18) => {
    $('#update-member').empty()
    $('#add-member').empty()
    for (let _0x585e4f in _0x59fb18) {
      let _0x4f93b9 = _0x59fb18[_0x585e4f]
      $('#update-member').append(
        "<div onclick=\"SelectItem('update-member', '" +
          _0x4f93b9.grade +
          "', '" +
          _0x4f93b9.label +
          '\')" class="popup-select-item">' +
          _0x4f93b9.label +
          '</div>'
      )
      $('#add-member').append(
        "<div onclick=\"SelectItem('add-member', '" +
          _0x4f93b9.grade +
          "', '" +
          _0x4f93b9.label +
          '\')" class="popup-select-item">' +
          _0x4f93b9.label +
          '</div>'
      )
    }
  },
  loadHome = (_0x9630e0) => {
    let _0x5b60d8 = '',
      _0x25e2af = '',
      _0x55a629 = ''
    for (let _0x23e413 in _0x9630e0.mostActive) {
      let _0x6172ea = _0x9630e0.mostActive[_0x23e413]
      _0x55a629 =
        _0x55a629 +
        ('\n            <div>\n                ' +
          (playerAccess.home.most_active_employees
            ? '<span>' +
              _0x6172ea.firstname +
              ' ' +
              _0x6172ea.lastname +
              "</span><i onclick=\"OpenDetails('employee-details', '" +
              _0x6172ea.identifier +
              '\')" class="fa-solid fa-chevron-right"></i>'
            : '') +
          '\n            </div>')
    }
    for (let _0x54a835 in _0x9630e0.wanted.citizens) {
      let _0x529812 = _0x9630e0.wanted.citizens[_0x54a835]
      _0x5b60d8 =
        _0x5b60d8 +
        ('\n            <div>\n                ' +
          (playerAccess.home.last_customers
            ? '<span>' +
              _0x529812.customer +
              '</span><i style="opacity: 0.0" class="fa-solid fa-chevron-right"></i>'
            : '') +
          '\n            </div>')
    }
    for (let _0x1d8d86 in _0x9630e0.wanted.vehicles) {
      let _0x177244 = _0x9630e0.wanted.vehicles[_0x1d8d86]
      _0x25e2af =
        _0x25e2af +
        ('\n            <div>\n                ' +
          (playerAccess.home.last_repairs
            ? '<span>' +
              _0x177244.title +
              '</span><span>$ ' +
              _0x177244.price +
              '</span>'
            : '') +
          '\n            </div>')
    }
    loadGrades(_0x9630e0.grades)
    playerInfo = _0x9630e0.playerInfo
    $('#home').html(
      '\n        <div class="top-bar">\n            <span id="welcome-message">' +
        locales.welcome +
        ', ' +
        _0x9630e0.playerInfo.name +
        ' - ' +
        _0x9630e0.playerInfo.grade_label +
        ' - ' +
        formatDutyTime(_0x9630e0.playerInfo.dutyTime) +
        '</span>\n            <div style="display: flex; align-items: center; gap: 1rem;">\n                <div class="custom-select">\n                <div class="custom-select-info" id="duty-menu-value" onclick="ToggleSelect(\'duty-menu\')">\n                    ' +
        (_0x9630e0.playerInfo.dutyStatus == 0
          ? '<span style="color: red;">' + locales.off_duty + '</span>'
          : _0x9630e0.playerInfo.dutyStatus == 1
          ? '<span>' + locales.on_duty + '</span>'
          : '<span style="color: orange;">' + locales.break + '</span>') +
        '\n                    <i id="duty-menu-arrow" class="fa-solid fa-chevron-down"></i>\n                </div>\n                <div class="custom-select-menu" id="duty-menu">\n                    <div class="custom-select-option" onclick="SwitchDuty(1)">' +
        locales.on_duty +
        '</div>\n                    <div class="custom-select-option" onclick="SwitchDuty(2)">' +
        locales.break +
        '</div>\n                    <div class="custom-select-option" onclick="SwitchDuty(0)">' +
        locales.off_duty +
        '</div>\n                </div>\n                </div>\n            </div>\n        </div>\n        <div class="section-main">\n            <div class="active-employees-wrapper">\n                <div class="active-employees-info">\n                    <span>' +
        locales.workers_on_duty +
        '</span>\n                    <span id="active-employees-count">0/0</span>\n                </div>\n                <div class="active-employees-list">\n                    <table id="active-employees-list">\n                        <tr>\n                            <th>' +
        locales.full_name +
        '</th>\n                            <th>' +
        locales.grade +
        '</th>\n                            <th>' +
        locales.status +
        '</th>\n                            <th>' +
        locales.radio_channel +
        '</th>\n                            <th>' +
        locales.duty_time +
        '</th>\n                            <th>' +
        locales.last_active +
        '</th>\n                        </tr>\n                    </table>\n                </div>\n            </div>\n            <div class="last-items-wrapper">\n                <div class="last-items">\n                    <span>' +
        locales.last_customers +
        '</span>\n                    <div class="last-items-list">\n                        ' +
        _0x5b60d8 +
        '\n                    </div>\n                </div>\n                <div class="last-items">\n                    <span>' +
        locales.last_repairs +
        '</span>\n                    <div class="last-items-list">\n                        ' +
        _0x25e2af +
        '\n                    </div>\n                </div>\n                <div class="last-items">\n                    <span>' +
        locales.most_active_workers +
        '</span>\n                    <div class="last-items-list">\n                        ' +
        _0x55a629 +
        '\n                    </div>\n                </div>\n            </div>\n        </div>\n    '
    )
    let _0x2f04b1 = 0
    for (let _0x5c2821 in _0x9630e0.employees) {
      let _0x1f09e9 = _0x9630e0.employees[_0x5c2821]
      _0x1f09e9.status == 1 &&
        (_0x2f04b1++,
        $('#active-employees-list').append(
          '\n                <tr>\n                    <td>' +
            _0x1f09e9.name +
            ' ' +
            (_0x1f09e9.identifier == _0x9630e0.playerInfo.identifier
              ? '(' + locales.you + ')'
              : '') +
            '</td>\n                    <td>' +
            _0x1f09e9.grade_label +
            '</td>\n                    <td ' +
            (_0x1f09e9.identifier == _0x9630e0.playerInfo.identifier
              ? 'id="my-status"'
              : '') +
            '>' +
            (_0x1f09e9.status == 0
              ? '<div class="player-status off-duty">' +
                locales.off_duty +
                '</div>'
              : _0x1f09e9.status == 1
              ? '<div class="player-status">' + locales.on_duty + '</div>'
              : '<div class="player-status on-break">' +
                locales.break +
                '</div>') +
            '</td>\n                    <td>' +
            _0x1f09e9.radio +
            '</td>\n                    <td>' +
            (playerAccess.home.duty_time
              ? formatDutyTime(_0x1f09e9.dutyTime)
              : locales.no_data) +
            '</td>\n                    <td>' +
            (playerAccess.home.last_active
              ? _0x1f09e9.lastActive
              : locales.no_data) +
            '</td>\n                    <td><div id="active-employee-btn-' +
            _0x5c2821 +
            '" class="player-btn"><i class="fa-solid fa-chevron-right"></i></div></td>\n                </tr>'
        ),
        $('#active-employee-btn-' + _0x5c2821).unbind(),
        $('#active-employee-btn-' + _0x5c2821).on('click', () => {
          playerAccess.employees
            ? OpenDetails('employee-details', _0x1f09e9.identifier)
            : $.post(
                'https://piotreq_lst/ShowNotification',
                JSON.stringify({ text: locales.no_permission })
              )
        }))
    }
    $('#active-employees-count').text(
      _0x2f04b1 + '/' + _0x9630e0.employees.length
    )
    dangerCodes = _0x9630e0.codes
    for (let _0x55add4 in _0x9630e0.codes) {
      let _0x409d3a = _0x9630e0.codes[_0x55add4]
      _0x409d3a.name == _0x9630e0.dangerCode &&
        $('#codes-menu-value').html(
          '\n                <span style="color: ' +
            _0x409d3a.color +
            '">' +
            _0x409d3a.label +
            '</span>\n                <i id="codes-menu-arrow" class="fa-solid fa-chevron-down"></i>\n            '
        )
      $('#codes-menu').append(
        '<div class="custom-select-option" onclick="SwitchCode(\'' +
          _0x409d3a.name +
          "', '" +
          _0x409d3a.label +
          "', '" +
          _0x409d3a.color +
          '\')">' +
          _0x409d3a.label +
          '</div>'
      )
    }
    clearInterval(dutyTimeInterval)
    _0x9630e0.playerInfo.dutyStatus == 1 &&
      (dutyTimeInterval = setInterval(() => {
        playerInfo.dutyTime++
        playerInfo = playerInfo
        $('#welcome-message').text(
          locales.welcome +
            ', ' +
            playerInfo.name +
            ' - ' +
            playerInfo.grade_label +
            ' - ' +
            formatDutyTime(playerInfo.dutyTime)
        )
      }, 1000))
  },
  DeleteWorkerLicense = () => {
    if (!activeWorker.identifier) {
      return
    }
    let _0x1a9714 = $('#remove-worker-license-value').attr('data-value')
    if (!_0x1a9714) {
      $.post(
        'https://piotreq_lst/ShowNotification',
        JSON.stringify({ text: locales.select_license_to_remove })
      )
      return
    }
    $.post(
      'https://piotreq_lst/actionData',
      JSON.stringify({
        action: 'DeleteWorkerLicense',
        player: activeWorker.identifier,
        type: _0x1a9714,
      })
    ).then((_0x131b45) => {
      if (_0x131b45) {
        for (let _0x685bc6 in activeWorker.licenses) {
          if (activeWorker.licenses[_0x685bc6].type == _0x1a9714) {
            delete activeWorker.licenses[_0x685bc6]
            break
          }
        }
        ClosePopup()
        $('#remove-worker-license-value').attr('data-value', null)
        $('#remove-worker-license-value').text(locales.select_license)
        $('#worker-license-' + _0x1a9714).remove()
      }
    })
  },
  AddWorkerLicense = () => {
    if (!activeWorker.identifier) {
      return
    }
    let _0xfdc944 = $('#add-worker-license-value').attr('data-value')
    if (!_0xfdc944) {
      $.post(
        'https://piotreq_lst/ShowNotification',
        JSON.stringify({ text: locales.select_license_to_assign })
      )
      return
    }
    let _0x1daf3a = false
    for (let _0xaeae51 in activeWorker.licenses) {
      let _0x2ec040 = activeWorker.licenses[_0xaeae51]
      if (_0x2ec040 && _0x2ec040.type == _0xfdc944) {
        _0x1daf3a = true
        break
      }
    }
    if (_0x1daf3a) {
      $.post(
        'https://piotreq_lst/ShowNotification',
        JSON.stringify({ text: locales.this_worker_has_license })
      )
      return
    }
    let _0x50d520 = $('#add-worker-license-value').text()
    $.post(
      'https://piotreq_lst/actionData',
      JSON.stringify({
        action: 'AddWorkerLicense',
        player: activeWorker.identifier,
        type: _0xfdc944,
        label: _0x50d520,
      })
    ).then((_0x221b70) => {
      _0x221b70 &&
        (activeWorker.licenses.push({
          type: _0xfdc944,
          label: _0x50d520,
        }),
        ClosePopup(),
        $('#add-worker-license-value').attr('data-value', null),
        $('#add-worker-license-value').text(locales.select_license),
        $('#remove-worker-license').prepend(
          '<div id="worker-license-' +
            _0xfdc944 +
            "\" onclick=\"SelectItem('remove-worker-license', '" +
            _0xfdc944 +
            "', '" +
            _0x50d520 +
            '\')" class="popup-select-item">' +
            _0x50d520 +
            '</div>'
        ))
    })
  },
  SetEmployeePhoto = () => {
    if (!activeWorker.identifier) {
      return
    }
    if (!playerAccess.employees || !playerAccess.employees.set_photo) {
      $.post(
        'https://piotreq_lst/ShowNotification',
        JSON.stringify({ text: locales.no_permission })
      )
      return
    }
    let _0x6e2081 = $('#set-employee-photo-url').val()
    if (_0x6e2081.length < 1 || _0x6e2081.includes('<script>')) {
      $.post(
        'https://piotreq_lst/ShowNotification',
        JSON.stringify({ text: locales.link_too_short })
      )
      return
    }
    _0x6e2081 = removeTags(_0x6e2081)
    $.post(
      'https://piotreq_lst/actionData',
      JSON.stringify({
        action: 'SetEmployeePhoto',
        player: activeWorker.identifier,
        photo: _0x6e2081,
      })
    ).then((_0x48ae3d) => {
      _0x48ae3d &&
        ($('#employee-details-photo').css(
          'background',
          'center / cover no-repeat url(' + _0x6e2081 + ')'
        ),
        ClosePopup())
    })
  },
  HireWorker = () => {
    let _0x3cf229 = $('#add-member-id').val()
    if (_0x3cf229.length < 1) {
      return
    }
    let _0x4e41eb = $('#add-member-value').attr('data-value')
    if (!_0x4e41eb) {
      $.post(
        'https://piotreq_lst/ShowNotification',
        JSON.stringify({ text: locales.select_grade_to_hire })
      )
      return
    }
    if (!playerAccess.employees || !playerAccess.employees.add) {
      $.post(
        'https://piotreq_lst/ShowNotification',
        JSON.stringify({ text: locales.no_permission })
      )
      return
    }
    $.post(
      'https://piotreq_lst/actionData',
      JSON.stringify({
        action: 'HireWorker',
        id: _0x3cf229,
        grade: _0x4e41eb,
      })
    ).then((_0x5beb3f) => {
      _0x5beb3f &&
        ($('#add-member-value').text(locales.select_grade),
        $('#add-member-value').attr('data-value', null),
        $('#add-member-id').val(''),
        ClosePopup(),
        refreshWorkers(_0x5beb3f))
    })
  },
  SendForBreak = () => {
    if (!playerAccess.employees || !playerAccess.employees.break) {
      $.post(
        'https://piotreq_lst/ShowNotification',
        JSON.stringify({ text: locales.no_permission })
      )
      return
    }
    if (activeWorker.status == 2 || activeWorker.status == 0) {
      $.post(
        'https://piotreq_lst/ShowNotification',
        JSON.stringify({ text: locales.player_off_duty_break })
      )
      return
    }
    $.post(
      'https://piotreq_lst/actionData',
      JSON.stringify({
        action: 'SendForBreak',
        identifier: activeWorker.identifier,
      })
    ).then((_0x398611) => {
      _0x398611 && $('#employee-status-info').text(locales.break)
    })
  },
  ResetAllTime = () => {
    let _0x2080c0 = $('#reset-time-value').attr('data-value')
    if (!_0x2080c0) {
      $.post(
        'https://piotreq_lst/ShowNotification',
        JSON.stringify({ text: locales.select_workers_to_reset_time })
      )
      return
    }
    if (!playerAccess.employees || !playerAccess.employees.reset_time_all) {
      $.post(
        'https://piotreq_lst/ShowNotification',
        JSON.stringify({ text: locales.no_permission })
      )
      return
    }
    $('#employees-list-wrapper').hide()
    let _0x3827bc = $(
      '<div class="loader-wrapper"><span class="loader"></span></div>'
    )
    $('#employees-wrapper').append(_0x3827bc)
    ClosePopup()
    $.post(
      'https://piotreq_lst/actionData',
      JSON.stringify({
        action: 'ResetTime',
        type: _0x2080c0,
      })
    ).then((_0x52c20b) => {
      _0x52c20b && (_0x3827bc.remove(), refreshWorkers(_0x52c20b))
    })
  },
  ResetEmployeeTime = () => {
    if (
      !playerAccess.employees ||
      !playerAccess.employees.reset_time_employee
    ) {
      $.post(
        'https://piotreq_lst/ShowNotification',
        JSON.stringify({ text: locales.no_permission })
      )
      return
    }
    $.post(
      'https://piotreq_lst/actionData',
      JSON.stringify({
        action: 'ResetTime',
        employee: true,
        identifier: activeWorker.identifier,
      })
    ).then((_0xce0337) => {
      _0xce0337 && (ClosePopup(), $('#employee-time-info').text('00:00:00'))
    })
  },
  FireWorker = () => {
    if (!playerAccess.employees || !playerAccess.employees.fire) {
      $.post(
        'https://piotreq_lst/ShowNotification',
        JSON.stringify({ text: locales.no_permission })
      )
      return
    }
    let _0x40956a = $('#fire-employee-reason').val()
    if (_0x40956a.length < 1 || _0x40956a.includes('<script>')) {
      $.post(
        'https://piotreq_lst/ShowNotification',
        JSON.stringify({ text: locales.fire_worker_reason_invalid })
      )
      return
    }
    _0x40956a = removeTags(_0x40956a)
    $.post(
      'https://piotreq_lst/actionData',
      JSON.stringify({
        action: 'FireWorker',
        identifier: activeWorker.identifier,
        name: activeWorker.name,
        reason: _0x40956a,
      })
    ).then((_0x494e96) => {
      _0x494e96 && (refreshWorkers(_0x494e96), ClosePopup(), CloseDetails())
    })
  },
  UpdateWorker = () => {
    if (!playerAccess.employees || !playerAccess.employees.update) {
      $.post(
        'https://piotreq_lst/ShowNotification',
        JSON.stringify({ text: locales.no_permission })
      )
      return
    }
    let _0x2c6124 = $('#update-member-value').attr('data-value')
    if (!_0x2c6124) {
      $.post(
        'https://piotreq_lst/ShowNotification',
        JSON.stringify({ text: locales.select_grade_to_update })
      )
      return
    }
    $.post(
      'https://piotreq_lst/actionData',
      JSON.stringify({
        action: 'UpdateWorker',
        identifier: activeWorker.identifier,
        grade: _0x2c6124,
      })
    ).then((_0x3b0230) => {
      activeWorker.grade_label = _0x3b0230
      $('#employee-grade-info').text(_0x3b0230)
      ClosePopup()
    })
  },
  ChangeEmployeeBadge = () => {
    if (!playerAccess.employees || !playerAccess.employees.change_badge) {
      $.post(
        'https://piotreq_lst/ShowNotification',
        JSON.stringify({ text: locales.no_permission })
      )
      return
    }
    let _0x23f01f = $('#change-badge-value').val()
    if (_0x23f01f.length < 1) {
      $.post(
        'https://piotreq_lst/ShowNotification',
        JSON.stringify({ text: locales.badge_too_short })
      )
      return
    }
    $.post(
      'https://piotreq_lst/actionData',
      JSON.stringify({
        action: 'ChangeBadge',
        identifier: activeWorker.identifier,
        badge: _0x23f01f,
      })
    ).then((_0x12f183) => {
      _0x12f183 &&
        ((activeWorker.badge = _0x23f01f),
        $('#employee-badge-info').text(_0x23f01f),
        ClosePopup())
    })
  },
  DeleteEmployeeNote = (_0x3e3a24) => {
    if (!playerAccess.employees || !playerAccess.employees.delete_note) {
      $.post(
        'https://piotreq_lst/ShowNotification',
        JSON.stringify({ text: locales.no_permission })
      )
      return
    }
    $.post(
      'https://piotreq_lst/actionData',
      JSON.stringify({
        action: 'DeleteEmployeeNote',
        id: _0x3e3a24,
      })
    ).then((_0xa7983c) => {
      _0xa7983c && $('#employee-note-' + _0x3e3a24).remove()
    })
  },
  AddEmployeeNote = () => {
    if (!playerAccess.employees || !playerAccess.employees.add_note) {
      $.post(
        'https://piotreq_lst/ShowNotification',
        JSON.stringify({ text: locales.no_permission })
      )
      return
    }
    let _0x305163 = $('#employee-note-title').val()
    if (_0x305163.length < 1 || _0x305163.includes('<script>')) {
      return
    }
    let _0x563f17 = $('#employee-note-text').val()
    if (_0x563f17.length < 1 || _0x563f17.includes('<script>')) {
      return
    }
    _0x305163 = removeTags(_0x305163)
    _0x563f17 = removeTags(_0x563f17)
    let _0x5deba9 = $('#employee-note-important').prop('checked')
    $.post(
      'https://piotreq_lst/actionData',
      JSON.stringify({
        action: 'AddEmployeeNote',
        title: _0x305163,
        text: _0x563f17,
        important: _0x5deba9,
        identifier: activeWorker.identifier,
      })
    ).then((_0x9105d) => {
      _0x9105d &&
        ($('#employee-note-title').val(''),
        $('#employee-note-text').val(''),
        $('#employee-note-important').prop('checked', false),
        ClosePopup(),
        $('#employee-note-list').prepend(
          '\n                <div class="employee-note ' +
            (_0x5deba9 ? 'important' : '') +
            '" id="employee-note-' +
            _0x9105d.id +
            '">\n                    <div class="employee-note-info">\n                        <span>' +
            _0x305163 +
            '</span>\n                        <i onclick="DeleteEmployeeNote(' +
            _0x9105d.id +
            ')" class="fa-solid fa-trash-can"></i>\n                    </div>\n                    <span>' +
            _0x563f17 +
            '</span>\n                    <span>' +
            locales.added_by +
            ': ' +
            _0x9105d.name +
            ' ' +
            _0x9105d.date +
            '</span>\n                </div>'
        ))
    })
  }
var Workers = []
const SearchEmployee = () => {
    let _0x167496 = [],
      _0x309b7f = $('#search-employee').val().toLowerCase()
    if (_0x309b7f.length < 1) {
      refreshWorkers(Workers)
    } else {
      for (let _0x2c6950 in Workers) {
        let _0x3d3a74 = Workers[_0x2c6950].name.toLowerCase()
        _0x3d3a74.includes(_0x309b7f) && _0x167496.push(Workers[_0x2c6950])
      }
      refreshWorkers(_0x167496)
      _0x167496 = []
    }
  },
  loadWorkers = (_0x149afd) => {
    Workers = _0x149afd
    $('#employees').html(
      '\n                <div class="top-bar">\n                    <span>' +
        locales.workers +
        '</span>\n                    <span id="employees-count">0/0</span>\n                </div>\n                <div class="citizens-wrapper" id="employees-wrapper">\n                    <div class="employees-top">\n                        <div class="lst-input">\n                            <input oninput="SearchEmployee()" id="search-employee" type="text" placeholder="' +
        locales.search_worker +
        '">\n                            <i class="fa-solid fa-magnifying-glass"></i>\n                        </div>\n                        <div class="employees-btn" onclick="OpenPopup(\'add-employee-popup\')">\n                            <i class="fa-regular fa-circle-plus"></i>\n                            <span>' +
        locales.hire_worker +
        '</span>\n                        </div>\n                        <div class="employees-btn" onclick="OpenPopup(\'reset-time-popup\')">\n                            <i class="fa-regular fa-clock"></i>\n                            <span>' +
        locales.reset_duty_time +
        '</span>\n                        </div>\n                    </div>\n                    <div class="citizens-list" id="employees-list-wrapper">\n                    </div>\n                </div>\n    '
    )
    refreshWorkers(_0x149afd)
  },
  refreshWorkers = (_0xec9026) => {
    $('#employees-list-wrapper').hide()
    let _0x3fd53a = $(
      '<div class="loader-wrapper"><span class="loader"></span></div>'
    )
    $('#employees-wrapper').append(_0x3fd53a)
    $('#employees-list-wrapper').html(
      '\n    <table id="employees-list">\n        <tr>\n            <th>' +
        locales.full_name +
        '</th>\n            <th>' +
        locales.grade +
        '</th>\n            <th>' +
        locales.status +
        '</th>\n            <th>' +
        locales.badge_number +
        '</th>\n            <th>' +
        locales.duty_time +
        '</th>\n            <th>' +
        locales.last_active +
        '</th>\n            <th style="width: 6%;"></th>\n        </tr>\n    </table>'
    )
    let _0x3161ea = 0
    for (let _0x1465a7 in _0xec9026) {
      let _0x2af47d = _0xec9026[_0x1465a7]
      _0x2af47d.status == 1 && _0x3161ea++
      $('#employees-list').append(
        '\n        <tr id="worker-row-' +
          _0x2af47d.ssn +
          '">\n            <td>' +
          _0x2af47d.name +
          '</td>\n            <td>' +
          _0x2af47d.grade_label +
          '</td>\n            <td>' +
          (_0x2af47d.status == 0
            ? '<div class="player-status off-duty">' +
              locales.off_duty +
              '</div>'
            : _0x2af47d.status == 1
            ? '<div class="player-status">' + locales.on_duty + '</div>'
            : '<div class="player-status on-break">' +
              locales.break +
              '</div>') +
          '</td>\n            <td>' +
          (_0x2af47d.badge || locales.no_data) +
          '</td>\n            <td>' +
          (playerAccess.home.duty_time
            ? formatDutyTime(_0x2af47d.dutyTime)
            : locales.no_data) +
          '</td>\n            <td>' +
          (playerAccess.home.last_active
            ? _0x2af47d.lastActive
            : locales.no_data) +
          "</td>\n            <td><div onclick=\"OpenDetails('employee-details', '" +
          _0x2af47d.identifier +
          '\')" class="player-btn"><i class="fa-solid fa-chevron-right"></i></div></td>\n        </tr>'
      )
    }
    $('#employees-count').text(_0x3161ea + '/' + _0xec9026.length)
    setTimeout(() => {
      _0x3fd53a.remove()
      $('#employees-list-wrapper').show()
    }, 100)
  }
var Announcements = []
const SearchAnnouncement = () => {
    let _0x2396e7 = [],
      _0x241189 = $('#search-announcement').val().toLowerCase()
    if (_0x241189.length < 1) {
      refreshAnnouncements(Announcements)
    } else {
      for (let _0x2b98c3 in Announcements) {
        let _0x448aff = Announcements[_0x2b98c3],
          _0x39f640 = _0x448aff.title.toLowerCase()
        _0x39f640.includes(_0x241189) && _0x2396e7.push(_0x448aff)
      }
      refreshAnnouncements(_0x2396e7)
      _0x2396e7 = []
    }
  },
  AddAnnouncement = () => {
    if (!playerAccess.announcements || !playerAccess.announcements.create) {
      $.post(
        'https://piotreq_lst/ShowNotification',
        JSON.stringify({ text: locales.no_permission })
      )
      return
    }
    let _0x20cc0d = $('#add-announcement-title').val()
    if (_0x20cc0d.length < 3 || _0x20cc0d.includes('<script>')) {
      $.post(
        'https://piotreq_lst/ShowNotification',
        JSON.stringify({ text: locales.title_too_short })
      )
      return
    }
    let _0x11a6ea = $('#add-announcement-text').val()
    if (_0x11a6ea.length < 5 || _0x11a6ea.includes('<script>')) {
      $.post(
        'https://piotreq_lst/ShowNotification',
        JSON.stringify({ text: locales.text_too_short })
      )
      return
    }
    let _0x49f657 = $('#add-announcement-check').prop('checked')
    $.post(
      'https://piotreq_lst/actionData',
      JSON.stringify({
        action: 'AddAnnouncement',
        title: _0x20cc0d,
        text: _0x11a6ea,
        important: _0x49f657,
      })
    ).then((_0xe5e02d) => {
      ClosePopup()
      Announcements = _0xe5e02d
      refreshAnnouncements(_0xe5e02d)
    })
  },
  DeleteAnnouncement = (_0x59e19c) => {
    if (!playerAccess.announcements || !playerAccess.announcements.delete) {
      $.post(
        'https://piotreq_lst/ShowNotification',
        JSON.stringify({ text: locales.no_permission })
      )
      return
    }
    $.post(
      'https://piotreq_lst/actionData',
      JSON.stringify({
        action: 'DeleteAnnouncement',
        id: _0x59e19c,
      })
    ).then((_0x257c96) => {
      _0x257c96 &&
        ((Announcements = _0x257c96), refreshAnnouncements(_0x257c96))
    })
  },
  refreshAnnouncements = (_0x3648f4) => {
    $('.announcements-list').empty()
    for (let _0x157889 in _0x3648f4) {
      let _0x314317 = _0x3648f4[_0x157889],
        _0x4c8e59 = new Date(_0x314317.time * 1000)
      $('.announcements-list').append(
        '\n        <div id="ann-' +
          _0x314317.id +
          '" class="announcement ' +
          (_0x314317.important == 1 ? 'important' : '') +
          '">\n            <div class="announcement-top">\n                <span>' +
          _0x314317.title +
          '</span>\n                ' +
          (playerAccess.announcements.delete
            ? '<div onclick="DeleteAnnouncement(' +
              _0x314317.id +
              ')" class="square-btn"><i class="fa-solid fa-trash-can"></i></div>'
            : '') +
          '\n            </div>\n            <span>' +
          _0x314317.text +
          '</span>\n            <span>' +
          _0x314317.firstname +
          ' ' +
          _0x314317.lastname +
          ', ' +
          formatTime(_0x4c8e59) +
          '</span>\n        </div>'
      )
    }
  }
function removeTags(_0x1b38ca) {
  return (
    (_0x1b38ca = _0x1b38ca.toString()), _0x1b38ca.replace(/(<([^>]+)>)/gi, '')
  )
}
function formatTime(_0x41bbe0) {
  let _0x57aa2e = new Date(_0x41bbe0)
  return (
    _0x57aa2e.getHours().toString().padStart(2, '0') +
    ':' +
    _0x57aa2e.getMinutes().toString().padStart(2, '0') +
    ' ' +
    _0x57aa2e.getDate().toString().padStart(2, '0') +
    '/' +
    (_0x57aa2e.getMonth() + 1).toString().padStart(2, '0') +
    '/' +
    _0x57aa2e.getFullYear()
  )
}
const ReportNotification = (_0x45702f) => {
    let _0x4a2063 = ''
    for (let _0x259765 in _0x45702f.info) {
      _0x4a2063 =
        _0x4a2063 +
        ('\n        <div class="report-info-row">\n            <i class="' +
          _0x45702f.info[_0x259765].icon +
          '"></i>\n            <span>' +
          _0x45702f.info[_0x259765].data +
          '</span>\n        </div>')
    }
    let _0x2deb61 = $(
      '\n    <div class="dispatch-report notify-report ' +
        (_0x45702f.type ? _0x45702f.type : 'normal') +
        '">\n        <div class="report-top">\n            <i class="' +
        _0x45702f.icon +
        '"></i>\n            <span>' +
        _0x45702f.title +
        '</span>\n            <div class="report-box outline-box">' +
        _0x45702f.code +
        '</div>\n            <div class="report-box outline-box">#' +
        _0x45702f.id +
        '</div>\n        </div>\n        <div class="report-main">\n        ' +
        _0x4a2063 +
        '\n        </div>\n        <div class="report-bot">\n            <div class="report-bot-flex">\n                <div class="report-box clickable">' +
        locales.react +
        '</div>\n                <div class="report-box clickable">' +
        locales.location +
        '</div>\n                ' +
        (_0x45702f.canAnswer
          ? '<div class="report-box clickable">' + locales.answer + '</div>'
          : '') +
        '\n            </div>\n            <div class="report-bot-flex">\n                <div class="report-box outline-box">' +
        _0x45702f.officers.length +
        '/' +
        _0x45702f.maxOfficers +
        '</div>\n                <div class="report-box"><i class="fa-solid fa-chevron-down"></i></div>\n            </div>\n        </div>\n    </div>'
    )
    $('.dispatch-notify-wrapper').prepend(_0x2deb61)
    setTimeout(() => {
      _0x2deb61.css({
        transform: 'translateX(0)',
        opacity: '1.0',
      })
      setTimeout(() => {
        _0x2deb61.css({
          transform: 'translateX(200%)',
          opacity: '0.0',
        })
        setTimeout(() => {
          _0x2deb61.remove()
        }, 500)
      }, _0x45702f.timeout || 5500)
    }, 200)
  },
  OpenDispatch = () => {
    inDispatch = true
    $('.dispatch-notify-wrapper').hide()
    $('.dispatch').css('display', 'flex')
  },
  CloseDispatch = () => {
    $('.dispatch-notify-wrapper').css('display', 'flex')
    $('.dispatch').hide()
    inDispatch = false
    $.post('https://piotreq_lst/CloseUI')
  }
var toggledOfficers = {}
const ToggleOfficers = (_0x5618fa, _0x4ec581) => {
    let _0x19a930 = $('#report-dropdown-' + _0x5618fa)
    _0x19a930.css('max-height') == '0px'
      ? ((toggledOfficers[_0x5618fa] = true),
        $(_0x4ec581).children('i').css('transform', 'rotate(180deg)'),
        _0x19a930.css('display', 'flex'),
        setTimeout(() => {
          _0x19a930.css('max-height', _0x19a930.prop('scrollHeight'))
        }, 10))
      : ((toggledOfficers[_0x5618fa] = null),
        $(_0x4ec581).children('i').css('transform', 'rotate(0)'),
        _0x19a930.css('max-height', '0px'),
        setTimeout(() => {
          _0x19a930.hide()
        }, 115))
  },
  loadDispatch = (_0x37270b) => {
    $('.dispatch').html(
      '<div class="reports-wrapper"><span>' +
        locales['ui_actual-reports'] +
        '</span><div class="reports-wrapper-list" id="actual-reports"></div></div>'
    )
    for (let _0x58cc52 in _0x37270b.dispatch) {
      let _0x3e6c74 = _0x37270b.dispatch[_0x58cc52],
        _0x19b59e = false,
        _0x48ccd8 = _0x3e6c74.officers,
        _0x2095b9 = true
      _0x3e6c74.jobs &&
        !_0x3e6c74.jobs[_0x37270b.job.name] &&
        (_0x2095b9 = false)
      if (_0x2095b9) {
        let _0x2ba36d = ''
        for (let _0x54c2dd in _0x3e6c74.info) {
          _0x2ba36d =
            _0x2ba36d +
            ('\n                <div class="report-info-row">\n                    <i class="' +
              _0x3e6c74.info[_0x54c2dd].icon +
              '"></i>\n                    <span>' +
              _0x3e6c74.info[_0x54c2dd].data +
              '</span>\n                </div>')
        }
        if (_0x48ccd8.length > 0) {
          for (let _0x1f8d10 in _0x48ccd8) {
            let _0x56dc9c = _0x48ccd8[_0x1f8d10]
            if (_0x56dc9c.identifier == _0x37270b.identifier) {
              _0x19b59e = true
              $('.dispatch').prepend(
                '<div class="reports-wrapper"><span>' +
                  locales.active_reports +
                  '</span><div class="reports-wrapper-list" id="active-reports"></div></div>'
              )
              break
            }
          }
        }
        let _0x7336ed = ''
        for (let _0x1198c6 in _0x48ccd8) {
          let _0x3b5610 = _0x48ccd8[_0x1198c6]
          _0x7336ed =
            _0x7336ed +
            ('<div class="report-officer">\n                    <i class="fa-regular fa-badge-sheriff"></i>\n                    <span>[' +
              _0x3b5610.badge +
              '] <font>' +
              _0x3b5610.name +
              '</font> [' +
              _0x3b5610.job +
              ']</span>\n                </div>')
        }
        _0x19b59e
          ? $('#active-reports').prepend(
              '\n                    <div class="dispatch-report ' +
                (_0x3e6c74.type ? _0x3e6c74.type : 'normal') +
                '">\n                        <div class="report-top">\n                            <i class="' +
                _0x3e6c74.icon +
                '"></i>\n                            <span>' +
                _0x3e6c74.title +
                '</span>\n                            <div class="report-box outline-box">' +
                _0x3e6c74.code +
                '</div>\n                            <div class="report-box outline-box">#' +
                _0x3e6c74.id +
                '</div>\n                        </div>\n                        <div class="report-main">\n                        ' +
                _0x2ba36d +
                '\n                        </div>\n                        <div class="report-bot">\n                            <div class="report-bot-flex">\n                                <div onclick="CancelReport(' +
                _0x3e6c74.id +
                ')" class="report-box clickable">' +
                locales.finish +
                '</div>\n                                <div onclick="LocateReport(' +
                _0x3e6c74.coords.x +
                ', ' +
                _0x3e6c74.coords.y +
                ')" class="report-box clickable">' +
                locales.location +
                '</div>\n                                ' +
                (_0x3e6c74.canAnswer
                  ? '<div onclick="AnswerReport(' +
                    _0x3e6c74.sender +
                    ')" class="report-box clickable">' +
                    locales.answer +
                    '</div>'
                  : '') +
                '\n                            </div>\n                            <div class="report-bot-flex">\n                                <div class="report-box outline-box">' +
                _0x48ccd8.length +
                '/' +
                _0x3e6c74.maxOfficers +
                '</div>\n                                <div onclick="ToggleOfficers(\'' +
                _0x3e6c74.id +
                '\', $(this))" class="report-box"><i ' +
                (toggledOfficers[_0x3e6c74.id]
                  ? 'style="transform: rotate(180deg)"'
                  : '') +
                ' class="fa-solid fa-chevron-down"></i></div>\n                            </div>\n                        </div>\n                        <div class="report-officers" ' +
                (toggledOfficers[_0x3e6c74.id]
                  ? 'style="display: flex; max-height: fit-content"'
                  : '') +
                ' id="report-dropdown-' +
                _0x3e6c74.id +
                '">\n                        ' +
                _0x7336ed +
                '\n                        </div>\n                    </div>'
            )
          : $('#actual-reports').prepend(
              '\n                    <div class="dispatch-report ' +
                (_0x3e6c74.type ? _0x3e6c74.type : 'normal') +
                '">\n                        <div class="report-top">\n                            <i class="' +
                _0x3e6c74.icon +
                '"></i>\n                            <span>' +
                _0x3e6c74.title +
                '</span>\n                            <div class="report-box outline-box">' +
                _0x3e6c74.code +
                '</div>\n                            <div class="report-box outline-box">#' +
                _0x3e6c74.id +
                '</div>\n                        </div>\n                        <div class="report-main">\n                        ' +
                _0x2ba36d +
                '\n                        </div>\n                        <div class="report-bot">\n                            <div class="report-bot-flex">\n                                <div onclick="ReactReport(' +
                _0x3e6c74.id +
                ')" class="report-box clickable">' +
                locales.react +
                '</div>\n                                <div onclick="LocateReport(' +
                _0x3e6c74.coords.x +
                ', ' +
                _0x3e6c74.coords.y +
                ')" class="report-box clickable">' +
                locales.location +
                '</div>\n                                ' +
                (_0x3e6c74.canAnswer
                  ? '<div onclick="AnswerReport(' +
                    _0x3e6c74.sender +
                    ')" class="report-box clickable">' +
                    locales.answer +
                    '</div>'
                  : '') +
                '\n                            </div>\n                            <div class="report-bot-flex">\n                                <div class="report-box outline-box">' +
                _0x48ccd8.length +
                '/' +
                _0x3e6c74.maxOfficers +
                '</div>\n                                <div onclick="ToggleOfficers(\'' +
                _0x3e6c74.id +
                '\', $(this))" class="report-box"><i ' +
                (toggledOfficers[_0x3e6c74.id]
                  ? 'style="transform: rotate(180deg)"'
                  : '') +
                ' class="fa-solid fa-chevron-down"></i></div>\n                            </div>\n                        </div>\n                        <div class="report-officers" ' +
                (toggledOfficers[_0x3e6c74.id]
                  ? 'style="display: flex; max-height: fit-content"'
                  : '') +
                ' id="report-dropdown-' +
                _0x3e6c74.id +
                '">\n                        ' +
                _0x7336ed +
                '\n                        </div>\n                    </div>'
            )
      }
    }
  },
  AnswerReport = (_0x19a25a) => {
    $.post(
      'https://piotreq_lst/AnswerReport',
      JSON.stringify({ sender: _0x19a25a })
    )
  },
  ReactReport = (_0x38a5b2) => {
    $.post('https://piotreq_lst/ReactReport', JSON.stringify({ id: _0x38a5b2 }))
  },
  CancelReport = (_0x1026b1) => {
    $.post(
      'https://piotreq_lst/CancelReport',
      JSON.stringify({ id: _0x1026b1 })
    )
  },
  LocateReport = (_0x304cb9, _0x4effe5) => {
    $.post(
      'https://piotreq_lst/LocateReport',
      JSON.stringify({
        x: _0x304cb9,
        y: _0x4effe5,
      })
    )
  },
  loadLicenses = (_0x2fc784) => {
    $('#add-worker-license').empty()
    for (let _0x4c6d87 in _0x2fc784.police) {
      let _0x15a436 = _0x2fc784.police[_0x4c6d87]
      $('#add-worker-license').append(
        "<div onclick=\"SelectItem('add-worker-license', '" +
          _0x4c6d87 +
          "', '" +
          _0x15a436.label +
          '\')" class="popup-select-item">' +
          _0x15a436.label +
          '</div>'
      )
    }
  },
  BuyVehicle = () => {
    if (!playerAccess.garage || !playerAccess.garage.buy) {
      $.post(
        'https://piotreq_lst/ShowNotification',
        JSON.stringify({ text: locales.no_permission })
      )
      return
    }
    let _0x512447 = $('#buy-vehicle-value').attr('data-value')
    if (!_0x512447) {
      $.post(
        'https://piotreq_lst/ShowNotification',
        JSON.stringify({ text: locales.select_model_to_buy })
      )
      return
    }
    $.post(
      'https://piotreq_lst/actionData',
      JSON.stringify({
        action: 'BuyVehicle',
        model: _0x512447,
      })
    ).then((_0xc6c1b2) => {
      _0xc6c1b2 &&
        (refreshGarage(_0xc6c1b2),
        ClosePopup(),
        $('#buy-vehicle-value').attr('data-value', null))
    })
  },
  loadVehicles = (_0x3becc8) => {
    $('#buy-vehicle').empty()
    for (let _0x50ca58 in _0x3becc8) {
      let _0x5dcc55 = _0x3becc8[_0x50ca58],
        _0x422d1d = $(
          '<div class="popup-select-item">' + _0x5dcc55.label + '</div>'
        )
      $('#buy-vehicle').append(_0x422d1d)
      _0x422d1d.on('click', () => {
        SelectItem('buy-vehicle', _0x50ca58, _0x5dcc55.label)
        $('#buy-vehicle-price').val(
          '$ ' + moneyFormat.format(_0x5dcc55.price).replace('$', '')
        )
      })
    }
  }
var moneyFormat = new Intl.NumberFormat('en-US', {
    style: 'currency',
    currency: 'USD',
    minimumFractionDigits: 0,
  }),
  shopCart = {}
const MakeOrder = () => {
    if (Object.keys(shopCart).length < 1) {
      return
    }
    $.post(
      'https://piotreq_lst/actionData',
      JSON.stringify({
        action: 'MakeOrder',
        cart: shopCart,
      })
    ).then((_0xcc1808) => {
      _0xcc1808 && loadOrders(_0xcc1808, true)
    })
    shopCart = {}
    RefreshCart()
  },
  RefreshCart = () => {
    let _0x51c1e5 = 0
    $('.shop-cart').empty()
    for (const [_0x15fe64, _0x4a3c50] of Object.entries(shopCart)) {
      _0x51c1e5 = _0x51c1e5 + _0x4a3c50.count * _0x4a3c50.price
      $('.shop-cart').append(
        '\n         <div class="shop-cart-item">\n            <span>' +
          _0x4a3c50.label +
          ' x' +
          _0x4a3c50.count +
          '</span>\n            <div class="cart-item-buttons">\n                <div class="cart-item-btn" onclick="AddToCart(\'' +
          _0x15fe64 +
          "', '" +
          _0x4a3c50.label +
          "', " +
          _0x4a3c50.price +
          ')"><i class="fa-regular fa-plus"></i></div>\n                <div class="cart-item-btn" onclick="RemoveFromCart(\'' +
          _0x15fe64 +
          '\')"><i class="fa-regular fa-minus"></i></div>\n            </div>\n        </div>'
      )
    }
    $('#cart-total').text('$ ' + _0x51c1e5)
  },
  RemoveFromCart = (_0x4f8a9f) => {
    shopCart[_0x4f8a9f] &&
      (shopCart[_0x4f8a9f].count--,
      shopCart[_0x4f8a9f].count < 1 && delete shopCart[_0x4f8a9f],
      RefreshCart())
  },
  AddToCart = (_0x5b0910, _0x1fe3a3, _0x4832fa) => {
    shopCart[_0x5b0910]
      ? shopCart[_0x5b0910].count++
      : (shopCart[_0x5b0910] = {
          label: _0x1fe3a3,
          price: _0x4832fa,
          count: 1,
        })
    RefreshCart()
  },
  loadShop = (_0x5dd144) => {
    $('.shop-wrapper').html(
      '\n    <div class="shop-items-wrapper">\n        <span>' +
        locales.products_list +
        '</span>\n        <div class="shop-items">\n            <div class="shop-items-list"></div>\n        </div>\n    </div>\n    <div class="shop-cart-wrapper">\n        <div>\n            <span>' +
        locales.cart +
        '</span>\n            <span>' +
        locales.total_price +
        ' - <font id="cart-total">$ 0</font></span>\n        </div>\n        <div class="shop-cart"></div>\n        <div class="shop-cart-btn" onclick="MakeOrder()">' +
        locales.order +
        '</div>\n    </div>'
    )
    $('.shop-items-list').empty()
    for (let _0x340dff in _0x5dd144) {
      let _0x58481b = _0x5dd144[_0x340dff]
      $('.shop-items-list').append(
        '\n        <div class="shop-item">\n            <div class="shop-item-main">\n                <img src="img/' +
          _0x58481b.itemName +
          '.png" alt="">\n                <span>' +
          _0x58481b.label +
          '</span>\n                <span>Cena - $ ' +
          _0x58481b.price +
          '</span>\n            </div>\n            <div class="shop-item-btn" onclick="AddToCart(\'' +
          _0x58481b.itemName +
          "', '" +
          _0x58481b.label +
          "', " +
          _0x58481b.price +
          ')">' +
          locales.add_to_cart +
          '</div>\n        </div>'
      )
    }
  }
window.addEventListener('message', (_0x2e2ee1) => {
  let _0x3031de = _0x2e2ee1.data
  switch (_0x3031de.action) {
    case 'OpenLST':
      loadShop(_0x3031de.shop), (myIdentifier = _0x3031de.id)
      !loadedVehicles &&
        ((loadedVehicles = true), loadVehicles(_0x3031de.vehicles))
      Object.keys(LSTLicenses).length < 1 &&
        (loadLicenses(_0x3031de.licenses), (LSTLicenses = _0x3031de.licenses))
      playerAccess = _0x3031de.access
      const _0x25a294 = document.querySelectorAll('.side-buttons > .side-btn')
      _0x25a294.forEach((_0x11e093) => {
        if ($(_0x11e093).attr('id')) {
          let _0x570e45 = $(_0x11e093).attr('id').replace('-btn', '')
          $('#' + _0x570e45 + '-btn').css(
            'display',
            playerAccess[_0x570e45] ? 'flex' : 'none'
          )
          $('#' + _0x570e45 + '-btn > span').text(locales[_0x570e45])
        }
      }),
        $(':root')
          .get(0)
          .style.setProperty('--main-color', _0x3031de.colors.mainColor),
        $(':root')
          .get(0)
          .style.setProperty(
            '--main-color-hover',
            _0x3031de.colors.mainColorHover
          ),
        $(':root')
          .get(0)
          .style.setProperty('--main-bg', _0x3031de.colors.bgColor),
        $('.lst-logo').css(
          'background',
          "center / cover no-repeat url('" + _0x3031de.colors.image + "')"
        ),
        loadTab(_0x3031de),
        $('.lst-wrapper').css('display', 'flex')
      break
    case 'OpenDispatch':
      OpenDispatch()
      break
    case 'LoadDispatch':
      loadDispatch(_0x3031de)
      break
    case 'ReportNotification':
      ReportNotification(_0x3031de.alert)
      break
  }
})
