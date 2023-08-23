import{F as pe}from"./FileInput.bfc636d8.js";import{T as ne}from"./TextInput.f4f909b7.js";import{C as me}from"./CheckboxInput.0509202e.js";import{T as ue}from"./TextareaInput.1737678e.js";import{L as ie}from"./LoadingButton.323ea2dd.js";import{_ as Ee,r as _,o as m,c as u,a as p,b as s,t as n,e as i,w as S,n as se,d as de,j as fe,T as _e,k as Ae,f as Ie}from"./app.d8289e67.js";import"./InputError.b5dfb222.js";import"./Input.954bfb09.js";const Me={remember:"form",props:{taxes:Array,account:Object,timezones:Array},components:{FileInput:pe,LoadingButton:ie,CheckboxInput:me,TextInput:ne,TextareaInput:ue},data(){return{errors:{},error:null,message:null,sending:!1,timezone:{label:"",value:""},form:{logo:null,name:this.account.name,email:this.account.email,phone:this.account.phone,address:this.account.address,gateways:this.account.gateways,header:this.account.header,footer:this.account.footer,fraction:this.account.fraction,per_page:this.account.per_page,language:this.account.language,direction:this.account.direction,default_tax:this.account.default_tax,default_locale:this.account.default_locale,APP_TIMEZONE:this.account.APP_TIMEZONE,MAIL_FROM_NAME:this.account.MAIL_FROM_NAME,MAIL_FROM_ADDRESS:this.account.MAIL_FROM_ADDRESS,MAIL_MAILER:this.account.MAIL_MAILER,MAIL_HOST:this.account.MAIL_HOST,MAIL_PORT:this.account.MAIL_PORT,MAIL_ENCRYPTION:this.account.MAIL_ENCRYPTION,MAIL_USERNAME:this.account.MAIL_USERNAME,MAIL_PASSWORD:this.account.MAIL_PASSWORD,STRIPE_KEY:this.account.STRIPE_KEY,STRIPE_SECRET:this.account.STRIPE_SECRET,STRIPE_CURRENCY:this.account.STRIPE_CURRENCY,PAYU_DEFAULT_GATEWAY:this.account.PAYU_DEFAULT_GATEWAY,PAYU_BIZ_KEY:this.account.PAYU_BIZ_KEY,PAYU_BIZ_SALT:this.account.PAYU_BIZ_SALT,PAYU_BIZ_MODE:this.account.PAYU_BIZ_MODE,PAYU_MONEY_KEY:this.account.PAYU_MONEY_KEY,PAYU_MONEY_SALT:this.account.PAYU_MONEY_SALT,PAYU_MONEY_AUTH:this.account.PAYU_MONEY_AUTH,PAYU_MONEY_MODE:this.account.PAYU_MONEY_MODE,SMS_FROM:this.account.SMS_FROM,VONAGE_KEY:this.account.VONAGE_KEY,VONAGE_SECRET:this.account.VONAGE_SECRET,VONAGE_SIGNATURE_SECRET:this.account.VONAGE_SIGNATURE_SECRET,VONAGE_APP_NAME:this.account.VONAGE_APP_NAME,VONAGE_APP_VERSION:this.account.VONAGE_APP_VERSION,MIRRORSIZE_API_KEY:this.account.MIRRORSIZE_API_KEY,MIRRORSIZE_MERCHANT_ID:this.account.MIRRORSIZE_MERCHANT_ID,MIRRORSIZE_USERNAME:this.account.MIRRORSIZE_USERNAME,MONEZIUM_SITE_KEY:this.account.MONEZIUM_SITE_KEY,MONEZIUM_SHOP_KEY:this.account.MONEZIUM_SHOP_KEY,SOCKET_SERVER_URL:this.account.SOCKET_SERVER_URL,MAILGUN_DOMAIN:this.account.MAILGUN_DOMAIN,MAILGUN_SECRET:this.account.MAILGUN_SECRET,MAILGUN_ENDPOINT:this.account.MAILGUN_ENDPOINT,POSTMARK_TOKEN:this.account.POSTMARK_TOKEN,AWS_ACCESS_KEY_ID:this.account.AWS_ACCESS_KEY_ID,AWS_SECRET_ACCESS_KEY:this.account.AWS_SECRET_ACCESS_KEY,AWS_DEFAULT_REGION:this.account.AWS_DEFAULT_REGION,stripe:this.account.stripe==1,payu:this.account.payu==1,sms_enabled:this.account.sms_enabled==1,email_enabled:this.account.email_enabled==1,notifications:this.account.notifications==1},tax:null,language:null}},watch:{timezone:function(e){e&&e.value&&(this.form.APP_TIMEZONE=e.value)}},mounted(){this.account.default_tax&&(this.tax=this.taxes.find(e=>e.value==this.account.default_tax)),this.account.language&&(this.language=this.$page.props.locales.find(e=>e.value==this.account.language)),this.form.APP_TIMEZONE&&(this.timezone=this.timezones.find(e=>e.value==this.form.APP_TIMEZONE))},methods:{taxChanged(e){this.tax=e||null,this.form.default_tax=e?e.value:null},langChanged(e){this.language=e||null,this.form.language=e?e.value:null},submit(){this.sending=!0;var e=new FormData;e.append("logo",this.form.logo||""),e.append("name",this.form.name||""),e.append("email",this.form.email||""),e.append("phone",this.form.phone||""),e.append("address",this.form.address||""),e.append("gateways",this.form.gateways||""),e.append("header",this.form.header||""),e.append("footer",this.form.footer||""),e.append("per_page",this.form.per_page||""),e.append("language",this.form.language||""),e.append("direction",this.form.direction||""),e.append("fraction",this.form.fraction||2),e.append("default_tax",this.form.default_tax||""),e.append("default_locale",this.form.default_locale||""),e.append("APP_TIMEZONE",this.form.APP_TIMEZONE||""),e.append("MAIL_MAILER",this.form.MAIL_MAILER||""),e.append("MAIL_HOST",this.form.MAIL_HOST||""),e.append("MAIL_PORT",this.form.MAIL_PORT||""),e.append("MAIL_ENCRYPTION",this.form.MAIL_ENCRYPTION||""),e.append("MAIL_USERNAME",this.form.MAIL_USERNAME||""),e.append("MAIL_PASSWORD",this.form.MAIL_PASSWORD||""),e.append("MAIL_FROM_NAME",this.form.MAIL_FROM_NAME||""),e.append("MAIL_FROM_ADDRESS",this.form.MAIL_FROM_ADDRESS||""),e.append("STRIPE_KEY",this.form.STRIPE_KEY||""),e.append("STRIPE_SECRET",this.form.STRIPE_SECRET||""),e.append("STRIPE_CURRENCY",this.form.STRIPE_CURRENCY||""),e.append("PAYU_DEFAULT_GATEWAY",this.form.PAYU_DEFAULT_GATEWAY||""),e.append("PAYU_BIZ_KEY",this.form.PAYU_BIZ_KEY||""),e.append("PAYU_BIZ_SALT",this.form.PAYU_BIZ_SALT||""),e.append("PAYU_BIZ_MODE",this.form.PAYU_BIZ_MODE||""),e.append("PAYU_MONEY_KEY",this.form.PAYU_MONEY_KEY||""),e.append("PAYU_MONEY_SALT",this.form.PAYU_MONEY_SALT||""),e.append("PAYU_MONEY_AUTH",this.form.PAYU_MONEY_AUTH||""),e.append("PAYU_MONEY_MODE",this.form.PAYU_MONEY_MODE||""),e.append("SMS_FROM",this.form.SMS_FROM||""),e.append("VONAGE_KEY",this.form.VONAGE_KEY||""),e.append("VONAGE_SECRET",this.form.VONAGE_SECRET||""),e.append("VONAGE_SIGNATURE_SECRET",this.form.VONAGE_SIGNATURE_SECRET||""),e.append("MAILGUN_DOMAIN",this.form.MAILGUN_DOMAIN||""),e.append("MAILGUN_SECRET",this.form.MAILGUN_SECRET||""),e.append("MAILGUN_ENDPOINT",this.form.MAILGUN_ENDPOINT||""),e.append("service_postmark_postmark",this.form.service_postmark_postmark||""),e.append("AWS_ACCESS_KEY_ID",this.form.AWS_ACCESS_KEY_ID||""),e.append("AWS_SECRET_ACCESS_KEY",this.form.AWS_SECRET_ACCESS_KEY||""),e.append("AWS_DEFAULT_REGION",this.form.AWS_DEFAULT_REGION||""),e.append("MIRRORSIZE_API_KEY",this.form.MIRRORSIZE_API_KEY||""),e.append("MIRRORSIZE_MERCHANT_ID",this.form.MIRRORSIZE_MERCHANT_ID||""),e.append("MIRRORSIZE_USERNAME",this.form.MIRRORSIZE_USERNAME||""),e.append("MONEZIUM_SITE_KEY",this.form.MONEZIUM_SITE_KEY||""),e.append("MONEZIUM_SHOP_KEY",this.form.MONEZIUM_SHOP_KEY||""),e.append("SOCKET_SERVER_URL",this.form.SOCKET_SERVER_URL||""),e.append("payu",!!this.form.payu),e.append("stripe",!!this.form.stripe),e.append("sms_enabled",!!this.form.sms_enabled),e.append("email_enabled",!!this.form.email_enabled),e.append("_method","put"),this.$axios.post(route("settings.update"),e).then(r=>{this.sending=!1,r.data.success&&(this.$page.props.flash.success=r.data.message,this.form.logo=null,this.$nextTick(()=>{document.body.dir=this.form.direction,document.getElementById("page-contents").scrollTop=0,this.$page.props.user.account.direction=this.form.direction,this.$i18n.global.locale=this.form.language}))}).catch(r=>{this.sending=!1,this.$page.props.flash.error=r.response.data.message,r.response.data.errors&&(this.errors=r.response.data.errors),this.$nextTick(()=>{document.getElementById("page-contents").scrollTop=0})})}}},Se={class:"bg-white rounded shadow overflow-hidden max-w-3xl"},Re={class:"p-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap"},ge={class:"ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2"},be={class:"form-label",for:"fraction"},Oe={key:0,class:"form-error"},Ne={class:"ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2"},Te={class:"form-label",for:"default_tax"},Ve={key:0,class:"form-error"},Ue={key:0,class:"mb-4 ltr:mr-6 rtl:ml-6 p-4 w-full border rounded text-center"},he=["src","alt"],Pe={class:"ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2"},ce={class:"form-label",for:"language"},Le={key:0,class:"form-error"},Ye={class:"ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2"},Ce={class:"form-label",for:"direction"},we={class:"uppercase"},De={key:0,class:"form-error"},Ke=p("div",{class:"w-full"},null,-1),Ge={class:"ltr:pr-6 rtl:pl-6 pb-8 w-full"},Ze={class:"form-label",for:"timezone"},ye={key:0,class:"form-error"},ve={class:"ltr:pr-6 rtl:pl-6 pb-8 w-full"},ke={class:"form-label",for:"mail_driver"},Fe={key:0,class:"form-error"},We=p("div",{class:"w-full"},null,-1),He={class:"ml-3 mt-2 w-full",key:"postmark"},Be={class:"ml-3 mt-2 flex flex-wrap w-full",key:"mailgun"},ze={class:"ml-3 mt-2 flex flex-wrap w-full",key:"ses"},$e={class:"ml-3 mt-2 flex flex-wrap w-full",key:"smtp"},je={class:"flex items-center flex-wrap mb-6 gap-x-6"},qe={class:"text-sm mb-2"},Je={class:"mb-8 -mt-2 text-xs font-bold text-orange-600"},Qe={class:"px-8 -mt-8 mb-10 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 flex flex-wrap"},Xe={key:0,class:"w-full mt-6"},xe={class:"px-8 py-4 bg-gray-100 border-t border-gray-200 flex items-center"};function el(e,r,A,ll,l,d){var b,O,N,T,V,U,h,P,c,L,Y,C,w,D,K,G,Z,y,v,k,F,W,H,B,z,$,j,q;const t=_("text-input"),f=_("v-select"),te=_("file-input"),g=_("textarea-input"),R=_("checkbox-input"),ae=_("loading-button");return m(),u("div",Se,[p("form",{onSubmit:r[45]||(r[45]=Ae((...o)=>d.submit&&d.submit(...o),["prevent"])),autocomplete:"off"},[p("div",Re,[s(t,{modelValue:l.form.name,"onUpdate:modelValue":r[0]||(r[0]=o=>l.form.name=o),errors:(b=e.$page.props.errors)==null?void 0:b.name,class:"ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2",label:e.$t("Name")},null,8,["modelValue","errors","label"]),s(t,{label:e.$t("Phone"),modelValue:l.form.phone,"onUpdate:modelValue":r[1]||(r[1]=o=>l.form.phone=o),errors:(O=e.$page.props.errors)==null?void 0:O.phone,class:"ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2"},null,8,["label","modelValue","errors"]),s(t,{label:e.$t("Email"),modelValue:l.form.email,"onUpdate:modelValue":r[2]||(r[2]=o=>l.form.email=o),errors:(N=e.$page.props.errors)==null?void 0:N.email,class:"ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2"},null,8,["label","modelValue","errors"]),s(t,{min:"10",max:"100",type:"number",modelValue:l.form.per_page,"onUpdate:modelValue":r[3]||(r[3]=o=>l.form.per_page=o),label:e.$t("Record per page"),errors:(T=e.$page.props.errors)==null?void 0:T.per_page,class:"ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2"},null,8,["modelValue","label","errors"]),p("div",ge,[p("label",be,n(e.$t("Decimals")),1),s(f,{transition:"",clearable:!1,"input-id":"fraction",modelValue:l.form.fraction,"onUpdate:modelValue":r[4]||(r[4]=o=>l.form.fraction=o),options:[0,1,2,3,4],dir:e.$page.props.user.account.direction,placeholder:e.$t("select_x",{x:e.$t("Decimals")})},null,8,["modelValue","dir","placeholder"]),(V=e.$page.props.errors)!=null&&V.fraction?(m(),u("div",Oe,n(l.errors.fraction[0]),1)):i("",!0)]),s(te,{type:"file",accept:"image/*",label:e.$t("Logo"),modelValue:l.form.logo,"onUpdate:modelValue":r[5]||(r[5]=o=>l.form.logo=o),errors:(U=e.$page.props.errors)==null?void 0:U.logo,class:"ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2"},null,8,["label","modelValue","errors"]),p("div",Ne,[p("label",Te,n(e.$t("Default Tax")),1),s(f,{value:l.tax,transition:"",options:A.taxes,onInput:d.taxChanged,"input-id":"default_tax","onOption:selected":d.taxChanged,dir:e.$page.props.user.account.direction,placeholder:e.$t("select_x",{x:e.$t("Default Tax")})},null,8,["value","options","onInput","onOption:selected","dir","placeholder"]),(h=e.$page.props.errors)!=null&&h.default_tax?(m(),u("div",Ve,n(l.errors.default_tax[0]),1)):i("",!0)]),A.account.logo_path?(m(),u("div",Ue,[p("img",{src:`/storage/account/${A.account.logo_path}`,alt:A.account.name},null,8,he)])):i("",!0),p("div",Pe,[p("label",ce,n(e.$t("Language")),1),s(f,{transition:"",modelValue:l.language,"onUpdate:modelValue":r[6]||(r[6]=o=>l.language=o),clearable:!1,"input-id":"language",onInput:d.langChanged,"onOption:selected":d.langChanged,options:e.$page.props.locales,dir:e.$page.props.user.account.direction,placeholder:e.$t("select_x",{x:e.$t("Language")})},null,8,["modelValue","onInput","onOption:selected","options","dir","placeholder"]),(P=e.$page.props.errors)!=null&&P.language?(m(),u("div",Le,n(l.errors.language[0]),1)):i("",!0)]),s(t,{type:"text",modelValue:l.form.default_locale,"onUpdate:modelValue":r[7]||(r[7]=o=>l.form.default_locale=o),label:e.$t("Locale for date & number"),errors:(c=e.$page.props.errors)==null?void 0:c.default_locale,class:"ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2"},null,8,["modelValue","label","errors"]),p("div",Ye,[p("label",Ce,n(e.$t("Direction")),1),s(f,{transition:"",clearable:!1,"input-id":"direction",modelValue:l.form.direction,"onUpdate:modelValue":r[8]||(r[8]=o=>l.form.direction=o),options:["ltr","rtl"],dir:e.$page.props.user.account.direction,placeholder:e.$t("select_x",{x:e.$t("Direction")})},{option:S(({label:o})=>[p("span",we,n(o),1)]),_:1},8,["modelValue","dir","placeholder"]),(L=e.$page.props.errors)!=null&&L.direction?(m(),u("div",De,n(l.errors.direction[0]),1)):i("",!0)]),s(t,{label:e.$t("Gateways"),modelValue:l.form.gateways,"onUpdate:modelValue":r[9]||(r[9]=o=>l.form.gateways=o),errors:(Y=e.$page.props.errors)==null?void 0:Y.gateways,class:"ltr:pr-6 rtl:pl-6 pb-8 w-full"},null,8,["label","modelValue","errors"]),s(t,{modelValue:l.form.address,"onUpdate:modelValue":r[10]||(r[10]=o=>l.form.address=o),errors:(C=e.$page.props.errors)==null?void 0:C.address,class:"ltr:pr-6 rtl:pl-6 pb-8 w-full",label:e.$t("Address")},null,8,["modelValue","errors","label"]),s(g,{modelValue:l.form.header,"onUpdate:modelValue":r[11]||(r[11]=o=>l.form.header=o),errors:(w=e.$page.props.errors)==null?void 0:w.header,class:"ltr:pr-6 rtl:pl-6 pb-8 w-full",label:e.$t("Order Header")},null,8,["modelValue","errors","label"]),s(g,{modelValue:l.form.footer,"onUpdate:modelValue":r[12]||(r[12]=o=>l.form.footer=o),errors:(D=e.$page.props.errors)==null?void 0:D.footer,class:"ltr:pr-6 rtl:pl-6 pb-8 w-full",label:e.$t("Order Footer")},null,8,["modelValue","errors","label"]),Ke,p("div",Ge,[p("label",Ze,n(e.$t("Timezone")),1),s(f,{clearable:!1,modelValue:l.timezone,"onUpdate:modelValue":r[13]||(r[13]=o=>l.timezone=o),options:A.timezones,dir:e.$page.props.user.account.direction,placeholder:e.$t("select_x",{x:e.$t("Timezone")}),class:se({error:l.errors.APP_TIMEZONE&&l.errors.APP_TIMEZONE.length})},{option:S(o=>[(m(),u("span",{class:"text-sm",key:o.value},n(o.label),1))]),_:1},8,["modelValue","options","dir","placeholder","class"]),(K=e.$page.props.errors)!=null&&K.APP_TIMEZONE?(m(),u("div",ye,n(l.errors.APP_TIMEZONE[0]),1)):i("",!0)]),s(t,{label:e.$t("From Name"),modelValue:l.form.MAIL_FROM_NAME,"onUpdate:modelValue":r[14]||(r[14]=o=>l.form.MAIL_FROM_NAME=o),errors:(G=e.$page.props.errors)==null?void 0:G.MAIL_FROM_NAME,class:"ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2"},null,8,["label","modelValue","errors"]),s(t,{label:e.$t("From Email"),modelValue:l.form.MAIL_FROM_ADDRESS,"onUpdate:modelValue":r[15]||(r[15]=o=>l.form.MAIL_FROM_ADDRESS=o),errors:(Z=e.$page.props.errors)==null?void 0:Z.MAIL_FROM_ADDRESS,class:"ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2"},null,8,["label","modelValue","errors"]),p("div",ve,[p("label",ke,n(e.$t("Mail Driver")),1),s(f,{searchable:!1,clearable:!1,filterable:!1,modelValue:l.form.MAIL_MAILER,"onUpdate:modelValue":r[16]||(r[16]=o=>l.form.MAIL_MAILER=o),dir:e.$page.props.user.account.direction,options:["smtp","mailgun","postmark","ses"],placeholder:e.$t("select_x",{x:e.$t("Mail Driver")}),class:se({error:l.errors.MAIL_MAILER&&l.errors.MAIL_MAILER.length})},null,8,["modelValue","dir","placeholder","class"]),(y=e.$page.props.errors)!=null&&y.MAIL_MAILER?(m(),u("div",Fe,n(l.errors.MAIL_MAILER[0]),1)):i("",!0)]),We,l.form.MAIL_MAILER?(m(),de(fe,{key:1,tag:"div",name:"slide-fade",class:"w-full bg-gray-200 rounded border px-4 pt-4 mb-6 ltr:mr-6 rtl:ml-6"},{default:S(()=>{var o,I,M,E,J,Q,X,x,ee,le,re,oe;return[l.form.MAIL_MAILER=="postmark"?(m(),u("div",He,[s(t,{class:"ltr:pr-6 rtl:pl-6 pb-8 w-full",label:e.$t("Postmark Token"),modelValue:l.form.POSTMARK_TOKEN,"onUpdate:modelValue":r[17]||(r[17]=a=>l.form.POSTMARK_TOKEN=a),errors:(o=e.$page.props.errors)==null?void 0:o.POSTMARK_TOKEN},null,8,["label","modelValue","errors"])])):l.form.MAIL_MAILER=="mailgun"?(m(),u("div",Be,[s(t,{modelValue:l.form.MAILGUN_DOMAIN,"onUpdate:modelValue":r[18]||(r[18]=a=>l.form.MAILGUN_DOMAIN=a),errors:(I=e.$page.props.errors)==null?void 0:I.MAILGUN_DOMAIN,class:"ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2",label:e.$t("Mailgun Domain")},null,8,["modelValue","errors","label"]),s(t,{modelValue:l.form.MAILGUN_SECRET,"onUpdate:modelValue":r[19]||(r[19]=a=>l.form.MAILGUN_SECRET=a),errors:(M=e.$page.props.errors)==null?void 0:M.MAILGUN_SECRET,class:"ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2",label:e.$t("Mailgun Secret")},null,8,["modelValue","errors","label"]),s(t,{modelValue:l.form.MAILGUN_ENDPOINT,"onUpdate:modelValue":r[20]||(r[20]=a=>l.form.MAILGUN_ENDPOINT=a),errors:(E=e.$page.props.errors)==null?void 0:E.MAILGUN_ENDPOINT,class:"ltr:pr-6 rtl:pl-6 pb-8 w-full",label:e.$t("Mailgun Endpoint")},null,8,["modelValue","errors","label"])])):l.form.MAIL_MAILER=="ses"?(m(),u("div",ze,[s(t,{modelValue:l.form.AWS_ACCESS_KEY_ID,"onUpdate:modelValue":r[21]||(r[21]=a=>l.form.AWS_ACCESS_KEY_ID=a),errors:(J=e.$page.props.errors)==null?void 0:J.AWS_ACCESS_KEY_ID,class:"ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2",label:e.$t("SES Key")},null,8,["modelValue","errors","label"]),s(t,{modelValue:l.form.AWS_SECRET_ACCESS_KEY,"onUpdate:modelValue":r[22]||(r[22]=a=>l.form.AWS_SECRET_ACCESS_KEY=a),errors:(Q=e.$page.props.errors)==null?void 0:Q.AWS_SECRET_ACCESS_KEY,class:"ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2",label:e.$t("SES Secret")},null,8,["modelValue","errors","label"]),s(t,{modelValue:l.form.AWS_DEFAULT_REGION,"onUpdate:modelValue":r[23]||(r[23]=a=>l.form.AWS_DEFAULT_REGION=a),errors:(X=e.$page.props.errors)==null?void 0:X.AWS_DEFAULT_REGION,class:"ltr:pr-6 rtl:pl-6 pb-8 w-full",label:e.$t("SES Region")},null,8,["modelValue","errors","label"])])):l.form.MAIL_MAILER=="smtp"?(m(),u("div",$e,[s(t,{modelValue:l.form.MAIL_HOST,"onUpdate:modelValue":r[24]||(r[24]=a=>l.form.MAIL_HOST=a),errors:(x=e.$page.props.errors)==null?void 0:x.MAIL_HOST,class:"ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-2/4",label:e.$t("SMTP Host")},null,8,["modelValue","errors","label"]),s(t,{modelValue:l.form.MAIL_PORT,"onUpdate:modelValue":r[25]||(r[25]=a=>l.form.MAIL_PORT=a),errors:(ee=e.$page.props.errors)==null?void 0:ee.MAIL_PORT,class:"ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/4",label:e.$t("SMTP Port")},null,8,["modelValue","errors","label"]),s(t,{label:e.$t("Encryption"),modelValue:l.form.MAIL_ENCRYPTION,"onUpdate:modelValue":r[26]||(r[26]=a=>l.form.MAIL_ENCRYPTION=a),class:"ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/4",errors:(le=e.$page.props.errors)==null?void 0:le.MAIL_ENCRYPTION},null,8,["label","modelValue","errors"]),s(t,{label:e.$t("SMTP Username"),modelValue:l.form.MAIL_USERNAME,"onUpdate:modelValue":r[27]||(r[27]=a=>l.form.MAIL_USERNAME=a),class:"ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2",errors:(re=e.$page.props.errors)==null?void 0:re.MAIL_USERNAME},null,8,["label","modelValue","errors"]),s(t,{label:e.$t("SMTP Password"),modelValue:l.form.MAIL_PASSWORD,"onUpdate:modelValue":r[28]||(r[28]=a=>l.form.MAIL_PASSWORD=a),class:"ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2",errors:(oe=e.$page.props.errors)==null?void 0:oe.MAIL_PASSWORD},null,8,["label","modelValue","errors"])])):i("",!0)]}),_:1})):i("",!0),s(t,{modelValue:l.form.VONAGE_KEY,"onUpdate:modelValue":r[29]||(r[29]=o=>l.form.VONAGE_KEY=o),label:e.$t("Vonage API Key"),class:"ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2",errors:(v=e.$page.props.errors)==null?void 0:v.VONAGE_KEY},null,8,["modelValue","label","errors"]),s(t,{modelValue:l.form.VONAGE_SECRET,"onUpdate:modelValue":r[30]||(r[30]=o=>l.form.VONAGE_SECRET=o),label:e.$t("Vonage API Secret"),class:"ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2",errors:(k=e.$page.props.errors)==null?void 0:k.VONAGE_SECRET},null,8,["modelValue","label","errors"]),s(t,{modelValue:l.form.SMS_FROM,"onUpdate:modelValue":r[31]||(r[31]=o=>l.form.SMS_FROM=o),label:e.$t("Vonage SMS From"),class:"ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2",errors:(F=e.$page.props.errors)==null?void 0:F.SMS_FROM},null,8,["modelValue","label","errors"]),s(t,{label:e.$t("Vonage Signature Secret"),modelValue:l.form.VONAGE_SIGNATURE_SECRET,"onUpdate:modelValue":r[32]||(r[32]=o=>l.form.VONAGE_SIGNATURE_SECRET=o),class:"ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2",errors:(W=e.$page.props.errors)==null?void 0:W.VONAGE_SIGNATURE_SECRET},null,8,["label","modelValue","errors"]),s(t,{modelValue:l.form.MIRRORSIZE_MERCHANT_ID,"onUpdate:modelValue":r[33]||(r[33]=o=>l.form.MIRRORSIZE_MERCHANT_ID=o),label:e.$t("Mirrorsize Merchant ID"),class:"ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2",errors:(H=e.$page.props.errors)==null?void 0:H.MIRRORSIZE_MERCHANT_ID},null,8,["modelValue","label","errors"]),s(t,{modelValue:l.form.MIRRORSIZE_USERNAME,"onUpdate:modelValue":r[34]||(r[34]=o=>l.form.MIRRORSIZE_USERNAME=o),label:e.$t("Mirrorsize Username"),class:"ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2",errors:(B=e.$page.props.errors)==null?void 0:B.MIRRORSIZE_USERNAME},null,8,["modelValue","label","errors"]),s(t,{modelValue:l.form.MIRRORSIZE_API_KEY,"onUpdate:modelValue":r[35]||(r[35]=o=>l.form.MIRRORSIZE_API_KEY=o),label:e.$t("Mirrorsize API Key"),class:"ltr:pr-6 rtl:pl-6 pb-8 w-full",errors:(z=e.$page.props.errors)==null?void 0:z.MIRRORSIZE_API_KEY},null,8,["modelValue","label","errors"]),s(t,{modelValue:l.form.MONEZIUM_SITE_KEY,"onUpdate:modelValue":r[36]||(r[36]=o=>l.form.MONEZIUM_SITE_KEY=o),label:e.$t("Monezium Site Key"),class:"ltr:pr-6 rtl:pl-6 pb-8 w-full",errors:($=e.$page.props.errors)==null?void 0:$.MONEZIUM_SITE_KEY},null,8,["modelValue","label","errors"]),s(t,{modelValue:l.form.MONEZIUM_SHOP_KEY,"onUpdate:modelValue":r[37]||(r[37]=o=>l.form.MONEZIUM_SHOP_KEY=o),label:e.$t("Monezium Shop Key"),class:"ltr:pr-6 rtl:pl-6 pb-8 w-full",errors:(j=e.$page.props.errors)==null?void 0:j.MONEZIUM_SHOP_KEY},null,8,["modelValue","label","errors"]),s(t,{modelValue:l.form.SOCKET_SERVER_URL,"onUpdate:modelValue":r[38]||(r[38]=o=>l.form.SOCKET_SERVER_URL=o),label:e.$t("Socket Server Url"),class:"ltr:pr-6 rtl:pl-6 pb-8 w-full",errors:(q=e.$page.props.errors)==null?void 0:q.SOCKET_SERVER_URL},null,8,["modelValue","label","errors"]),p("div",je,[p("p",qe,n(e.$t("Enable Auto Notifications")),1),s(R,{class:"mb-2",id:"email_enabled",label:e.$t("By Email"),checked:l.form.email_enabled,"onUpdate:checked":r[39]||(r[39]=o=>l.form.email_enabled=o)},null,8,["label","checked"]),s(R,{class:"mb-2",id:"sms_enabled",label:e.$t("By SMS"),checked:l.form.sms_enabled,"onUpdate:checked":r[40]||(r[40]=o=>l.form.sms_enabled=o)},null,8,["label","checked"])]),p("p",Je,n(e.$t("confirm_vonage_setting")),1)]),p("div",Qe,[s(R,{id:"stripe",class:"mb-2",checked:l.form.stripe,"onUpdate:checked":r[41]||(r[41]=o=>l.form.stripe=o),label:e.$t("Enable Stripe Payments")},null,8,["checked","label"]),s(_e,{name:"slide-fade",class:"w-full bg-gray-200 rounded border px-4 pt-4 mb-6 ltr:mr-6 rtl:ml-6"},{default:S(()=>{var o,I,M;return[l.form.stripe?(m(),u("div",Xe,[s(t,{modelValue:l.form.STRIPE_KEY,"onUpdate:modelValue":r[42]||(r[42]=E=>l.form.STRIPE_KEY=E),errors:(o=e.$page.props.errors)==null?void 0:o.STRIPE_KEY,class:"ltr:pr-6 rtl:pl-6 pb-8 w-full",label:e.$t("Stripe Publishable Key")},null,8,["modelValue","errors","label"]),s(t,{modelValue:l.form.STRIPE_SECRET,"onUpdate:modelValue":r[43]||(r[43]=E=>l.form.STRIPE_SECRET=E),errors:(I=e.$page.props.errors)==null?void 0:I.STRIPE_SECRET,class:"ltr:pr-6 rtl:pl-6 pb-8 w-full",label:e.$t("Stripe Secret Key")},null,8,["modelValue","errors","label"]),s(t,{modelValue:l.form.STRIPE_CURRENCY,"onUpdate:modelValue":r[44]||(r[44]=E=>l.form.STRIPE_CURRENCY=E),errors:(M=e.$page.props.errors)==null?void 0:M.STRIPE_CURRENCY,class:"ltr:pr-6 rtl:pl-6 pb-8 w-full",label:e.$t("Stripe Currency (ISO code, USD, EUR etc)")},null,8,["modelValue","errors","label"])])):i("",!0)]}),_:1})]),p("div",xe,[s(ae,{loading:l.sending,class:"btn-gray ltr:ml-auto rtl:mr-auto",type:"submit"},{default:S(()=>[Ie(n(e.$t("update_x",{x:e.$tc("Setting",2)})),1)]),_:1},8,["loading"])])],32)])}const ul=Ee(Me,[["render",el]]);export{ul as default};
