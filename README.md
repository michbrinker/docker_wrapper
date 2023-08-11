# DockerWrapper

Simple wrapper for the docker command. Launch new docker instances, read log output, and get information on a currently running instance.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'docker_wrapper'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install docker_wrapper

## Usage

Create a new docker container.
```
  docker = DockerWrapper::Container.new('name', image: 'hello-world')
```

Alternatively, create a new docker container and pass environment variables and volume mappings as array arguments to the docker container.
```
  docker = DockerWrapper::Container.new('name', image: 'hello-world', env: ['LOCAL_DIR'], volume: ['/tmp/test:/test'])
```

Run the docker container. The `create` and `run` methods accept additional parameters as argument that can be passed on to the docker container during run-time.
```
  docker.run('my_parameters')
```

View the log output. This output is returned as an array.
```
  puts docker.logs
```

Shut down the docker container by using the `rm` method.
```
  docker.rm
```

Additional methods include `inspect` to view the container information, `running?` to get a Boolean result on its current status, and `exec` to execute a given command on the running docker container.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/docker_wrapper. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the DockerWrapper project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/docker_wrapper/blob/master/CODE_OF_CONDUCT.md).
