class projects::dotfiles {
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
}
