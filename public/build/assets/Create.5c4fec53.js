import{L}from"./Layout.c268843b.js";import{g as D}from"./debounce.9b400763.js";import{T as F}from"./TextInput.f4f909b7.js";import{C as B}from"./CheckboxInput.0509202e.js";import{L as N}from"./LoadingButton.323ea2dd.js";import{_ as U,r as n,o as y,c as x,a as o,b as a,w,f as p,t as i,k as j,n as A,e as T}from"./app.d8289e67.js";import"./Dropdown.48a14283.js";import"./FlashMessages.3029884e.js";import"./InputError.b5dfb222.js";import"./Input.954bfb09.js";const $={layout:L,remember:"form",props:{members:Array},metaInfo:{title:"Create Salary"},components:{LoadingButton:N,TextInput:F,CheckboxInput:B},data(){return{sending:!1,form:{date:null,amount:null,advance:null,staff_id:null,description:null},staff:null,staff_members:[]}},mounted(){this.staff_members=this.members.map(e=>({value:e.value,label:e.label+(e.salary?" ("+parseFloat(e.salary).toFixed(2)+")":"")})),this.form.date=this.$options.filters.formatDate(new Date)},methods:{staffChanged(e){this.staff=e||null,this.form.staff_id=e?e.value:null},submit(){this.sending=!0,this.$inertia.post(this.route("salaries.store"),this.form,{onFinish:()=>this.sending=!1})},searchStaff(e,t){e&&(t(!0),this.searchingStaff(t,e,this))},searchingStaff:D((e,t,f)=>{fetch(f.route("ajax.staff")+"?with_salaries=1&search="+escape(t)).then(d=>{d.json().then(r=>f.staff_members=r.map(s=>({value:s.value,label:s.label+(s.salary?" ("+parseFloat(s.salary).toFixed(2)+")":"")}))),e(!1)})},350)}},O={class:"mb-6 mt-2 font-bold text-lg md:text-2xl"},z=o("span",{class:"text-gray-400 font-medium mx-2"},"/",-1),E={class:"bg-white rounded shadow overflow-hidden max-w-3xl"},M={class:"p-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap"},q={class:"px-8 pb-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap"},G={class:"ltr:pr-6 rtl:pl-6 pb-8 w-full"},H={class:"form-label",for:"staff_id"},J={key:0,class:"form-error"},K={class:"px-8 pb-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0"},P={class:"px-8 py-4 bg-gray-100 border-t border-gray-200 flex justify-end items-center"};function Q(e,t,f,d,r,s){var u,c,h,b,_,g,v;const k=n("Icons"),S=n("Link"),m=n("text-input"),C=n("v-select"),V=n("checkbox-input"),I=n("loading-button");return y(),x("div",null,[o("h1",O,[a(S,{class:"text-gray-600 hover:text-gray-800 inline-flex items-center",href:e.route("salaries")},{default:w(()=>[a(k,{name:"back",class:"flex-shrink-0 w-3 h-3 md:w-5 md:h-5 fill-current ltr:mr-2 rtl:ml-2 rtl:rotate"}),p(" "+i(e.$t("Salaries")),1)]),_:1},8,["href"]),z,p(" "+i(e.$t("Create")),1)]),o("div",E,[o("form",{onSubmit:t[4]||(t[4]=j((...l)=>s.submit&&s.submit(...l),["prevent"])),autocomplete:"off"},[o("div",M,[a(m,{label:"Date",type:"date",modelValue:r.form.date,"onUpdate:modelValue":t[0]||(t[0]=l=>r.form.date=l),pattern:"\\d{4}-\\d{2}-\\d{2}",errors:(u=e.$page.props.errors)==null?void 0:u.date,class:"ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2"},null,8,["modelValue","errors"]),a(m,{modelValue:r.form.amount,"onUpdate:modelValue":t[1]||(t[1]=l=>r.form.amount=l),errors:(c=e.$page.props.errors)==null?void 0:c.amount,class:"ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2",label:"Amount"},null,8,["modelValue","errors"])]),o("div",q,[o("div",G,[o("label",H,i(e.$t("Staff")),1),a(C,{dir:e.$page.props.user.account.direction,transition:"",value:r.staff,"input-id":"staff_id",onInput:s.staffChanged,onSearch:s.searchStaff,options:r.staff_members,placeholder:"Search Staff","onOption:selected":s.staffChanged,class:A({error:((h=e.$page.props.errors)==null?void 0:h.staff_id)&&((b=e.$page.props.errors)==null?void 0:b.staff_id.length)})},null,8,["dir","value","onInput","onSearch","options","onOption:selected","class"]),(_=e.$page.props.errors)!=null&&_.staff_id?(y(),x("div",J,i((g=e.$page.props.errors)==null?void 0:g.staff_id[0]),1)):T("",!0)]),a(m,{modelValue:r.form.description,"onUpdate:modelValue":t[2]||(t[2]=l=>r.form.description=l),errors:(v=e.$page.props.errors)==null?void 0:v.description,class:"ltr:pr-6 rtl:pl-6 pb-8 w-full",label:"Description"},null,8,["modelValue","errors"])]),o("div",K,[a(V,{id:"advance",checked:r.form.advance,"onUpdate:checked":t[3]||(t[3]=l=>r.form.advance=l),label:e.$t("Advance payment (deduct from next salary)")},null,8,["checked","label"])]),o("div",P,[a(I,{loading:r.sending,class:"btn-gray",type:"submit"},{default:w(()=>[p(i(e.$t("Create Salary")),1)]),_:1},8,["loading"])])],32)])])}const le=U($,[["render",Q]]);export{le as default};
