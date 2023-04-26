module ApplicationHelper
  include Pagy::Frontend
  def formatted_time(time)
    time.in_time_zone('Asia/Kathmandu').strftime('%d %b, %Y %H:%M')
  end
end
