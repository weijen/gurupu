class ExpensesController < ApplicationController
  #maca add start
  prepend_before_action :check_frozen, only: [:destroy, :show, :update, :create]
  prepend_before_action :check_join
  before_action :set_expense, only: [:edit, :update, :destroy, :show] 
  #maca add end

  def index
    @expenses = @group.expenses
  end

  def summary    
    @sel_type = params[:var] || "utt" 
    if params[:q] == nil
      @start_day = (Date.today - 1.month).to_s
      @end_day = Date.today.to_s
      if @group.expenses.first != nil    
        first_creat = @group.expenses.first.created_at.strftime('%Y-%m-%d')         
        @start_day = first_creat if first_creat > @start_day
      end
    else
      @start_day = params[:q][:date_gteq].to_s
      @end_day = params[:q][:date_lteq].to_s      
    end      

    @q = Expense.search(params[:q])
    ex_raw = @q.result

    # prepare output data
    if @sel_type=='all'
      $ex_sum_all=[]
      ex_raw.each do |ex|
        $ex_sum_all<<[1,ex.date.strftime('%Y-%m-%d'), ex.user.name, ex.tag.name, ex.name, ex.cost]
      end
      $ex_sum_all << [2,'sum','','','',ex_raw.sum {|ex| ex.cost}]      
    else
      @ex_sum = ex_raw.all(select: "user_id,tag_id, SUM(cost) costs",
        group: "user_id, tag_id", 
        order: "user_id, tag_id")         
      @ex_sum_all=[]
      # group by user -> tag
      if @sel_type[0,2]=="ut"  
        @ex_sum.each do |ex|
          @ex_sum_all<<[1, ex.user_id, ex.tag_id, ex.costs, ex.user.name, ex.tag.name]      
        end
        @ex_sum1 = @ex_sum.group_by(&:user_id).map {|k,v| [k, v.sum {|e| e.costs}, User.find(k).name] }.sort  
      # group by tag -> user
      elsif @sel_type[0,2]=="tu"  
        @ex_sum.each do |ex|
          @ex_sum_all<<[1, ex.tag_id, ex.user_id, ex.costs, ex.tag.name, ex.user.name]      
        end
        @ex_sum1 = @ex_sum.group_by(&:tag_id).map {|k,v| [k, v.sum {|e| e.costs}, Tag.find(k).name] }.sort
      end    
      #-----------------------------------------
      # @ex_sum_all type=0: summary key1
      #             type=1: summary key1+key2
      #             type=2: summary all
      #-----------------------------------------
      @ex_sum1.each do |key1, sum_costs, name1|
        @ex_sum_all<<[0, key1, 0, sum_costs, name1, '']
      end
      @ex_sum_all = @ex_sum_all.sort_by { |type, key1, key2| [key1, type, key2] }
      
      # total_costs
      total_costs = @ex_sum1.sum {|key1, costs| costs}
      @ex_sum_all<<[2, 0, 0, total_costs, '', '']
    end
  end

  def export
    respond_to do |format|    
      format.csv do    
        csv_string = CSV.generate do |csv|
          csv << ["\xEF\xBB\xBFdate", "member", "tag", "item", "cost"]
          $ex_sum_all.each do |type, date, member, tag, item, cost| 
            csv << [date, member, tag, item, cost]
          end
        end
        render :text => csv_string
      end
    end
  end

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
    @expense.destroy
    #maca test redirect_to group_expenses_path
    respond_to do |format|
      format.json { head :no_content }
    end

  end

  private

  #maca add start
  def check_frozen
    if @group.state =="forzen"
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
    if @user_status!="join"
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
    params.require(:expense).permit(:name, :cost, :date, :tag_id, :user_id) #maca
  end

end
