###
This file is part of data-recorder, a simple tool to record real things into data files
Copyright (C) 2015 Pierre Bellon (Toutenrab)

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
###

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
                if value == null || value === "" || FieldUtils.keyableString(value)
                    ngModel.$setValidity 'validName', true
                    return value
                else
                    ngModel.$setValidity 'validName', false
                    return

            ngModel.$formatters.push(validate)
            ngModel.$parsers.push(validate)
       ]
