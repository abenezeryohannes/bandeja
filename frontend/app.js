import Vue from 'vue'
import VueRouter from 'vue-router';

import vSelect from 'vue-select'
Vue.component('v-select', vSelect)


import VueSweetalert2 from 'vue-sweetalert2';

const options = {
    confirmButtonColor: '#41b882',
    cancelButtonColor: '#ff7674', 
};
Vue.use(VueSweetalert2, options);

import VueApexCharts from 'vue-apexcharts'
Vue.use(VueApexCharts)

Vue.component('apexchart', VueApexCharts)

Vue.directive('click-outside', {

    bind: function (el, binding, vnode) {
        el.clickOutsideEvent = function (event) {
            if (!(el == event.target || el.contains(event.target) )) {
                vnode.context[binding.expression](event)
            }
        }; 
        document.body.addEventListener('click', el.clickOutsideEvent)
    },
    unbind: function (el) {
        document.body.removeEventListener('click', el.clickOutsideEvent)
    },

})


import { routes } from './routes';

Vue.use(VueRouter);

const router = new VueRouter({
    mode: 'history',
    routes,
    scrollBehavior(to, from, savedPosition) {
    	return {x: 0, y:0 }
    }
});

import axios from "axios"

let base_url = '/'
if(process.env.NODE_ENV == 'development'){
  base_url = '/'
}
const axiosConfig = {
  baseURL: base_url,
  withCredentials: true
}

window.base_url = base_url
const ax = axios.create(axiosConfig)

// ax.interceptors.request.use(req => {
//   // `req` is the Axios request config, so you can modify
//   // the `headers`.
//   req.headers.authorization = 'my secret token';
//   return req;
// });


ax.interceptors.response.use((response) => {
  // if(response.status == 401) {
  //      alert("You are not authorized");
  // }
  // console.log("response", response)
  return response;
}
, (error) => {
//   console.log("error  ",error.response.status )
  // alert(error.response.status)
  // if(error.response.status == "302") {
  //   window.location.replace(error.response.data.to);
  // }
  if(error.response.status == "401") {
       window.location.replace(error.response.data.redirect_to);
  }
   // console.log(error)
   // return error
   // return Promise.reject(error);
}
);
Vue.prototype.$axios = ax


Vue.mixin({
    computed: {

    },

    methods: {

    }


})


new Vue({
  el: '#app',
  router
});
