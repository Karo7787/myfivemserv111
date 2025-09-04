const crimetab = new Vue({
  el: "#crimeTab",
  delay: 20,
  data: () => ({
    lang: locales,
    listRanks: groupPermissions,
    forwardGroup: ownerCanForwardGroup,
    deleteGroup: ownerCanDeleteGroup,
    page: "Home",
    nameCrime: null,
    datas: {},
    newnameorg: null,
    players: {},
    mychar: {},
    numberiban: null,
    amountiban: null,
    currencycrypto: null,
    drop_player_name: null,
    drop_player_cid: null,
    position_player_name: null,
    position_player_cid: null,
    position_player_newrank: null,
    inviteCid: null,
    updates: [],
    missions: {},
    timeNow: 0,
    loading: true,
    account: [],
    quests: [],
    usingsfbanking: false,
    access_player: null,
    access_playername: null,
    access_bank: 1,
    access_crypto: 1,
  }),
  methods: {
    closeMDTclear() {
      this.loading = true;
      $.post("https://sfctab/close", JSON.stringify({}));
      $('.gpt-popup').css('display', "none")
      $(".gpt-popups-wrapper").css("display", "none");
      Object.assign(this.$data, this.$options.data());
    },
    changePage(d) {
      this.page = d;
    },
    setNewNameCrime(d) {
      this.loading = true;
      $.post("https://sfctab/setNewNameCrime", JSON.stringify({ newname: d }));
    },
    parseCrypto(d) {
      return parseFloat(d).toFixed(5);
    },
    correctPosition(d) {
      let F;
      if (d == 10) {
        F = this.lang.rang10;
      }
      if (d == 9) {
        F = this.lang.rang9;
      }
      if (d == 3) {
        F = this.lang.rang3;
      }
      if (d == 2) {
        F = this.lang.rang2;
      }
      if (d == 1) {
        F = this.lang.rang1;
      }
      if (d == 0) {
        F = this.lang.rang0;
      }
      return F;
    },
    withdrawMoney() {
      $(".gpt-popups-wrapper").css("display", "flex");
      $("#withdrawMoney-popup").css("display", "flex");
      return;
    },
    withdrawMoneyClose() {
      $(".gpt-popups-wrapper").css("display", "none");
      $("#withdrawMoney-popup").css("display", "none");
      this.numberiban = null;
      this.amountiban = null;
      this.currencycrypto = null;
      return;
    },
    sendWithdrawMoney() {
      $.post(
        "https://sfctab/sendWithdrawMoney",
        JSON.stringify({
          tonumber: this.numberiban,
          amount: this.amountiban,
          crimeid: this.datas.id,
        })
      );
      this.withdrawMoneyClose();
    },
    withdrawCrypto() {
      $(".gpt-popups-wrapper").css("display", "flex");
      $("#withdrawCrypto-popup").css("display", "flex");
      return;
    },
    withdrawCryptoClose() {
      $(".gpt-popups-wrapper").css("display", "none");
      $("#withdrawCrypto-popup").css("display", "none");
      this.numberiban = null;
      this.amountiban = null;
      this.currencycrypto = null;
      $("#" + "withdrawCrypto-type" + "-value").text("");
      $("#" + "withdrawCrypto-type" + "-value").attr("data-value", '');
      return;
    },
    sendWithdrawCrypto() {
      $.post(
        "https://sfctab/sendWithdrawCrypto",
        JSON.stringify({
          tonumber: this.numberiban,
          amount: this.amountiban,
          currency: this.currencycrypto,
          crimeid: this.datas.id,
        })
      );
      this.withdrawCryptoClose();
    },
    dropFromCrime(d, A, F) {
      this.drop_player_name = d + " " + A;
      this.drop_player_cid = F;
      $(".gpt-popups-wrapper").css("display", "flex");
      $("#dropPlayer-popup").css("display", "flex");
      return;
    },
    dropFromCrimeClose() {
      $(".gpt-popups-wrapper").css("display", "none");
      $("#dropPlayer-popup").css("display", "none");
      this.drop_player_cid = null;
      this.drop_player_name = ""
      return;
    },
    quitFromCrime() {
      this.drop_player_cid = this.mychar.playerid;
      $(".gpt-popups-wrapper").css("display", "flex");
      $("#quitPlayer-popup").css("display", "flex");
      return;
    },
    quitFromCrimeClose() {
      $(".gpt-popups-wrapper").css("display", "none");
      $("#quitPlayer-popup").css("display", "none");
      this.drop_player_cid = null;
      return;
    },
    acceptPlayerQuit() {
      $.post(
        "https://sfctab/acceptPlayerQuit",
        JSON.stringify({
          char_id: this.drop_player_cid,
          crimeid: this.datas.id,
        })
      );
      this.quitFromCrimeClose();
      this.closeMDTclear();
    },
    SelectItem(elementId, code, label) {
      $("#" + elementId + "-value").text(label);
      $("#" + elementId + "-value").attr("data-value", code);
      if(elementId == "change-player-position"){
        this.position_player_newrank = code
      }
      if(elementId == "giveaccess-player"){
        this.access_player = code
      }
      if(elementId == "giveaccess-bank"){
        this.access_bank = code
      }
      if(elementId == "giveaccess-crypto"){
        this.access_crypto = code
      }
      if(elementId == "withdrawCrypto-type"){
        this.currencycrypto = code
      }
      this.ToggleSelect(elementId);
    },
    ToggleSelect(elementId) {
      let element = $("#" + elementId);
      element.css("max-height") == "0px"
        ? (element.animate({ opacity: "1.0" }, 100),
        element.css("max-height", "12.5rem"),
        element.css("overflow-y", "scroll"),
          $("#" + elementId + "-arrow").css("transform", "rotate(180deg)"))
        : (element.css("max-height", "0px"),
          $("#" + elementId + "-arrow").css("transform", "rotate(0deg)"),
          element.css("overflow-y", "hidden"),
          element.animate({ opacity: "0.0" }, 100));
    },
    acceptPlayerDrop() {
      $.post(
        "https://sfctab/acceptPlayerDrop",
        JSON.stringify({
          char_id: this.drop_player_cid,
          crimeid: this.datas.id,
        })
      );
      this.dropFromCrimeClose();
    },
    changePosition(d, A, F) {
      this.position_player_name = d + " " + A;
      this.position_player_cid = F;
      
      $(".gpt-popups-wrapper").css("display", "flex");
      $("#changePlayerPosition-popup").css("display", "flex");
      return;
    },
    changePositionClose() {
      $(".gpt-popups-wrapper").css("display", "none");
      $("#changePlayerPosition-popup").css("display", "none");
      this.position_player_name = null;
      this.position_player_cid = null;
      this.position_player_newrank = null;
      $("#" + "change-player-position" + "-value").text("");
      $("#" + "change-player-position" + "-value").attr("data-value", '');
      return;
    },
    acceptPlayerPosition() {
      $.post(
        "https://sfctab/acceptPlayerPosition",
        JSON.stringify({
          char_id: this.position_player_cid,
          newposition: this.position_player_newrank,
          crimeid: this.datas.id,
        })
      );
      this.changePositionClose();
    },
    buyUpdate(d) {
      $.post(
        "https://sfctab/buyUpdate",
        JSON.stringify({ id: d, crimeid: this.datas.id })
      );
      return;
    },
    checkUpdate(d) {
      return this.datas.updates["update-" + d] == "ok";
    },
    invitePlayer() {
      $(".gpt-popups-wrapper").css("display", "flex");
      $("#invitePlayer-popup").css("display", "flex");
      return;
    },
    invitePlayerClose() {
      $(".gpt-popups-wrapper").css("display", "none");
      $("#invitePlayer-popup").css("display", "none");
      this.inviteCid = null;
      return;
    },
    invitePlayerSend() {
      if(this.inviteCid>0){
        $.post(
          "https://sfctab/invitePlayerSend",
          JSON.stringify({ char_id: this.inviteCid, crimeid: this.datas.id })
        );
        this.invitePlayerClose();
      }
    },
    counterLevel(d) {
      return parseInt(d / 1e3);
    },
    counterPoints(d) {
      let F = parseInt(d / 1e3);
      let J = d - F * 1e3;
      return J;
    },
    counterLevelMission(d) {
      return parseInt(d / 100);
    },
    counterPointsMission(d) {
      let F = parseInt(d / 100);
      let J = d - F * 100;
      return J;
    },
    counterPercentStats(d) {
      let F = parseInt(d / 1e3);
      let J = d - F * 1e3;
      return J / 10;
    },
    counterPercentStatsMission(d) {
      let F = parseInt(d / 100);
      let J = d - F * 100;
      return J;
    },
    counterNameMission(d) {
      let F = d.split("-");
      let J = "";
      for (let U = 0; U < this.missions.length; U++) {
        if (this.missions[U].id == F[1]) {
          J = this.missions[U].name;
        }
      }
      return J;
    },
    getValueName(d) {
      let F = "";
      for (let J = 0; J < this.updates.length; J++) {
        if (this.updates[J].id == d) {
          F = this.updates[J].name;
        }
      }
      return F;
    },
    needUpdate(d) {
      if (this.updates[d].need) {
        let F = true;
        if (
          this.datas.updates["update-" + d] != "ok"
        ) {
          F = false;
        }
        return F;
      } else {
        return true;
      }
    },
    refreshTimeStamp(d) {
      this.timeNow = Math.round(+new Date() / 1e3);
      $("#errormessage-" + d).html("");
      $("#errormessage-" + d).html(this.lang.mission_start_error);
      setTimeout(() => {
        $("#errormessage-" + d).html("");
      }, 1e3);
    },
    timeForMission(d, A) {
      let J = Math.floor(d) + Math.floor(A);
      return !!(J < this.timeNow);
    },
    startMission(d, A, F) {
      if (this.getMyCrypto(F) < this.toNumber(A)) {
        this.refreshTimeStamp(d);
        return;
      }
      $.post(
        "https://sfctab/startMission",
        JSON.stringify({ idmission: d, crimeid: this.datas.id })
      );
      return;
    },
    setFailedMission(d) {
      $.post(
        "https://sfctab/setFailedMission",
        JSON.stringify({ idmission: d, crimeid: this.datas.id })
      );
      return;
    },
    getMyCrypto(d) {
      let F = null;
      if (this.datas.cryptoamount.length > 0) {
        this.datas.cryptoamount.filter((J) => {
          if (J.name == d) {
            F = J.amount;
          }
        });
      }
      if (F == null) {
        F = 0;
      }
      return this.toNumber(F);
    },
    toNumber(d) {
      return parseFloat(d);
    },
    loadDataForSettingsAccount() {
      if (this.usingsfbanking) {
        this.loading = true;
        $.post("https://sfctab/loadDataForSettingsAccount", JSON.stringify({}));
        this.changePage("Bank");
      }
    },
    giveAccessToAccount() {
      $(".gpt-popups-wrapper").css("display", "flex");
      $("#GiveAccess-popup").css("display", "flex");
      return;
    },
    giveAccessToAccountClose() {
      $(".gpt-popups-wrapper").css("display", "none");
      $("#GiveAccess-popup").css("display", "none");
      $("#" + "giveaccess-player" + "-value").text("");
      $("#" + "giveaccess-player" + "-value").attr("data-value", '');
      this.access_player = null;
      this.access_bank = 1;
      this.access_crypto = 1;
      return;
    },
    checkHaveAccess() {
      var A = false;
      if (this.account.length == 0) {
        A = false;
      } else {
        this.account.filter((F) => {
          if (F.playerid == this.access_player) {
            A = true;
          }
        });
      }
      return A;
    },
    giveAccessToAccountSend() {
      $.post(
        "https://sfctab/giveAccessToAccountSend",
        JSON.stringify({
          playerid: this.access_player,
          bank: this.access_bank,
          crypto: this.access_crypto,
        })
      );
      this.giveAccessToAccountClose();
      this.loading = true;
    },
    removeAccessAccount(d, A) {
      this.access_player = d;
      this.access_playername = A;
      $(".gpt-popups-wrapper").css("display", "flex");
      $("#RemoveAccess-popup").css("display", "flex");
      return;
    },
    removeAccessAccountClose() {
      $(".gpt-popups-wrapper").css("display", "none");
      $("#RemoveAccess-popup").css("display", "none");
      this.access_player = null;
      this.access_playername = null;
      return;
    },
    removeAccessAccountSend() {
      $.post(
        "https://sfctab/removeAccessAccountSend",
        JSON.stringify({ playerid: this.access_player })
      );
      this.removeAccessAccountClose();
      this.loading = true;
    },
    checkPerm(d) {
      var F = false;
      if (this.listRanks.length == 0) {
        F = false;
      } else {
        this.listRanks.filter((J) => {
          if (J.rang == this.mychar.position) {
            J.permissions.filter((T) => {
              if (T.id == d) {
                F = true;
              }
            });
          }
        });
      }
      return F;
    },
    calcPercent(num1, num2) {
      return Math.floor((num1 / num2) * 100)
    },
    loadDataForQuests() {
      this.loading = true;
      $.post("https://sfctab/loadDataForQuests", JSON.stringify({})).then((data) => {
        crimetab.quests = data;
        this.changePage("Quests");
        this.loading = false;
      });
    },
    collectQuest(id) {
      $.post("https://sfctab/collectQuest", JSON.stringify({ id: id }));
      $.post("https://sfctab/loadDataForQuests", JSON.stringify({})).then((data) => {
        crimetab.quests = data;
        this.changePage("Quests");
      });
    },
    deleteThisGroup() {
      if (this.mychar.position == 10) {
        $.post("https://sfctab/deleteThisGroup", JSON.stringify({}));
        this.closeMDTclear();
      }
    },
  },
  computed: {
    filtered_employees: function () {
      function A(J, U) {
        if (J.position < U.position) {
          return 1;
        }
        if (J.position > U.position) {
          return -1;
        }
        return 0;
      }
      let F = this.players.sort(A);
      return F;
    },
  },
});
document.onreadystatechange = () => {
  if (document.readyState === "complete") {
    window.addEventListener("message", function (A) {
      if (A.data.isVisible == true) {
        document.body.style.display = A.data.isVisible ? "block" : "none";
        crimetab.nameCrime = A.data.nameCrime;
        crimetab.datas = A.data.datas;
        crimetab.datas.updates = JSON.parse(A.data.datas.updates)
        crimetab.players = A.data.players;
        crimetab.mychar = A.data.mychar;
        crimetab.updates = A.data.updates;
        crimetab.missions = A.data.missions;
        crimetab.timeNow = Math.round(+new Date() / 1e3);
        if (crimetab.page == "Home") {
          crimetab.changePage("Home");
        }
        crimetab.loading = false;
      } else {
        if (A.data.isVisible == false) {
          crimetab.loading = true;
          document.body.style.display = A.data.isVisible ? "block" : "none";
        } else {
          if (A.data.refreshData == true) {
            crimetab.loading = false;
            crimetab.nameCrime = A.data.nameCrime;
            crimetab.datas = A.data.datas;
            crimetab.datas.updates = JSON.parse(A.data.datas.updates)
            crimetab.players = A.data.players;
            crimetab.mychar = A.data.mychar;
            crimetab.updates = A.data.updates;
            crimetab.missions = A.data.missions;
            crimetab.timeNow = Math.round(+new Date() / 1e3);
          } else {
            if (A.data.usingsfbanking == true) {
              crimetab.usingsfbanking = true;
            } else if (A.data.refreshDataAccount == true) {
              crimetab.account = A.data.account;
              crimetab.loading = false;
            }
          }
        }
      }
    });
  }
};
document.onkeydown = function (d) {
  if (d.which == 27) {
    crimetab.closeMDTclear();
  }
};
