class ExpensesController < ApplicationController
  #maca add start
  prepend_before_action :check_frozen, only: [:destroy, :show, :update, :create]
  prepend_before_action :check_join
  before_action :set_expense, only: [:edit, :update, :destroy, :show] 
  #maca add end

  def index
    @expenses = @group.expenses
  end

  #maca add start
  def summary
    @expenses = @group.expenses
    @total_cost = @expenses.sum {|e| e.cost}        
    @ex_sum = @expenses.all(select: "tag_id, SUM(cost) costs",
                            group: "tag_id")    
  end
  #maca add end

  def new
    @expense = @group.expenses.build
  end

  def create
    @expense = @group.expenses.build(expense_params)
    @expense.user_id = current_user.id #maca
    if @expense.save
      redirect_to group_expenses_path
    else
      render action: 'new'
    end
  end

  #maca add start
  def show
    @expense.destroy    
    redirect_to group_expenses_path
  end
  #maca add end

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
    #maca test @expense.destroy
    #maca test redirect_to group_expenses_path
  end

  private

  #maca add start
  def check_frozen
    if @group.is_frozen?
      flash[:alert] = action_name+" fail! Group state is frozen"  
      redirect_to group_expenses_path
    end
  end

  def check_join
    @group = Group.find_by_slug(params[:group_id])
    @user_status = ""    
    group_user = @group.group_users.find_by_user_id(current_user.id)   
    if group_user!=nil 
      @user_status = group_user.state
    end  
    if @user_status!="joined"
      render action: 'none'
    end
  end
  #maca add end  

  def set_group
    @group = Group.find_by_slug(params[:group_id])
  end

  def set_expense
    @expense = Expense.find_by_slug(params[:id])
  end

  def expense_params
    #maca params.require(:expense).permit(:name, :description, :cost, :date, :tag_id)
    params.require(:expense).permit(:name, :description, :cost, :date, :tag_id, :user_id) #maca
  end

end
