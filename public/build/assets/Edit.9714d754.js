import{L as N,F as V}from"./Layout.c268843b.js";import{M as k}from"./Modal.44e047a5.js";import{T as M}from"./TextInput.f4f909b7.js";import{L as O}from"./LoadingButton.323ea2dd.js";import q from"./Customization.1deb895a.js";import{_ as F,r as d,o as u,c,a as e,b as n,w as p,f as h,t as s,k as A,n as y,F as I,g as L}from"./app.d8289e67.js";import"./Dropdown.48a14283.js";import"./FlashMessages.3029884e.js";import"./InputError.b5dfb222.js";import"./Input.954bfb09.js";import"./RadioInput.967e0b49.js";import"./TextareaInput.1737678e.js";const S={layout:N,remember:"form",props:{order:Object,iproducts:Array,icustomers:Array,icategories:Array},components:{LoadingButton:O,TextInput:M,Modal:k,Customization:q},metaInfo(){return{title:this.$tc("Product Order",2)}},data(){return{viewModal:!1,customers:[],products:[],customer:this.icustomers.find(t=>t.id===this.order.customer.id),form:{reference:this.order.reference,customer_id:this.order.customer_id,carts:[]},sending:!1,errors:{},product:null,cart:null,custom_fields:[]}},mounted(){this.customers=this.icustomers,this.products=this.iproducts,this.form.carts=this.order.carts.map(t=>({id:t.id,unit:t.unit,qty:t.quantity,product:this.iproducts.find(o=>Number(o.id)===Number(t.product_id)),customization:JSON.parse(t.customization)}))},computed:{totalAmount(){return this.form.carts.reduce((t,o)=>parseFloat(o.unit)*parseFloat(o.qty)+t,0)},totalQuantity(){return this.form.carts.reduce((t,o)=>parseFloat(o.qty)+t,0)}},methods:{...V,submit(){const t=this.form.carts.map(o=>({id:o.id,customization:JSON.stringify(o.customization),product_id:o.product.id,quantity:o.qty,unit:o.unit}));this.$inertia.put(this.route("product_orders.update",this.order.id),{carts:t,customer:this.form.customer_id,reference:this.form.reference},{onFinish:()=>this.sending=!1})},customerChanged(t){this.form.customer_id=t?t.value:null},addToOrder(t){const o=Math.max(...this.form.carts.map(a=>a.id));this.form.carts.push({id:o+1,unit:t.price,qty:1,product:t,customization:null}),this.product=null},openCustomizationField(t){this.cart=t,this.custom_fields=this.icategories.find(o=>Number(o.id)===Number(t.product.category_id)).custom_fields,this.viewModal=!0},changeCustomization(t){this.viewModal=!1;const o=this.form.carts.findIndex(a=>Number(a.id)===Number(t.id));this.form.carts[o].customization=t.data},removeCart(t){this.form.carts=this.form.carts.filter(o=>Number(o.id)!==Number(t))},isCustomizable(t){return this.icategories.find(o=>Number(o.id)===Number(t.product.category_id)).custom_fields.length>0}}},T={class:"mb-6 mt-2 font-bold text-lg md:text-2xl"},P=e("span",{class:"text-gray-400 font-medium mx-2"},"/",-1),U={class:"bg-white rounded shadow max-w-3xl"},B={class:"p-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap"},j={class:"w-full flex pb-8"},E={class:"ltr:pr-6 rtl:pl-6 w-full lg:w-1/2"},Q={class:"form-label font-medium text-gray-700",for:"customer_id"},J={class:"w-full flex pb-8"},$={class:"ltr:mr-6 rtl:ml-6 mb-8 w-full border rounded overflow-x-auto lg:overflow-x-hidden pb-4 lg:pb-0"},D={class:"w-full"},R=e("th",{class:"border-b pl-4 pr-2 py-2 bg-gray-200 text-center"},"No",-1),G=e("th",{class:"border-b pl-2 pr-4 py-2 bg-gray-200 ltr:text-left rtl:text-right"},null,-1),H={class:"border-b pl-2 pr-4 py-2 bg-gray-200 ltr:text-left rtl:text-right"},K={class:"border-b px-4 py-2 bg-gray-200 w-40"},W={class:"border-b px-4 py-2 bg-gray-200 w-16"},X={class:"border-b px-4 py-2 bg-gray-200 w-12"},Y={class:"border-b px-4 py-2 bg-gray-200"},Z={class:"border-b pl-4 pr-2 py-2"},tt={class:"flex flex-col content-center items-center justify-around w-6"},et={class:"pt-1"},ot=["onClick"],rt={class:"border-b px-4 py-2 no-drop"},st=["src"],lt={class:"border-b pl-2 pr-4 py-2 leading-normal"},it={class:"border-b px-4 py-2 no-drop"},nt=["onClick"],dt={key:1,class:"text-center font-bold"},at={class:"border-b px-4 py-2 ltr:text-right rtl:text-left no-drop"},ut={class:"border-b px-4 py-2 no-drop"},ct={class:"border-b px-4 py-2 ltr:text-right rtl:text-left"},mt={class:"border-b px-4 py-2 bg-gray-200 ltr:text-right rtl:text-left",colspan:"5"},pt={class:"border-b px-4 py-2 bg-gray-200 text-center"},ht={class:"border-b px-4 py-2 bg-gray-200 ltr:text-right rtl:text-left"},ft={class:"px-8 py-4 bg-gray-100 border-t border-gray-200 flex items-center"};function bt(t,o,a,_t,l,i){var g;const f=d("Icons"),x=d("Link"),b=d("v-select"),_=d("text-input"),w=d("loading-button"),v=d("Customization"),C=d("Modal");return u(),c("div",null,[e("h1",T,[n(x,{class:"text-gray-600 hover:text-gray-800 inline-flex items-center",href:t.route("product_orders")},{default:p(()=>[n(f,{name:"back",class:"flex-shrink-0 w-3 h-3 md:w-5 md:h-5 fill-current ltr:mr-2 rtl:ml-2 rtl:rotate"}),h(" "+s(t.$tc("Product Order",2)),1)]),_:1},8,["href"]),P,h(" "+s(a.order.reference),1)]),e("div",U,[e("form",{onSubmit:o[3]||(o[3]=A((...r)=>i.submit&&i.submit(...r),["prevent"])),autocomplete:"off"},[e("div",B,[e("div",j,[e("div",E,[e("label",Q,s(t.$tc("Customer")),1),n(b,{transition:"",modelValue:l.customer,"onUpdate:modelValue":o[0]||(o[0]=r=>l.customer=r),clearable:!1,options:l.customers,"input-id":"customer_id","onOption:selected":i.customerChanged,dir:t.$page.props.user.account.direction,placeholder:t.$t("search_x",{x:t.$tc("Customer")}),class:y({error:!1})},null,8,["modelValue","options","onOption:selected","dir","placeholder"])]),n(_,{label:t.$t("Reference"),modelValue:l.form.reference,"onUpdate:modelValue":o[1]||(o[1]=r=>l.form.reference=r),errors:(g=t.$page.props.errors)==null?void 0:g.reference,class:"ltr:pr-6 rtl:pl-6 w-full lg:w-1/2"},null,8,["label","modelValue","errors"])]),e("div",J,[n(b,{transition:"",modelValue:l.product,"onUpdate:modelValue":o[2]||(o[2]=r=>l.product=r),clearable:!1,options:l.products,"onOption:selected":i.addToOrder,dir:t.$page.props.user.account.direction,placeholder:t.$t("Search product to add to order"),class:"ltr:pr-6 rtl:pl-6 w-full"},null,8,["modelValue","options","onOption:selected","dir","placeholder"])]),e("div",$,[e("table",D,[e("thead",null,[e("tr",null,[R,G,e("th",H,s(t.$tc("Product")),1),e("th",K,s(t.$tc("Customization")),1),e("th",W,s(t.$t("Price")),1),e("th",X,s(t.$t("Qty")),1),e("th",Y,s(t.$t("Amount")),1)])]),e("tbody",null,[(u(!0),c(I,null,L(l.form.carts,(r,z)=>(u(),c("tr",{key:"cart_"+r.id},[e("td",Z,[e("div",tt,[e("div",et,s(z+1),1),e("button",{type:"button",onClick:m=>i.removeCart(r.id),class:"mt-1 p-1 text-gray-500 hover:text-red-600"},[n(f,{name:"trash",class:"flex-shrink-0 w-3 h-3 fill-current"})],8,ot)])]),e("td",rt,[e("img",{src:"/storage/product/"+r.product.main_photo,alt:"product-photo",class:"h-12 object-cover"},null,8,st)]),e("td",lt,s(r.product.name),1),e("td",it,[i.isCustomizable(r)?(u(),c("div",{key:0,class:y(`bg-${r.customization?"gray":"red"}-500 rounded text-sm py-1 px-2 text-white cursor-pointer w-20 text-center mx-auto`),onClick:m=>i.openCustomizationField(r)},s(r.customization?"Edit":"Add"),11,nt)):(u(),c("div",dt," N/A "))]),e("td",at,s(t.$number(r.unit)),1),e("td",ut,[n(_,{small:"",type:"number",class:"w-16 text-center",modelValue:r.qty,"onUpdate:modelValue":m=>r.qty=m},null,8,["modelValue","onUpdate:modelValue"])]),e("td",ct,s(t.$number(r.unit*r.qty)),1)]))),128))]),e("tfoot",null,[e("tr",null,[e("th",mt,s(t.$t("Total")),1),e("th",pt,s(i.totalQuantity),1),e("th",ht,s(t.$number(i.totalAmount)),1)])])])])]),e("div",ft,[n(w,{loading:l.sending,class:"btn-gray ltr:ml-auto rtl:mr-auto",type:"submit"},{default:p(()=>[h(s(t.$t("update_x",{x:t.$tc("Product Order",1)})),1)]),_:1},8,["loading"])])],32)]),n(C,{show:l.viewModal,"max-width":"3xl",closeable:!0,onClose:o[6]||(o[6]=()=>l.viewModal=!1)},{default:p(()=>[n(v,{opened:l.viewModal,cart:l.cart,icustom_fields:l.custom_fields,onSubmit:o[4]||(o[4]=r=>i.changeCustomization(r)),onClose:o[5]||(o[5]=()=>l.viewModal=!1)},null,8,["opened","cart","icustom_fields"])]),_:1},8,["show"])])}const qt=F(S,[["render",bt]]);export{qt as default};