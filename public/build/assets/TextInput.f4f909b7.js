import{T as m,a as f}from"./InputError.b5dfb222.js";import{T as b}from"./Input.954bfb09.js";import{_ as y,v as _,r as a,o as n,c as g,d as o,e as s,b as p,n as i}from"./app.d8289e67.js";const v={emits:["update:modelValue"],components:{TecLabel:m,TecInput:b,TecInputError:f},props:{id:{type:String,default(){return _()}},type:{type:String,default:"text"},enableFloat:{type:Boolean,default:!1},size:String,label:String,disabled:Boolean,readonly:Boolean,placeholder:String,errors:String,modelValue:[String,Number]},methods:{focus(){this.$refs.input.focus()},select(){this.$refs.input.select()},setSelectionRange(l,t){this.$refs.input.setSelectionRange(l,t)}}};function S(l,t,e,T,h,k){const u=a("tec-label"),c=a("tec-input"),d=a("tec-input-error");return n(),g("div",{class:i(["col-span-6 sm:col-span-4 relative",{"mb-2":e.size!="small"}])},[e.label?(n(),o(u,{key:0,for:e.id,value:e.label},null,8,["for","value"])):s("",!0),p(c,{id:e.id,ref:"input",type:e.type,disabled:e.disabled,readonly:e.readonly,value:e.modelValue,step:e.enableFloat?.01:1,class:i(["block w-full",{"border-red-500 input-error":e.errors,"py-0 pr-0 h-8":e.size=="small","mt-1":e.label}]),onFocus:t[0]||(t[0]=r=>l.$emit("focus")),placeholder:e.placeholder||e.label,onInput:t[1]||(t[1]=r=>l.$emit("update:modelValue",r.target.value))},null,8,["id","type","disabled","readonly","value","step","placeholder","class"]),e.errors?(n(),o(d,{key:1,message:Array.isArray(e.errors)?e.errors.join(", "):e.errors},null,8,["message"])):s("",!0)],2)}const I=y(v,[["render",S]]);export{I as T};
