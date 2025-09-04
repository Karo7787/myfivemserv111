
const sfbanking = new Vue({
    'el': "#Bank",
    'delay': 0xa,
    'data': () => ({
        'page': "Home",
        'lang': locales,
        'bank_number': 0x0,
        'bank_amount': 0x0,
        'atm': false,
        'bank_logs': [],
        'money_in_eq': 0x0,
        'withdraw_amount': null,
        'withdraw_desc': null,
        'payment_amount': null,
        'payment_desc': null,
        'transfer_number': null,
        'transfer_amount': null,
        'transfer_desc': null,
        'main_account': 0x0,
        'accounts': [],
        'active_account': 0x0,
        'loading': false,
        'crypto_number': 0x0,
        'crypto_amount': [],
        'crypto_logs': [],
        'currency': [],
        'sellcrypto_amount': null,
        'sellcrypto_currency': null,
        'buycrypto_amount': null,
        'buycrypto_currency': null
    }),
    'methods': {
        'closeMDTclear'() {
            this.loading = true;
            $.post("https://sfbanking/close", JSON.stringify({}));
            setTimeout(()=> {
                Object.assign(this.$data, this.$options.data());
            }, 200)
        },
        'changePage'(S) {
            this.page = S;
            ClearActiveNavItems();
            if (S == "Payment") {
                $("#Payment").addClass("nav-active");
            } else {
                if (S == "Withdraw") {
                    $("#Withdraw").addClass("nav-active");
                } else {
                    if (S == "Transfer") {
                        $("#Transfer").addClass("nav-active");
                    } else {
                        if (S == "SellCrypto") {
                            $("#SellCrypto").addClass("nav-activeC");
                        } else {
                            if (S == "BuyCrypto") {
                                $("#BuyCrypto").addClass("nav-activeC");
                            } else if (S == "TransferCrypto") {
                                $("#TransferCrypto").addClass("nav-activeC");
                            }
                        }
                    }
                }
            }
        },
        'createNewAccount'() {
            $.post("https://sfbanking/createNewAccount", JSON.stringify({}));
        },
        'backToMain'() {
            this.changePage("Home");
            this.withdraw_amount = null;
            this.withdraw_desc = null;
            this.payment_amount = null;
            this.payment_desc = null;
            this.transfer_number = null;
            this.transfer_amount = null;
            this.transfer_desc = null;
        },
        'backToMainCrypto'() {
            this.changePage("HomeCrypto");
            this.sellcrypto_amount = null;
            this.sellcrypto_currency = null;
            this.buycrypto_amount = null;
            this.buycrypto_currency = null;
            this.transfer_number = null;
        },
        'sendPaymentMoney'() {
            if(this.payment_amount>=1 && this.payment_amount<=this.money_in_eq){
                $.post("https://sfbanking/depositSubmit", JSON.stringify({
                    'fromAccount': this.bank_number,
                    'amount': this.payment_amount,
                    'reason': this.payment_desc
                }));
                this.backToMain();
            }
        },
        'sendWithdrawMoney'() {
            if(this.withdraw_amount>=1 && this.withdraw_amount<=this.bank_amount){
                $.post("https://sfbanking/withdrawSubmit", JSON.stringify({
                    'fromAccount': this.bank_number,
                    'amount': this.withdraw_amount,
                    'reason': this.withdraw_desc
                }));
                this.bank_amount = Math.floor(this.bank_amount) - this.withdraw_amount;
                this.backToMain();
                if(this.atm){
                    this.closeMDTclear()
                }
            }
        },
        'sendTransferMoney'() {
            if(this.transfer_amount>=1 && this.transfer_amount<=this.bank_amount && this.transfer_number > 0 && this.transfer_number != this.bank_number){
                $.post("https://sfbanking/transferSubmit", JSON.stringify({
                    'fromAccount': this.bank_number,
                    'toPlayer': this.transfer_number,
                    'amount': this.transfer_amount,
                    'reason': this.transfer_desc
                }));
                this.bank_amount = Math.floor(this.bank_amount) - this.transfer_amount;
                this.backToMain();
            }
        },
        'goodDate'(S) {
            function L(o) {
                if (o < 10) {
                    o = '0' + o;
                }
                return o;
            }
            let P = new Date(S * 1);
            let u = P.getFullYear();
            let n = P.getMonth() + 1;
            let z = P.getDate();
            let s = L(z) + '/' + L(n) + '/' + u;
            return s;
        },
        'goodTime'(S) {
            function L(o) {
                if (o < 10) {
                    o = '0' + o;
                }
                return o;
            }
            let P = new Date(S * 1);
            let d = P.getHours();
            let N = P.getMinutes();
            let h = L(d) + ':' + L(N)
            return h;
        },
        'changeAccount'(S) {
            $.post("https://sfbanking/changeAccount", JSON.stringify({
                'account': S.target.value
            }));
            this.loading = true;
        },
        'changeAccountCrypto'(S) {
            $.post("https://sfbanking/changeAccountCrypto", JSON.stringify({
                'account': S.target.value
            }));
            this.loading = true;
        },
        'setCrypto'(S) {
            this.sellcrypto_currency = S.target.value;
        },
        'setCryptoBuy'(S) {
            this.buycrypto_currency = S.target.value;
        },
        'parseCrypto'(S) {
            return parseFloat(S).toFixed(2);
        },
        'checkHaveCrypto'() {
            return !!(this.parseCrypto(this.sellcrypto_amount) <= this.getMyCrypto(this.sellcrypto_currency));
        },
        'getPriceCrypto'(S) {
            let L = null;
            if (this.currency.length > 0) {
                this.currency.filter(P => {
                    if (P.name == S) {
                        L = P.price;
                    }
                });
            }
            if (L == null) {
                L = 0;
            }
            return this.parseCrypto(L);
        },
        'getMyCrypto'(S) {
            let L = null;
            if (this.crypto_amount.length > 0) {
                this.crypto_amount.filter(P => {
                    if (P.name == S) {
                        L = P.amount;
                    }
                });
            }
            if (L == null) {
                L = 0;
            }
            return this.parseCrypto(L);
        },
        'sendSellCrypto'() {
            if((this.sellcrypto_amount > 0 && this.sellcrypto_currency && checkHaveCrypto()) && (this.sellcrypto_amount > 0 && this.sellcrypto_currency)){
                $.post("https://sfbanking/sendSellCrypto", JSON.stringify({
                    'fromAccount': this.crypto_number,
                    'amount': this.sellcrypto_amount,
                    'currency': this.sellcrypto_currency
                }));
                if (this.crypto_amount.length > 0) {
                    this.crypto_amount.filter(M => {
                        if (M.name == this.sellcrypto_currency) {
                            M.amount = M.amount - this.sellcrypto_amount;
                        }
                    });
                }
                this.backToMainCrypto();
            }
        },
        'sendBuyCrypto'() {
            if((this.buycrypto_amount > 0 && this.buycrypto_currency && (this.buycrypto_amount * this.getPriceCrypto(this.buycrypto_currency)) <= this.bank_amount)){
                $.post("https://sfbanking/sendBuyCrypto", JSON.stringify({
                    'fromAccount': this.crypto_number,
                    'amount': this.buycrypto_amount,
                    'currency': this.buycrypto_currency
                }));
                this.backToMainCrypto();
            }
        },
        'sendTransferCrypto'() {
            if((this.sellcrypto_amount > 0 && this.transfer_number > 0 && this.checkHaveCrypto())){
                $.post("https://sfbanking/sendTransferCrypto", JSON.stringify({
                    'fromAccount': this.crypto_number,
                    'toAccount': this.transfer_number,
                    'amount': this.sellcrypto_amount,
                    'currency': this.sellcrypto_currency
                }));
                if (this.crypto_amount.length > 0) {
                    this.crypto_amount.filter(M => {
                        if (M.name == this.sellcrypto_currency) {
                            M.amount = M.amount - this.sellcrypto_amount;
                        }
                    });
                }
                this.backToMainCrypto();
            }
        }
    }
});
$("#home").addClass("nav-active");
document.onreadystatechange = () => {
    if (document.readyState === "complete") {
        window.addEventListener("message", function (M) {
            if (M.data.openLoading) {
                if (M.data.loading == "crypto") {
                    document.body.style.display = M.data.openLoading ? "block" : "none";
                    sfbanking.loading = true;
                    sfbanking.changePage("HomeCrypto");
                }
                if (M.data.loading == "bank") {
                    document.body.style.display = M.data.openLoading ? "block" : "none";
                    sfbanking.loading = true;
                    sfbanking.changePage("Home");
                }
            } else {
                if (M.data.isVisible == true) {
                    sfbanking.bank_number = M.data.bank_number;
                    sfbanking.bank_amount = Math.floor(M.data.bank_amount);
                    sfbanking.atm = M.data.atm;
                    sfbanking.bank_logs = M.data.bank_logs;
                    sfbanking.money_in_eq = M.data.money_in_eq;
                    sfbanking.main_account = M.data.bank_number;
                    sfbanking.active_account = M.data.bank_number;
                    sfbanking.accounts = M.data.accounts;
                    sfbanking.changePage("Home");
                    sfbanking.loading = false;
                } else {
                    if (M.data.isVisible == false) {
                        document.body.style.display = M.data.isVisible ? "block" : "none";
                    } else {
                        if (M.data.refreshData == true) {
                            if (M.data.bank_number) {
                                sfbanking.bank_number = M.data.bank_number;
                            }
                            sfbanking.bank_amount = Math.floor(M.data.bank_amount);
                            sfbanking.bank_logs = M.data.bank_logs;
                            sfbanking.money_in_eq = M.data.money_in_eq;
                            sfbanking.$forceUpdate();
                        } else {
                            if (M.data.refreshDataCrypto == true) {
                                sfbanking.crypto_amount = M.data.crypto_amount;
                                sfbanking.crypto_logs = M.data.crypto_logs;
                                sfbanking.bank_amount = Math.floor(M.data.bank_amount);
                                sfbanking.$forceUpdate();
                            } else {
                                if (M.data.refreshAccount == true) {
                                    sfbanking.bank_number = M.data.bank_number;
                                    sfbanking.bank_amount = Math.floor(M.data.bank_amount);
                                    sfbanking.bank_logs = M.data.bank_logs;
                                    sfbanking.money_in_eq = M.data.money_in_eq;
                                    sfbanking.active_account = M.data.bank_number;
                                    sfbanking.loading = false;
                                    sfbanking.$forceUpdate();
                                } else {
                                    if (M.data.refreshAccountCrypto == true) {
                                        sfbanking.crypto_number = M.data.crypto_number;
                                        sfbanking.crypto_amount = M.data.crypto_amount;
                                        sfbanking.crypto_logs = M.data.crypto_logs;
                                        sfbanking.bank_amount = Math.floor(M.data.bank_amount);
                                        sfbanking.active_account = M.data.crypto_number;
                                        sfbanking.loading = false;
                                        sfbanking.$forceUpdate();
                                    } else {
                                        if (M.data.isVisibleCrypto == true) {
                                            sfbanking.crypto_number = M.data.crypto_number;
                                            sfbanking.crypto_amount = M.data.crypto_amount;
                                            sfbanking.bank_amount = Math.floor(M.data.bank_amount);
                                            sfbanking.crypto_logs = M.data.crypto_logs;
                                            sfbanking.main_account = M.data.crypto_number;
                                            sfbanking.active_account = M.data.crypto_number;
                                            sfbanking.accounts = M.data.accounts;
                                            sfbanking.currency = M.data.currency;
                                            sfbanking.changePage("HomeCrypto");
                                            sfbanking.loading = false;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            ;
        });
    }
    ;
};
document.onkeydown = function (S) {
    if (S.which == 27) {
        if (sfbanking.loading == false) {
            sfbanking.closeMDTclear();
        }
    }
};
function ClearActiveNavItems() {
    $("#Payment").removeClass("nav-active");
    $("#Withdraw").removeClass("nav-active");
    $("#Transfer").removeClass("nav-active");
    $("#SellCrypto").removeClass("nav-activeC");
    $("#BuyCrypto").removeClass("nav-activeC");
    $("#TransferCrypto").removeClass("nav-activeC");
}
function W(Y, Q) {
    const U = x();
    W = function (g, B) {
        g = g - 103;
        let D = U[g];
        return D;
    };
    return W(Y, Q);
}