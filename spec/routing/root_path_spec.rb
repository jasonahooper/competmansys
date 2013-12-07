require 'spec_helper'

describe 'root-path' do

  it 'routes to welcome#index' do
    expect(get("/")).to route_to("welcome#index")
  end

end