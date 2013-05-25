class RepositoriesController < ApplicationController
  def index
    if params[:owner_name]
      collection = Travis::Repository.find_all(params.slice(:owner_name))
    else
      collection = Travis::Repository.current
    end
    @repositories = RepositoryDecorator.decorate_collection(collection)
  end

  def show
    @repository = RepositoryDecorator.decorate(Travis::Repository.find(slug))
  end

  private

  def slug
    "#{params[:owner_name]}/#{params[:name]}"
  end
end
