require "spec_helper"

describe "routing to builds" do
  it "routes /henrikhodne/travis-lite/builds to builds#index" do
    expect(get: "/henrikhodne/travis-lite/builds").to route_to(
      controller: "builds",
      action: "index",
      owner_name: "henrikhodne",
      repository_name: "travis-lite",
    )
  end

  it "routes repository names containing dots correctly" do
    expect(get: "/henrikhodne/davinci.rb/builds").to route_to(
      controller: "builds",
      action: "index",
      owner_name: "henrikhodne",
      repository_name: "davinci.rb",
    )
  end

  it "routes /henrikhodne/travis-lite/builds/12345 to builds#show" do
    expect(get: "/henrikhodne/travis-lite/builds/12345").to route_to(
      controller: "builds",
      action: "show",
      owner_name: "henrikhodne",
      repository_name: "travis-lite",
      id: "12345",
    )
  end
end
