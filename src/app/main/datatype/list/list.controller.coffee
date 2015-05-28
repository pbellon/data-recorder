class DatatypeListCtrl
  constructor: (@storage)->
    console.log 'DatatypeListCtrl !'

  allTypes: =>
    @storage.allAggregated()

  addRecord: (id)=>
    console.log 'should add record to type:', @storage.get(id)

angular.module "dataRecorder"
  .controller "DatatypeListCtrl", DatatypeListCtrl
