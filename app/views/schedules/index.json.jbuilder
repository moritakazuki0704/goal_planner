   json.array!(@schedules) do |schedule|
    json.id schedule.id
    json.title schedule.title
    json.start schedule.start_date
    json.startTime schedule.start_time
    json.end schedule.end_date
    json.endTime schedule.end_time
    json.allDay schedule.is_all_day
    json.url schedule_path(schedule.id)
   end