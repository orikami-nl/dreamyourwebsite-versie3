class CommentMail < MailForm::Base
  attribute :body  
  attribute :name
  attribute :email
  attribute :associate_email
	attribute :post_title

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
      :subject => "Nieuwe reactie op blogpost",
			:to => %(#{associate_email}),
      :from => %(<#{email}>)
    }
  end
end
