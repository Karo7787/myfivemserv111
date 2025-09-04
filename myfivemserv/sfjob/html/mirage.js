const jobCenter = new Vue({
  el: "#content",
  delay: 20,
  data: () => ({
    lang: locales,
    descriptions: defaultJobs,
    page: "Home",
    loading: true,
    myjobs: {},
    systemjobs: {},
    page: "jobcenter",
    jobcash: "unemployed",
    idcash: 1,
    datacash: { money: 0, products: {} },
    jobName: "",
    allitems: { label: "" },
    productsJob: [],
    cart: [],
    discount: 0,
    amountmoney: null,
    tipamount: null,
    tipStatus: tipsEnabled,
  }),
  methods: {
    close() {
      $.post("https://sfjob/close", JSON.stringify({}));
      setTimeout(() => {
        Object.assign(this.$data, this.$options.data());
      }, 100);
    },
    addJob(k) {
      this.myjobs.push(k);
      $.post("https://sfjob/addJob", JSON.stringify({ job: k }));
      return;
    },
    dropJob(k) {
      const w = this.myjobs.indexOf(k);
      if (w > -1) {
        this.myjobs.splice(w, 1);
      }
      $.post("https://sfjob/dropJob", JSON.stringify({ job: k }));
      return;
    },
    haveJob(k) {
      const w = this.myjobs.indexOf(k);
      return !!(w > -1);
    },
    getDescription(k) {
      return this.descriptions[k]
        ? this.descriptions[k]
        : this.lang.text_description;
    },
    changePage(k) {
      this.page = k;
    },
    getProductsFromJob() {
      return this.productsJob.length > 0 ? this.productsJob : {};
    },
    addProduct(k, G) {
      let J = -1;
      this.cart.filter((D, e) => {
        if (D.product == k) {
          J = e;
        }
      });
      if (J > -1) {
        this.cart[J].amount = this.cart[J].amount + 1;
      } else {
        let D = {
          product: this.productsJob[G].product,
          price: this.productsJob[G].price,
          list: this.productsJob[G].list,
          amount: 1,
        };
        this.cart.push(D);
      }
    },
    removeProduct(k) {
      let w = -1;
      this.cart.filter((J, D) => {
        if (J.product == k) {
          w = D;
        }
      });
      if (w > -1) {
        this.cart[w].amount = this.cart[w].amount - 1;
        if (this.cart[w].amount <= 0) {
          this.cart.splice(w, 1);
        }
      }
    },
    getPaidOrder() {
      let G = 0;
      this.cart.filter((w) => {
        G = G + w.amount * w.price;
      });
      G = G * (1 - (this.discount / 100))
      return Math.floor(G);
    },
    correctName(k) {
      if (k) {
        return this.allitems[k] ? this.allitems[k].label : k;
      }
    },
    inInventory(k) {
      return k ? !!this.allitems[k] : false;
    },
    addOrder(k) {
      $.post(
        "https://sfjob/moneyToPay",
        JSON.stringify({
          jobcash: this.jobcash,
          idcash: this.idcash,
          money: k,
          products: this.cart,
        })
      );
      this.close();
    },
    pay(k) {
      $.post(
        "https://sfjob/payForOrder",
        JSON.stringify({
          jobcash: this.jobcash,
          idcash: this.idcash,
          money: this.datacash.money,
          tip: this.tipamount,
          payment: k,
        })
      );
      this.close();
    },
  },
});
document.onreadystatechange = () => {
  if (document.readyState === "complete") {
    window.addEventListener("message", function (G) {
      if (G.data.isVisible == true) {
        document.body.style.display = G.data.isVisible ? "block" : "none";
        jobCenter.changePage(G.data.open);
        if (G.data.open == "jobcenter") {
          jobCenter.myjobs = G.data.myjobs;
          jobCenter.systemjobs = G.data.systemjobs;
        }
        if (G.data.open == "sellcash") {
          jobCenter.jobcash = G.data.job;
          jobCenter.idcash = G.data.idcash;
          if (G.data.dataCash) {
            jobCenter.cart = G.data.dataCash.products;
            jobCenter.amountmoney = G.data.dataCash.money;
          }
          jobCenter.jobName = G.data.nameJob;
          jobCenter.allitems = G.data.allitems;
          jobCenter.productsJob = G.data.itemsFromJob;
        }
        if (G.data.open == "buycash") {
          jobCenter.jobcash = G.data.job;
          jobCenter.idcash = G.data.idcash;
          jobCenter.jobName = G.data.nameJob;
          jobCenter.allitems = G.data.allitems;
          if (G.data.dataCash) {
            jobCenter.datacash.products = G.data.dataCash.products;
            jobCenter.datacash.money = G.data.dataCash.money;
          }
        }
      } else if (G.data.isVisible == false) {
        jobCenter.loading = true;
        document.body.style.display = G.data.isVisible ? "block" : "none";
      }
    });
  }
};
document.onkeydown = function (k) {
  if (k.which == 27) {
    jobCenter.close();
  }
};
