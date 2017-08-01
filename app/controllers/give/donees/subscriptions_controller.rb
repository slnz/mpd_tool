# frozen_string_literal: true

module Give
  module Donees
    class SubscriptionsController < DoneesController
      decorates_assigned :subscriptions, :subscription
      before_action :authenticate_user!, except: %i[index new]
      before_action :check_project, except: [:index]
      add_breadcrumb 'Prayer Partnership', proc { |c| c.donee_subscriptions_path(donee_id: c.donee.slug) }
      helper_method :current_subscription
      def index
        load_subscriptions if user_signed_in?
      end

      def new
        create
      end

      def create
        build_subscription
        save_subscription
        flash[:success] =
          "You've successfully signed up to receive prayer updates for #{donee.first_name} on #{project.title}"
        redirect_to action: :index
      end

      protected

      def load_subscriptions
        @subscriptions ||= subscription_scope
      end

      def build_subscription
        @subscription ||= subscription_scope.find_or_create_by(project: project)
      end

      def save_subscription
        @subscription.save
      end

      def subscription_scope
        current_user.subscriptions.where(designation: designation)
      end

      def current_subscription
        subscription_scope.find_by(project: project)
      end
    end
  end
end
