require "json"

class JobDecorator < Draper::Decorator
  delegate_all

  def number
    "##{object.number}"
  end

  def state
    object.state.capitalize
  end

  def language
    object.config["language"]
  end

  def duration
    h.distance_of_time_in_words(object.duration)
  end

  def finished_at
    if object.finished_at
      "#{h.time_ago_in_words(object.finished_at)} ago"
    else
      "still running"
    end
  end

  def row_class
    {
      "green" => "success",
      "red" => "error",
      "yellow" => "warning",
    }.fetch(object.color)
  end

  def config
    JSON.pretty_generate(object.config)
  end

  def repository
    RepositoryDecorator.decorate(object.repository)
  end

  def build
    BuildDecorator.decorate(object.build)
  end

  def url_info
    {
      owner_name: repository.owner_name,
      repository_name: repository.name,
      id: object.id,
    }
  end
end
