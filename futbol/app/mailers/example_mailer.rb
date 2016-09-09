class ExampleMailer < ApplicationMailer
    default from: "from@example.com"

    def sample_email(invite)
        @invite = invite

        # mail(to: @invite.mail, subject: 'Sample Email')

        # First, instantiate the Mailgun Client with your API key
        mg_client = Mailgun::Client.new ENV['api_key']
        mb_obj = Mailgun::MessageBuilder.new

        # Define the from address.
        mb_obj.from ENV['email_from']
        
        # Define a to recipient.
        mb_obj.add_recipient :to, @invite.mail
        
        # Define the subject.
        mb_obj.subject "Mailgun HTML Example"
        
        # Define the body of the message.
        # mb_obj.body_text render_to_string('/example_mailer/sample_email.text.erb', layout: false, content_type: 'text/plain').to_str
        
        # Define the body of the message.
        mb_obj.body_html render_to_string('example_mailer/sample_email').to_str
        # mb_obj.body_text "EMAIL!"

        # Finally, send your message using the client
        mg_client.send_message ENV['domain'], mb_obj
    end
end