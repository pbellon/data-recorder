class DatatypeFieldUtils

  createFieldKey: (field)->
    key = ''
    if DatatypeFieldUtils.keyableString(field.name)
      key = field.name.toLowerCase()
      key.replace(' ', '_')
    else
      throw new Error("Invalid field name, please only use alphanumeric characters & ")
    key



  keyableString: (field)->
    pattern = /^([a-zA-Z0-9 ])$/
    pattern.test(field.name)


angular.module 'dataRecorder'
       .service 'FieldUtils', DatatypeFieldUtils

angular.module 'dataRecorder'
       .directive 'keyableString', ['FieldUtils', (FieldUtils)->
          restrict: 'A',
          require: 'ngModel',
          link: (scope, el, attrs, ngModel)->
            validate = (regexp, value)->
                if value == null || value === "" || !required || FieldUtils.keyableString(value)
                    ngModel.$setValidity 'validName', true
                    return value
                else
                    ngModel.$setValidity 'validName', false
                    return

            ngModel.$formatters.push(validate)
            ngModel.$parsers.push(validate)
       ]
