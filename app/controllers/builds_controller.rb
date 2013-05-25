class BuildsController < ApplicationController
  def index
  end

  def show
    @build = BuildDecorator.decorate(Travis::Build.find(params[:id]))
    if @build.jobs.length == 1
      redirect_to repository_job_url(@build.jobs.first.url_info)
    end
  end
end
