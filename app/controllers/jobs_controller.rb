class JobsController < ApplicationController
  def show
    @job = JobDecorator.decorate(Travis::Job.find(params[:id]))
  end
end
