"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[765],{3905:function(e,t,n){n.d(t,{Zo:function(){return s},kt:function(){return d}});var r=n(7294);function a(e,t,n){return t in e?Object.defineProperty(e,t,{value:n,enumerable:!0,configurable:!0,writable:!0}):e[t]=n,e}function o(e,t){var n=Object.keys(e);if(Object.getOwnPropertySymbols){var r=Object.getOwnPropertySymbols(e);t&&(r=r.filter((function(t){return Object.getOwnPropertyDescriptor(e,t).enumerable}))),n.push.apply(n,r)}return n}function i(e){for(var t=1;t<arguments.length;t++){var n=null!=arguments[t]?arguments[t]:{};t%2?o(Object(n),!0).forEach((function(t){a(e,t,n[t])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(n)):o(Object(n)).forEach((function(t){Object.defineProperty(e,t,Object.getOwnPropertyDescriptor(n,t))}))}return e}function l(e,t){if(null==e)return{};var n,r,a=function(e,t){if(null==e)return{};var n,r,a={},o=Object.keys(e);for(r=0;r<o.length;r++)n=o[r],t.indexOf(n)>=0||(a[n]=e[n]);return a}(e,t);if(Object.getOwnPropertySymbols){var o=Object.getOwnPropertySymbols(e);for(r=0;r<o.length;r++)n=o[r],t.indexOf(n)>=0||Object.prototype.propertyIsEnumerable.call(e,n)&&(a[n]=e[n])}return a}var p=r.createContext({}),u=function(e){var t=r.useContext(p),n=t;return e&&(n="function"==typeof e?e(t):i(i({},t),e)),n},s=function(e){var t=u(e.components);return r.createElement(p.Provider,{value:t},e.children)},c={inlineCode:"code",wrapper:function(e){var t=e.children;return r.createElement(r.Fragment,{},t)}},m=r.forwardRef((function(e,t){var n=e.components,a=e.mdxType,o=e.originalType,p=e.parentName,s=l(e,["components","mdxType","originalType","parentName"]),m=u(n),d=a,f=m["".concat(p,".").concat(d)]||m[d]||c[d]||o;return n?r.createElement(f,i(i({ref:t},s),{},{components:n})):r.createElement(f,i({ref:t},s))}));function d(e,t){var n=arguments,a=t&&t.mdxType;if("string"==typeof e||a){var o=n.length,i=new Array(o);i[0]=m;var l={};for(var p in t)hasOwnProperty.call(t,p)&&(l[p]=t[p]);l.originalType=e,l.mdxType="string"==typeof e?e:a,i[1]=l;for(var u=2;u<o;u++)i[u]=n[u];return r.createElement.apply(null,i)}return r.createElement.apply(null,n)}m.displayName="MDXCreateElement"},7031:function(e,t,n){n.r(t),n.d(t,{frontMatter:function(){return l},contentTitle:function(){return p},metadata:function(){return u},toc:function(){return s},default:function(){return m}});var r=n(7462),a=n(3366),o=(n(7294),n(3905)),i=["components"],l={sidebar_position:2},p="Props",u={unversionedId:"Common/props",id:"Common/props",isDocsHomePage:!1,title:"Props",description:"Overview",source:"@site/docs/Common/props.md",sourceDirName:"Common",slug:"/Common/props",permalink:"/roact-spring/docs/Common/props",editUrl:"https://github.com/chriscerie/roact-spring/edit/master/docs/Common/props.md",tags:[],version:"current",sidebarPosition:2,frontMatter:{sidebar_position:2},sidebar:"defaultSidebar",previous:{title:"Introduction",permalink:"/roact-spring/docs/intro"},next:{title:"Configs",permalink:"/roact-spring/docs/Common/configs"}},s=[{value:"Overview",id:"overview",children:[],level:2},{value:"Default props",id:"default-props",children:[{value:"Imperative updates",id:"imperative-updates",children:[],level:3},{value:"Compatible props",id:"compatible-props",children:[],level:3}],level:2}],c={toc:s};function m(e){var t=e.components,n=(0,a.Z)(e,i);return(0,o.kt)("wrapper",(0,r.Z)({},c,n,{components:t,mdxType:"MDXLayout"}),(0,o.kt)("h1",{id:"props"},"Props"),(0,o.kt)("h2",{id:"overview"},"Overview"),(0,o.kt)("pre",null,(0,o.kt)("code",{parentName:"pre",className:"language-lua"},"RoactSpring.useSpring(hooks, {\n    from = { ... }\n})\n")),(0,o.kt)("p",null,"All primitives inherit the following properties (though some of them may bring their own additionally):"),(0,o.kt)("table",null,(0,o.kt)("thead",{parentName:"table"},(0,o.kt)("tr",{parentName:"thead"},(0,o.kt)("th",{parentName:"tr",align:null},"Property"),(0,o.kt)("th",{parentName:"tr",align:null},"Type"),(0,o.kt)("th",{parentName:"tr",align:null},"Description"))),(0,o.kt)("tbody",{parentName:"table"},(0,o.kt)("tr",{parentName:"tbody"},(0,o.kt)("td",{parentName:"tr",align:null},"from"),(0,o.kt)("td",{parentName:"tr",align:null},"table"),(0,o.kt)("td",{parentName:"tr",align:null},"Starting values")),(0,o.kt)("tr",{parentName:"tbody"},(0,o.kt)("td",{parentName:"tr",align:null},"to"),(0,o.kt)("td",{parentName:"tr",align:null},"table"),(0,o.kt)("td",{parentName:"tr",align:null},"Animates to ...")),(0,o.kt)("tr",{parentName:"tbody"},(0,o.kt)("td",{parentName:"tr",align:null},"immediate"),(0,o.kt)("td",{parentName:"tr",align:null},"boolean"),(0,o.kt)("td",{parentName:"tr",align:null},"Prevents animation if true.")),(0,o.kt)("tr",{parentName:"tbody"},(0,o.kt)("td",{parentName:"tr",align:null},(0,o.kt)("a",{parentName:"td",href:"configs"},"config")),(0,o.kt)("td",{parentName:"tr",align:null},"table"),(0,o.kt)("td",{parentName:"tr",align:null},"Spring config (contains mass, tension, friction, etc)")))),(0,o.kt)("h2",{id:"default-props"},"Default props"),(0,o.kt)("h3",{id:"imperative-updates"},"Imperative updates"),(0,o.kt)("p",null,"Imperative updates inherit default props declared from passing props to ",(0,o.kt)("inlineCode",{parentName:"p"},"useSprings")," or ",(0,o.kt)("inlineCode",{parentName:"p"},"useSpring"),"."),(0,o.kt)("pre",null,(0,o.kt)("code",{parentName:"pre",className:"language-lua"},"local styles, api = RoactSpring.useSpring(hooks, function()\n    return {\n        position = UDim2.fromScale(0.5, 0.5) ,\n        config = { tension = 100 },\n    }\nend)\n\nhooks.useEffect(function()\n    -- The `config` prop is inherited by the animation\n    -- Spring will animate with tension at 100\n    api.start({ position = UDim2.fromScale(0.3, 0.3) })\nend)\n")),(0,o.kt)("h3",{id:"compatible-props"},"Compatible props"),(0,o.kt)("p",null,"The following props can have default values:"),(0,o.kt)("ul",null,(0,o.kt)("li",{parentName:"ul"},(0,o.kt)("inlineCode",{parentName:"li"},"config")),(0,o.kt)("li",{parentName:"ul"},(0,o.kt)("inlineCode",{parentName:"li"},"immediate"))))}m.isMDXComponent=!0}}]);