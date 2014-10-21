module ActiveAdmin
  module Views
    class Footer < Component
      def build
        super id: 'footer'
        div do
          small 'Developed by Student Life'
        end
      end
    end
  end
end
