class NotifierMailer < ApplicationMailer
  default from: "whatnext@arpcentral.net"

  def welcome(user)
     @user = user
     mail(to: @user.email, bcc: 'whatnext@arpcentral.net',  subject: "Welcome to 'What Next?' The Worlds first and only Choose-Our_Adventur Web App.")
  end

  def new_chapter(chapter, user)
    @chapter = chapter
    @user = user
      mail(to: @user.email, bcc: 'whatnext@arpcentral.net',  subject: "New Chapter for '#{@chapter.story.name}' has been published!")
  end

  def voting_completed(chapter, author)
    @chapter = chapter
    @author = author
      mail(to: @author.email, bcc: 'whatnext@arpcentral.net',  subject: "Voting has been completed for  '#{@chapter.story.name}'.")
  end

end
