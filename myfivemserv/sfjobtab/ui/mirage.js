const sfjobtab = new Vue({
    'el': "#content",
    'delay': 0x14,
    'data': () => ({
        'lang': locales,
        'page': "home",
        'mychar': {
            'id': 0x0,
            'cid': "char1:me",
            'name': "Max Tester",
            'date': "12.05.2023 16:41:43",
            'workname': "burgershot",
            'worktime': 0x0,
            'worktime_all': 0x0,
            'position': 0x0,
            'numberInvoices': 0x0
        },
        'business': {
            'workname': "burgershot",
            'name': "Burger Shot",
            'money': 0x0,
            'numberInvoices': 0x0,
            'profit': 0x0,
            'bank_number': 0x0,
            'date_creation': '',
            'maxlimit': 0x6,
            'updates': [],
            'system': 0x0,
            'payoutBank': false,
            'employees': [],
            'announcements': [],
            'listUpdates': [],
            'listRanks': [],
            'products': [],
            'invoices': []
        },
        'permissionList': [{
            'id': 0x1,
            'name': this.locales.editpermissions_text_1
        }, {
            'id': 0x2,
            'name': this.locales.editpermissions_text_2
        }, {
            'id': 0x3,
            'name': this.locales.editpermissions_text_3
        }, {
            'id': 0x4,
            'name': this.locales.editpermissions_text_4
        }, {
            'id': 0x5,
            'name': this.locales.editpermissions_text_5,
            'name2': this.locales.editpermissions_text_5_2
        }, {
            'id': 0x6,
            'name': this.locales.editpermissions_text_6
        }, {
            'id': 0x7,
            'name': this.locales.editpermissions_text_7
        }, {
            'id': 0x8,
            'name': this.locales.editpermissions_text_8
        }, {
            'id': 0x9,
            'name': this.locales.editpermissions_text_9
        }, {
            'id': 0xa,
            'name': this.locales.editpermissions_text_10
        }, {
            'id': 0xb,
            'name': this.locales.editpermissions_text_11
        }, {
            'id': 0xc,
            'name': this.locales.editpermissions_text_12
        }, {
            'id': 0xd,
            'name': this.locales.editpermissions_text_13
        }, {
            'id': 0xf,
            'name': this.locales.editpermissions_text_15
        }, {
            'id': 0x10,
            'name': this.locales.editpermissions_text_16
        }, {
            'id': 0x11,
            'name': this.locales.editpermissions_text_17
        }, {
            'id': 0x12,
            'name': this.locales.editpermissions_text_18
        }, {
            'id': 0x13,
            'name': this.locales.editpermissions_text_19
        }],
        'readyUpdates': true,
        'searchMenu': '',
        'searchEmployee': '',
        'allitems': {
            'label': ''
        },
        'editPermissions_id': null,
        'editPermissions_position': null,
        'editPermissions_label': null,
        'editPermissions_permissions': [],
        'editPosition_id': null,
        'editPosition_position': null,
        'editPosition_label': null,
        'editPosition_money': 0x0,
        'dropProduct_id': null,
        'dropProduct_idproduct': null,
        'dropProduct_product': null,
        'addNewKit_nameKit': null,
        'addNewKit_price': 0x0,
        'addNewKit_products': [],
        'addAnnoNew_title': null,
        'addAnnoNew_message': null,
        'dropAnno_id': null,
        'dropAnno_val': null,
        'dropAnno_title': null,
        'editAnno_id': null,
        'editAnno_val': null,
        'editAnno_title': null,
        'editAnno_message': null,
        'dropEmployee_id': null,
        'dropEmployee_val': null,
        'dropEmployee_name': null,
        'changePositionEmployee_id': null,
        'changePositionEmployee_val': null,
        'changePositionEmployee_name': null,
        'changePositionEmployee_position': null,
        'changePositionEmployee_position_new': null,
        'employeeStats_name': null,
        'employeeStats_playerId': null,
        'employeeStats_stats': null,
        'addEmployee_playerid': null,
        'payoutBonus_player': null,
        'payoutBonus_time': 0x0,
        'payoutBonus_money': '0$',
        'addInvoice_player': null,
        'addInvoice_amount': 0x0,
        'addInvoice_desc': null,
        'loading': false,
        'account': [],
        'usingsfbanking': false,
        'access_player': null
    }),
    'methods': {
        'closeTablet'() {
            $.post("https://sfjobtab/close", JSON.stringify({}));
        },
        'backLastPage'() {
            this.changePage(this.titleText("page"));
            this.editPermissions_id = null;
            this.editPermissions_position = null;
            this.editPermissions_label = null;
            this.editPermissions_permissions = [];
            this.editPosition_id = null;
            this.editPosition_position = null;
            this.editPosition_label = null;
            this.editPosition_money = 0;
            this.dropProduct_id = null;
            this.dropProduct_idproduct = null;
            this.dropProduct_product = null;
            this.addNewKit_nameKit = null;
            this.addNewKit_price = 0;
            this.addNewKit_products = [];
            this.addAnnoNew_title = null;
            this.addAnnoNew_message = null;
            this.dropAnno_id = null;
            this.dropAnno_val = null;
            this.dropAnno_title = null;
            this.dropEmployee_id = null;
            this.dropEmployee_val = null;
            this.dropEmployee_name = null;
            this.editAnno_id = null;
            this.editAnno_val = null;
            this.editAnno_title = null;
            this.editAnno_message = null;
            this.changePositionEmployee_id = null;
            this.changePositionEmployee_val = null;
            this.changePositionEmployee_name = null;
            this.changePositionEmployee_position = null;
            this.addEmployee_playerid = null;
            this.payoutBonus_player = null;
            this.payoutBonus_time = 0;
            this.payoutBonus_money = '0$';
            this.addInvoice_player = null;
            this.addInvoice_amount = 0;
            this.addInvoice_desc = null;
            this.access_player = null;
        },
        'changePage'(O) {
            this.page = O;
        },
        'titleText'(O) {
            if (O == "name") {
                let Q = '';
                if (this.page == "home") {
                    Q = this.business.name;
                }
                if (this.page == "finances") {
                    Q = this.lang.headers_text_finances;
                }
                if (this.page == "employees") {
                    Q = this.lang.headers_text_employees + " " + this.business.employees.length + '/' + this.business.maxlimit;
                }
                if (this.page == "announcements") {
                    Q = this.lang.headers_text_announcements;
                }
                if (this.page == "stats") {
                    Q = this.lang.headers_text_stats;
                }
                if (this.page == "updates") {
                    Q = this.lang.headers_text_updates;
                }
                if (this.page == "settings") {
                    Q = this.lang.headers_text_settings;
                }
                if (this.page == "addInvoice") {
                    Q = this.lang.headers_text_addInvoice;
                }
                if (this.page == "addAnno") {
                    Q = this.lang.headers_text_addAnno;
                }
                if (this.page == "dropAnno") {
                    Q = this.lang.headers_text_dropAnno;
                }
                if (this.page == "editAnno") {
                    Q = this.lang.headers_text_editAnno;
                }
                if (this.page == "setBonus") {
                    Q = this.lang.headers_text_setBonus;
                }
                if (this.page == "setMenu") {
                    Q = this.lang.headers_text_setMenu;
                }
                if (this.page == "setPermissions") {
                    Q = this.lang.headers_text_setPermissions;
                }
                if (this.page == "setBankAccess") {
                    Q = this.lang.headers_text_setAccessBank;
                }
                if (this.page == "giveBankAccess") {
                    Q = this.lang.headers_text_setAccessBank;
                }
                if (this.page == "addEmployee") {
                    Q = this.lang.headers_text_addEmployee;
                }
                if (this.page == "payoutBonus") {
                    Q = this.lang.headers_text_payoutBonus;
                }
                if (this.page == "resetTimework") {
                    Q = this.lang.headers_text_resetWorktime;
                }
                if (this.page == "dropEmployee") {
                    Q = this.lang.headers_text_dropEmployee;
                }
                if (this.page == "changePositionEmployee") {
                    Q = this.lang.headers_text_changePositionEmployee;
                }
                if (this.page == "employeeStats") {
                    Q = this.lang.headers_text_employeeStats + " " + this.employeeStats_name;
                }
                if (this.page == "editPosition") {
                    Q = this.lang.headers_text_editPosition;
                }
                if (this.page == "editPermissions") {
                    Q = this.lang.headers_text_editPermissions;
                }
                if (this.page == "addNewProduct") {
                    Q = this.lang.headers_text_addNewProduct;
                }
                if (this.page == "addNewKit") {
                    Q = this.lang.headers_text_addNewKit;
                }
                if (this.page == "dropProduct") {
                    Q = this.lang.headers_text_dropProduct;
                }
                return Q;
            }
            if (O == "page") {
                let t = "home";
                if (this.page == "addInvoice") {
                    t = "finances";
                } else {
                    if (this.page == "addAnno") {
                        t = "announcements";
                    } else {
                        if (this.page == "dropAnno") {
                            t = "announcements";
                        } else {
                            if (this.page == "editAnno") {
                                t = "announcements";
                            } else {
                                if (this.page == "setBonus") {
                                    t = "settings";
                                } else {
                                    if (this.page == "setMenu") {
                                        t = "settings";
                                    } else {
                                        if (this.page == "setPermissions") {
                                            t = "settings";
                                        } else {
                                            if (this.page == "setBankAccess") {
                                                t = "settings";
                                            } else {
                                                if (this.page == "giveBankAccess") {
                                                    t = "setBankAccess";
                                                } else {
                                                    if (this.page == "addEmployee") {
                                                        t = "employees";
                                                    } else {
                                                        if (this.page == "payoutBonus") {
                                                            t = "employees";
                                                        } else {
                                                            if (this.page == "resetTimework") {
                                                                t = "employees";
                                                            } else {
                                                                if (this.page == "dropEmployee") {
                                                                    t = "employees";
                                                                } else {
                                                                    if (this.page == "changePositionEmployee") {
                                                                        t = "employees";
                                                                    } else {
                                                                        if (this.page == "employeeStats") {
                                                                            t = "employees";
                                                                        } else {
                                                                            if (this.page == "editPosition") {
                                                                                t = "setBonus";
                                                                            } else {
                                                                                if (this.page == "editPermissions") {
                                                                                    t = "setPermissions";
                                                                                } else {
                                                                                    if (this.page == "addNewProduct") {
                                                                                        t = "setMenu";
                                                                                    } else {
                                                                                        if (this.page == "addNewKit") {
                                                                                            t = "setMenu";
                                                                                        } else if (this.page == "dropProduct") {
                                                                                            t = "setMenu";
                                                                                        } else {
                                                                                            t = "home";
                                                                                        }
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                return t;
            }
        },
        'checkPerm'(O) {
            var Q = false;
            if (this.mychar.position == 10) {
                Q = true;
            } else if (this.business.listRanks.length == 0) {
                Q = false;
            } else {
                this.business.listRanks.filter(t => {
                    if (t.position == this.mychar.position) {
                        t.permissions.filter(x => {
                            if (x.id == O) {
                                Q = true;
                            }
                        });
                    }
                });
            }
            return Q;
        },
        'getNamePerm'(O) {
            var Q = this.lang.setpermissions_list_nodata;
            if (this.business.listRanks.length == 0) {
                Q = this.lang.setpermissions_list_nodata;
            } else {
                this.permissionList.filter(t => {
                    if (t.id == O) {
                        if (O == 5 && this.business.payoutBank == false) {
                            Q = t.name2;
                        } else {
                            Q = t.name;
                        }
                    }
                });
            }
            return Q;
        },
        'editPermissions'(O) {
            const Q = this.business.listRanks[O];
            this.editPermissions_id = O;
            this.editPermissions_position = Q.position;
            this.editPermissions_label = Q.label;
            this.editPermissions_permissions = Q.permissions.slice();
            this.changePage("editPermissions");
        },
        'checkIsAddedPerm'(O) {
            var Q = true;
            this.editPermissions_permissions.filter(t => {
                if (t.id == O) {
                    Q = false;
                }
            });
            return Q;
        },
        'addBadgePerm'(O) {
            this.editPermissions_permissions.push({
                'id': O
            });
        },
        'removeBadgePerm'(O) {
            this.editPermissions_permissions.splice(O, 1);
        },
        'editPermissionsSave'() {
            $.post("https://sfjobtab/editPermissionsSave", JSON.stringify({
                'workname': this.business.workname,
                'position': this.editPermissions_position,
                'permissions': this.editPermissions_permissions
            }));
            this.business.listRanks[this.editPermissions_id].permissions = this.editPermissions_permissions;
            this.backLastPage();
        },
        'editPosition'(O) {
            const Q = this.business.listRanks[O];
            this.editPosition_id = O;
            this.editPosition_position = Q.position;
            this.editPosition_label = Q.label;
            this.editPosition_money = Q.money;
            this.changePage("editPosition");
        },
        'editPositionSave'() {
            $.post("https://sfjobtab/editPositionSave", JSON.stringify({
                'workname': this.business.workname,
                'position': this.editPosition_position,
                'money': this.editPosition_money
            }));
            this.business.listRanks[this.editPosition_id].money = this.editPosition_money;
            this.backLastPage();
        },
        'dropProduct'(O) {
            this.dropProduct_id = O;
            this.dropProduct_idproduct = this.business.products[O].id;
            this.dropProduct_product = this.business.products[O].product;
            this.changePage("dropProduct");
        },
        'dropProductSave'() {
            $.post("https://sfjobtab/dropProductSave", JSON.stringify({
                'workname': this.business.workname,
                'product_id': this.dropProduct_idproduct
            }));
            this.business.products.splice(this.dropProduct_id, 1);
            this.backLastPage();
        },
        'getNameProduct'(O) {
            if (O) {
                return this.allitems[O] ? this.allitems[O].label : O;
            }
        },
        'addProductToKit'(O) {
            let Q = false;
            for (let t = 0; t < this.addNewKit_products.length; t++) {
                if (this.addNewKit_products[t].product == O) {
                    this.addNewKit_products[t].amount = this.addNewKit_products[t].amount + 1;
                    Q = true;
                }
            }
            if (Q == false) {
                this.addNewKit_products.push({
                    'product': O,
                    'amount': 0x1
                });
            }
        },
        'removeProductTFromKit'(O) {
            let Q = false;
            this.addNewKit_products[O].amount = this.addNewKit_products[O].amount - 1;
            if (this.addNewKit_products[O].amount <= 0) {
                Q = true;
            }
            if (Q == true) {
                this.addNewKit_products.splice(O, 1);
            }
        },
        'addNewKitSave'() {
            let productsprice = 0
            this.addNewKit_products.forEach(element => {
                let productdb = this.business.products.find(db => db.product == element.product)
                productsprice = productsprice + productdb.price
            });
            if(this.addNewKit_price <= productsprice){
                $.post("https://sfjobtab/addNewKitSave", JSON.stringify({
                    'workname': this.business.workname,
                    'kit_name': this.addNewKit_nameKit,
                    'kit_price': this.addNewKit_price,
                    'kit_products': this.addNewKit_products
                }));
                this.backLastPage();
            }
        },
        'getNameRank'(O) {
            var Q = null;
            this.business.listRanks.filter(t => {
                if (t.position == O) {
                    Q = t.label;
                }
            });
            if (Q == null) {
                Q = 'ND';
            }
            return Q;
        },
        'counterTime'(O) {
            function Q(f) {
                if (f < 10) {
                    f = '0' + f;
                }
                return f;
            }
            let t = O / 60;
            let x = O - Math.floor(t) * 60;
            return Q(Math.floor(t)) + ':' + Q(x);
        },
        'checkUpdate'(O) {
            return !!this.business.updates.hasOwnProperty("update-" + O);
        },
        'needUpdate'(O) {
            if (this.business.listUpdates[O].need) {
                let Q = true;
                if (this.business.updates.hasOwnProperty("update-" + this.business.listUpdates[O].need) == false) {
                    Q = false;
                }
                return Q;
            } else {
                return true;
            }
        },
        'getValueName'(O) {
            let Q = '';
            for (let t = 0; t < this.business.listUpdates.length; t++) {
                if (this.business.listUpdates[t].id == O) {
                    Q = this.business.listUpdates[t].name;
                }
            }
            return Q;
        },
        'buyUpdate'(O) {
            $.post("https://sfjobtab/buyUpdate", JSON.stringify({
                'workname': this.business.workname,
                'idupdate': O
            }));
            this.readyUpdates = false;
            return;
        },
        'addAnnoNew'() {
            function F(x) {
                if (x < 10) {
                    x = '0' + x;
                }
                return x;
            }
            const Q = new Date();
            const t = F(Q.getDate()) + '-' + F(Q.getMonth() + 1) + '-' + Q.getFullYear() + " " + F(Q.getHours()) + ':' + F(Q.getMinutes()) + ':' + F(Q.getSeconds());
            $.post("https://sfjobtab/addAnnoNew", JSON.stringify({
                'workname': this.business.workname,
                'title': this.addAnnoNew_title,
                'message': this.addAnnoNew_message,
                'who': this.mychar.name,
                'date': t
            }));
            if (this.business.announcements.length > 0) {
                this.business.announcements.unshift({
                    'title': this.addAnnoNew_title,
                    'message': this.addAnnoNew_message,
                    'who': this.mychar.name,
                    'date': t
                });
            } else {
                this.business.announcements.push({
                    'title': this.addAnnoNew_title,
                    'message': this.addAnnoNew_message,
                    'who': this.mychar.name,
                    'date': t
                });
            }
            this.backLastPage();
        },
        'dropAnno'(O, F, Q) {
            this.dropAnno_id = F;
            this.dropAnno_val = O;
            this.dropAnno_title = Q;
            this.changePage("dropAnno");
        },
        'dropAnnoSave'() {
            $.post("https://sfjobtab/dropAnno", JSON.stringify({
                'workname': this.business.workname,
                'id': this.dropAnno_id
            }));
            this.business.announcements.splice(this.dropAnno_val, 1);
            this.backLastPage();
        },
        'editAnno'(O, F, Q, t) {
            this.editAnno_id = F;
            this.editAnno_val = O;
            this.editAnno_title = Q;
            this.editAnno_message = t;
            this.changePage("editAnno");
        },
        'editAnnoSave'() {
            $.post("https://sfjobtab/editAnno", JSON.stringify({
                'workname': this.business.workname,
                'id': this.editAnno_id,
                'title': this.editAnno_title,
                'message': this.editAnno_message
            }));
            this.business.announcements[this.editAnno_val].message = this.editAnno_message;
            this.backLastPage();
        },
        'dropEmployee'(O) {
            let Q = this.business.employees[O];
            this.dropEmployee_id = Q.playerid;
            this.dropEmployee_val = O;
            this.dropEmployee_name = Q.name;
            this.changePage("dropEmployee");
        },
        'dropEmployeeConfirm'() {
            $.post("https://sfjobtab/dropEmployee", JSON.stringify({
                'workname': this.business.workname,
                'idplayer': this.dropEmployee_id
            }));
            this.business.employees.splice(this.dropEmployee_val, 1);
            this.backLastPage();
        },
        'toNumber'(O) {
            return parseFloat(O);
        },
        'showEmployeeStats'(O) {
            let Q = this.business.employees[O];
            let t = false;
            this.employeeStats_name = Q.name;
            this.employeeStats_playerId = Q.playerid;
            for (const x in Q.other) {
                if (Q.other[x].stats) {
                    t = Q.other[x].stats;
                }
            }
            this.employeeStats_stats = t;
            this.changePage("employeeStats");
        },
        'clearPlayerStats'() {
            let F = false;
            for (const Q in this.employeeStats_stats) {
                if (this.employeeStats_stats[Q]) {
                    if (this.employeeStats_stats[Q] > 0) {
                        this.employeeStats_stats[Q] = 0;
                        F = true;
                    }
                }
            }
            if (F) {
                $.post("https://sfjobtab/clearPlayerStats", JSON.stringify({
                    'workname': this.business.workname,
                    'idplayer': this.employeeStats_playerId
                }));
            }
        },
        'changePositionEmployee'(O) {
            let Q = this.business.employees[O];
            this.changePositionEmployee_id = Q.playerid;
            this.changePositionEmployee_val = O;
            this.changePositionEmployee_name = Q.name;
            this.changePositionEmployee_position = Q.position;
            this.changePositionEmployee_position_new = null;
            this.changePage("changePositionEmployee");
        },
        'changePositionEmployeeConfirm'() {
            $.post("https://sfjobtab/changePositionEmployee", JSON.stringify({
                'workname': this.business.workname,
                'idplayer': this.changePositionEmployee_id,
                'new_position': this.changePositionEmployee_position_new
            }));
            this.business.employees[this.changePositionEmployee_val].position = this.changePositionEmployee_position_new;
            this.backLastPage();
        },
        'getCorrectId'(O) {
            let Q = null;
            for (const t in this.business.employees) {
                if (this.business.employees[t].playerid == O) {
                    Q = t;
                }
            }
            return Q;
        },
        'getCorrectId2'(O) {
            let Q = null;
            for (const t in this.business.products) {
                if (this.business.products[t].id == O) {
                    Q = t;
                }
            }
            return Q;
        },
        'addEmployeeConfirm'() {
            $.post("https://sfjobtab/addEmployee", JSON.stringify({
                'workname': this.business.workname,
                'idplayer': this.addEmployee_playerid
            }));
            this.backLastPage();
        },
        'resetTimeworkConfirm'() {
            $.post("https://sfjobtab/resetTimework", JSON.stringify({
                'workname': this.business.workname
            }));
            this.backLastPage();
        },
        'checkEmployee'(O) {
            this.payoutBonus_player = O.target.value;
            for (const Q in this.business.employees) {
                if (this.business.employees[Q].id == this.payoutBonus_player) {
                    this.payoutBonus_time = Math.floor(this.business.employees[Q].worktime / 60);
                    this.payoutBonus_money = this.payoutBonus_time * this.getMoneyRank(this.business.employees[Q].position) + '$';
                }
            }
        },
        'getMoneyRank'(O) {
            var Q = 0;
            if (this.business.listRanks.length > 0) {
                this.business.listRanks.filter(t => {
                    if (t.position == O) {
                        Q = t.money;
                    }
                });
            }
            return Q;
        },
        'payoutBonusConfirm'() {
            this.business.money = this.toNumber(this.business.money) - this.toNumber(this.payoutBonus_money);
            for (const F in this.business.employees) {
                if (this.business.employees[F].id == this.payoutBonus_player) {
                    this.business.employees[F].worktime = this.business.employees[F].worktime - this.payoutBonus_time * 60;
                    $.post("https://sfjobtab/payoutBonus", JSON.stringify({
                        'workname': this.business.workname,
                        'idplayer': this.business.employees[F].playerid,
                        'position': this.business.employees[F].position,
                        'hours': this.payoutBonus_time
                    }));
                }
            }
            this.backLastPage();
        },
        'addInvoice'() {
            $.post("https://sfjobtab/addInvoice", JSON.stringify({
                'workname': this.business.workname,
                'idplayer': this.addInvoice_player,
                'amount': this.addInvoice_amount,
                'description': this.addInvoice_desc
            }));
            this.backLastPage();
        },
        'goodDate'(O) {
            function Q(A) {
                if (A < 10) {
                    A = '0' + A;
                }
                return A;
            }
            let t = new Date(O * 1);
            let x = t.getFullYear();
            let f = t.getMonth();
            let e = t.getDate();
            let P = t.getHours();
            let w = t.getMinutes();
            let T = t.getSeconds();
            let h = Q(e) + '-' + Q(f + 1) + '-' + x + " " + Q(P) + ':' + Q(w) + ':' + Q(T);
            return h;
        },
        'loadDataForSettingsAccount'() {
            if (this.usingsfbanking) {
                this.loading = true;
                $.post("https://sfjobtab/loadDataForSettingsAccount", JSON.stringify({}));
                this.changePage("setBankAccess");
            }
        },
        'giveAccessToAccount'() {
            if (this.usingsfbanking) {
                this.changePage("giveBankAccess");
            }
            return;
        },
        'checkHaveAccess'() {
            var F = false;
            if (this.account.length == 0) {
                F = false;
            } else {
                this.account.filter(Q => {
                    if (Q.playerid == this.access_player) {
                        F = true;
                    }
                });
            }
            return F;
        },
        'giveAccessToAccountSend'() {
            $.post("https://sfjobtab/giveAccessToAccountSend", JSON.stringify({
                'playerid': this.access_player
            }));
            this.backLastPage();
            this.loading = true;
        },
        'removeAccessAccount'(O) {
            $.post("https://sfjobtab/removeAccessAccountSend", JSON.stringify({
                'playerid': O
            }));
            this.loading = true;
            return;
        }
    },
    'computed': {
        'filtered_contacts': function () {
            function F(t, x) {
                if (t.name.toLowerCase() < x.name.toLowerCase()) {
                    return -1;
                }
                if (t.name.toLowerCase() > x.name.toLowerCase()) {
                    return 1;
                }
                return 0;
            }
            let Q = this.phonecontacts.sort(F);
            return Q.filter(t => {
                if (t.name.toLowerCase().search(this.searchphonecontacts.toLowerCase()) != -1) {
                    return t;
                }
            });
        },
        'filtered_products'() {
            let F = [];
            for (const Q in this.business.products) {
                if (this.business.products[Q].product.toLowerCase().search(this.searchMenu.toLowerCase()) != -1 && this.business.products[Q].list.length > 0) {
                    F.push(this.business.products[Q]);
                }
            }
            return F;
        },
        'availableProducts'() {
            let F = [];
            for (const Q in this.business.products) {
                if (this.business.products[Q].list.length == 0) {
                    F.push(this.business.products[Q]);
                }
            }
            return F;
        },
        'filtered_employees': function () {
            function F(t, x) {
                if (t.position < x.position) {
                    return 1;
                }
                if (t.position > x.position) {
                    return -1;
                }
                return 0;
            }
            let Q = this.business.employees.sort(F);
            return Q.filter(t => {
                if (t.name.toLowerCase().search(this.searchEmployee.toLowerCase()) != -1) {
                    return t;
                }
            });
        }
    }
});
document.onreadystatechange = () => {
    if (document.readyState === "complete") {
        window.addEventListener("message", function (F) {
            if (F.data.isVisible == true) {
                document.body.style.display = F.data.isVisible ? "block" : "none";
                sfjobtab.mychar = F.data.mychar;
                sfjobtab.business = F.data.business;
                sfjobtab.allitems = F.data.items;
                sfjobtab.changePage("home");
            } else if (F.data.isVisible == false) {
                document.body.style.display = F.data.isVisible ? "block" : "none";
            }
            if (F.data.refreshBusiness) {
                sfjobtab.business = F.data.refreshBusiness;
                sfjobtab.readyUpdates = true;
            }
            if (F.data.refreshPlayer) {
                sfjobtab.mychar = F.data.refreshPlayer;
            }
            if (F.data.usingsfbanking == true) {
                sfjobtab.usingsfbanking = true;
            }
            if (F.data.refreshDataAccount == true) {
                sfjobtab.account = F.data.account;
                sfjobtab.loading = false;
            }
            ;
        });
    }
    ;
};
document.onkeydown = function (O) {
    if (O.which == 27) {
        sfjobtab.closeTablet();
    }
};