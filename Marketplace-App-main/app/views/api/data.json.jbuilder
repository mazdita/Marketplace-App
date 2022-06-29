json.array! @data do |placement|
    json.id placement.id
    json.start_date placement.start_date
    json.end_date placement.end_date
    json.monthly_salary placement.monthly_salary
    json.client do 
        json.extract! placement.client, :id, :name, :email, :address
    end
    json.worker do
        json.extract! placement.worker, :id, :email, :first_name, :last_name, :country, :city
    end
    json.job_request do
        json.extract! placement.job_request, :id, :job_function, :address, :monthly_salary, :vacancies_count, :total_vacancies, :skills
    end
end
