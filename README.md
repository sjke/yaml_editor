# YamlEditor
*** IN PROGRESS [Don't user in production] ***

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/yaml_editor`. To experiment with that code, run `bin/console` for an interactive prompt.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'yaml_editor'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install yaml_editor

## Usage

Example:
```ruby
require 'highline'
require "yaml_editor"

cli = HighLine.new
APP_ROOT = Pathname.new File.expand_path('../../', __FILE__)

puts "\n== Configure settings =="
Dir[File.expand_path('config/*.yml', APP_ROOT)].each do |file|
  next unless cli.agree("\n You want to change the settings for #{file.gsub("#{APP_ROOT}/", '')}? (Y/N)")
  editor = YamlEditor::Editor.new(file)
  editor.edit_config do |data, key, value, parent|
    next if parent.include?('production')
    data[key] = cli.ask("#{parent.clone.push(key).join('.')}: ") { |q| q.default = value.to_s }
  end
  editor.save
end

```
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sjke/yaml_editor.
