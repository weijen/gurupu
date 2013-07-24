Gurupu.Views.Expenses ||= {}

class Gurupu.Views.Expenses.ModalView extends Backbone.View
  template: JST["backbone/templates/expenses/modal"]
  initialize: (options) ->
    @expense = options.expense
  events:
    "click .del-comfirm": "delete"
    "click .cancel": "hide"
    "hidden": "hidden"
  hide: ->
    @$el.find("#myModal").modal("hide")
  delete: ->
    @hide()
  render: ->
    @$el.html(@template())
    return this
  hidden: () ->
    @remove()
    false



