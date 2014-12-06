class ActivitiesController < ApplicationController
  # GET /activities
  # GET /activities.json
  def index
    @activities = current_user.activities.order created_at: :desc
  end
end
