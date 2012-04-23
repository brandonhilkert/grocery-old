require 'spec_helper'

describe App do
  include Rack::Test::Methods

  def app
    described_class
  end

  context '/' do
    subject { get '/' }

    it "should be successful" do
      subject.status.should == 200
    end
  end

  # context 'POST /lists' do
  #   before do
  #     @list = create(:story)
  #   end

  #   subject do
  #     get '/stories'
  #   end

  #   it 'should be successful' do
  #     subject.status.should == 200
  #   end

  #   it 'should render json' do
  #     json = ActiveSupport::JSON.decode(subject.body)
  #     json.length.should == 1
  #     json[0]['id'].should == @story.id
  #   end
  # end
  
end