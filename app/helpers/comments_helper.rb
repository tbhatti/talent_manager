module CommentsHelper
  def relative_time(user,start_time)
    diff_seconds = Time.now - start_time
    case diff_seconds
      when 0 .. 59
         "Posted by #{user} #{(diff_seconds).to_i} seconds ago"
      when 60 .. (3600-1)
         "Posted by #{user} #{(diff_seconds/60).to_i} minutes ago"
      when 3600 .. (3600*24-1)
         "Posted by #{user} #{(diff_seconds/3600).to_i} hours ago"
      when (3600*24) .. (3600*24*30)
         "Posted by #{user} #{(diff_seconds/(3600*24)).to_i} days ago"
      else
         start_time.strftime("%m/%d/%Y")
    end
  end
end
