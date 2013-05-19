namespace :populate do
  desc "Populate SBK townships"
  task :townships => :environment do
    Township.insert_township('Bugojno')
    Township.insert_township("Busovaca")
    Township.insert_township('Donji Vakuf')
    Township.insert_township('Fojnica')
    Township.insert_township('Gornji Vakuf')
    Township.insert_township('Jajce')
    Township.insert_township('Kiseljak')
    Township.insert_township("Kresevo")
    Township.insert_township('Novi Travnik')
    Township.insert_township('Travnik')
    Township.insert_township('Vitez')
  end
end