import{L as H,D as V}from"./Dropdown.48a14283.js";import{D as z}from"./Dialog.05b0b37c.js";import{M as U}from"./Modal.44e047a5.js";import{S as q}from"./SmsDialog.bc6d4fbe.js";import G from"./Show.d6da9b53.js";import{_ as W,r as C,o as y,c as p,a as r,t as d,d as B,w as T,e as x,b as k,f as S,n as D,F as $,g as F}from"./app.d8289e67.js";import"./LoadingButton.323ea2dd.js";import"./TextareaInput.1737678e.js";import"./InputError.b5dfb222.js";var A={exports:{}},O={exports:{}};(function(){var t="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/",c={rotl:function(e,g){return e<<g|e>>>32-g},rotr:function(e,g){return e<<32-g|e>>>g},endian:function(e){if(e.constructor==Number)return c.rotl(e,8)&16711935|c.rotl(e,24)&4278255360;for(var g=0;g<e.length;g++)e[g]=c.endian(e[g]);return e},randomBytes:function(e){for(var g=[];e>0;e--)g.push(Math.floor(Math.random()*256));return g},bytesToWords:function(e){for(var g=[],u=0,h=0;u<e.length;u++,h+=8)g[h>>>5]|=e[u]<<24-h%32;return g},wordsToBytes:function(e){for(var g=[],u=0;u<e.length*32;u+=8)g.push(e[u>>>5]>>>24-u%32&255);return g},bytesToHex:function(e){for(var g=[],u=0;u<e.length;u++)g.push((e[u]>>>4).toString(16)),g.push((e[u]&15).toString(16));return g.join("")},hexToBytes:function(e){for(var g=[],u=0;u<e.length;u+=2)g.push(parseInt(e.substr(u,2),16));return g},bytesToBase64:function(e){for(var g=[],u=0;u<e.length;u+=3)for(var h=e[u]<<16|e[u+1]<<8|e[u+2],f=0;f<4;f++)u*8+f*6<=e.length*8?g.push(t.charAt(h>>>6*(3-f)&63)):g.push("=");return g.join("")},base64ToBytes:function(e){e=e.replace(/[^A-Z0-9+\/]/ig,"");for(var g=[],u=0,h=0;u<e.length;h=++u%4)h!=0&&g.push((t.indexOf(e.charAt(u-1))&Math.pow(2,-2*h+8)-1)<<h*2|t.indexOf(e.charAt(u))>>>6-h*2);return g}};O.exports=c})();var M={utf8:{stringToBytes:function(t){return M.bin.stringToBytes(unescape(encodeURIComponent(t)))},bytesToString:function(t){return decodeURIComponent(escape(M.bin.bytesToString(t)))}},bin:{stringToBytes:function(t){for(var c=[],e=0;e<t.length;e++)c.push(t.charCodeAt(e)&255);return c},bytesToString:function(t){for(var c=[],e=0;e<t.length;e++)c.push(String.fromCharCode(t[e]));return c.join("")}}},N=M;/*!
 * Determine if an object is a Buffer
 *
 * @author   Feross Aboukhadijeh <https://feross.org>
 * @license  MIT
 */var Q=function(t){return t!=null&&(R(t)||Y(t)||!!t._isBuffer)};function R(t){return!!t.constructor&&typeof t.constructor.isBuffer=="function"&&t.constructor.isBuffer(t)}function Y(t){return typeof t.readFloatLE=="function"&&typeof t.slice=="function"&&R(t.slice(0,0))}(function(){var t=O.exports,c=N.utf8,e=Q,g=N.bin,u=function(h,f){h.constructor==String?f&&f.encoding==="binary"?h=g.stringToBytes(h):h=c.stringToBytes(h):e(h)?h=Array.prototype.slice.call(h,0):!Array.isArray(h)&&h.constructor!==Uint8Array&&(h=h.toString());for(var i=t.bytesToWords(h),w=h.length*8,l=1732584193,s=-271733879,n=-1732584194,o=271733878,a=0;a<i.length;a++)i[a]=(i[a]<<8|i[a]>>>24)&16711935|(i[a]<<24|i[a]>>>8)&4278255360;i[w>>>5]|=128<<w%32,i[(w+64>>>9<<4)+14]=w;for(var _=u._ff,m=u._gg,b=u._hh,v=u._ii,a=0;a<i.length;a+=16){var P=l,I=s,L=n,E=o;l=_(l,s,n,o,i[a+0],7,-680876936),o=_(o,l,s,n,i[a+1],12,-389564586),n=_(n,o,l,s,i[a+2],17,606105819),s=_(s,n,o,l,i[a+3],22,-1044525330),l=_(l,s,n,o,i[a+4],7,-176418897),o=_(o,l,s,n,i[a+5],12,1200080426),n=_(n,o,l,s,i[a+6],17,-1473231341),s=_(s,n,o,l,i[a+7],22,-45705983),l=_(l,s,n,o,i[a+8],7,1770035416),o=_(o,l,s,n,i[a+9],12,-1958414417),n=_(n,o,l,s,i[a+10],17,-42063),s=_(s,n,o,l,i[a+11],22,-1990404162),l=_(l,s,n,o,i[a+12],7,1804603682),o=_(o,l,s,n,i[a+13],12,-40341101),n=_(n,o,l,s,i[a+14],17,-1502002290),s=_(s,n,o,l,i[a+15],22,1236535329),l=m(l,s,n,o,i[a+1],5,-165796510),o=m(o,l,s,n,i[a+6],9,-1069501632),n=m(n,o,l,s,i[a+11],14,643717713),s=m(s,n,o,l,i[a+0],20,-373897302),l=m(l,s,n,o,i[a+5],5,-701558691),o=m(o,l,s,n,i[a+10],9,38016083),n=m(n,o,l,s,i[a+15],14,-660478335),s=m(s,n,o,l,i[a+4],20,-405537848),l=m(l,s,n,o,i[a+9],5,568446438),o=m(o,l,s,n,i[a+14],9,-1019803690),n=m(n,o,l,s,i[a+3],14,-187363961),s=m(s,n,o,l,i[a+8],20,1163531501),l=m(l,s,n,o,i[a+13],5,-1444681467),o=m(o,l,s,n,i[a+2],9,-51403784),n=m(n,o,l,s,i[a+7],14,1735328473),s=m(s,n,o,l,i[a+12],20,-1926607734),l=b(l,s,n,o,i[a+5],4,-378558),o=b(o,l,s,n,i[a+8],11,-2022574463),n=b(n,o,l,s,i[a+11],16,1839030562),s=b(s,n,o,l,i[a+14],23,-35309556),l=b(l,s,n,o,i[a+1],4,-1530992060),o=b(o,l,s,n,i[a+4],11,1272893353),n=b(n,o,l,s,i[a+7],16,-155497632),s=b(s,n,o,l,i[a+10],23,-1094730640),l=b(l,s,n,o,i[a+13],4,681279174),o=b(o,l,s,n,i[a+0],11,-358537222),n=b(n,o,l,s,i[a+3],16,-722521979),s=b(s,n,o,l,i[a+6],23,76029189),l=b(l,s,n,o,i[a+9],4,-640364487),o=b(o,l,s,n,i[a+12],11,-421815835),n=b(n,o,l,s,i[a+15],16,530742520),s=b(s,n,o,l,i[a+2],23,-995338651),l=v(l,s,n,o,i[a+0],6,-198630844),o=v(o,l,s,n,i[a+7],10,1126891415),n=v(n,o,l,s,i[a+14],15,-1416354905),s=v(s,n,o,l,i[a+5],21,-57434055),l=v(l,s,n,o,i[a+12],6,1700485571),o=v(o,l,s,n,i[a+3],10,-1894986606),n=v(n,o,l,s,i[a+10],15,-1051523),s=v(s,n,o,l,i[a+1],21,-2054922799),l=v(l,s,n,o,i[a+8],6,1873313359),o=v(o,l,s,n,i[a+15],10,-30611744),n=v(n,o,l,s,i[a+6],15,-1560198380),s=v(s,n,o,l,i[a+13],21,1309151649),l=v(l,s,n,o,i[a+4],6,-145523070),o=v(o,l,s,n,i[a+11],10,-1120210379),n=v(n,o,l,s,i[a+2],15,718787259),s=v(s,n,o,l,i[a+9],21,-343485551),l=l+P>>>0,s=s+I>>>0,n=n+L>>>0,o=o+E>>>0}return t.endian([l,s,n,o])};u._ff=function(h,f,i,w,l,s,n){var o=h+(f&i|~f&w)+(l>>>0)+n;return(o<<s|o>>>32-s)+f},u._gg=function(h,f,i,w,l,s,n){var o=h+(f&w|i&~w)+(l>>>0)+n;return(o<<s|o>>>32-s)+f},u._hh=function(h,f,i,w,l,s,n){var o=h+(f^i^w)+(l>>>0)+n;return(o<<s|o>>>32-s)+f},u._ii=function(h,f,i,w,l,s,n){var o=h+(i^(f|~w))+(l>>>0)+n;return(o<<s|o>>>32-s)+f},u._blocksize=16,u._digestsize=16,A.exports=function(h,f){if(h==null)throw new Error("Illegal argument "+h);var i=t.wordsToBytes(u(h,f));return f&&f.asBytes?i:f&&f.asString?g.bytesToString(i):t.bytesToHex(i)}})();const Z={metaInfo(){return{title:this.$t("Order Number",{x:this.order.id})}},props:{order:{default:{}},modal:{default:!0},edit:{type:Function}},components:{Logo:H,Dropdown:V,Dialog:z,Modal:U,MeasurementComponent:G,SmsDialog:q},computed:{total_paid:function(){return this.$number(this.order.payments.reduce((t,c)=>t+parseFloat(c.amount),0))}},data(){return{sending:!1,confirm:!1,send_sms:!1,emailing:!1,message:null,dialogButtonText:null,dialogAction:null,dialogTitle:null,dialogBody:null,viewMeasurement:!1}},methods:{showMeasurement(t){fetch(this.route("measurements.show",[t.id,A.exports(t.name)])+"?ajax=1").then(c=>{c.json().then(e=>{this.measurement=e,this.viewMeasurement=!0})})},printOrder(){window.print()},editOrder(){this.$emit("close"),this.$inertia.get(route("orders.edit",this.order.id))},updateStatusNow(t){this.$emit("close"),this.$inertia.put(this.route("orders.status",this.order.id),{status:t})},updateStatus(t){this.order.status=="Completed"?this.message=this.$t("Order is already marked as completed."):(this.dialogButtonText=this.$t("Yes"),this.dialogAction=()=>this.updateStatusNow(t),this.dialogTitle=this.$t("update_status_x",{x:this.$t(t)}),this.dialogBody=this.$t("ask_update_status_x",{x:this.$t(t)}),this.confirm=!0)},smsToCustomer(){this.send_sms=!0},emailOrder(){this.sending=!0,this.emailing=!0,this.$axios.post(this.route("orders.email",this.order.id)).then(t=>{this.sending=!1,this.emailing=!1,this.message=t.data.message||this.$t("System is unable to sent email, either customer do not have email or system settings are not correct.")}).catch(t=>{this.sending=!1,this.emailing=!1,this.message=t.response.data.message||this.$t("Request has been failed, please check the logs in storage folder and contact developer.")})},hide(){this.$emit("close")}}},J={key:0,class:"bg-white rounded-md ltr:text-left rtl:text-right"},K={key:0,class:"np flex justify-between items-center px-6 py-4 mb-4 bg-gray-100 border-b rounded-t"},X={class:"font-bold"},j={class:"flex items-center"},tt={class:"modal-close mx-2 cursor-pointer text-gray-700 hover:text-gray-800"},et={class:"mt-2 py-2 bg-gray-800 rounded text-sm"},rt=["disabled"],st=r("svg",{class:"fill-current text-black",xmlns:"http://www.w3.org/2000/svg",width:"18",height:"18",viewBox:"0 0 18 18"},[r("path",{d:"M14.53 4.53l-1.06-1.06L9 7.94 4.53 3.47 3.47 4.53 7.94 9l-4.47 4.47 1.06 1.06L9 10.06l4.47 4.47 1.06-1.06L10.06 9z"})],-1),ot=[st],nt={class:"print"},lt={class:"max-w-2xl h-full py-4 px-6 leading-normal"},it={class:"flex flex-wrap xs:flex-no-wrap justify-around w-full items-center"},dt={class:"text-gray-900 mx-auto xs:mx-0",style:{width:"180px"}},at=["alt","src"],ut={class:"text-sm px-4 py-4 xs:py-0 text-center xs:ltr:text-left rtl:text-right"},ct={class:"font-extrabold"},ht={class:"font-bold"},mt={class:"text-sm"},gt={class:"flex"},ft={class:"ltr:text-right rtl:text-left ltr:mr-2 rtl:ml-2",style:{width:"70px"}},yt={class:"font-bold"},pt={class:"flex"},xt={class:"ltr:text-right rtl:text-left ltr:mr-2 rtl:ml-2",style:{width:"70px"}},bt={class:"font-bold"},_t={class:"inline-block"},vt={class:"flex"},wt={class:"ltr:text-right rtl:text-left ltr:mr-2 rtl:ml-2",style:{width:"70px"}},kt={class:"font-bold"},Ct={key:0,class:"my-6 px-4 py-3 border rounded"},St={class:"font-extrabold inline-block"},Tt={class:"font-extrabold inline-block"},$t={class:"font-extrabold inline-block"},Bt=["href"],Ft={id:"details",class:"block xs:flex my-6"},Mt={id:"company",class:"ltr:pr-0 rtl:pl-0 xs:ltr:pr-3 xs:rtl:pl-3 w-full xs:max-w-1/2"},Dt={class:"px-2 py-2 border rounded-t font-bold"},Nt={class:"border rounded-b border-t-0 px-2 py-2"},At={class:"flex"},Ot={class:"ltr:mr-2 rtl:ml-2",style:{"min-width":"70px"}},Rt={key:0,class:"flex"},Pt={class:"ltr:mr-2 rtl:ml-2",style:{"min-width":"70px"}},It={class:"flex"},Lt={class:"ltr:mr-2 rtl:ml-2",style:{"min-width":"70px"}},Et={key:1,class:"flex"},Ht={class:"ltr:mr-2 rtl:ml-2",style:{"min-width":"70px"}},Vt={id:"customer",class:"mt-4 xs:mt-0 ltr:pl-0 rtl:pr-0 xs:ltr:pl-3 xs:rtl:pr-3 w-full xs:max-w-1/2"},zt={class:"px-2 py-2 border rounded-t font-bold"},Ut={class:"border rounded-b border-t-0 px-2 py-2"},qt={class:"flex"},Gt={class:"ltr:mr-2 rtl:ml-2",style:{"min-width":"70px"}},Wt={key:0,class:"flex"},Qt={class:"ltr:mr-2 rtl:ml-2",style:{"min-width":"70px"}},Yt={class:"flex"},Zt={class:"ltr:mr-2 rtl:ml-2",style:{"min-width":"70px"}},Jt={key:1,class:"flex"},Kt={class:"ltr:mr-2 rtl:ml-2",style:{"min-width":"70px"}},Xt={class:"border rounded leading-tight"},jt={class:"px-4 py-3 border-b rounded-t font-bold"},te={class:"rounded-b overflow-x-auto scroll-on-light"},ee={class:"w-full all max-w-full min-w-0"},re={class:"border-b bg-gray-200 px-4 py-2"},se={class:"border-b bg-gray-200 px-4 py-2 text-center"},oe={class:"border-b bg-gray-200 px-4 py-2 text-center"},ne={class:"border-b bg-gray-200 px-4 py-2 text-center"},le={class:"border-b px-4 py-2"},ie={style:{"min-width":"180px"}},de={key:0},ae={class:"text-muted"},ue=["onClick"],ce={class:"border-b px-4 py-2 ltr:text-right rtl:text-left"},he={class:"border-b px-4 py-2 ltr:text-right rtl:text-left"},me={class:"border-b px-4 py-2 ltr:text-right rtl:text-left"},ge={colspan:"3",class:"border-b px-4 py-2 bg-gray-200 ltr:text-right rtl:text-left"},fe={class:"border-b px-4 py-2 bg-gray-200 ltr:text-right rtl:text-left"},ye={key:0},pe={class:"border-b px-4 py-2 bg-gray-200 ltr:text-right rtl:text-left",colspan:"3"},xe={class:"border-b px-4 py-2 bg-gray-200 ltr:text-right rtl:text-left"},be={class:"border-b px-4 py-2 bg-gray-200 ltr:text-right rtl:text-left",colspan:"3"},_e={class:"border-b px-4 py-2 bg-gray-200 ltr:text-right rtl:text-left"},ve={key:2},we={class:"border-b px-4 py-2 bg-gray-200 ltr:text-right rtl:text-left",colspan:"3"},ke={class:"border-b px-4 py-2 bg-gray-200 ltr:text-right rtl:text-left"},Ce={class:"border-b px-4 py-2 bg-gray-200 ltr:text-right rtl:text-left font-normal",colspan:"3"},Se={class:"border-b px-4 py-2 bg-gray-200 ltr:text-right rtl:text-left font-normal"},Te={class:"border-b px-4 py-2 bg-gray-200 ltr:text-right rtl:text-left",colspan:"3"},$e={class:"border-b px-4 py-2 bg-gray-200 ltr:text-right rtl:text-left"},Be={class:"pt-6"},Fe={class:"font-bold"},Me={class:"print-only mt-auto w-full text-center text-sm text-gray-600 pt-6"},De={key:1,class:"np block xs:flex items-end justify-between px-6 py-4 mt-4 bg-gray-100 border-t rounded-b"},Ne={class:"m-1 xs:m-0"},Ae=["disabled"],Oe={key:0,class:"btn-spinner dark ltr:mr-2 rtl:ml-2"},Re=["disabled"],Pe={key:0,class:"btn-spinner dark ltr:mr-2 rtl:ml-2"},Ie={class:"flex items-center cursor-pointer select-none group px-4 py-3 text-sm rounded bg-gray-200 hover:bg-gray-400 border ltr:mr-2 rtl:ml-2"},Le={class:"mb-2 py-2 bg-gray-800 rounded text-sm"};function Ee(t,c,e,g,u,h){var _;const f=C("Icons"),i=C("Dropdown"),w=C("logo"),l=C("dropdown"),s=C("MeasurementComponent"),n=C("Modal"),o=C("SmsDialog"),a=C("Dialog");return e.order&&e.order.id?(y(),p("div",J,[e.modal&&t.$page.props.user?(y(),p("div",K,[r("p",X,d(t.$t("Order Number",{x:e.order.id})),1),r("div",j,[e.order.status!="Completed"&&(t.$page.props.user.edit_all||t.$page.props.user.id==((_=e.order.user)==null?void 0:_.id))?(y(),B(i,{key:0,placement:"bottom-end"},{dropdown:T(()=>[r("div",et,[r("button",{type:"button",onClick:c[0]||(c[0]=m=>h.updateStatus("Pending")),class:"block w-full ltr:text-left rtl:text-right px-6 py-3 text-white hover:bg-gray-900 hover:text-white fill-white"},d(t.$t("mark_as_x",{x:t.$t("Pending")})),1),r("button",{type:"button",onClick:c[1]||(c[1]=m=>h.updateStatus("Received")),class:"block w-full ltr:text-left rtl:text-right px-6 py-3 text-white hover:bg-gray-900 hover:text-white fill-white"},d(t.$t("mark_as_x",{x:t.$t("Received")})),1),r("button",{type:"button",onClick:c[2]||(c[2]=m=>h.updateStatus("Preparing")),class:"block w-full ltr:text-left rtl:text-right px-6 py-3 text-white hover:bg-gray-900 hover:text-white fill-white"},d(t.$t("mark_as_x",{x:t.$t("Preparing")})),1),r("button",{type:"button",onClick:c[3]||(c[3]=m=>h.updateStatus("Ready")),class:"block w-full ltr:text-left rtl:text-right px-6 py-3 text-white hover:bg-gray-900 hover:text-white fill-white"},d(t.$t("mark_as_x",{x:t.$t("Ready")})),1),r("button",{type:"button",onClick:c[4]||(c[4]=m=>h.updateStatus("Completed")),class:"block w-full ltr:text-left rtl:text-right px-6 py-3 text-white hover:bg-gray-900 hover:text-white fill-white"},d(t.$t("mark_as_x",{x:t.$t("Completed")})),1)])]),default:T(()=>[r("div",tt,[k(f,{class:"w-5 h-5 fill-current",name:"scissors"})])]),_:1})):x("",!0),r("a",{onClick:c[5]||(c[5]=m=>h.printOrder()),class:"modal-close mx-2 cursor-pointer text-gray-700 hover:text-gray-800"},[k(f,{name:"printer",class:"h-5 w-5 fill-current"})]),t.$page.props.user.edit_all||t.$page.props.user.id==e.order.user.id?(y(),p("a",{key:1,onClick:c[6]||(c[6]=m=>h.editOrder(e.order.id)),class:"modal-close mx-2 cursor-pointer text-gray-700 hover:text-gray-800"},[k(f,{name:"pencil",class:"h-5 w-5 fill-current"})])):x("",!0),t.$page.props.user.account.sms_enabled&&(t.$page.props.user.can_sms||t.$page.props.user.owner)?(y(),p("a",{key:2,onClick:c[7]||(c[7]=m=>h.smsToCustomer()),class:"modal-close mx-2 cursor-pointer text-gray-700 hover:text-gray-800"},[k(f,{name:"sms",class:"h-5 w-5 fill-current"})])):x("",!0),r("button",{type:"button",disabled:u.emailing,onClick:c[8]||(c[8]=m=>h.emailOrder()),class:"modal-close mx-2 cursor-pointer text-gray-700 hover:text-gray-800"},[k(f,{name:"email",class:"h-5 w-5 fill-current"})],8,rt),r("a",{class:"modal-close ml-2 cursor-pointer",onClick:c[9]||(c[9]=m=>h.hide())},ot)])])):x("",!0),r("div",nt,[r("div",lt,[r("div",it,[r("div",dt,[e.order.account.logo_path?(y(),p("img",{key:0,alt:e.order.account.name,src:`/storage/account/${e.order.account.logo_path}`},null,8,at)):(y(),B(w,{key:1}))]),r("div",ut,[r("div",ct,d(e.order.account.name),1),r("div",ht,d(e.order.account.phone),1),S(" "+d(e.order.account.email),1)]),r("div",mt,[r("div",gt,[r("span",ft,d(t.$t("Order No"))+":",1),r("span",yt,d(e.order.id),1)]),r("div",pt,[r("span",xt,d(t.$t("Date"))+":",1),r("span",bt,[r("span",_t,d(t.$datetime(e.order.created_at)),1)])]),r("div",vt,[r("span",wt,d(t.$t("Reference"))+":",1),r("span",kt,d(t.$reference(e.order.reference)),1)])])]),e.order.account.header?(y(),p("div",Ct,d(e.order.account.header),1)):x("",!0),r("div",{class:D(["my-6 px-4 py-3 rounded text-sm flex justify-between",{"bg-gray-200":e.order.status==t.$t("Received"),"bg-indigo-200":e.order.status==t.$t("Preparing"),"bg-green-200":e.order.status==t.$t("Ready"),"bg-green-700 text-white fill-white":e.order.status==t.$t("Completed")}])},[r("div",null,[S(d(t.$t("Priority"))+": ",1),r("span",St,d(e.order.priority==3?t.$t("Urgent"):e.order.priority==2?t.$t("High"):t.$t("Normal")),1)]),r("div",null,[S(d(t.$t("Status"))+": ",1),r("span",Tt,d(e.order.status),1)]),r("div",null,[S(d(t.$t("Delivery Date"))+": ",1),r("span",$t,d(t.$date(e.order.delivery_date)),1)])],2),e.order.photo_path?(y(),p("a",{key:1,target:"_blank",class:"np w-full block my-6 px-4 py-3 rounded border bg-gray-200 hover:bg-gray-300",href:`/orders/${e.order.id}/photo/${e.order.user.id+"--"+e.order.hash}`},d(t.$t("View Order Photo")),9,Bt)):x("",!0),r("div",Ft,[r("div",Mt,[r("div",Dt,d(t.$t("Company Details")),1),r("div",Nt,[r("div",At,[r("span",Ot,d(t.$t("Name"))+":",1),r("span",null,[r("strong",null,d(e.order.account.name),1)])]),e.order.account.address?(y(),p("div",Rt,[r("span",Pt,d(t.$t("Address"))+":",1),r("span",null,d(e.order.account.address),1)])):x("",!0),r("div",It,[r("span",Lt,d(t.$t("Phone"))+":",1),r("span",null,d(e.order.account.phone),1)]),e.order.account.email?(y(),p("div",Et,[r("span",Ht,d(t.$t("Email"))+":",1),r("span",null,d(e.order.account.email),1)])):x("",!0)])]),r("div",Vt,[r("div",zt,d(t.$t("Customer Details")),1),r("div",Ut,[r("div",qt,[r("span",Gt,d(t.$t("Name"))+":",1),r("span",null,[r("strong",null,d(e.order.customer.name),1)])]),e.order.customer.address?(y(),p("div",Wt,[r("span",Qt,d(t.$t("Address"))+":",1),r("span",null,d(e.order.customer.address),1)])):x("",!0),r("div",Yt,[r("span",Zt,d(t.$t("Phone"))+":",1),r("span",null,d(e.order.customer.phone),1)]),e.order.customer.email?(y(),p("div",Jt,[r("span",Kt,d(t.$t("Email"))+":",1),r("span",null,d(e.order.customer.email),1)])):x("",!0)])])]),r("div",Xt,[r("p",jt,d(t.$tc("Service",2)),1),r("div",te,[r("table",ee,[r("thead",null,[r("tr",null,[r("th",re,d(t.$t("Item / Details")),1),r("th",se,d(t.$t("Price")),1),r("th",oe,d(t.$t("Qty")),1),r("th",ne,d(t.$t("Amount")),1)])]),r("tbody",null,[(y(!0),p($,null,F(e.order.services,m=>(y(),p("tr",{key:"service_"+m.id},[r("td",le,[r("div",ie,[r("div",null,d(m.name)+" ("+d(m.code)+")",1),t.$page.props.user?(y(),p("div",de,[r("small",ae,[S(d(t.$tc("Measurement"))+": ",1),r("button",{class:"text-indigo-600 hover:fonr-bold",onClick:b=>h.showMeasurement(m.measurement)},d(m.measurement.name),9,ue)])])):x("",!0)])]),r("td",ce,d(t.$number(m.price)),1),r("td",he,d(t.$number(m.qty)),1),r("td",me,d(t.$number(m.amount)),1)]))),128))]),r("tfoot",null,[r("tr",null,[r("th",ge,d(t.$t("Total")),1),r("th",fe,d(t.$number(e.order.total)),1)]),e.order.discount?(y(),p("tr",ye,[r("th",pe,d(t.$t("Discount")),1),r("th",xe,d(t.$number(e.order.discount_amount)),1)])):x("",!0),e.order.taxes.length?(y(!0),p($,{key:1},F(e.order.taxes,(m,b)=>(y(),p("tr",{key:"tr_"+b},[r("th",be,d(m.name),1),r("th",_e,d(t.$number(m.pivot.total_amount)),1)]))),128)):x("",!0),e.order.taxes.length||e.order.discount?(y(),p("tr",ve,[r("th",we,d(t.$t("Grand Total")),1),r("th",ke,d(t.$number(e.order.grand_total)),1)])):x("",!0),e.order.payments.length?(y(),p($,{key:3},[(y(!0),p($,null,F(e.order.payments,(m,b)=>(y(),p("tr",{key:"payment_"+b},[r("th",Ce,d(t.$tc("Payment"))+" ("+d(t.$date(m.date))+") ",1),r("th",Se,d(t.$number(m.amount)),1)]))),128)),r("tr",null,[r("th",Te,d(t.$t("Balance")),1),r("th",$e,d(t.$number(e.order.grand_total-this.total_paid)),1)])],64)):x("",!0)])])])]),r("div",Be,[r("h4",Fe,d(t.$t("Comment / Note")),1),r("p",null,d(e.order.note),1)]),e.order.account.footer?(y(),p("div",{key:2,class:D(["mt-6 px-4 py-3 border rounded",e.modal?"":"mb-3"])},d(e.order.account.footer),3)):x("",!0),r("div",Me,d(t.$t("This is a computer-generated document. No signature is required.")),1)])]),e.modal?(y(),p("div",De,[r("div",Ne,[t.$page.props.user.edit_all||t.$page.props.user.id==e.order.user.id?(y(),p("button",{key:0,onClick:c[10]||(c[10]=m=>h.editOrder()),class:"px-4 py-3 text-sm rounded bg-gray-200 hover:bg-gray-400 border ltr:mr-2 rtl:ml-2"},d(t.$t("Edit")),1)):x("",!0),t.$page.props.user.account.sms_enabled&&(t.$page.props.user.can_sms||t.$page.props.user.owner)?(y(),p("button",{key:1,disabled:u.sending,onClick:c[11]||(c[11]=m=>h.smsToCustomer()),class:"inline-flex items-center mt-1 px-4 py-3 text-sm rounded bg-gray-200 hover:bg-gray-400 border ltr:mr-2 rtl:ml-2"},[u.sending?(y(),p("div",Oe)):x("",!0),S(" "+d(t.$t("SMS")),1)],8,Ae)):x("",!0),r("button",{disabled:u.sending,onClick:c[12]||(c[12]=m=>h.emailOrder()),class:"inline-flex items-center mt-1 px-4 py-3 text-sm rounded bg-gray-200 hover:bg-gray-400 border ltr:mr-2 rtl:ml-2"},[u.sending?(y(),p("div",Pe)):x("",!0),S(" Notify ")],8,Re),e.order.status!="Completed"&&(t.$page.props.user.edit_all||t.$page.props.user.id==e.order.user.id)?(y(),B(l,{key:2,class:"mt-1",placement:"top-start"},{dropdown:T(()=>[r("div",Le,[r("button",{type:"button",onClick:c[13]||(c[13]=m=>h.updateStatus("Completed")),class:"block w-full ltr:text-left rtl:text-right px-6 py-3 text-white hover:bg-gray-900 hover:text-white fill-white"},d(t.$t("mark_as_x",{x:t.$t("Completed")})),1),r("button",{type:"button",onClick:c[14]||(c[14]=m=>h.updateStatus("Ready")),class:"block w-full ltr:text-left rtl:text-right px-6 py-3 text-white hover:bg-gray-900 hover:text-white fill-white"},d(t.$t("mark_as_x",{x:t.$t("Ready")})),1),r("button",{type:"button",onClick:c[15]||(c[15]=m=>h.updateStatus("Preparing")),class:"block w-full ltr:text-left rtl:text-right px-6 py-3 text-white hover:bg-gray-900 hover:text-white fill-white"},d(t.$t("mark_as_x",{x:t.$t("Preparing")})),1),r("button",{type:"button",onClick:c[16]||(c[16]=m=>h.updateStatus("Received")),class:"block w-full ltr:text-left rtl:text-right px-6 py-3 text-white hover:bg-gray-900 hover:text-white fill-white"},d(t.$t("mark_as_x",{x:t.$t("Received")})),1)])]),default:T(()=>[r("div",Ie,[S(d(t.$t("Status"))+" ",1),k(f,{class:"w-2 h-2 fill-current ml-2",name:"cheveron-up"})])]),_:1})):x("",!0)]),r("button",{onClick:c[17]||(c[17]=m=>h.hide()),class:"btn-gray"},d(t.$t("Close")),1)])):x("",!0),k(n,{show:u.viewMeasurement,"max-width":"2xl",closeable:!0,onClose:c[19]||(c[19]=m=>u.viewMeasurement=!1)},{default:T(()=>{var m;return[k(s,{measurement:t.measurement,onClose:c[18]||(c[18]=()=>u.viewMeasurement=!1),notify:e.order.customer.id!=((m=t.measurement)==null?void 0:m.customer.id)},null,8,["measurement","notify"])]}),_:1},8,["show"]),k(n,{show:u.send_sms,"max-width":"sm",closeable:!1,onClose:c[21]||(c[21]=m=>u.send_sms=!1)},{default:T(()=>[k(o,{order:e.order,onClose:c[20]||(c[20]=()=>u.send_sms=!1)},null,8,["order"])]),_:1},8,["show"]),k(a,{show:u.message,content:u.message,closeText:t.$t("ok"),close:()=>u.message=null},null,8,["show","content","closeText","close"]),k(a,{show:u.confirm,close:()=>u.confirm=!1,"action-text":u.dialogButtonText,action:u.dialogAction,title:u.dialogTitle,content:u.dialogBody},null,8,["show","close","action-text","action","title","content"])])):x("",!0)}const Ze=W(Z,[["render",Ee]]);export{Ze as default};