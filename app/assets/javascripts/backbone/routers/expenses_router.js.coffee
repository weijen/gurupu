class Gurupu.Routers.ExpensesRouter extends Backbone.Router
  initialize: (options) ->
    @expenses = new Gurupu.Collections.ExpensesCollection()
    @expenses.reset @expenses.fetch()
    @tags = new Gurupu.Collections.TagsCollection()
    @tags.reset options.tags
    @current_user_name = options.current_user_name
  routes:
    ""  : "index"

  index: ->
    @view = new Gurupu.Views.Expenses.CreateView(collection:@tags, expenses:@expenses, username:@current_user_name)
    $('#create').html(@view.render().el)
    $('[data-behaviour~=datepicker]').datepicker({format:'yyyy-mm-dd'})
    @view = new Gurupu.Views.Expenses.ExpenseListView(collection:@expenses, tags:@tags)
    $("#expenses").append(@view.render().el)
