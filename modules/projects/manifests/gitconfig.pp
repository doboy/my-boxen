class projects::gitconfig {
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
    value  => 'log --graph'
  }

  git::config::global { 'alias.bls':
    value  => 'for-each-ref --sort=-committerdate --format=\'  %(refname:short)\' refs/heads/'
  }

  git::config::global { 'color.ui':
    value  => true
  }

  git::config::global { 'push.default':
    value  => simple
  }
}
