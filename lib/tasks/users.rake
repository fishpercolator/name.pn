namespace :users do
  desc "Delete users who never named themselves within a month of signing up (DRY_RUN=1 lists them instead)"
  task purge_abandoned: :environment do
    abandoned = User.abandoned
    count = abandoned.count

    if ENV["DRY_RUN"].present?
      puts abandoned.pluck(:email), "Abandoned users to delete: #{count}"
    else
      abandoned.find_each(&:destroy!)
      puts "Abandoned users deleted: #{count}"
    end
  end
end
