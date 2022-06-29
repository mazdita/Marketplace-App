#This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# def clean_db
#   Client.destroy_all
# end

# clean_db


#skills
skills = %w(driving_license english excel communication programming manufacturing cooking)
skills.each do |n|
  name = n
  Skill.create!(name: name)
end

#Client seed
50.times do |n|
    name = Faker::Company.name
    email = Faker::Internet.email(name: name)
    password = "123456"
    address = Faker::Address.full_address
    Client.create!(name: name,
                  email: email,
                  password: password,
                  address: address)
end

#Worker seeds
500.times do |n|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = Faker::Internet.email(name: first_name)
  phone_number = Faker::PhoneNumber.cell_phone
  country = Faker::Address.country
  city = Faker::Address.city
  working = false
  password = "123456"
  worker = Worker.create!(first_name: first_name,
                last_name: last_name,
                email: email,
                # phone_number: phone_number,
                country: country,
                city: city,
                # working: working,
                password: password)
  @array = %w(1 2 3 4 5 6 7)
  @a = @array.sample(rand(2..4))
  @a.each do |skill_id|
    WorkerSkill.create(worker_id: worker.id, skill_id: skill_id)
  end
end

#Job Request seeds
200.times do |n|
  client_id = rand(1..50)
  start_date = rand(1..20).week.from_now
  end_date = rand(6..24).months.from_now
  job_function = Faker::Job.title
  address = Faker::Address.full_address
  vacancies_count = rand(25..2500)
  total_vacancies = vacancies_count
  monthly_salary = rand(600..5000)
  market_value = total_vacancies * monthly_salary
  status = "Opened"
  details = Faker::Lorem.paragraph(sentence_count: rand(10..30))
  job = JobRequest.create!( client_id: client_id,
                    start_date: start_date,
                    end_date: end_date,
                    job_function: job_function,
                    address: address,
                    vacancies_count: vacancies_count,
                    total_vacancies: total_vacancies,
                    monthly_salary: monthly_salary,
                    market_value: market_value,
                    status: status,
                    details: details)
  @array = %w(1 2 3 4 5 6 7)
  @a = @array.sample(rand(2..4))
  @a.each do |skill_id|
    killer = [true, false].sample
    JobRequiredSkill.create(job_request_id: job.id, skill_id: skill_id, killer: killer)
  end
end

#Candidacies seeds
200.times do |n|
  status = 0
  start_date = rand(1..20).week.from_now
  worker_id = rand(1..500)
  job_request_id = rand(1..100)
  Candidacy.create!(status: status,
                    start_date: start_date,
                    worker_id: worker_id,
                    job_request_id: job_request_id)
end

#Placements seeds
400.times do |n|
  candidacy_id = rand(1..200)
  worker_id = rand(1..500)
  client_id = rand(1..50)
  start_date = rand(1..20).week.from_now
  end_date = rand(6..24).months.from_now
  monthly_salary = rand(600..5000)
  Placement.create!(candidacy_id: candidacy_id,
                    worker_id: worker_id,
                    client_id: client_id,
                    start_date: start_date,
                    end_date: end_date,
                    monthly_salary: monthly_salary)
end

#Admin
Admin.create!(email: "nicomg100@gmail.com", password: "123456", api_key: "mDp+_{ex_cG%`=xnUq0uYdv*2U6`K[")