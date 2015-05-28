angular.module 'dataRecorder'
  .config ($stateProvider)->
    $stateProvider
      .state('datatype',
        url: '/datatype/'
        template: '<div ui-view></div>'
        abstract: true
        resolve:
          storage: (DatatypeStorage)-> return DatatypeStorage
      )
      .state('datatype.list',
        url: ''
        controller: 'DatatypeListCtrl as listCtrl'
        templateUrl: 'app/main/datatype/list/list.html'
      )
      .state('datatype.new',
        url: 'new/'
        controller: 'DatatypeFormCtrl as formCtrl'
        templateUrl: 'app/main/datatype/form/form.html'
        resolve:
          type: -> null
      )
      .state('datatype.single',
        template: '<div ui-view></div>'
        url: '{type_id:int}/'
        abstract: true
        resolve:
          type: (storage, $stateParams)->
            storage.get $stateParams.type_id
      )
      .state('datatype.single.records',
        controller: 'DatatypeRecordsCtrl as recordsCtrl'
        templateUrl: 'app/main/datatype/records/records.html'
        url: 'records/'
      )
      .state('datatype.single.edit',
        url: 'edit/'
        controller: 'DatatypeFormCtrl as formCtrl'
        templateUrl: 'app/main/datatype/form/form.html'
      )
