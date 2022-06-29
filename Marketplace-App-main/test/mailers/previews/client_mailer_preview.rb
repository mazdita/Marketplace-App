# Preview all emails at http://localhost:3000/rails/mailers/client_mailer
class ClientMailerPreview < ActionMailer::Preview
    def notify_job_request_full
        client = Client.first
    end
end
