class ExpensesController < ApplicationController
  def index
    @expenses = @group.expenses
  end

  def new
    @expense = @group.build_expense
  end

  def create
    @expense = @group.build_expense(expense_params)
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
    redirect_to expenses_path
  end

  private
  def set_group
    @group = Group.where(secret_str: params[:group_id])
  end

  def set_expense
    @expense = Expense.find(params[:id])
  end

  def expense_params
    params.require(:expense).permit(:name, :cost)
  end

end
