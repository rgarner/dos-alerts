namespace :dos do
  desc 'Scrape the DOS site and save results locally'
  task :scrape do
    ruby 'scrape.rb'
  end
end