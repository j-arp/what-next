require 'rails_helper'
require 'support/user_with_supscriptions_context'

RSpec.describe VotesController, type: :controller do
  include_context "user_with_supscriptions"

  describe "GET #create" do
    it "returns http success" do
      expect {
          post :create, {action_id: @chapter.actions.first.id, chapter_id: @chapter.id}, valid_session
       }.to change{Vote.count}.by(1)
    end

    it "redirects back to chapter" do
      post :create, {action_id: @chapter.actions.first.id, chapter_id: @chapter.id}, valid_session
      expect(response).to redirect_to read_chapter_path(@chapter.number)
    end

    it "does not create a new vote if already voted" do
      post :create, {action_id: @chapter.actions.first.id, chapter_id: @chapter.id}, valid_session
      expect {
          post :create, {action_id: @chapter.actions.first.id, chapter_id: @chapter.id}, valid_session
       }.to change{Vote.count}.by(0)
    end
  end

end
