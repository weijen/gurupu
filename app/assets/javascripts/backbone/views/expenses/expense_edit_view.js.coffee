Gurupu.Views.Expenses ||= {}

class Gurupu.Views.Expenses.ExpenseEditView extends Backbone.View
  initialize: (options) ->
    @expense = options.expense
    @tags = options.tags
  template: JST["backbone/templates/expenses/expenseEdit"]
  tagName: "tr"
  events:
    "click .cancel": "switchView"
    "click .comfirm": "updateExpense"
  updateExpense: ->
    @expense.set({
      name: @$el.find("[name='name']").val()
      cost: @$el.find("[name='cost']").val()
      tag_id: @$el.find("[name='tag_id']").val()
      date: @$el.find("[name='date']").val()
    }).save()
  
    @switchView()
  switchView: ->
    expenseView = new Gurupu.Views.Expenses.ExpenseView(expense:@expense,tags:@tags)
    @$el.after(expenseView.render().el)
    @.remove()
  render: ->
    @$el.html(@template(expense:@expense,tags:@tags))
    @$el.find('[data-behaviour~=datepicker]').datepicker({format:'yyyy-mm-dd'})
    return this
  
