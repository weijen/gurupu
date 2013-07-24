Gurupu.Views.Expenses ||= {}

class Gurupu.Views.Expenses.CreateView extends Backbone.View
  template: JST["backbone/templates/expenses/create"]
  initialize: (options) ->
    @collection = options.collection
    @expenses = options.expenses
    @username = options.username
  tagName:"form"
  className:"well well-large"
  events:
    "click button": "createExpense"
  createExpense: (event) ->
    event.preventDefault()
    event.stopPropagation()
    @expenses.create({
      name: @$el.find("[name='name']").val()
      cost: @$el.find("[name='cost']").val()
      tag_id: @$el.find("[name='tag_id']").val()
      date: @$el.find("[name='date']").val()
      username: @username
      editable: true
      deleteable: true
    })
  render: ->
    @$el.html(@template(collection:@collection))
    return this
