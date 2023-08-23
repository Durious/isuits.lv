import{p as y}from"./pickBy.bd80f484.js";import{L as w}from"./Layout.c268843b.js";import{t as g}from"./throttle.7e7db953.js";import{S as v,m as $}from"./SearchFilter.6af03689.js";import{P as V}from"./Pagination.cc1280e3.js";import{_ as T,r as i,o as a,c as m,a as e,t as o,b as n,w as f,F as C,g as N,e as p,f as j,d as r}from"./app.d8289e67.js";import"./debounce.9b400763.js";import"./Dropdown.48a14283.js";import"./FlashMessages.3029884e.js";const B={layout:w,metaInfo:{title:"Taxes"},components:{Pagination:V,SearchFilter:v},props:{taxes:Object,filters:Object},metaInfo(){return{title:this.$tc("Tax",2)}},data(){return{form:{search:this.filters.search,trashed:this.filters.trashed}}},watch:{form:{handler:g(function(){let t=y(this.form);this.$inertia.replace(this.route("taxes",Object.keys(t).length?t:{remember:"forget"}))},250),deep:!0}},methods:{rowClicked(t){this.$inertia.visit(this.route("taxes.edit",t))},reset(){this.form=$(this.form,()=>null)}}},I={class:"mb-6 mt-2 font-bold text-lg md:text-2xl"},L={class:"np mb-6 flex justify-between items-center"},S={class:"block text-gray-700"},O={class:"inline md:hidden"},F={class:"hidden md:inline"},R={class:"bg-white rounded shadow overflow-x-auto scroll-on-light"},D={class:"w-full whitespace-no-wrap"},P={class:"text-left font-bold"},U={class:"px-6 pt-6 pb-4"},q={class:"px-6 pt-6 pb-4"},E={class:"px-6 pt-6 pb-4"},W={class:"px-6 pt-6 pb-4 text-center"},z={class:"px-6 pt-6 pb-4 text-center"},A={class:"px-6 pt-6 pb-4 text-center"},G={class:"px-6 pt-6 pb-4",colspan:"2"},H=["onClick"],J={class:"border-t px-6 py-4"},K={class:"flex items-center"},M={class:"border-t px-6 py-4"},Q={class:"border-t px-6 py-4"},X={class:"flex items-center justify-end"},Y={class:"text-right"},Z={class:"border-t px-6 py-4"},ee={class:"border-t px-6 py-4"},te={class:"border-t px-6 py-4"},se={class:"border-t px-6 py-4 max-w-lg truncate"},oe={class:"border-t px-6 py-4 w-8"},ae={key:0},le={class:"border-t px-6 py-4",colspan:"8"};function re(t,c,d,ne,h,_){const u=i("v-select"),x=i("search-filter"),l=i("Icons"),b=i("Link"),k=i("pagination");return a(),m("div",null,[e("h1",I,o(t.$tc("Tax",2)),1),e("div",L,[n(x,{modelValue:h.form.search,"onUpdate:modelValue":c[1]||(c[1]=s=>h.form.search=s),class:"w-full max-w-md ltr:mr-4 rtl:ml-4",onReset:_.reset},{default:f(()=>[e("label",S,o(t.$t("Trashed")),1),n(u,{modelValue:h.form.trashed,"onUpdate:modelValue":c[0]||(c[0]=s=>h.form.trashed=s),options:[{value:"",label:"Not Trashed"},{value:"with",label:t.$t("With Trashed")},{value:"only",label:t.$t("Only Trashed")}],reduce:s=>s.value},null,8,["modelValue","options","reduce"])]),_:1},8,["modelValue","onReset"]),n(b,{class:"btn-gray",href:t.route("taxes.create")},{default:f(()=>[e("span",O,[n(l,{name:"add",class:"w-4 h-4 text-white fill-white group-hover:text-white fill-white"})]),e("span",F,o(t.$t("create_x",{x:t.$tc("Tax")})),1)]),_:1},8,["href"])]),e("div",R,[e("table",D,[e("thead",null,[e("tr",P,[e("th",U,o(t.$t("Code")),1),e("th",q,o(t.$t("Name")),1),e("th",E,o(t.$t("Rate")),1),e("th",W,o(t.$t("State")),1),e("th",z,o(t.$t("Same")),1),e("th",A,o(t.$t("Compound")),1),e("th",G,o(t.$t("Description")),1)])]),e("tbody",null,[(a(!0),m(C,null,N(d.taxes.data,s=>(a(),m("tr",{key:s.id,onClick:ie=>_.rowClicked(s.id),class:"cursor-pointer hover:bg-teal-200 focus-within:bg-teal-200"},[e("td",J,[e("div",K,[j(o(s.code)+" ",1),s.deleted_at?(a(),r(l,{key:0,name:"trash",class:"flex-shrink-0 w-3 h-3 fill-gray-400 ml-2"})):p("",!0)])]),e("td",M,o(s.name),1),e("td",Q,[e("div",X,[s.active?(a(),r(l,{key:0,name:"check",class:"flex-shrink-0 w-3 h-3 fill-green-600 ltr:mr-2 rtl:ml-2"})):p("",!0),e("div",Y,o(t.$number(s.rate)),1)])]),e("td",Z,[s.state?(a(),r(l,{key:0,name:"check",class:"flex-shrink-0 w-4 h-4 fill-green-600 mx-auto"})):(a(),r(l,{key:1,name:"cross",class:"flex-shrink-0 w-4 h-4 text-red-600 mx-auto"}))]),e("td",ee,[s.same?(a(),r(l,{key:0,name:"check",class:"flex-shrink-0 w-4 h-4 fill-green-600 mx-auto"})):(a(),r(l,{key:1,name:"cross",class:"flex-shrink-0 w-4 h-4 text-red-600 mx-auto"}))]),e("td",te,[s.compound?(a(),r(l,{key:0,name:"check",class:"flex-shrink-0 w-4 h-4 fill-green-600 mx-auto"})):(a(),r(l,{key:1,name:"cross",class:"flex-shrink-0 w-4 h-4 text-red-600 mx-auto"}))]),e("td",se,o(s.description),1),e("td",oe,[n(l,{name:"cheveron-right",class:"block w-6 h-6 fill-gray-400 rtl:rotate"})])],8,H))),128)),d.taxes.data.length===0?(a(),m("tr",ae,[e("td",le,o(t.$t("no_x_found",{x:t.$tc("Tax")})),1)])):p("",!0)])])]),n(k,{links:d.taxes.links,meta:d.taxes.meta},null,8,["links","meta"])])}const be=T(B,[["render",re]]);export{be as default};
