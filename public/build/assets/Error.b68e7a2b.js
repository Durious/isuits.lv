import{_ as i,o as n,c,a as t,t as s}from"./app.d8289e67.js";const d={props:{status:Number},computed:{title(){return{403:this.$t("403: Forbidden"),419:this.$t("419: Page Expired"),500:this.$t("500: Server Error"),404:this.$t("404: Page Not Found"),503:this.$t("503: Service Unavailable")}[this.status]},description(){return{500:this.$t("Whoops, something went wrong on our servers."),419:this.$t("Whoops, please refresh the page then try again."),403:this.$t("Sorry, you are forbidden from accessing this page."),404:this.$t("Sorry, the page you are looking for could not be found."),503:this.$t("Sorry, we are doing some maintenance. Please check back soon.")}[this.status]}},methods:{goBack(){window?history.back():this.$inertia.visit(this.route("dashboard"))}}},h={class:"w-full min-h-screen flex items-center p-6 bg-gradient-gray"},l={class:"w-full max-w-sm mx-auto bg-white text-gray-700 rounded shadow-lg leading-normal"},g={class:"p-4"},u={class:"font-bold"},p={class:"text-sm mt-2"};function m(r,o,b,f,_,e){return n(),c("div",h,[t("div",l,[t("div",g,[t("h4",u,s(e.title),1),t("h4",p,s(e.description),1)]),t("button",{type:"button",onClick:o[0]||(o[0]=(...a)=>e.goBack&&e.goBack(...a)),class:"px-4 py-2 w-full text-sm rounded-b border-t border-gray-200 bg-gray-200 hover:bg-gray-300"},s(r.$t("Go Back")),1)])])}const $=i(d,[["render",m]]);export{$ as default};
