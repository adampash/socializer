class VisitorsController < ApplicationController
  before_filter :authenticate_user!, :only => [:login_success]
end
