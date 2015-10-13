module Mpd
  class PagesController < MpdController
    before_action :setup_redirect

    def setup_redirect
      store_location_for(:user, params[:redirect_to]) if params[:redirect_to].present?
    end

    def show
      render "mpd/pages/#{params[:id]}"
    end
  end
end
