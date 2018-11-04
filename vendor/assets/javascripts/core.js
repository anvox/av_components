/*global Vue*/
/*exported vcomponent*/

function vcomponent(name, options){
  if(options.template === undefined){
    options.template = "#v-template-" + name;
  }
  Vue.component(name, options);
}
