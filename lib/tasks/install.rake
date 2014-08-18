namespace :cms do
    task :install_all => :environment do
      Rake::Task["db:migrate"].execute
      Rake::Task["db:seed"].execute
	end
end