class Gurupu.Models.Expenses extends Backbone.Model
  paramRoot: 'expense'

  defaults:
    name: null
    cost: null
    date: null
    tag_id: null
    username: null 

  toJSON: ->
    attrs = _(@attributes).clone()
    delete attrs.tagname
    delete attrs.username
    delete attrs.editable
    delete attrs.deleteable
    return attrs

  serialize_for_view: ->
    _(@attributes).clone()
  
class Gurupu.Collections.ExpensesCollection extends Backbone.Collection
  model: Gurupu.Models.Expenses
  url: 'expenses'
