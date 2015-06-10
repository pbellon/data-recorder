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

class DatatypeFormCtrl
  constructor: (@type, @storage)->
    @fieldTypes = @storage.FIELD_TYPES
    console.log 'fieldTypes: ', @fieldTypes
    @newType = false
    if !@type?
      @type =
        fields: []
        id: @storage.newTypeId()
      @newType = true

    @newField = @createNewField()
    @editingFields = {}

  save: (form)=>
    unless form.$valid
      unless form.$error.required.length == 1 and form.new_field.$error.required
        return
    if !@isEditing()
      @storage.create(@type)
      console.log 'create'
    else
      @storage.save(@type)
      console.log 'save'

  isEditing: => @newType != true

  addSubfield: (form)=>
    @newFieldSubmitted = true
    return unless _.isEmpty form.new_field.$error
    console.log @newField
    @newField.type = @fieldTypes[@newField.type]
    @type.fields.push(angular.copy(@newField))
    @newField = @createNewField()

  createNewField: =>
    @newFieldSubmitted = false
    return id: @storage.newFieldId(@type)

  isEditingField: (field)=>
    @editingFields[field.id]?

angular.module 'dataRecorder.datatype'
  .controller 'DatatypeFormCtrl', DatatypeFormCtrl
