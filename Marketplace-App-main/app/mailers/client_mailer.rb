class ClientMailer < ApplicationMailer
    def notify_job_request_full(client)
        @client = client
        mail to: @client.email, subject: "Job Request has been completely filled"
    end

    def notify_job_request_almost_full(client)
        @client = client
        mail to: @client.email, subject: "Job Request has been completely filled"
    end

    def send_offer_to_worker(client:, worker:)
        @client = client
        @worker = worker
        mail to: @worker.email, subject: "#{@client.name.humanize} has offered you a job!"
    end
end
