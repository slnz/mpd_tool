module Mpd
  class DonorsController < MpdController
    add_breadcrumb 'Donors', proc { |c| c.donors_path }
    decorates_assigned :donors

    def index
      load_donors
      respond_to do |format|
        format.html
        format.csv { send_data @donors.to_csv, filename: "donors-#{Time.zone.today}.csv" }
      end
    end

    protected

    def load_donors
      @q ||= apply_scopes(donor_scope).search(params[:q])
      @donors ||= if params[:format] == 'csv'
        @q.result.all
      else
        @q.result.page(params[:page])
      end
    end

    def donor_scope
      current_user.donors
    end
  end
end
