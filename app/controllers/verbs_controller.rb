class VerbsController < ApplicationController
  # GET /verbs.json
  def index
    @verbs = VerbList.all
  end
end
