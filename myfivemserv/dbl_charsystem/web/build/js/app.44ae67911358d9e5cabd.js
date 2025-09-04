webpackJsonp(
  [1],
  {
    "4BKi": function (t, e) {},
    "7tvi": function (t, e) {},
    NHnr: function (t, e, a) {
      "use strict";
      Object.defineProperty(e, "__esModule", { value: !0 });
      var s = a("7+uW"),
        n = a("mvHQ"),
        o = a.n(n),
        i = {
          methods: {
            eventHandler: function (t) {
              var e = t.data;
              if ("open" == e.action)
                this.$store.commit("SetValue", { name: "visible", value: !0 }),
                  e.data.type &&
                    this.$store.commit("SetValue", {
                      name: "type",
                      value: e.data.type,
                    }),
                  this.$router.push({ name: e.type, params: e.data });
              else if ("setButtons" == e.action)
                this.$store.commit("SetValue", {
                  name: "buttons",
                  value: e.data,
                });
              else if ("setComponents" == e.action) {
                var a = e.data.config,
                  s = e.data.elements;
                for (var n in a)
                  for (var o = a[n], i = 0; i < o.length; i++)
                    for (var r = o[i], c = 0; c < r.components.length; c++) {
                      var l = r.components[c];
                      r.components[c] = s[l];
                    }
                this.$store.commit("SetValue", {
                  name: "components",
                  value: a,
                });
              } else
                "tattoos" == e.action
                  ? (this.$store.commit("SetValue", {
                      name: "visible",
                      value: !0,
                    }),
                    this.$store.commit("SetValue", {
                      name: "tattoosButtons",
                      value: e.data.buttons,
                    }),
                    this.$store.commit("SetValue", {
                      name: "tattoosComponents",
                      value: e.data.components,
                    }),
                    this.$router.push({ name: "tattoos" }))
                  : "refreshTattoos" == e.action &&
                    this.$store.commit("SetValue", {
                      name: "tattoosComponents",
                      value: e.data,
                    });
            },
          },
          created: function () {
            window.addEventListener("message", this.eventHandler),
            fetch("https://" + GetParentResourceName() + "/MulticharacterReady", {
              method: "POST",
              headers: {
                "Content-Type": "application/json; charset=UTF-8",
              },
              body: o()({}),
            }),
            setTimeout(() => {
              fetch("https://" + GetParentResourceName() + "/loaded", {
                method: "POST",
                headers: { "Content-Type": "application/json; charset=UTF-8" },
                body: o()({}),
              });
            }, 2500)
          },
        },
        r = {
          render: function () {
            var t = this.$createElement,
              e = this._self._c || t;
            return this.$store.state.config.visible
              ? e("div", { attrs: { id: "app" } }, [e("router-view")], 1)
              : this._e();
          },
          staticRenderFns: [],
        };
      var c = a("VU/8")(
          i,
          r,
          !1,
          function (t) {
            a("4BKi");
          },
          null,
          null
        ).exports,
        l = a("/ocq"),
        u = {
          data: function () {
            return { limit: 1, characters: [] };
          },
          methods: {
            select: function (t) {
              if (!(this.limit < t)) {
                if (!this.characters[String(t)])
                  return (
                    fetch("https://" + GetParentResourceName() + "/disablepeds"),
                    this.$store.commit("SetValue", {
                      name: "type",
                      value: "creator",
                    }),
                    this.$store.commit("SetValue", {
                      name: "canCancel",
                      value: !1,
                    }),
                    this.$store.commit("SetValue", {
                      name: "charId",
                      value: t,
                    }),
                    fetch("https://" + GetParentResourceName() + "/creator"),
                    void this.$router.push({ name: "creator/identity" })
                  );
                this.$store.commit("SetValue", { name: "visible", value: !1 }),
                  this.$store.commit("SetValue", {
                    name: "canCancel",
                    value: !0,
                  }),
                  fetch("https://" + GetParentResourceName() + "/disablepeds", {
                    method: "POST",
                    headers: {
                      "Content-Type": "application/json; charset=UTF-8",
                    },
                    body: o()({}),
                  }),
                  fetch("https://" + GetParentResourceName() + "/select", {
                    method: "POST",
                    headers: {
                      "Content-Type": "application/json; charset=UTF-8",
                    },
                    body: o()({ id: t }),
                  });
              }
            },
          },
          created: function () {
            (this.limit = this.$route.params.limit),
            (this.characters = this.$route.params.characters),
            (console.log(JSON.stringify(this.characters)))
          },
        },
        m = {
          render: function () {
            var t = this,
              e = t.$createElement,
              a = t._self._c || e;
            return a(
              "div",
              { staticClass: "content" },
              t._l(3, function (e) {
                return a(
                  "div",
                  {
                    staticClass: "character",
                    on: {
                      click: function (a) {
                        return t.select(e);
                      },
                    },
                  },
                  [
                    a(
                      "svg",
                      {
                        staticClass: "stroke",
                        staticStyle: { filter: "url(#shadowsvg-icon)" },
                        attrs: {
                          xmlns: "http://www.w3.org/2000/svg",
                          width: "64",
                          height: "64",
                          viewBox: "0 -14 512 512",
                        },
                      },
                      [
                        a(
                          "filter",
                          { attrs: { id: "shadowsvg-icon" } },
                          [
                            a("feDropShadow", {
                              attrs: {
                                dx: "0",
                                dy: "0",
                                stdDeviation: "5",
                                "flood-color": "#f58522d1",
                              },
                            }),
                          ],
                          1
                        ),
                        t._v(" "),
                        a("path", {
                          attrs: {
                            fill: "transparent",
                            stroke: "#f58522",
                            "stroke-width": "20",
                            "stroke-linecap": "round",
                            d: "M 254.5,24.5 C 258.201,25.1177 261.867,25.951 265.5,27C 321.671,58.92 378.005,90.5867 434.5,122C 440.82,124.986 444.987,129.819 447,136.5C 447.667,204.833 447.667,273.167 447,341.5C 443.833,348.667 438.667,353.833 431.5,357C 375.5,388.333 319.5,419.667 263.5,451C 258.167,453 252.833,453 247.5,451C 189.995,418.413 132.328,386.08 74.5,354C 69.5551,351.054 66.0551,346.888 64,341.5C 63.3333,273.167 63.3333,204.833 64,136.5C 64.92,133.062 66.5867,130.062 69,127.5C 125.923,94.6204 183.09,62.1204 240.5,30C 244.962,27.2551 249.628,25.4218 254.5,24.5 Z",
                          },
                        }),
                      ]
                    ),
                    t._v(" "),
                    a(
                      "svg",
                      {
                        staticClass: "background",
                        staticStyle: { filter: "url(#shadowsvg-icon)" },
                        attrs: {
                          xmlns: "http://www.w3.org/2000/svg",
                          width: "64",
                          height: "64",
                          viewBox: "0 -14 512 512",
                        },
                      },
                      [
                        a("path", {
                          attrs: {
                            fill: "#f58522",
                            d: "M 254.5,24.5 C 258.201,25.1177 261.867,25.951 265.5,27C 321.671,58.92 378.005,90.5867 434.5,122C 440.82,124.986 444.987,129.819 447,136.5C 447.667,204.833 447.667,273.167 447,341.5C 443.833,348.667 438.667,353.833 431.5,357C 375.5,388.333 319.5,419.667 263.5,451C 258.167,453 252.833,453 247.5,451C 189.995,418.413 132.328,386.08 74.5,354C 69.5551,351.054 66.0551,346.888 64,341.5C 63.3333,273.167 63.3333,204.833 64,136.5C 64.92,133.062 66.5867,130.062 69,127.5C 125.923,94.6204 183.09,62.1204 240.5,30C 244.962,27.2551 249.628,25.4218 254.5,24.5 Z",
                          },
                        }),
                      ]
                    ),
                    t._v(" "),
                    !t.characters[String(e)] && t.limit >= e
                      ? a("i", { staticClass: "fa-solid fa-plus" })
                      : t._e(),
                    t._v(" "),
                    t.characters[String(e)]
                      ? a("i", { staticClass: "fa-solid fa-user" })
                      : t._e(),
                    t._v(" "),
                    t.limit < e
                      ? a("i", { staticClass: "fa-solid fa-lock" })
                      : t._e(),
                    t._v(" "),
                    t.characters[String(e)]
                      ? a("div", { staticClass: "tooltip" }, [
                          a("div", { staticClass: "tooltip-title" }, [
                            t._v(
                              "\n                " +
                                t._s(t.characters[String(e)].firstname) +
                                " " +
                                t._s(t.characters[String(e)].lastname) +
                                "\n                "
                            ),
                            a("div", { staticClass: "tooltip-ssn" }, [
                              t._v("SSN: " + t._s(t.characters[String(e)].ssn)),
                            ]),
                          ]),
                          t._v(" "),
                          a("div", { staticClass: "tooltip-data" }, [
                            a("div", { staticClass: "tooltip-data-item" }, [
                              a("div", { staticClass: "data-item-title" }, [
                                t._v("Praca"),
                              ]),
                              t._v(" "),
                              a("div", { staticClass: "data-item-desc" }, [
                                t._v(t._s(t.characters[String(e)].job)),
                              ]),
                            ]),
                            t._v(" "),
                            a("div", { staticClass: "tooltip-data-item" }, [
                              a("div", { staticClass: "data-item-title" }, [
                                t._v("Gotówka"),
                              ]),
                              t._v(" "),
                              a("div", { staticClass: "data-item-desc" }, [
                                t._v("$" + t._s(t.characters[String(e)].money)),
                              ]),
                            ]),
                          ]),
                        ])
                      : t._e(),
                  ]
                );
              }),
              0
            );
          },
          staticRenderFns: [],
        };
      var d = a("VU/8")(
          u,
          m,
          !1,
          function (t) {
            a("7tvi");
          },
          "data-v-2b71deca",
          null
        ).exports,
        h = a("Xxa5"),
        v = a.n(h),
        p = a("exGp"),
        f = a.n(p),
        C = {
          data: function () {
            return { type: void 0, buttons: [] };
          },
          methods: {
            mousedown: function (t) {
              (this.pressed = !0),
                (this.lastX = t.offsetX),
                (this.lastY = t.offsetY);
            },
            mouseup: function (t) {
              this.move(t),
                (this.pressed = !1),
                (this.lastX = 0),
                (this.lastY = 0);
            },
            move: function (t) {
              if (this.pressed) {
                var e = this.lastX - t.offsetX;
                Math.abs(e) > 0 &&
                  fetch("https://" + GetParentResourceName() + "/camRotate", {
                    method: "POST",
                    headers: {
                      "Content-Type": "application/json; charset=UTF-8",
                    },
                    body: o()({ dist: e }),
                  }),
                  (e = this.lastY - t.offsetY),
                  Math.abs(e) > 0 &&
                    fetch("https://" + GetParentResourceName() + "/camHeight", {
                      method: "POST",
                      headers: {
                        "Content-Type": "application/json; charset=UTF-8",
                      },
                      body: o()({ dist: e }),
                    }),
                  (this.lastX = t.offsetX),
                  (this.lastY = t.offsetY);
              }
            },
            scroll: function (t) {
              var e = t.deltaY / 10;
              fetch("https://" + GetParentResourceName() + "/camZoom", {
                method: "POST",
                headers: { "Content-Type": "application/json; charset=UTF-8" },
                body: o()({ dist: e }),
              });
            },
            openApp: function (t) {
              (t.params && this.$route.params.name == t.params.name) ||
                this.$router.push(t);
            },
            toggle: function (t) {
              $(".component." + t).toggleClass("active");
            },
            save: function () {
              this.$store.state.config.save();
            },
            cancel: function () {
              this.$store.state.config.cancel();
            },
            componentAdd: function (t) {
              var e = this;
              return f()(
                v.a.mark(function a() {
                  var s;
                  return v.a.wrap(
                    function (a) {
                      for (;;)
                        switch ((a.prev = a.next)) {
                          case 0:
                            (s = $("#" + t + "-input").val()),
                              (s = Number(s)),
                              ++s > $("#" + t + "-input").attr("max") &&
                                (s = $("#" + t + "-input").attr("min")),
                              e.componentSet(t, s);
                          case 5:
                          case "end":
                            return a.stop();
                        }
                    },
                    a,
                    e
                  );
                })
              )();
            },
            componentRemove: function (t) {
              var e = this;
              return f()(
                v.a.mark(function a() {
                  var s;
                  return v.a.wrap(
                    function (a) {
                      for (;;)
                        switch ((a.prev = a.next)) {
                          case 0:
                            (s = $("#" + t + "-input").val()),
                              (s = Number(s)),
                              --s < $("#" + t + "-input").attr("min") &&
                                (s = $("#" + t + "-input").attr("max")),
                              e.componentSet(t, s);
                          case 5:
                          case "end":
                            return a.stop();
                        }
                    },
                    a,
                    e
                  );
                })
              )();
            },
            componentSet: function (t, e) {
              var a = this;
              return f()(
                v.a.mark(function s() {
                  var n, i, r;
                  return v.a.wrap(
                    function (s) {
                      for (;;)
                        switch ((s.prev = s.next)) {
                          case 0:
                            return (
                              (n = $("#" + t + "-input").val()),
                              void 0 !== e && (n = e),
                              $("#" + t + "-input").val(n),
                              $("#" + t + "-span").html(n),
                              a.$store.commit("SetComponentValue", {
                                component: a.$route.params.name,
                                name: t,
                                value: n,
                              }),
                              (s.next = 7),
                              fetch(
                                "https://" +
                                  GetParentResourceName() +
                                  "/change",
                                {
                                  method: "POST",
                                  headers: {
                                    "Content-Type":
                                      "application/json; charset=UTF-8",
                                  },
                                  body: o()({ name: t, value: n }),
                                }
                              )
                            );
                          case 7:
                            return (i = s.sent), (s.next = 10), i.json();
                          case 10:
                            (r = s.sent) &&
                              ($("#" + r.name + "-input").val(r.value),
                              $("#" + r.name + "-span").html(r.value),
                              a.$store.commit("SetComponentValue", {
                                component: a.$route.params.name,
                                name: r.name,
                                value: r.value,
                                max: r.max,
                              }));
                          case 12:
                          case "end":
                            return s.stop();
                        }
                    },
                    s,
                    a
                  );
                })
              )();
            },
          },
          mounted: function () {
            this.buttons =
              this.$store.state.config.buttons[this.$store.state.config.type];
          },
        },
        g = {
          render: function () {
            var t = this,
              e = t.$createElement,
              a = t._self._c || e;
            return a("div", { staticClass: "content" }, [
              a("div", { staticClass: "container" }, [
                a(
                  "div",
                  { staticClass: "header" },
                  t._l(t.buttons, function (e) {
                    return a(
                      "div",
                      {
                        class: [
                          "header-button",
                          t.$route.params.name == e.name && "active",
                        ],
                        on: {
                          click: function (a) {
                            "identity" == e.name
                              ? t.openApp({ name: "creator/identity" })
                              : t.openApp({
                                  name: "creator",
                                  params: { name: e.name },
                                });
                          },
                        },
                      },
                      [
                        a("div", { staticClass: "background" }),
                        t._v(" "),
                        a(
                          "svg",
                          {
                            staticClass: "stroke",
                            staticStyle: { filter: "url(#shadowsvg-icon)" },
                            attrs: {
                              xmlns: "http://www.w3.org/2000/svg",
                              width: "64",
                              height: "64",
                              viewBox: "0 -14 512 512",
                            },
                          },
                          [
                            a(
                              "filter",
                              { attrs: { id: "shadowsvg-icon" } },
                              [
                                a("feDropShadow", {
                                  attrs: {
                                    dx: "0",
                                    dy: "0",
                                    stdDeviation: "5",
                                    "flood-color": "#f58522d1",
                                  },
                                }),
                              ],
                              1
                            ),
                            t._v(" "),
                            a("path", {
                              attrs: {
                                fill: "transparent",
                                stroke: "#f58522",
                                "stroke-width": "20",
                                "stroke-linecap": "round",
                                d: "M 254.5,24.5 C 258.201,25.1177 261.867,25.951 265.5,27C 321.671,58.92 378.005,90.5867 434.5,122C 440.82,124.986 444.987,129.819 447,136.5C 447.667,204.833 447.667,273.167 447,341.5C 443.833,348.667 438.667,353.833 431.5,357C 375.5,388.333 319.5,419.667 263.5,451C 258.167,453 252.833,453 247.5,451C 189.995,418.413 132.328,386.08 74.5,354C 69.5551,351.054 66.0551,346.888 64,341.5C 63.3333,273.167 63.3333,204.833 64,136.5C 64.92,133.062 66.5867,130.062 69,127.5C 125.923,94.6204 183.09,62.1204 240.5,30C 244.962,27.2551 249.628,25.4218 254.5,24.5 Z",
                              },
                            }),
                          ]
                        ),
                        t._v(" "),
                        a("img", {
                          attrs: {
                            src: t.getURL("buttons/" + e.name + ".svg"),
                            alt: "",
                          },
                        }),
                        t._v(" "),
                        a("div", { staticClass: "header-button-label-box" }, [
                          a(
                            "svg",
                            {
                              staticClass: "header-button-label-box-bg",
                              attrs: {
                                xmlns: "http://www.w3.org/2000/svg",
                                viewBox: "-2 0 165 12",
                              },
                            },
                            [
                              a("path", {
                                staticClass: "header-button-label-box-shadow",
                                attrs: {
                                  fill: "transparent",
                                  stroke: "#f5852240",
                                  "stroke-width": "2",
                                  "stroke-linecap": "round",
                                  d: "M0,41L161,41L140.875,4.164C139.472,1.597 136.78,0 133.855,0L27.145,0C24.22,0 21.528,1.597 20.125,4.164L0,41Z",
                                },
                              }),
                            ]
                          ),
                          t._v(" "),
                          a(
                            "div",
                            { staticClass: "header-button-label-text" },
                            [
                              t._v(
                                "\n                        " +
                                  t._s(e.label) +
                                  "\n                    "
                              ),
                            ]
                          ),
                        ]),
                      ]
                    );
                  }),
                  0
                ),
                t._v(" "),
                a(
                  "div",
                  { staticClass: "components" },
                  t._l(
                    t.$store.state.config.components[t.$route.params.name],
                    function (e) {
                      return a("div", { class: ["component", e.name] }, [
                        a(
                          "div",
                          {
                            staticClass: "component-title",
                            on: {
                              click: function (a) {
                                return t.toggle(e.name);
                              },
                            },
                          },
                          [
                            a("img", {
                              attrs: {
                                src: t.getURL("components/" + e.name + ".svg"),
                              },
                            }),
                            t._v(
                              "\n                    " +
                                t._s(e.label) +
                                "\n                    "
                            ),
                            a("i", {
                              staticClass: "fa-solid fa-chevron-down arrowDown",
                            }),
                            t._v(" "),
                            a("i", {
                              staticClass: "fa-solid fa-chevron-up arrowUp",
                            }),
                          ]
                        ),
                        t._v(" "),
                        a(
                          "div",
                          { staticClass: "component-items" },
                          t._l(e.components, function (e) {
                            return a("div", { staticClass: "component-item" }, [
                              a(
                                "div",
                                { staticClass: "component-item-title" },
                                [
                                  t._v(
                                    "\n                            " +
                                      t._s(e.label) +
                                      "\n                        "
                                  ),
                                ]
                              ),
                              t._v(" "),
                              a("input", {
                                staticClass: "component-item-range",
                                attrs: {
                                  type: "range",
                                  id: e.name + "-input",
                                  min: e.min,
                                  max: e.max,
                                },
                                domProps: { value: e.value },
                                on: {
                                  input: function (a) {
                                    return t.componentSet(e.name);
                                  },
                                },
                              }),
                              t._v(" "),
                              a(
                                "div",
                                { staticClass: "component-item-number" },
                                [
                                  a(
                                    "svg",
                                    {
                                      staticClass: "component-item-number-bg",
                                      attrs: {
                                        xmlns: "http://www.w3.org/2000/svg",
                                        viewBox: "-2 0 165 12",
                                      },
                                    },
                                    [
                                      a("path", {
                                        staticClass:
                                          "component-item-number-shadow",
                                        attrs: {
                                          fill: "transparent",
                                          stroke: "#f5852240",
                                          "stroke-width": "2",
                                          "stroke-linecap": "round",
                                          d: "M0,41L161,41L140.875,4.164C139.472,1.597 136.78,0 133.855,0L27.145,0C24.22,0 21.528,1.597 20.125,4.164L0,41Z",
                                        },
                                      }),
                                    ]
                                  ),
                                  t._v(" "),
                                  a(
                                    "div",
                                    {
                                      staticClass: "component-item-number-text",
                                    },
                                    [
                                      a("i", {
                                        staticClass: "fa-solid fa-chevron-left",
                                        on: {
                                          click: function (a) {
                                            return t.componentRemove(e.name);
                                          },
                                        },
                                      }),
                                      t._v(" "),
                                      a("div", { staticClass: "numbers" }, [
                                        a(
                                          "span",
                                          { attrs: { id: e.name + "-span" } },
                                          [t._v(t._s(e.value))]
                                        ),
                                        t._v(" I "),
                                        a("span", [t._v(t._s(e.max))]),
                                      ]),
                                      t._v(" "),
                                      a("i", {
                                        staticClass:
                                          "fa-solid fa-chevron-right",
                                        on: {
                                          click: function (a) {
                                            return t.componentAdd(e.name);
                                          },
                                        },
                                      }),
                                    ]
                                  ),
                                ]
                              ),
                            ]);
                          }),
                          0
                        ),
                      ]);
                    }
                  ),
                  0
                ),
                t._v(" "),
                a("div", { staticClass: "footer" }, [
                  this.$store.state.config.canCancel
                    ? a(
                        "div",
                        {
                          staticClass: "footer-button",
                          on: {
                            click: function (e) {
                              return t.cancel();
                            },
                          },
                        },
                        [t._v("ANULUJ")]
                      )
                    : t._e(),
                  t._v(" "),
                  a(
                    "div",
                    {
                      staticClass: "footer-button",
                      on: {
                        click: function (e) {
                          return t.save();
                        },
                      },
                    },
                    [t._v("ZAPISZ")]
                  ),
                ]),
              ]),
              t._v(" "),
              a("div", {
                staticClass: "camContainer",
                on: {
                  mousedown: t.mousedown,
                  mouseup: t.mouseup,
                  mousemove: t.move,
                  wheel: t.scroll,
                },
              }),
            ]);
          },
          staticRenderFns: [],
        };
      var b = a("VU/8")(
          C,
          g,
          !1,
          function (t) {
            a("x95M");
          },
          "data-v-7eaa0768",
          null
        ).exports,
        w = {
          data: function () {
            return {
              type: void 0,
              buttons: [],
              nationalities: [
                "Afganistan",
                "Albania",
                "Algieria",
                "Andora",
                "Angola",
                "Antigua i Barbuda",
                "Argentyna",
                "Armenia",
                "Australia",
                "Austria",
                "Azerbejdżan",
                "Bahamy",
                "Bahrajn",
                "Bangladesz",
                "Barbados",
                "Białoruś",
                "Belgia",
                "Belize",
                "Benin",
                "Bhutan",
                "Boliwia",
                "Bośnia i Hercegowina",
                "Botswana",
                "Brazylia",
                "Brunei",
                "Bułgaria",
                "Burkina Faso",
                "Burundi",
                "Cabo Verde",
                "Kambodża",
                "Kamerun",
                "Kanada",
                "Republika Środkowoafrykańska",
                "Czad",
                "Chile",
                "Chiny",
                "Kolumbia",
                "Komory",
                "Kongo",
                "Kostaryka",
                "Wybrzeże Kości Słoniowej",
                "Chorwacja",
                "Kuba",
                "Cypr",
                "Czechy",
                "Dania",
                "Dżibuti",
                "Dominika",
                "Republika Dominikańska",
                "Ekwador",
                "Egipt",
                "Salwador",
                "Gwinea Równikowa",
                "Erytrea",
                "Estonia",
                "Eswatini",
                "Etiopia",
                "Fidżi",
                "Finlandia",
                "Francja",
                "Gabon",
                "Gambia",
                "Gruzja",
                "Niemcy",
                "Ghana",
                "Grecja",
                "Grenada",
                "Gwatemala",
                "Gwinea",
                "Gwinea-Bissau",
                "Gujana",
                "Haiti",
                "Honduras",
                "Węgry",
                "Islandia",
                "Indie",
                "Indonezja",
                "Iran",
                "Irak",
                "Irlandia",
                "Izrael",
                "Włochy",
                "Jamajka",
                "Japonia",
                "Jordania",
                "Kazachstan",
                "Kenia",
                "Kiribati",
                "Korea Północna",
                "Korea Południowa",
                "Kosowo",
                "Kuwejt",
                "Kirgistan",
                "Laos",
                "Łotwa",
                "Liban",
                "Lesotho",
                "Liberia",
                "Libia",
                "Liechtenstein",
                "Litwa",
                "Luksemburg",
                "Madagaskar",
                "Malawi",
                "Malezja",
                "Malediwy",
                "Mali",
                "Malta",
                "Wyspy Marshalla",
                "Mauretania",
                "Mauritius",
                "Meksyk",
                "Mikronezja",
                "Mołdawia",
                "Monako",
                "Mongolia",
                "Czarnogóra",
                "Maroko",
                "Mozambik",
                "Myanmar",
                "Namibia",
                "Nauru",
                "Nepal",
                "Holandia",
                "Nowa Zelandia",
                "Nikaragua",
                "Macedonia Północna",
                "Norwegia",
                "Oman",
                "Pakistan",
                "Palau",
                "Panama",
                "Papua-Nowa Gwinea",
                "Paragwaj",
                "Peru",
                "Filipiny",
                "Polska",
                "Portugalia",
                "Katar",
                "Rumunia",
                "Rosja",
                "Rwanda",
                "Saint Kitts i Nevis",
                "Saint Lucia",
                "Saint Vincent i Grenadyny",
                "Samoa",
                "San Marino",
                "Wyspy Świętego Tomasza i Książęca",
                "Arabia Saudyjska",
                "Senegal",
                "Serbia",
                "Seszele",
                "Sierra Leone",
                "Singapur",
                "Słowacja",
                "Słowenia",
                "Wyspy Salomona",
                "Somalia",
                "Południowa Afryka",
                "Sudan",
                "Surinam",
                "Szwecja",
                "Szwajcaria",
                "Syria",
                "Tajwan",
                "Tadżykistan",
                "Tanzania",
                "Tajlandia",
                "Timor Wschodni",
                "Togo",
                "Tonga",
                "Trynidad i Tobago",
                "Tunezja",
                "Turcja",
                "Turkmenistan",
                "Tuvalu",
                "Uganda",
                "Ukraina",
                "Zjednoczone Emiraty Arabskie",
                "Wielka Brytania",
                "Stany Zjednoczone",
                "Urugwaj",
                "Uzbekistan",
                "Vanuatu",
                "Watykan",
                "Wenezuela",
                "Wietnam",
                "Jemen",
                "Zambia",
                "Zimbabwe",
              ],
              toggled: !1,
            };
          },
          methods: {
            mousedown: function (t) {
              (this.pressed = !0),
                (this.lastX = t.offsetX),
                (this.lastY = t.offsetY);
            },
            mouseup: function (t) {
              this.move(t),
                (this.pressed = !1),
                (this.lastX = 0),
                (this.lastY = 0);
            },
            move: function (t) {
              if (this.pressed) {
                var e = this.lastX - t.offsetX;
                Math.abs(e) > 0 &&
                  fetch("https://" + GetParentResourceName() + "/camRotate", {
                    method: "POST",
                    headers: {
                      "Content-Type": "application/json; charset=UTF-8",
                    },
                    body: o()({ dist: e }),
                  }),
                  (e = this.lastY - t.offsetY),
                  Math.abs(e) > 0 &&
                    fetch("https://" + GetParentResourceName() + "/camHeight", {
                      method: "POST",
                      headers: {
                        "Content-Type": "application/json; charset=UTF-8",
                      },
                      body: o()({ dist: e }),
                    }),
                  (this.lastX = t.offsetX),
                  (this.lastY = t.offsetY);
              }
            },
            scroll: function (t) {
              var e = t.deltaY / 10;
              fetch("https://" + GetParentResourceName() + "/camZoom", {
                method: "POST",
                headers: { "Content-Type": "application/json; charset=UTF-8" },
                body: o()({ dist: e }),
              });
            },
            openApp: function (t) {
              this.$router.push(t);
            },
            onInput: function (t) {
              var e = $("#" + t).val();
              e.length > 16 && (e = e.slice(0, 16)),
                (e = e[0].toUpperCase() + e.slice(1)),
                this.$store.commit("SetValue", { name: t, value: e });
            },
            onSex: function (t) {
              fetch("https://" + GetParentResourceName() + "/change", {
                method: "POST",
                headers: { "Content-Type": "application/json; charset=UTF-8" },
                body: o()({ name: "sex", value: t }),
              });
            },
            onDate: function () {
              this.$store.commit("SetValue", {
                name: "dateofbirth",
                value: $("#dateofbirth").val(),
              });
            },
            heightSet: function () {
              this.$store.commit("SetValue", {
                name: "height",
                value: $("#height").val(),
              });
            },
            heightUp: function () {
              var t = this.$store.state.config.height;
              t >= 220 && (t = 139),
                this.$store.commit("SetValue", {
                  name: "height",
                  value: t + 1,
                });
            },
            heightDown: function () {
              var t = this.$store.state.config.height;
              t <= 140 && (t = 221),
                this.$store.commit("SetValue", {
                  name: "height",
                  value: t - 1,
                });
            },
            save: function () {
              this.$store.state.config.save();
            },
          },
          mounted: function () {
            (this.buttons =
              this.$store.state.config.buttons[this.$store.state.config.type]),
              (this.nationalities = this.nationalities.sort()),
              this.$store.commit("SetValue", {
                name: "nationality",
                value: this.nationalities[0],
              }),
              this.$store.commit("SetValue", {
                name: "id",
                value: this.$route.params.id,
              });
          },
        },
        _ = {
          render: function () {
            var t = this,
              e = t.$createElement,
              a = t._self._c || e;
            return a("div", { staticClass: "content" }, [
              a("div", { staticClass: "container" }, [
                a(
                  "div",
                  { staticClass: "header" },
                  t._l(t.buttons, function (e) {
                    return a(
                      "div",
                      {
                        class: ["header-button", e.isActive && "active"],
                        on: {
                          click: function (a) {
                            "identity" == e.name
                              ? t.openApp({ name: "creator/identity" })
                              : t.openApp({
                                  name: "creator",
                                  params: { name: e.name },
                                });
                          },
                        },
                      },
                      [
                        a("div", { staticClass: "background" }),
                        t._v(" "),
                        a(
                          "svg",
                          {
                            staticClass: "stroke",
                            staticStyle: { filter: "url(#shadowsvg-icon)" },
                            attrs: {
                              xmlns: "http://www.w3.org/2000/svg",
                              width: "64",
                              height: "64",
                              viewBox: "0 -14 512 512",
                            },
                          },
                          [
                            a(
                              "filter",
                              { attrs: { id: "shadowsvg-icon" } },
                              [
                                a("feDropShadow", {
                                  attrs: {
                                    dx: "0",
                                    dy: "0",
                                    stdDeviation: "5",
                                    "flood-color": "#f58522d1",
                                  },
                                }),
                              ],
                              1
                            ),
                            t._v(" "),
                            a("path", {
                              attrs: {
                                fill: "transparent",
                                stroke: "#f58522",
                                "stroke-width": "20",
                                "stroke-linecap": "round",
                                d: "M 254.5,24.5 C 258.201,25.1177 261.867,25.951 265.5,27C 321.671,58.92 378.005,90.5867 434.5,122C 440.82,124.986 444.987,129.819 447,136.5C 447.667,204.833 447.667,273.167 447,341.5C 443.833,348.667 438.667,353.833 431.5,357C 375.5,388.333 319.5,419.667 263.5,451C 258.167,453 252.833,453 247.5,451C 189.995,418.413 132.328,386.08 74.5,354C 69.5551,351.054 66.0551,346.888 64,341.5C 63.3333,273.167 63.3333,204.833 64,136.5C 64.92,133.062 66.5867,130.062 69,127.5C 125.923,94.6204 183.09,62.1204 240.5,30C 244.962,27.2551 249.628,25.4218 254.5,24.5 Z",
                              },
                            }),
                          ]
                        ),
                        t._v(" "),
                        a("img", {
                          attrs: {
                            src: t.getURL("buttons/" + e.name + ".svg"),
                            alt: "",
                          },
                        }),
                        t._v(" "),
                        a("div", { staticClass: "header-button-label-box" }, [
                          a(
                            "svg",
                            {
                              staticClass: "header-button-label-box-bg",
                              attrs: {
                                xmlns: "http://www.w3.org/2000/svg",
                                viewBox: "-2 0 165 12",
                              },
                            },
                            [
                              a("path", {
                                staticClass: "header-button-label-box-shadow",
                                attrs: {
                                  fill: "transparent",
                                  stroke: "#f5852240",
                                  "stroke-width": "2",
                                  "stroke-linecap": "round",
                                  d: "M0,41L161,41L140.875,4.164C139.472,1.597 136.78,0 133.855,0L27.145,0C24.22,0 21.528,1.597 20.125,4.164L0,41Z",
                                },
                              }),
                            ]
                          ),
                          t._v(" "),
                          a(
                            "div",
                            { staticClass: "header-button-label-text" },
                            [
                              t._v(
                                "\n                        " +
                                  t._s(e.label) +
                                  "\n                    "
                              ),
                            ]
                          ),
                        ]),
                      ]
                    );
                  }),
                  0
                ),
                t._v(" "),
                a("div", { staticClass: "components" }, [
                  a("div", { staticClass: "component" }, [
                    a("div", { staticClass: "component-title" }, [
                      t._v("\n                    Imię\n                "),
                    ]),
                    t._v(" "),
                    a("input", {
                      staticClass: "component-input",
                      attrs: {
                        type: "text",
                        placeholder: "John",
                        id: "firstname",
                      },
                      domProps: { value: t.$store.state.config.firstname },
                      on: {
                        input: function (e) {
                          return t.onInput("firstname");
                        },
                      },
                    }),
                  ]),
                  t._v(" "),
                  a("div", { staticClass: "component" }, [
                    a("div", { staticClass: "component-title" }, [
                      t._v("\n                    Nazwisko\n                "),
                    ]),
                    t._v(" "),
                    a("input", {
                      staticClass: "component-input",
                      attrs: {
                        type: "text",
                        placeholder: "Doe",
                        id: "lastname",
                      },
                      domProps: { value: t.$store.state.config.lastname },
                      on: {
                        input: function (e) {
                          return t.onInput("lastname");
                        },
                      },
                    }),
                  ]),
                  t._v(" "),
                  a("div", { staticClass: "component" }, [
                    a("div", { staticClass: "component-title" }, [
                      t._v(
                        "\n                    Data urodzenia\n                "
                      ),
                    ]),
                    t._v(" "),
                    a("input", {
                      staticClass: "component-input",
                      attrs: { type: "date", id: "dateofbirth" },
                      domProps: { value: t.$store.state.config.dateofbirth },
                      on: {
                        input: function (e) {
                          return t.onDate();
                        },
                      },
                    }),
                  ]),
                  t._v(" "),
                  a("div", { staticClass: "component" }, [
                    a("div", { staticClass: "component-title" }, [
                      t._v("\n                    Wzrost\n                "),
                    ]),
                    t._v(" "),
                    a("div", { staticClass: "component-input height" }, [
                      a("input", {
                        attrs: {
                          type: "range",
                          min: "140",
                          max: "220",
                          id: "height",
                        },
                        domProps: { value: t.$store.state.config.height },
                        on: {
                          input: function (e) {
                            return t.heightSet();
                          },
                        },
                      }),
                      t._v(" "),
                      a("div", { staticClass: "component-item-number" }, [
                        a(
                          "svg",
                          {
                            staticClass: "component-item-number-bg",
                            attrs: {
                              xmlns: "http://www.w3.org/2000/svg",
                              viewBox: "-2 0 165 12",
                            },
                          },
                          [
                            a("path", {
                              staticClass: "component-item-number-shadow",
                              attrs: {
                                fill: "transparent",
                                stroke: "#f5852240",
                                "stroke-width": "2",
                                "stroke-linecap": "round",
                                d: "M0,41L161,41L140.875,4.164C139.472,1.597 136.78,0 133.855,0L27.145,0C24.22,0 21.528,1.597 20.125,4.164L0,41Z",
                              },
                            }),
                          ]
                        ),
                        t._v(" "),
                        a(
                          "div",
                          { staticClass: "component-item-number-text" },
                          [
                            a("i", {
                              staticClass: "fa-solid fa-chevron-left",
                              on: {
                                click: function (e) {
                                  return t.heightDown();
                                },
                              },
                            }),
                            t._v(" "),
                            a(
                              "div",
                              {
                                staticClass: "numbers",
                                attrs: { contenteditable: "" },
                              },
                              [
                                t._v(
                                  "\n                                " +
                                    t._s(this.$store.state.config.height) +
                                    "\n                            "
                                ),
                              ]
                            ),
                            t._v(" "),
                            a("i", {
                              staticClass: "fa-solid fa-chevron-right",
                              on: {
                                click: function (e) {
                                  return t.heightUp();
                                },
                              },
                            }),
                          ]
                        ),
                      ]),
                    ]),
                  ]),
                  t._v(" "),
                  a("div", { staticClass: "component" }, [
                    a("div", { staticClass: "component-title" }, [
                      t._v("\n                    Płeć\n                "),
                    ]),
                    t._v(" "),
                    a("div", { staticClass: "component-input" }, [
                      a(
                        "div",
                        {
                          class: [
                            "component-button",
                            "m" == this.$store.state.config.gender && "active",
                          ],
                          on: {
                            click: function (e) {
                              t.$store.commit("SetValue", {
                                name: "gender",
                                value: "m",
                              }),
                                t.onSex(0);
                            },
                          },
                        },
                        [
                          t._v("Mężczyzna "),
                          a("i", { staticClass: "fa-solid fa-mars" }),
                        ]
                      ),
                      t._v(" "),
                      a(
                        "div",
                        {
                          class: [
                            "component-button",
                            "f" == this.$store.state.config.gender && "active",
                          ],
                          on: {
                            click: function (e) {
                              t.$store.commit("SetValue", {
                                name: "gender",
                                value: "f",
                              }),
                                t.onSex(1);
                            },
                          },
                        },
                        [
                          t._v("Kobieta "),
                          a("i", { staticClass: "fa-solid fa-venus" }),
                        ]
                      ),
                    ]),
                  ]),
                  t._v(" "),
                  a("div", { staticClass: "component" }, [
                    a("div", { staticClass: "component-title" }, [
                      t._v(
                        "\n                    Narodowość\n                "
                      ),
                    ]),
                    t._v(" "),
                    a("div", { class: ["selector", t.toggled && "active"] }, [
                      a(
                        "div",
                        {
                          staticClass: "selector-title",
                          on: {
                            click: function (e) {
                              t.toggled = !t.toggled;
                            },
                          },
                        },
                        [
                          t._v(
                            "\n                        " +
                              t._s(this.$store.state.config.nationality) +
                              " "
                          ),
                          a("i", { staticClass: "fa-solid fa-chevron-down" }),
                        ]
                      ),
                      t._v(" "),
                      a(
                        "div",
                        { staticClass: "selector-options" },
                        t._l(t.nationalities, function (e) {
                          return a(
                            "div",
                            {
                              staticClass: "selector-option",
                              on: {
                                click: function (a) {
                                  t.$store.commit("SetValue", {
                                    name: "nationality",
                                    value: e,
                                  }),
                                    (t.toggled = !1);
                                },
                              },
                            },
                            [t._v(t._s(e))]
                          );
                        }),
                        0
                      ),
                    ]),
                  ]),
                ]),
                t._v(" "),
                a("div", { staticClass: "footer" }, [
                  a(
                    "div",
                    {
                      staticClass: "footer-button",
                      on: {
                        click: function (e) {
                          return t.save();
                        },
                      },
                    },
                    [t._v("ZAPISZ")]
                  ),
                ]),
              ]),
              t._v(" "),
              a("div", {
                staticClass: "camContainer",
                on: {
                  mousedown: t.mousedown,
                  mouseup: t.mouseup,
                  mousemove: t.move,
                  wheel: t.scroll,
                },
              }),
            ]);
          },
          staticRenderFns: [],
        };
      var y = a("VU/8")(
          w,
          _,
          !1,
          function (t) {
            a("ez2n");
          },
          "data-v-43486ae2",
          null
        ).exports,
        k = {
          methods: {
            mousedown: function (t) {
              (this.pressed = !0),
                (this.lastX = t.offsetX),
                (this.lastY = t.offsetY);
            },
            mouseup: function (t) {
              this.move(t),
                (this.pressed = !1),
                (this.lastX = 0),
                (this.lastY = 0);
            },
            move: function (t) {
              if (this.pressed) {
                var e = this.lastX - t.offsetX;
                Math.abs(e) > 0 &&
                  fetch("https://" + GetParentResourceName() + "/camRotate", {
                    method: "POST",
                    headers: {
                      "Content-Type": "application/json; charset=UTF-8",
                    },
                    body: o()({ dist: e }),
                  }),
                  (e = this.lastY - t.offsetY),
                  Math.abs(e) > 0 &&
                    fetch("https://" + GetParentResourceName() + "/camHeight", {
                      method: "POST",
                      headers: {
                        "Content-Type": "application/json; charset=UTF-8",
                      },
                      body: o()({ dist: e }),
                    }),
                  (this.lastX = t.offsetX),
                  (this.lastY = t.offsetY);
              }
            },
            scroll: function (t) {
              var e = t.deltaY / 10;
              fetch("https://" + GetParentResourceName() + "/camZoom", {
                method: "POST",
                headers: { "Content-Type": "application/json; charset=UTF-8" },
                body: o()({ dist: e }),
              });
            },
            check: function (t) {
              fetch("https://" + GetParentResourceName() + "/tattoosCheck", {
                method: "POST",
                headers: { "Content-Type": "application/json; charset=UTF-8" },
                body: o()(t),
              });
            },
            apply: function (t, e) {
              fetch("https://" + GetParentResourceName() + "/tattoosApply", {
                method: "POST",
                headers: { "Content-Type": "application/json; charset=UTF-8" },
                body: o()({ tattoo: t, type: e }),
              });
            },
            toggle: function (t) {
              $(".component." + t).toggleClass("active");
            },
            save: function () {
              this.$store.state.config.tattooSave();
            },
          },
        },
        S = {
          render: function () {
            var t = this,
              e = t.$createElement,
              a = t._self._c || e;
            return a("div", { staticClass: "content" }, [
              a("div", { staticClass: "container" }, [
                a("div", { staticClass: "header" }, [
                  a("div", { staticClass: "header-button active" }, [
                    a("div", { staticClass: "background" }),
                    t._v(" "),
                    a(
                      "svg",
                      {
                        staticClass: "stroke",
                        staticStyle: { filter: "url(#shadowsvg-icon)" },
                        attrs: {
                          xmlns: "http://www.w3.org/2000/svg",
                          width: "64",
                          height: "64",
                          viewBox: "0 -14 512 512",
                        },
                      },
                      [
                        a(
                          "filter",
                          { attrs: { id: "shadowsvg-icon" } },
                          [
                            a("feDropShadow", {
                              attrs: {
                                dx: "0",
                                dy: "0",
                                stdDeviation: "5",
                                "flood-color": "#f58522d1",
                              },
                            }),
                          ],
                          1
                        ),
                        t._v(" "),
                        a("path", {
                          attrs: {
                            fill: "transparent",
                            stroke: "#f58522",
                            "stroke-width": "20",
                            "stroke-linecap": "round",
                            d: "M 254.5,24.5 C 258.201,25.1177 261.867,25.951 265.5,27C 321.671,58.92 378.005,90.5867 434.5,122C 440.82,124.986 444.987,129.819 447,136.5C 447.667,204.833 447.667,273.167 447,341.5C 443.833,348.667 438.667,353.833 431.5,357C 375.5,388.333 319.5,419.667 263.5,451C 258.167,453 252.833,453 247.5,451C 189.995,418.413 132.328,386.08 74.5,354C 69.5551,351.054 66.0551,346.888 64,341.5C 63.3333,273.167 63.3333,204.833 64,136.5C 64.92,133.062 66.5867,130.062 69,127.5C 125.923,94.6204 183.09,62.1204 240.5,30C 244.962,27.2551 249.628,25.4218 254.5,24.5 Z",
                          },
                        }),
                      ]
                    ),
                    t._v(" "),
                    a("img", {
                      attrs: { src: t.getURL("buttons/accessories.svg") },
                    }),
                    t._v(" "),
                    a("div", { staticClass: "header-button-label-box" }, [
                      a(
                        "svg",
                        {
                          staticClass: "header-button-label-box-bg",
                          attrs: {
                            xmlns: "http://www.w3.org/2000/svg",
                            viewBox: "-2 0 165 12",
                          },
                        },
                        [
                          a("path", {
                            staticClass: "header-button-label-box-shadow",
                            attrs: {
                              fill: "transparent",
                              stroke: "#f5852240",
                              "stroke-width": "2",
                              "stroke-linecap": "round",
                              d: "M0,41L161,41L140.875,4.164C139.472,1.597 136.78,0 133.855,0L27.145,0C24.22,0 21.528,1.597 20.125,4.164L0,41Z",
                            },
                          }),
                        ]
                      ),
                      t._v(" "),
                      a("div", { staticClass: "header-button-label-text" }, [
                        t._v(
                          "\n                        Tatuaże\n                    "
                        ),
                      ]),
                    ]),
                  ]),
                ]),
                t._v(" "),
                a(
                  "div",
                  { staticClass: "components" },
                  t._l(t.$store.state.config.tattoosButtons, function (e) {
                    return a("div", { class: "component " + e.name }, [
                      a(
                        "div",
                        {
                          staticClass: "component-title",
                          on: {
                            click: function (a) {
                              return t.toggle(e.name);
                            },
                          },
                        },
                        [
                          a("img", {
                            attrs: {
                              src: t.getURL("buttons/" + e.name + ".svg"),
                            },
                          }),
                          t._v(
                            "\n                    " +
                              t._s(e.label) +
                              "\n                    "
                          ),
                          a("i", {
                            staticClass: "fa-solid fa-chevron-down arrowDown",
                          }),
                          t._v(" "),
                          a("i", {
                            staticClass: "fa-solid fa-chevron-up arrowUp",
                          }),
                        ]
                      ),
                      t._v(" "),
                      a(
                        "div",
                        { staticClass: "component-items" },
                        t._l(
                          t.$store.state.config.tattoosComponents,
                          function (s) {
                            return s.category == e.name
                              ? a("div", { staticClass: "component-item" }, [
                                  a(
                                    "div",
                                    { staticClass: "component-item-title" },
                                    [
                                      t._v(
                                        "\n                            " +
                                          t._s(s.label) +
                                          "\n                        "
                                      ),
                                    ]
                                  ),
                                  t._v(" "),
                                  a(
                                    "div",
                                    { staticClass: "component-item-buttons" },
                                    [
                                      a(
                                        "div",
                                        {
                                          staticClass: "component-item-button",
                                          on: {
                                            click: function (e) {
                                              return t.check(s);
                                            },
                                          },
                                        },
                                        [t._v("SPRAWDŹ")]
                                      ),
                                      t._v(" "),
                                      s.has
                                        ? t._e()
                                        : a(
                                            "div",
                                            {
                                              staticClass:
                                                "component-item-button",
                                              on: {
                                                click: function (e) {
                                                  return t.apply(s, "buy");
                                                },
                                              },
                                            },
                                            [
                                              t._v("KUP "),
                                              a("span", [
                                                t._v(
                                                  "($" + t._s(s.price) + ")"
                                                ),
                                              ]),
                                            ]
                                          ),
                                      t._v(" "),
                                      s.has
                                        ? a(
                                            "div",
                                            {
                                              staticClass:
                                                "component-item-button",
                                              on: {
                                                click: function (e) {
                                                  return t.apply(s, "remove");
                                                },
                                              },
                                            },
                                            [
                                              t._v("USUŃ "),
                                              a("span", [
                                                t._v(
                                                  "($" +
                                                    t._s(s.removePrice) +
                                                    ")"
                                                ),
                                              ]),
                                            ]
                                          )
                                        : t._e(),
                                    ]
                                  ),
                                ])
                              : t._e();
                          }
                        ),
                        0
                      ),
                    ]);
                  }),
                  0
                ),
                t._v(" "),
                a("div", { staticClass: "footer" }, [
                  a(
                    "div",
                    {
                      staticClass: "footer-button",
                      on: {
                        click: function (e) {
                          return t.save();
                        },
                      },
                    },
                    [t._v("ZAPISZ")]
                  ),
                ]),
              ]),
              t._v(" "),
              a("div", {
                staticClass: "camContainer",
                on: {
                  mousedown: t.mousedown,
                  mouseup: t.mouseup,
                  mousemove: t.move,
                  wheel: t.scroll,
                },
              }),
            ]);
          },
          staticRenderFns: [],
        };
      var x = a("VU/8")(
        k,
        S,
        !1,
        function (t) {
          a("WBDC");
        },
        "data-v-74770aff",
        null
      ).exports;
      s.a.use(l.a);
      var T = new l.a({
          routes: [
            { path: "/selector", name: "selector", component: d },
            { path: "/creator/:name", name: "creator", component: b },
            {
              path: "/creator/identity",
              name: "creator/identity",
              component: y,
            },
            { path: "/tattoos", name: "tattoos", component: x },
          ],
        }),
        P = a("NYxO"),
        j =
          (a("bOdI"),
          {
            id: 1,
            firstname: "",
            lastname: "",
            dateofbirth: "2000-01-01",
            height: 180,
            gender: null,
            nationality: null,
            visible: !1,
            type: null,
            canCancel: !0,
            charId: 0,
            buttons: [],
            components: [],
            tattoosButtons: [],
            tattoosComponents: [],
            save: function () {
              if (j.type && "creator" == j.type) {
                var t = j.firstname;
                if (t && (t.length < 3 || t.length > 20)) return;
                var e = j.lastname;
                if (e && (e.length < 3 || e.length > 20)) return;
                if (!j.gender) return;
                if (!j.nationality) return;
                (j.visible = !1),
                  (j.canCancel = !0),
                  fetch("https://" + GetParentResourceName() + "/create", {
                    method: "POST",
                    headers: {
                      "Content-Type": "application/json; charset=UTF-8",
                    },
                    body: o()({
                      id: j.charId,
                      firstname: t,
                      lastname: e,
                      dateofbirth: j.dateofbirth,
                      height: j.height,
                      gender: j.gender,
                      nationality: j.nationality,
                    }),
                  });
            } else
                (j.visible = !1),
                  (j.canCancel = !0),
                  fetch("https://" + GetParentResourceName() + "/save");
            },
            cancel: function () {
              (j.visible = !1),
                (j.canCancel = !0),
                fetch("https://" + GetParentResourceName() + "/cancel");
            },
            tattooSave: function () {
              (j.visible = !1),
                (j.canCancel = !0),
                fetch("https://" + GetParentResourceName() + "/tattooSave");
            },
          }),
        R = {
          state: j,
          getters: {},
          actions: {},
          mutations: {
            SetValue: function (t, e) {
              t[e.name] = e.value;
            },
            SetComponentValue: function (t, e) {
              t.components[e.component].forEach(function (t) {
                for (var a = 0; a < t.components.length; a++) {
                  var s = t.components[a];
                  s.name == e.name &&
                    ((s.value = e.value), e.max && (s.max = e.max));
                }
              });
            },
          },
        };
      s.a.use(P.a);
      var U = new P.a.Store({ modules: { config: R }, strict: !0 });
      (s.a.config.productionTip = !1),
        (s.a.prototype.openAnim = !1),
        (s.a.prototype.getURL = function (t) {
          return "nui://" + GetParentResourceName() + "/web/images/" + t;
        }),
        new s.a({
          el: "#app",
          store: U,
          router: T,
          render: function (t) {
            return t(c);
          },
        });
    },
    WBDC: function (t, e) {},
    ez2n: function (t, e) {},
    x95M: function (t, e) {},
  },
  ["NHnr"]
);
