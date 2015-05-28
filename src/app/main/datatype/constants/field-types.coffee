angular.module 'dataRecorder'
  .constant 'FIELD_TYPES',
    int:
      type: typeof(0)
      name: 'Integer'
    float:
      type: typeof(0.0)
      name: 'Float'
    string:
      type: typeof('')
      name: 'String'
    date:
      type: typeof(new Date())
      name: 'Date'
