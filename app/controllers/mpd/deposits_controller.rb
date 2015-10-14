module Mpd
  class DepositsController < MpdController
    has_scope :project
    decorates_assigned :deposits, :deposit
    add_breadcrumb 'Deposits', proc { |c| c.deposits_path }

    def index
      load_deposits
    end

    def show
      load_deposit
      add_breadcrumb "##{@deposit.id}", deposit_path(@deposit)
    end

    def new
      add_breadcrumb 'New', new_deposit_path
      build_deposit
    end

    def edit
      show
      add_breadcrumb 'Edit', edit_deposit_path(@deposit)
      build_deposit
    end

    def create
      build_deposit
      return render action: :new unless save_deposit
      flash[:success] = "You've successfully added a deposit."
      redirect_to deposit_path(@deposit)
    end

    def update
      load_deposit
      build_deposit
      return render action: :edit unless save_deposit
      flash[:success] = "You've successfully updated a deposit."
      redirect_to deposit_path(@deposit)
    end

    def destroy
      load_deposit
      @deposit.destroy
      flash[:success] = "You've successfully deleted a deposit."
      redirect_to action: :index
    end

    protected

    def load_deposits
      @q ||= apply_scopes(deposit_scope).search(params[:q])
      @deposits ||= @q.result.page(params[:page])
    end

    def load_deposit
      @deposit ||= deposit_scope.find(params[:id])
    end

    def build_deposit
      @deposit ||= deposit_scope.build
      @deposit.attributes = deposit_params
    end

    def save_deposit
      @deposit.save
    end

    def deposit_scope
      current_user.designation.try(:deposits)
    end

    def deposit_params
        deposit_params = params[:deposit]
        return {} unless deposit_params
        deposit_params.permit(:first_name, :last_name, :amount, :giving_method,
                              :address_line_1, :address_line_2, :city, :postcode, :terms)
    end
  end
end
