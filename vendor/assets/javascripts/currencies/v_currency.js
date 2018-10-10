/*global Vue*/

Vue.component('v-currency', {
  template: '<div class="input-group" ref="container">' +
              '<span v-if="isPrefix" class="input-group-addon">{{currencySymbol}}</span>' +
              '<input ref="control" :class="inputClasses" type="text" :disabled="disabledValue" :readonly="readonlyValue" step="any" v-model="dataView" />' +
              '<input :name="input_name" type="hidden" :value="dataValue" />' +
              '<span v-if="!isPrefix" class="input-group-addon">{{currencySymbol}}</span>' +
            '</div>',
  data: function(){
    var parsed_value = 0;
    if(!isNaN(parseFloat(this.value))){
      parsed_value = parseFloat(this.value);
    }

    return {
      dataValue: parsed_value,
      dataView: parsed_value.toLocaleString(),
      containerClasses: 'input-group',
    };
  },
  props: {
    value: {
      default: 0,
    },
    currency: {
      default: "VND",
    },
    input_name: {
      default: "v-currency",
    },
    input_class: {
      default: "",
    },
    disabled: {
      default: false,
    },
    readonly: {
      default: false,
    }
  },
  computed: {
    isPrefix: function(){
      if(this.currency.toUpperCase() === "VND"){
        return false;
      }
      return true;
    },
    currencySymbol: function(){
      if(this.currency.toUpperCase() === "VND"){
        return "₫";
      }
      if(this.currency.toUpperCase() === "USD"){
        return "$";
      }
      return "";
    },
    disabledValue: function(){
      if(this.disabled){ return "disabled"; }
      return false;
    },
    readonlyValue: function(){
      if(this.readonly){ return "readonly"; }
      return false;
    },
    inputClasses: function(){
      return this.input_class + " form-control text-right";
    },
  },
  watch: {
    dataView: function(d){
      if(d === ""){
        this.dataValue = 0;
      }else{
        if(isNaN(this.dataView)){
          this.dataValue = parseFloat(this.dataView.replace(/[^0-9\.]/g,''));
        }else{
          this.dataValue = parseFloat(this.dataView);
        }
      }
      this.$emit("input", parseFloat(this.dataValue));
    },
    value: function(){
      var parsed_value = 0;
      if(!isNaN(parseFloat(this.value))){
        parsed_value = parseFloat(this.value);
      }
      this.dataValue = parsed_value;
      if(!$(this.$refs.control).is(":focus")){
        this.dataView = parsed_value.toLocaleString();
      }
    }
  },
  mounted: function(){
    $(this.$refs.control).on('focus', function(){
      this.dataView = this.dataValue.toString();
    }.bind(this));
    $(this.$refs.control).on('blur', function(){
      this.dataView = this.dataValue.toLocaleString();
    }.bind(this));

    $(this.$refs.control).data($(this.$refs.container).data());
    $(this.$refs.container).removeData();
  }
});
