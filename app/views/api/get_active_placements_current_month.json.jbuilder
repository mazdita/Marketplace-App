json.extract! get_active_placements_current_month, :client_name, :worker_name, :job_function,:start_date, :end_date ,:monthly_salary

json.url result_url(result, format: :json)