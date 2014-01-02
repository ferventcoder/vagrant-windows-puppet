Package {
  provider => chocolatey,
}

package {'ruby':
  ensure => '1.9.3.48400',
} ->
package {'ruby.devkit':
  ensure => latest,
} ->
package {'bundler':
  ensure => latest,
  provider => gem,
} ->
package {'debugger':
  ensure => '1.6.2',
  provider => gem,
}
# must build debugger separate since it requires devkit
