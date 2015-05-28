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

    @newField =
      id: @newFieldId()

  save: (form)=>
    console.log form
    return unless form.$valid
    if @isEditing()
      @storage.create(@type)
    else
      @storage.save(@type)

  isEditing: => @newType

  newFieldId: =>
    max = -1
    _.each @type.fields || [], (f)->
      max = if max < f.id then f.id else max
    if max < 0
      max = 0
    max + 1

angular.module('dataRecorder')
  .controller 'DatatypeFormCtrl', DatatypeFormCtrl
