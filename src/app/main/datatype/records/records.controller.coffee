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
