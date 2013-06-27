class ExpensesController < ApplicationController
  def index
    @expenses = @group.expenses
  end

  def new
    @expense = @group.expenses.build
  end

  def create
    @expense = @group.expenses.build(expense_params)
    if @expense.save
      redirect_to group_expenses_path
    else
      render action: 'new'
    end
  end

  def edit
  end

  def update
    if @expense.update(expense_params)
      redirect_to group_expenses_path
    else
      render action: 'edit'
    end
  end

  def destroy
    @expense.destroy
    redirect_to group_expenses_path
  end

  private
  def set_group
    @group = Group.find_by_slug(params[:group_id])
  end

  def set_expense
    @expense = Expense.find_by_slug(params[:id])
  end

  def expense_params
    params.require(:expense).permit(:name, :description, :cost, :date, :tag_id)
  end

end
