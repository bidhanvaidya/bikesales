if ENV["RAILS_ENV"] == "development"
  worker_processes 0
else
  worker_processes 1
end

timeout 30