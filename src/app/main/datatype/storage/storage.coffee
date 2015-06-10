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

angular.module 'dataRecorder'
  .service 'DatatypeStorage', [ 'STORAGE_KEYS', 'FIELD_TYPES', class DatatypeStorage
        constructor: (@KEYS, @FIELD_TYPES)->
            @local = window.localStorage
            @_initStorage()
            @datatypes = [
                {
                  title: 'Cigarettes',
                  id: 1,
                  attrs: {
                    id: {
                      order: 0
                      id: 1
                      name: 'ID'
                      type: 'int'
                      editable: false
                    }
                    date: {
                      order: 1
                      id: 2
                      name: 'Date'
                      type: 'date'
                      editable: false

                    }
                  }
                  records: [
                    {id: 1, date: new Date()}
                    {id: 2, date: new Date()}
                    {id: 3, date: new Date()}
                    {id: 4, date: new Date()}
                    {id: 5, date: new Date()}
                    {id: 6, date: new Date()}
                    {id: 7, date: new Date()}
                    {id: 8, date: new Date()}
                    {id: 9, date: new Date()}
                    {id: 10, date: new Date()}
                    {id: 11, date: new Date()}
                    {id: 12, date: new Date()}
                    {id: 13, date: new Date()}
                  ]
                },
                {
                  title: 'Drinks'
                  id: 2
                  attrs: {
                    id: {
                      id: 1
                      order: 0,
                      name: 'ID'
                      type: 'int'
                      editable: false
                    }
                    date: {
                      id: 2
                      order: 1,
                      name: 'Date'
                      type: 'date'
                      editable: false
                    }
                    degree: {
                      id: 3,
                      order: 2,
                      type: 'int'
                      name: 'Degree'
                      editable: true
                    },
                    name: {
                      id: 4,
                      order: 3,
                      type: 'string',
                      name: 'Name'
                      editable: true
                    }
                  }
                  records: [
                    {id: 1, date: new Date(), degree: 12, name: 'Wine'}
                    {id: 2, date: new Date(), degree: 13, name: 'Wine'}
                    {id: 3, date: new Date(), degree: 7 , name: 'Beer'}
                    {id: 4, date: new Date(), degree: 8 , name: 'Beer'}
                    {id: 5, date: new Date(), degree: 8 , name: 'Beer'}
                    {id: 6, date: new Date(), degree: 9 , name: 'Beer'}
                    {id: 7, date: new Date(), degree: 7 , name: 'Beer'}
                    {id: 8, date: new Date(), degree: 7 , name: 'Beer'}
                    {id: 9, date: new Date(), degree: 7 , name: 'Beer'}
                  ]
                }
              ]

        all: =>
          _.map @_listIds(), (id)=> @get(id)

        allAggregated: =>
            aa = _.map @all(), (el)->
                r = el.records || []
                el.count = r.length
                delete el['records'] if el.records?
                return el
            console.log aa
            aa

        get: (id)=>
            @_get(
                @_getTypeStorageKey(id)
            )

        updateRecord: (type_id, record_id, record)=>
          type = _.findWhere @datatypes, id: type_id
          # remove old record version
          records = _.filter type.records, (r)-> r.id == record_id
          records.push(record)
          type.records = records
          @save(type.id, type)

        delete: (id)=>
          @datatypes = _.filter @datatypes, (el)-> el.id != id

        deleteRecord: (id, recordId)=>
          record = @get(id)
          record.records = _.filter record.records, (el)-> el.id !=recordId


        newTypeId: =>
          @_newId(@_listIds())

        newFieldId: (type) =>
          @_newId _.pluck(type.fields, 'id')

        save: (type)=>
            @_set(@_getTypeStorageKey(type.id), type)

        create: (type)=>
            @_addToTypes(type)


        # Intern methods

        _addToTypes: (type)=>
            @_addToListIDs(type.id)
            key = @_getTypeStorageKey(type.id)
            @_set(key, type)

        _getTypeStorageKey: (type_id)=> @KEYS.TYPE.replace('{id}', type_id)

        _newId: (prev_ids)=>
          max = -1
          _.each prev_ids, (id)->
            max = if max < id then id else max
          max = 0 if max < 0
          max + 1

        _listIds: => @_get(@KEYS.ID_LIST)

        _initStorage: =>
            ids = @_get(@KEYS.ID_LIST)
            if !ids?  || ids == ''
                @_set(@KEYS.ID_LIST, [])

        _save: (type)=>
            key = @_getStorageKey(type.id)
            @_set(key, type)

        _get: (key)=>
            value = @local.getItem("dataRecorder.#{key}")
            value = JSON.parse value if value
            value

        _set: (key, val)=>
            @local.setItem("dataRecorder.#{key}", JSON.stringify val)

        _removeAllData: =>
            @local.clear()

        _addToListIDs: (id) =>
            list = @_listIds()
            console.log 'list id ', list
            list.push id
            console.log 'list id ', list
            @_set(@KEYS.ID_LIST, list)
  ]
