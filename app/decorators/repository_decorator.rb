class RepositoryDecorator < Draper::Decorator
  delegate_all

  def owner_name
    slug_parts.first
  end

  def name
    slug_parts.last
  end

  def last_build_number
    "##{object.last_build_number}"
  end

  def last_build_state
    object.last_build_state.capitalize
  end

  def last_build_url_info
    {
      owner_name: owner_name,
      repository_name: name,
      id: object.last_build_id,
    }
  end

  def row_class
    {
      "green" => "success",
      "red" => "error",
      "yellow" => "warning",
    }.fetch(object.color)
  end

  def url_info
    {
      owner_name: owner_name,
      name: name,
    }
  end

  def builds
    BuildDecorator.decorate_collection(object.builds.take(25))
  end

  private

  def slug_parts
    object.slug.split("/", 2)
  end
end
