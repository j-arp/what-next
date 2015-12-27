class InvitationWorker
  @queue = "mail_queue_#{Rails.env}".to_sym

  def self.perform(email, message, story_id, user_id)
    puts "send invites to #{email_list}"
    @story = Story.find(story_id)
    @user = User.find(user_id)


      invitation = Invitation.create!(email: email.strip, message: message, story: @story, user: @user) 
      NotifierMailer.invite(@story, email.strip, message).deliver_now if invitation

  end
end
