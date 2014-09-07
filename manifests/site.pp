require boxen::environment
require homebrew
require gcc

Exec {
  group       => 'staff',
  logoutput   => on_failure,
  user        => $boxen_user,

  path => [
    "${boxen::config::home}/rbenv/shims",
    "${boxen::config::home}/rbenv/bin",
    "${boxen::config::home}/rbenv/plugins/ruby-build/bin",
    "${boxen::config::home}/homebrew/bin",
    '/usr/bin',
    '/bin',
    '/usr/sbin',
    '/sbin'
  ],

  environment => [
    "HOMEBREW_CACHE=${homebrew::config::cachedir}",
    "HOME=/Users/${::boxen_user}"
  ]
}

File {
  group => 'staff',
  owner => $boxen_user
}

Package {
  provider => homebrew,
  require  => Class['homebrew']
}

Repository {
  provider => git,
  extra    => [
    '--recurse-submodules'
  ],
  require  => File["${boxen::config::bindir}/boxen-git-credential"],
  config   => {
    'credential.helper' => "${boxen::config::bindir}/boxen-git-credential"
  }
}

Service {
  provider => ghlaunchd
}

Homebrew::Formula <| |> -> Package <| |>

node default {
  # core modules, needed for most things
  include dnsmasq
  include git
  include hub
  include nginx
  include chrome
  include zsh
  include brewcask

  # fail if FDE is not enabled
  if $::root_encrypted == 'no' {
    fail('Please enable full disk encryption and try again')
  }

  # node versions
  include nodejs::v0_6
  include nodejs::v0_8
  include nodejs::v0_10

  # default ruby versions
  ruby::version { '1.9.3': }
  ruby::version { '2.0.0': }
  ruby::version { '2.1.0': }
  ruby::version { '2.1.1': }
  ruby::version { '2.1.2': }

  # common, useful packages
  package {
    [
      'ack',
      'findutils',
      'gnu-tar'
    ]:
  }

  file { "${boxen::config::srcdir}/our-boxen":
    ensure => link,
    target => $boxen::config::repodir
  }

  file { "/usr/local":
    ensure => directory
  } ->
  package { 'sublime-text':
    provider => 'brewcask'
  }

  # ohmyzsh
  $home = "/Users/${::boxen_user}"
  $github_user = "doboy"

  $oh_my_zsh_dir = "${boxen::config::srcdir}/.oh-my-zsh"
  repository { $oh_my_zsh_dir:
    source => "${github_user}/oh-my-zsh"
  } ->
  file { "${home}/.oh-my-zsh":
    ensure  => link,
    target  => "${boxen::config::srcdir}/.oh-my-zsh"
  }

  # dotfiles
  $dotfiles_dir = "${boxen::config::srcdir}/dotfiles"

  repository { $dotfiles_dir:
    source => "${github_user}/dotfiles"
  }

  file { "${home}/.aliases":
    ensure  => link,
    target  => "${dotfiles_dir}/.aliases",
    require => Repository[$dotfiles_dir]
  }

  file { "${home}/.zshrc":
    ensure  => link,
    target  => "${dotfiles_dir}/.zshrc",
    require => Repository[$dotfiles_dir]
  }

  file { "${home}/.s3cfg":
    ensure  => link,
    target  => "${dotfiles_dir}/.s3cfg",
    require => Repository[$dotfiles_dir]
  }

  file { "${home}/.gitignore_global":
    ensure  => link,
    target  => "${dotfiles_dir}/.gitignore_global",
    require => Repository[$dotfiles_dir]
  }

  file { "${home}/.ssh":
    ensure  => link,
    target  => "${dotfiles_dir}/.ssh",
    require => Repository[$dotfiles_dir]
  }

  file { "${home}/.emacs.d":
    ensure  => link,
    target  => "${dotfiles_dir}/.emacs.d",
    require => Repository[$dotfiles_dir]
  }

  file { "${home}/.emacs":
    ensure  => link,
    target  => "${dotfiles_dir}/.emacs",
    require => Repository[$dotfiles_dir]
  }

  # git stuff
  git::config::global { 'user.email':
    value  => 'doboy0@gmail.com'
  }

  git::config::global { 'user.name':
    value  => 'Huan Do'
  }

  git::config::global { 'github.user':
    value  => 'doboy'
  }

  git::config::global { 'alias.br':
    value  => 'branch'
  }

  git::config::global { 'alias.co':
    value  => 'checkout'
  }

  git::config::global { 'alias.ci':
    value  => 'commit'
  }

  git::config::global { 'alias.cp':
    value  => 'cherry-pick'
  }

  git::config::global { 'alias.di':
    value  => 'diff'
  }

  git::config::global { 'alias.dic':
    value  => 'diff --cached'
  }

  git::config::global { 'alias.sh':
    value  => 'show'
  }

  git::config::global { 'alias.st':
    value  => 'status'
  }

  git::config::global { 'alias.l':
    value  => '"!fn() { git log $* --graph --pretty=\'tformat:%C(yellow)%h %Cgreen(%ar) %C(blue)<%an> %C(red)%s\'; }; fn"'
  }

  git::config::global { 'alias.bls':
    value  => 'for-each-ref --sort=-committerdate --format=\'  %(refname:short)\' refs/heads/'
  }

  git::config::global { 'color.ui':
    value  => true
  }

  git::config::global { 'alias.push':
    value  => simple
  }
}
