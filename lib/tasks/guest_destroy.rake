namespace :guest_destroy do
  desc 'Guest_destroy'
  task run: :environment do
    User.where(role: 'guest').where("created_at < ?", 3.days.ago).destroy_all
  end
end