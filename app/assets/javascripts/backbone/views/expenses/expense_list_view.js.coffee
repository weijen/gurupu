Gurupu.Views.Expenses ||= {}

class Gurupu.Views.Expenses.ExpenseListView extends Backbone.View
  template: JST["backbone/templates/expenses/expenseList"]
  initialize: (options) ->
    @collection = options.collection
    @tags = options.tags
    @collection.on 'add', @addOne, @
    @collection.on 'reset', @addAll, @
  addOne: (@expense) ->
    expenseView = new Gurupu.Views.Expenses.ExpenseView(expense: @expense,tags:@tags)
    @$el.find('tbody').prepend(expenseView.render().el)
  addAll: ->
    @.collection.forEach(@addOne,@)
  render: ->
    @$el.html(@template())
    return this
