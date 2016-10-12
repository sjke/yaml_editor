# frozen_string_literal: true
require 'psych'
require 'yaml'

module Psych
  module Visitors
    class ToRuby
      def revive_hash(hash, o)
        @st[o.anchor] = hash if o.anchor

        o.children.each_slice(2) do |k, v|
          key = accept(k)
          hash[key] = accept(v)
        end
        hash
      end
    end
  end
end

module YamlEditor
  class Editor
    BROKEN_ANCHOR_INSERT_PATTER = '!!str \'<<\''.freeze
    VALID_ANCHOR_INSERT_PATTERN = '<<'.freeze

    def initialize(file_path)
      @file_path = file_path
      tree = Psych.parse File.read(@file_path)
      @data = Psych::Visitors::ToRuby.create.accept tree
    end

    def edit_config(&_block)
      each_with_data(@data) { |data, key, value, parent| yield(data, key, value, parent) }
    end

    def save
      File.open(@file_path, 'w') do |f|
        f.write @data.to_yaml.gsub(BROKEN_ANCHOR_INSERT_PATTER, VALID_ANCHOR_INSERT_PATTERN)
      end
    end

    private

    def each_with_data(data, parent = [])
      data.each do |key, value|
        next if key == VALID_ANCHOR_INSERT_PATTERN
        if value.is_a?(Hash)
          each_with_data(value, parent.clone.push(key)) do |data, key, value, parent|
            yield(data, key, value, parent)
          end
        else
          yield(data, key, value, parent)
        end
      end
    end
  end
end
