module Mpd
  class PagesController < MpdController
    def show
      render "mpd/pages/#{params[:id]}"
    end
  end
end
