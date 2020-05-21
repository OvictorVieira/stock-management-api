require 'simplecov'

SimpleCov.start do
  add_filter do |source_file|
    source_file.lines.count < 5
  end

  add_filter '/spec/'
end