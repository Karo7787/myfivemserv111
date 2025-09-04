let deadTimer = 0,
  deadInterval
var locales = {}
window.onload = () => {
  setTimeout(() => {
    $.post('https://p_ambulancejob/NUILoaded').then((_0x29bb26) => {
      locales = _0x29bb26
      $('#healing-items').text(locales.healing_items)
    })
  }, 250)
}
const ToggleDeathScreen = (_0x548fb1) => {
  if (deadInterval) {
    clearInterval(deadInterval)
  }
  _0x548fb1.state
    ? (_0x548fb1.deadStage == 1
        ? $('.death-wrapper').html(
            '\n            <span>' +
              locales.you_are_bleeding_out +
              '</span>\n            <span id="death-time">00:00</span>'
          )
        : $('.death-wrapper').html(
            '\n            <span>' +
              locales.you_are_dead +
              '</span>\n            <span id="death-time">00:00</span>\n            <span>' +
              locales.hold +
              ' <div class="death-key">G</div> ' +
              locales.to_call_medics +
              '</span>\n            <span>' +
              locales.hold +
              ' <div class="death-key">E</div> ' +
              locales.to_call_local_medics +
              '</span>'
          ),
      (deadTimer = _0x548fb1.time),
      $('#death-time').text(formatDeathTime(deadTimer)),
      $('.death-wrapper').fadeIn(300).css('display', 'flex'),
      (deadInterval = setInterval(() => {
        deadTimer--
        $('#death-time').text(formatDeathTime(deadTimer))
        deadTimer < 1 &&
          ($('#death-time').text('00:00'),
          clearInterval(deadInterval),
          (deadInterval = null),
          (deadTimer = 0),
          $.post('https://p_ambulancejob/FinishTimer'))
      }, 1000)))
    : $('.death-wrapper').fadeOut(300)
}
var audioPlayer
let damageUI = false
const humanWrapper = $('.human-wrapper')
let humanImages = []
const loadHuman = (_0x22ed74) => {
    humanImages = []
    humanWrapper.html(
      '<div class="human"><img src="images/human.png" class="human-image"></div>'
    )
    for (const [_0x2a03e7, _0x197b89] of Object.entries(_0x22ed74)) {
      _0x197b89 &&
        (humanImages.push(_0x197b89),
        $('.human').append(
          '<img src="images/' +
            _0x197b89 +
            '.png" class="human-part human-' +
            _0x197b89 +
            '">'
        ))
    }
  },
  loadBoneMenu = (_0x43e12e) => {
    $('.damage-info-box').html(
      '\n    <span>' +
        _0x43e12e.label +
        '</span>\n    <div class="damage-wrapper-secondary-box">' +
        (_0x43e12e.value == 'default'
          ? locales.low_damages
          : parseInt(_0x43e12e.value) > 10 && parseInt(_0x43e12e.value) < 60
          ? locales.medium_damages
          : locales.high_damages) +
        '</div>'
    )
    $('.damage-part-box').html(
      '<img src="images/' + _0x43e12e.bone + '.png" alt="">'
    )
    $('.damage-items-list').empty()
    for (let _0x595023 in _0x43e12e.items) {
      const _0x1710cf = _0x43e12e.items[_0x595023]
      $('.damage-items-list').append(
        '\n        <div class="damage-item-wrapper" id="damage-item-' +
          _0x1710cf.name +
          '">\n            <div class="damage-wrapper-box damage-item-icon">\n                <img src="' +
          _0x1710cf.image +
          '" id="draggable-item-' +
          _0x1710cf.name +
          '" draggable="true" alt="">\n            </div>\n            <div class="damage-wrapper-box">\n                <span>' +
          _0x1710cf.label +
          '</span>\n                <span>' +
          _0x1710cf.desc +
          '</span>\n                <div class="damage-item-count ' +
          (_0x1710cf.count < 1 ? 'low-count' : '') +
          '">\n                    ' +
          locales.you_have_count +
          ' ' +
          _0x1710cf.count +
          '\n                </div>\n            </div>\n        </div>'
      )
      _0x1710cf.count > 0 &&
        dragElement(
          document.getElementById('draggable-item-' + _0x1710cf.name),
          _0x1710cf.boneId,
          _0x1710cf.name,
          _0x1710cf.required
        )
    }
  }
