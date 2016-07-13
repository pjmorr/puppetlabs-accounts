require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'
require 'bundler'
require 'bundler/audit/task'
require 'colorize'

require_relative 'lib/version'
require_relative 'lib/monthly_issue'
require_relative 'lib/patch_issue'
require_relative 'lib/regression_issue'
require_relative 'lib/release/gitlab_ce_release'
require_relative 'lib/remotes'
require_relative 'lib/sync'

PuppetLint.configuration.fail_on_warnings = true
PuppetLint.configuration.send('relative')
PuppetLint.configuration.send('disable_80chars')
PuppetLint.configuration.send('disable_class_inherits_from_params_class')
PuppetLint.configuration.send('disable_documentation')
PuppetLint.configuration.send('disable_single_quote_string_with_variables')
PuppetLint.configuration.ignore_paths = ["spec/**/*.pp", "pkg/**/*.pp"]

Bundler::Audit::Task.new

task default: 'bundle:audit'
def get_version(args)
  version = Version.new(args[:version])

  unless version.valid?
    puts "Version number must be in the following format: X.Y.Z-rc1 or X.Y.Z".colorize(:red)
    exit 1
  end

  version
end

def skip?(repo)
  ENV[repo.upcase] == 'false'
end

desc "Create release"
task :release, [:version] do |t, args|
  version = get_version(args)

  if skip?('ce')
    puts 'Skipping release for project'.colorize(:red)
  else
    puts 'CE release'.colorize(:blue)
    Release::GitlabCeRelease.new(version).execute
  end
end

desc "Sync master branch in remotes"
task :sync do
  if skip?('ce')
    puts 'Skipping sync for project'.colorize(:yellow)
  else
    Sync.new(Remotes.remotes).execute
  end
end

def create_or_show_issue(issue)
  if issue.exists?
    puts "--> Issue \"#{issue.title}\" already exists.".red
    puts "    #{issue.url}"
    exit 1
  else
    issue.create
    puts "--> Issue \"#{issue.title}\" created.".green
    puts "    #{issue.url}"
  end
end

desc "Create the monthly release issue"
task :monthly_issue, [:version] do |t, args|
  version = get_version(args)
  issue = MonthlyIssue.new(version)

  create_or_show_issue(issue)
end

desc "Create the regression tracking issue"
task :regression_issue, [:version] do |t, args|
  version = get_version(args)
  issue = RegressionIssue.new(version)

  create_or_show_issue(issue)
end

desc "Create a patch issue"
task :patch_issue, [:version] do |t, args|
  version = get_version(args)
  issue = PatchIssue.new(version)

  create_or_show_issue(issue)
end
