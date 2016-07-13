module Remotes
  def self.ce_remotes
    {
      dev: 'git@gitlab.dev.uberops.net:puppet/uberops-hipnotify.git',
      gitlabprod: 'git@gitlab.ubermonitoring.com:puppet/uberops-hipnotify.git',
      bitbucket: 'git@bitbucket.org:uberops/uberops-hipnotify.git'
    }
  end
end
