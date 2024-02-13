

   json.array!(@schedules) do |schedule|
    json.id schedule.id
    json.title schedule.title
    json.start schedule.start_time
    json.end schedule.finish_time
    json.url schedule_path(schedule.id)
   end