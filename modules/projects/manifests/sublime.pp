class projects::sublime {
  include sublime_text_3
  include sublime_text_3::package_control

  file { "/Users/huan/Library/Application Support/Sublime Text 3/Packages":
    ensure => link,
    target => "/Users/huan/Dropbox/Sublime/Packages"
  } -> sublime_text_3::package { 'TrailingSpaces':
    source => 'SublimeText/TrailingSpaces'
  }
}
