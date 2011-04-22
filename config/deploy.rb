    ### deploy.rb
    set :application, "jot_locker"
    set :domain, "gqvccyab.joyent.us"

    set :user, "jill"
    set :runner, user
    set :admin_runner, user # Does nothing on a Shared Accelerator
    set :scm, :git
    set :scm_username, "kormie"
    set :scm_passphrase, "Wq8FCefx3mmvpBAL29bvmXgM/6QqitNRYKZpGEvRf780RaFNewmKn6QNVmc6rYuz
    B9VBpAaX3DdDQUeXTszVF2yXMRgmQyoww2r/W/Ap9YSICDpOFTQZsnyTYNIWVW2f
    /2arSTHatoNQc5dZB/RUXCKdl5Krd1GhgqYdj3kmOWwiHq1UmoWs3bNPjZb6H76E
    GH8DMxsHd1s3acxcqepmqxNQUmsOwVY/JwuK/SiC/DqC9wq6splAHCU9cI1JBzLH
    V05uVhLOThtFefPvf6potRx3hVxekLmi6F4//7B9VVVINexRo9Sdz76uVvMnAjf9
    19Exi4rFFLbYJvyanXn6GAgMU/iee+W8hqUPlYtsft0GmeLBqnExs7t3BYik6NYr
    qjGKIO9EmDrzv5Y7kST7F+AgpYmFKTVC6L1BmLSlIF2XhZkWSfvfQAvCDZRDyx3h
    bAA6kUMJ7QfDiKr47QY7vQzpAPg/JGZPN5VWk4Kx+w9DSNzbsHD8buqmfMrcQaiS
    gZwODJh9GzKXQithaJsJfPI6Kw1o340p/rfm47Ld+I4PBVMODXup/8UggNHkpRcx
    IfnqQUCIJUGhnGq3mjFruQSK1wM8ub7FtynJnLoThp601zbzMeo2YwhfafkukkZF
    UwBL4oD7+9tMngO/r5V9uI5UNUPMmWIcNuMYJBU06JAz5vu4lHj2eeNb0gVy6jo2
    JgEx1qz/NXF/AptkysckcRh9pubBS7MHe1rTMxikIgRgzVMCpiudSsxBUbMDOFQP
    gAyDmdycobu8LKHkDBhlwPkSk+Mx+5Rp6hQt9J/OtCK2NbPOaB1q/9qjxreyELVB
    aM9v6iiNu+fyjunqcPbw2v5++EFhCzBU+8TYoLlltDCVM15vBiLYkJnPBJJsgQuq
    g3efsUBiFZJ/DANttiJU/L6XVJIxUVEWcKdjHk2tUc8JnevX3P3VMvz/s5GCTI66
    vAXZfG+X/HN3N/uGGl7sv7hV6gVRzsw+S3OXkYjMx03w/N65TVzbi6mVMm1x/1Uj
    PP0Z+rbSB47vqV6b2sFCN73vbg+4vvWMA8lIhILvaBGiNWFXiZcgOSTY/bJ+TDq0
    6jV2nq49SdAJyr57IktC+j3edAT0jPfgGSHh+F9si77+e1o/CYw9qIzq7B0MTQEy
    KF2v5HRCzYWR0o5ujCtsqK6yZ3wPI4xNr9QedT5vUvcH+LdM7hKnF7TpkDILvjJQ
    9u69f2dVzTeJDUxFgEd55ExBcZsLxFixKk/GIEw46ogrvs7L/IilXGNkzkQ4HjAU
    Qb41rbSzVBnqWiGlnPN6nEHTLwal7OH1lmotwoOWVkUhw+2cu4KqbWa762mD2AAg
    j875aDS6gRt4b6n9weKdbTB4Abn1t1nmWoIA8cZ9+eixGayuNcYNMT22wXq6b9og
    51/ZfoifDSurwXspkTgG1a/TYFwEv8V+rXxQR4owepwuqIA9PO6eSV8RlFMEmgNJ
    Z06be/w4Ll1WmmBbJBAwNpoRcfivFjwKrJeEkO9SDHKdSYhyuGwhDPHclimrxo3K
    kvMwIjzlBEWF7DV2vP7OkloqgTyqWjiJHbHYBphxlUaEfid/vbu/AQ=="

    set :repository, "git@github.com:kormie/Jot-Locker.git"
    set :checkout, "export"

    role :app, domain
    # These aren't required if you are just using one Shared Accelerator, but it's good practice
    role :web, domain
    role :db, domain, :primary => true

    set :deploy_to, "/users/home/#{user}/web/#{application}" # Or wherever you want the application root to be

    set :service_name, "smf-service_name" # Irrelevant because SMF doesn't work from the CLI on shared - left in as a reminder of a dream
    set :mongrel_config, "#{deploy_to}/shared/config/mongrel_cluster.yml" # Similarly irrelevant on Shared
    set :use_sudo, false # Don't need sudo on a shared accelerator
    default_run_options[:pty] = true # Much time was lost figuring this one out - see http://weblog.jamisbuck.org/2007/10/14/capistrano-2-1

  # Shared Accelerators don't allow CLI access to SMF on Solaris
  # Capistrano will throw warnings/errors if you don't overwrite these methods.
  # It's a good opportunity to throw in a reminder about it.
  namespace :deploy do
    desc "Restart the service"
    task :restart, :roles => :app  do
      puts "Remember to restart this from Webmin for changes to take effect."
      # Some svcadm stuff would go here if it worked
    end

    desc "Start the service" # The :spinner task went out of style when Mongrel and the gang came to town
    task :start, :roles => :app  do
      puts "Remember to start this from Webmin for changes to take effect."
    end

    desc "Stop the service"
    task :stop, :roles => :app do
      puts "This service must be stopped from Webmin."
    end

    # These tasks are used to enable/disable the application by replacing a .htaccess file
    # Surely someone has a better idea.
    namespace :web do
      desc "Present a maintenance page to visitors."
      task :disable, :roles => :web do
        run "cp /users/home/#{user}/web/public/down.txt /users/home/#{user}/web/public/.htaccess"
      end

      desc "Makes the application web-accessible again."
      task :enable, :roles => :web do
        run "cp /users/home/#{user}/web/public/up.txt /users/home/#{user}/web/public/.htaccess"
      end
    end
  end