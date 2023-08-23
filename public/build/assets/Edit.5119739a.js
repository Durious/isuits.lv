import{L as S}from"./Layout.c268843b.js";import{d as z}from"./DeleteMixin.d312fa19.js";import{T as A}from"./TextInput.f4f909b7.js";import{F as J}from"./FileInput.bfc636d8.js";import{L as q}from"./LoadingButton.323ea2dd.js";import{T as G}from"./TextareaInput.1737678e.js";import{T as H}from"./TrashedMessage.7363da80.js";import{D as K}from"./DeleteRestoreComponent.725db004.js";import{_ as Q,r as m,o as i,c as u,a as r,b as s,w as h,f as b,t as p,d as y,e as c,k as C,n as P,F as D,g as W}from"./app.d8289e67.js";import"./Dropdown.48a14283.js";import"./FlashMessages.3029884e.js";import"./InputError.b5dfb222.js";import"./Input.954bfb09.js";import"./Dialog.05b0b37c.js";import"./Modal.44e047a5.js";const X={layout:S,props:{customField:Object,iTagBackground:Object},mixins:[z("customfield","customField")],components:{LoadingButton:q,TextInput:A,FileInput:J,TextareaInput:G,TrashedMessage:H,DeleteRestoreComponent:K},data(){var e,o,n,a;return{errors:{},restore:!1,form:{name:this.customField.name,type:this.customField.type,tag:this.customField.tag,options:(e=JSON.parse(this.customField.options))!=null?e:[{name:"",description:"",file:"",preview:""},{name:"",description:"",file:"",preview:""}],description:this.customField.description},tagBackground:(n=(o=this.iTagBackground)==null?void 0:o.background)!=null?n:null,tagPreview:this.iTagBackground?"/storage/tagpreview/"+((a=this.iTagBackground)==null?void 0:a.background):null,sending:!1,types:["Text","Number","ImageRadio","Radio","TextArea"]}},watch:{tagBackground(e){e?typeof e=="object"&&this.previewImage(e):this.tagPreview=null}},methods:{addOption(){this.form.options.push({name:"",description:"",file:"",preview:""})},removeOption(){this.form.options.pop()},submit(){this.sending=!0;const e=new FormData;e.append("name",this.form.name),e.append("type",this.form.type),e.append("description",this.form.description),e.append("tag",this.form.tag),(this.form.type==="Radio"||this.form.type==="ImageRadio")&&this.form.options.forEach((o,n)=>{for(let a in o)a==="file"||a==="preview"?this.form.type==="ImageRadio"&&e.append(`options[${n}][${a}]`,o[a]||""):e.append(`options[${n}][${a}]`,o[a])}),this.$inertia.post(this.route("customfields.update",this.customField.id),e,{onError:o=>{this.errors=o,this.sending=!1},onFinish:()=>{this.sending=!1}})},submitPreview(){const e=new FormData;e.append("name",this.customField.tag),e.append("background",this.tagBackground),this.$inertia.post(this.route("customfields.savePreview"),e,{onFinish:()=>{this.sending=!1}})},previewImage(e){const o=new FileReader;o.onload=n=>{this.tagPreview=n.target.result},o.readAsDataURL(e)}}},Y={class:"mb-6 mt-2 font-bold text-lg md:text-2xl"},Z=r("span",{class:"text-gray-400 font-medium mx-2"},"/",-1),$={class:"w-full flex flex-wrap"},ee={class:"w-full md:w-3/5 px-3"},te={class:"bg-white rounded shadow overflow-hidden"},oe={class:"p-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap"},re={class:"px-8 pb-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap"},le={class:"ltr:pr-6 rtl:pl-6 pb-8 w-full"},se={class:"form-label",for:"type"},ie={key:0,class:"form-error"},ne={key:1,class:"form-error"},ae={class:"w-full"},me={class:"mb-3"},pe={class:"flex w-full"},de={class:"w-full flex items-center justify-end mt-5 mb-6 gap-4 ltr:pr-6 rtl:pl-6"},ue=r("svg",{xmlns:"http://www.w3.org/2000/svg",fill:"none",viewBox:"0 0 24 24","stroke-width":"1.5",stroke:"currentColor",class:"w-6 h-6"},[r("path",{"stroke-linecap":"round","stroke-linejoin":"round",d:"M12 4.5v15m7.5-7.5h-15"})],-1),ce=[ue],fe=r("svg",{xmlns:"http://www.w3.org/2000/svg",fill:"none",viewBox:"0 0 24 24","stroke-width":"1.5",stroke:"currentColor",class:"w-6 h-6"},[r("path",{"stroke-linecap":"round","stroke-linejoin":"round",d:"M19.5 12h-15"})],-1),ge=[fe],we={class:"px-8 pb-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap"},he={class:"px-8 pb-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap"},be={class:"px-8 py-4 bg-gray-100 border-t border-gray-200 flex justify-between items-center"},ve={key:0,class:"w-full md:w-2/5 px-3"},ye={class:"bg-white rounded shadow overflow-hidden"},_e={class:"p-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 w-full"},ke=["src"],Ve={class:"mt-8 text-right"};function xe(e,o,n,a,t,d){var k,V,x,F,B,R,T,U,I;const O=m("Icons"),L=m("Link"),N=m("trashed-message"),w=m("text-input"),j=m("v-select"),v=m("file-input"),E=m("textarea-input"),M=m("DeleteRestoreComponent"),_=m("loading-button");return i(),u("div",null,[r("h1",Y,[s(L,{class:"text-gray-600 hover:text-gray-800 inline-flex items-center",href:e.route("customfields")},{default:h(()=>[s(O,{name:"back",class:"flex-shrink-0 w-3 h-3 md:w-5 md:h-5 fill-current ltr:mr-2 rtl:ml-2 rtl:rotate"}),b(" "+p(e.$tc("custom_field",2)),1)]),_:1},8,["href"]),Z,b(" "+p(e.$t("Edit")),1)]),n.customField.deleted_at?(i(),y(N,{key:0,class:"mb-6",onRestore:o[0]||(o[0]=()=>t.restore=!0)},{default:h(()=>[r("span",null,p(e.$t("already_deleted_x",{x:e.$tc("custom_field")})),1)]),_:1})):c("",!0),r("div",$,[r("div",ee,[r("div",te,[r("form",{onSubmit:o[8]||(o[8]=C((...l)=>d.submit&&d.submit(...l),["prevent"])),autocomplete:"off"},[r("div",oe,[s(w,{modelValue:t.form.name,"onUpdate:modelValue":o[1]||(o[1]=l=>t.form.name=l),errors:(k=t.errors)==null?void 0:k.name,class:"ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-full",label:e.$t("Name")},null,8,["modelValue","errors","label"])]),r("div",re,[r("div",le,[r("label",se,p(e.$tc("Type")),1),s(j,{dir:e.$page.props.user.account.direction,transition:"","input-id":"type",options:t.types,filterable:!1,searchable:!1,modelValue:t.form.type,"onUpdate:modelValue":o[2]||(o[2]=l=>t.form.type=l),placeholder:e.$t("select_x",{x:e.$t("Type")}),class:P({error:((V=t.errors)==null?void 0:V.type)&&((x=t.errors)==null?void 0:x.type.length)})},null,8,["dir","options","modelValue","placeholder","class"]),(F=t.errors)!=null&&F.type?(i(),u("div",ie,p((B=t.errors)==null?void 0:B.type),1)):c("",!0),(R=t.errors)!=null&&R.options?(i(),u("div",ne,p((T=t.errors)==null?void 0:T.options),1)):c("",!0)]),t.form.type==="Radio"||t.form.type==="ImageRadio"?(i(),u(D,{key:0},[r("div",ae,[(i(!0),u(D,null,W(t.form.options,(l,f)=>(i(),u("div",{key:f,class:P(["py-5",f!==0?"border-t":""])},[r("div",me,p(e.$tc("Option")+" "+(f+1)),1),r("div",pe,[s(w,{modelValue:l.name,"onUpdate:modelValue":g=>l.name=g,class:"ltr:pr-6 rtl:pl-6 w-full lg:w-1/2",label:e.$t("Name"),errors:t.errors["options."+f+".name"]},null,8,["modelValue","onUpdate:modelValue","label","errors"]),s(w,{modelValue:l.description,"onUpdate:modelValue":g=>l.description=g,class:"ltr:pr-6 rtl:pl-6 w-full lg:w-1/2",label:e.$t("Description"),errors:t.errors["options."+f+".description"]},null,8,["modelValue","onUpdate:modelValue","label","errors"])]),t.form.type==="ImageRadio"?(i(),y(v,{key:0,type:"file",accept:"image/*",label:e.$t("Photo"),previewUrl:"/storage/customfield/",modelValue:l.file,"onUpdate:modelValue":g=>l.file=g,error:t.errors["options."+f+".file"],class:"ltr:pr-6 rtl:pl-6 w-full lg:w-full"},null,8,["label","modelValue","onUpdate:modelValue","error"])):c("",!0),t.form.type==="ImageRadio"?(i(),y(v,{key:1,type:"file",accept:"image/*",label:e.$t("Preview"),previewUrl:"/storage/customfield/",modelValue:l.preview,"onUpdate:modelValue":g=>l.preview=g,error:t.errors["options."+f+".preview"],class:"ltr:pr-6 rtl:pl-6 w-full lg:w-full"},null,8,["label","modelValue","onUpdate:modelValue","error"])):c("",!0)],2))),128))]),r("div",de,[r("button",{type:"button",onClick:o[3]||(o[3]=(...l)=>d.addOption&&d.addOption(...l)),class:"bg-gray-700 px-3 py-1.5 rounded-md text-gray-50 hover:bg-gray-800"},ce),r("button",{type:"button",onClick:o[4]||(o[4]=(...l)=>d.removeOption&&d.removeOption(...l)),class:"bg-gray-700 px-3 py-1.5 rounded-md text-gray-50 hover:bg-gray-800"},ge)])],64)):c("",!0)]),r("div",we,[s(w,{modelValue:t.form.tag,"onUpdate:modelValue":o[5]||(o[5]=l=>t.form.tag=l),errors:(U=t.errors)==null?void 0:U.tag,class:"ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-full",label:e.$t("Tag")},null,8,["modelValue","errors","label"])]),r("div",he,[s(E,{label:e.$t("Description"),modelValue:t.form.description,"onUpdate:modelValue":o[6]||(o[6]=l=>t.form.description=l),error:(I=t.errors)==null?void 0:I.description,class:"ltr:pr-6 rtl:pl-6 pb-8 w-full"},null,8,["label","modelValue","error"])]),r("div",be,[s(M,{restore:t.restore,data:n.customField,permanentEnable:!1,model:"Product",routeM:"customfields",onCloseRestore:o[7]||(o[7]=()=>t.restore=!1)},null,8,["restore","data"]),s(_,{loading:t.sending,class:"btn-gray",type:"submit"},{default:h(()=>[b(p(e.$t("update_x",{x:e.$tc("custom_field")})),1)]),_:1},8,["loading"])])],32)])]),this.customField.tag?(i(),u("div",ve,[r("div",ye,[r("form",{onSubmit:o[10]||(o[10]=C((...l)=>d.submitPreview&&d.submitPreview(...l),["prevent"])),autocomplete:"off",class:"w-full"},[r("div",_e,[s(v,{type:"file",accept:"image/*",label:e.$t("customization_preview_x",{x:this.customField.tag}),modelValue:t.tagBackground,"onUpdate:modelValue":o[9]||(o[9]=l=>t.tagBackground=l),error:t.errors["options."+e.index+".file"],class:"w-full capitalize"},null,8,["label","modelValue","error"]),t.tagPreview?(i(),u("img",{key:0,src:t.tagPreview,class:"mt-8 w-1/2 mx-auto"},null,8,ke)):c("",!0),r("div",Ve,[s(_,{loading:t.sending,class:"btn-gray",type:"submit"},{default:h(()=>[b(p(e.$t("save_x",{x:e.$tc("preview_image")})),1)]),_:1},8,["loading"])])])],32)])])):c("",!0)])])}const Se=Q(X,[["render",xe]]);export{Se as default};
