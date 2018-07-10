'use strict'
import 'lodash/lodash'

const ConfigField = {
  template: "#vue-config-field",
  props: [
    "pluginType",
    "option",
    "initialExpression",
    "initialTimeFormat",
  ],

  data: function() {
    return {
      expression: null,
      timeFormat: null,
      textValue: null,
    }
  },

  filters: {
    humanize: function(value) {
      return _.capitalize(value.replace(/_/g, " "))
    }
  },

  mounted: function() {
    if (this.option.name === "expression") {
      this.expression = this.initialExpression
    } else if (this.option.name === "time_format") {
      this.timeFormat = this.initialTimeFormat
    } else {
      this.textValue = this.option.default
    }
  },

  updated: function() {
    if (this.option.name === "expression") {
      this.expression = this.initialExpression
    }
    if (this.option.name === "time_format") {
      this.timeFormat = this.initialTimeFormat
    }
    this.$nextTick(() => {
      console.log("config-field updated")
      $("[data-toggle=tooltip]").tooltip("dispose")
      $("[data-toggle=tooltip]").tooltip("enable")
    })
  },

  watch: {
    "expression": function(newValue, oldValue) {
      this.$emit("change-parse-config", {
        "expression": this.expression,
        "timeFormat": this.timeFormat
      })
    },
    "timeFormat": function(newValue, oldValue) {
      this.$emit("change-parse-config", {
        "expression": this.expression,
        "timeFormat": this.timeFormat
      })
    }
  },

  methods: {
    inputId: function(pluginType, option) {
      if (pluginType === "output") {
        return `setting_${option.name}`
      } else {
        return `setting_${pluginType}_0__${option.name}`
      }

    },
    inputName: function(pluginType, option) {
      if (pluginType === "output") {
        return `setting[${option.name}]`
      } else {
        return `setting[${pluginType}[0]][${option.name}]`
      }
    },
    checked: function(checked) {
      if (checked === true || checked === "true") {
        return "checked"
      } else {
        return ""
      }
    }
  }
}

export { ConfigField as default }
