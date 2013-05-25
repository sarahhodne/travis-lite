require "spec_helper"

describe "routing to jobs" do
  it "routes /henrikhodne/travis-lite/jobs/12345 to jobs#show" do
    expect(get: "/henrikhodne/travis-lite/jobs/12345").to route_to(
      controller: "jobs",
      action: "show",
      owner_name: "henrikhodne",
      repository_name: "travis-lite",
      id: "12345",
    )
  end
end
