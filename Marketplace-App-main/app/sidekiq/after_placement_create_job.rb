class AfterPlacementCreateJob
  include Sidekiq::Job

  def perform(candidacy_id, request_id, worker_id)
    @candidacy = Candidacy.find(candidacy_id)
    @worker = Worker.find(worker_id)
    @request = JobRequest.find(request_id)
    
    @candidacy.update_status(1)
    @request.update_vacancies
    @worker.change_availiability
    @worker.change_availiability
    @worker.archive_candidacies
    return
  end
end