function dragElement(_0x3db8ab, _0x564bbb, _0x2beea8, _0x579286) {
  var _0x3ad0a3 = 0,
    _0x2dde4f = 0,
    _0x556f5c = 0,
    _0x342196 = 0
  _0x3db8ab.onmousedown = _0x2d8060
  function _0x2d8060(_0xbd3dca) {
    _0xbd3dca = _0xbd3dca || window.event
    _0xbd3dca.preventDefault()
    _0x556f5c = _0xbd3dca.clientX
    _0x342196 = _0xbd3dca.clientY
    _0x3db8ab.classList.add('dragging')
    document.onmouseup = _0x30ab71
    document.onmousemove = _0x38f993
  }
  function _0x38f993(_0x2e93e5) {
    _0x2e93e5 = _0x2e93e5 || window.event
    _0x2e93e5.preventDefault()
    _0x3ad0a3 = _0x556f5c - _0x2e93e5.clientX
    _0x2dde4f = _0x342196 - _0x2e93e5.clientY
    _0x556f5c = _0x2e93e5.clientX
    _0x342196 = _0x2e93e5.clientY
    _0x3db8ab.style.top = _0x3db8ab.offsetTop - _0x2dde4f + 'px'
    _0x3db8ab.style.left = _0x3db8ab.offsetLeft - _0x3ad0a3 + 'px'
  }
  function _0x30ab71() {
    const _0x400edd = document.getElementById('drop-zone'),
      _0x426ede = _0x400edd.getBoundingClientRect(),
      _0xe365e5 = _0x3db8ab.getBoundingClientRect(),
      _0x1bca54 =
        _0xe365e5.top < _0x426ede.bottom &&
        _0xe365e5.bottom > _0x426ede.top &&
        _0xe365e5.left < _0x426ede.right &&
        _0xe365e5.right > _0x426ede.left
    _0x1bca54 &&
      $.post(
        'https://p_ambulancejob/HealBone',
        JSON.stringify({
          boneId: _0x564bbb,
          itemName: _0x2beea8,
          itemCount: _0x579286,
        })
      ).then((_0x4a24c2) => {
        const _0x4676f1 = $('#damage-item-' + _0x2beea8 + ' .damage-item-count')
        _0x4676f1.text(locales.you_have_count + ' ' + _0x4a24c2)
        _0x4a24c2 < 1
          ? (_0x4676f1.addClass('low-count'), (_0x3db8ab.onmousedown = null))
          : (_0x4676f1.removeClass('low-count'),
            dragElement(_0x3db8ab, _0x564bbb, _0x2beea8, _0x579286))
      })
    document.onmouseup = null
    document.onmousemove = null
    _0x3ad0a3 = 0
    _0x2dde4f = 0
    _0x556f5c = 0
    _0x342196 = 0
    _0x3db8ab.style.top = 'unset'
    _0x3db8ab.style.left = 'unset'
    _0x3db8ab.classList.remove('dragging')
  }
}
window.addEventListener('message', (_0x59501d) => {
  let _0x903ea9 = _0x59501d.data
  switch (_0x903ea9.action) {
    case 'DeathScreen':
      ToggleDeathScreen(_0x903ea9.data)
      break
    case 'ShowBlood':
      $('.blood-image').attr('src', _0x903ea9.image),
        $('.blood-image').fadeIn(125),
        setTimeout(() => {
          $('.blood-image').fadeOut(125)
        }, 450)
      break
    case 'HeartBeat':
      _0x903ea9.state
        ? (audioPlayer && audioPlayer.pause(),
          (audioPlayer = new Howl({ src: ['./sounds/heartbeat.ogg'] })),
          audioPlayer.volume(1),
          audioPlayer.play())
        : audioPlayer && audioPlayer.pause()
      break
    case 'ToggleDamageUI':
      _0x903ea9.state
        ? damageUI
          ? ((damageUI = false),
            humanWrapper.animate(
              {
                left: '-15rem',
                opacity: '0.0',
              },
              750
            ))
          : (loadHuman(_0x903ea9.damages),
            (damageUI = true),
            humanWrapper.animate(
              {
                left: '4.5rem',
                opacity: '1.0',
              },
              750
            ),
            setTimeout(() => {
              damageUI &&
                (humanWrapper.animate(
                  {
                    left: '-15rem',
                    opacity: '0.0',
                  },
                  750
                ),
                (damageUI = false))
            }, 4000))
        : ((damageUI = false),
          humanWrapper.animate(
            {
              left: '-15rem',
              opacity: '0.0',
            },
            750
          ))
      break
    case 'BoneMenu':
      const _0xffbf82 = $('.damage-wrapper')
      _0x903ea9.state
        ? (loadBoneMenu(_0x903ea9.data),
          _0xffbf82.animate({ opacity: '1.0' }),
          $('.damage-info-wrapper, .damage-items-wrapper').css(
            'transform',
            'translateX(0)'
          ))
        : (_0xffbf82.animate({ opacity: '0.0' }),
          $('.damage-info-wrapper').css('transform', 'translateX(-250%)'),
          $('.damage-items-wrapper').css('transform', 'translateX(250%)'))
      break
  }
})
document.onkeydown = (_0x1e607c) => {
  _0x1e607c.which == 27 &&
    ($('.damage-wrapper').animate({ opacity: '0.0' }),
    $('.damage-info-wrapper').css('transform', 'translateX(-250%)'),
    $('.damage-items-wrapper').css('transform', 'translateX(250%)'),
    $.post('https://p_ambulancejob/CloseUI'))
}
const formatDeathTime = (_0x1775b1) => {
  let _0xd79b4d = Math.floor(_0x1775b1 / 60)
      .toString()
      .padStart(2, '0'),
    _0x59ca0b = (_0x1775b1 - _0xd79b4d * 60).toString().padStart(2, '0')
  return _0xd79b4d + ':' + _0x59ca0b
}
