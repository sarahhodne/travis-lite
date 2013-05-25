class OwnerNameContraint
  BLACKLIST = [
    "javascripts",
    "stylesheets",
    "assets",
  ].freeze

  def self.matches?(request)
    !new(request).blacklisted?
  end

  def initialize(request)
    @request = request
  end

  def blacklisted?
    BLACKLIST.any? { |blacklist_entry| blacklist_entry === owner_name }
  end

  private

  def owner_name
    @request.params[:owner_name]
  end
end

TravisLite::Application.routes.draw do
  get "jobs/show"
  resources :repositories, path: ':owner_name', only: %i[index show], param: :name, constraints: OwnerNameContraint do
    resources :builds, only: %i[index show]
    resources :jobs, only: %i[show]
  end

  root "repositories#index"
end
