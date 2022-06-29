module JobRequestsHelper
    def already_applied
        puts current_worker.candidacies.any? {|candidacy| candidacy.job_request_id === params[:id]}
    end
end
