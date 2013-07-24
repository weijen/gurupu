Gurupu.Views.Expenses ||= {}

class Gurupu.Views.Expenses.ExpenseView extends Backbone.View
  initialize: (options) ->
    @tags = options.tags
    @expense = options.expense
  events:
    "click .quick-func": "quickExpense"
    "click .del-func": "deleteExpense"
    "click .edit-func": "editExpense"
    "click .del-comfirm": "destroyExpense"
  destroyExpense: ->
    @expense.destroy({
      success: =>
        @.$el.remove()
    })

  deleteExpense: (event) ->
    event.preventDefault()
    mv = new Gurupu.Views.Expenses.ModalView(expense:@expense)
    @$el.append(mv.render().el)
    @$el.find("#myModal").modal("show")
  editExpense: (event) ->
    event.preventDefault()
    expenseEditView = new Gurupu.Views.Expenses.ExpenseEditView(expense:@expense,tags:@tags)
    @$el.after(expenseEditView.render().el)
    @.remove()
  quickExpense: (event) ->
    create = $("#create") 
    create.find("[name='name']").val(@expense.get('name'))
    create.find("[name='cost']").val(@expense.get('cost')).focus()
    create.find("[name='tag_id']").val(@expense.get('tag_id'))


  template: JST["backbone/templates/expenses/expense"]

  tagName: "tr"

  render: ->
    @$el.html(@template(expense:@expense,tags:@tags))
    return this
