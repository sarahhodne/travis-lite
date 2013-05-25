class BuildDecorator < Draper::Decorator
  delegate_all

  def number
    "##{object.number}"
  end

  def state
    object.state.capitalize
  end

  def row_class
    {
      "green" => "success",
      "red" => "error",
      "yellow" => "warning",
    }.fetch(object.color)
  end

  def repository
    RepositoryDecorator.decorate(object.repository)
  end

  def url_info
    {
      owner_name: repository.owner_name,
      repository_name: repository.name,
      id: object.id,
    }
  end

  def commit_info
    if object.push?
      "#{object.commit.branch}@#{object.commit.short_sha}"
    else
      "Pull Request ##{object.pr_number}"
    end
  end

  def jobs
    JobDecorator.decorate_collection(object.jobs)
  end
end
