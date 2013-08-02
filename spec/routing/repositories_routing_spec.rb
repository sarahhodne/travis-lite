require "spec_helper"

describe "routing to repositories" do
  it "routes / to repositories#index" do
    expect(get: "/").to route_to(
      controller: "repositories",
      action: "index",
    )
  end

  it "routes /:owner_name to repositories#index for owner_name" do
    expect(get: "/henrikhodne").to route_to(
      controller: "repositories",
      action: "index",
      owner_name: "henrikhodne",
    )
  end

  it "routes /:owner_name/:name to repositories#show for repository" do
    expect(get: "/henrikhodne/travis-lite").to route_to(
      controller: "repositories",
      action: "show",
      owner_name: "henrikhodne",
      name: "travis-lite",
    )
  end

  it "routes repository names containing dots correctly" do
    expect(get: "/henrikhodne/davinci.rb").to route_to(
      controller: "repositories",
      action: "show",
      owner_name: "henrikhodne",
      name: "davinci.rb",
    )
  end

  it "doesn't route /javascripts/application.js" do
    expect(get: "/javascripts/application.js").to_not be_routable
  end
end
