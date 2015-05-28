class DatatypeRecordsCtrl
  constructor: (@type, @$filter)->
    @attrs_editions = {}

  attrs: =>
    _.map @type.attrs, (attr, k)-> _.extend attr, {key: k}

  attrsOrdering: (attr)=>
    @type.attrs[attr.key].order

  isEditable: (attr_key)=>
    @type.attrs[attr_key].editable

  isEditing: (record)=>
    @attrs_editions[record.id]?

  editRecord: (record)=>
    @attrs_editions[record.id] = @attrs_editions[record.id] ||  {
      current: angular.copy(record)
      old: angular.copy(record)
    }

  cancelEditions: (record)=>
    # record = @attrs_editions[record.id].old
    delete @attrs_editions[record.id]

  saveEditions: (record)=>
    @storage.update(record.id, @attrs_editions[record.id].current)
    delete @attrs_editions[record.id]



angular.module "dataRecorder"
  .controller "DatatypeRecordsCtrl", DatatypeRecordsCtrl
