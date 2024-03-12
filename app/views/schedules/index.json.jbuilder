   json.array!(@schedules) do |schedule|
    json.id schedule.id
    json.title schedule.title
    json.start schedule.start_datetime
    json.end schedule.end_datetime
    json.url schedule_path(schedule.id)

    if schedule.problem.progress_status == "finish"
      json.color "#28a745"
    elsif schedule.problem.progress_status == "pending"
      json.color "#17a2b8"
    end
   end