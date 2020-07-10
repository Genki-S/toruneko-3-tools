#!/usr/bin/env ruby

require 'open3'

ARGF.each do |line|
  unless line =~ /gen "/
    puts line
    next
  end

  itemName = /gen "([^"]*)"/.match(line).captures[0]
  mecabOutput, status = Open3.capture2('mecab', stdin_data: itemName)
  unless status.success?
    raise 'mecab failed'
  end

  reading = ''
  mecabOutput.each_line do |l|
    next if l.chomp == "EOS"
    reading += l.split(',').last.chomp
  end

  hiragana, status = Open3.capture2('nkf --hiragana', stdin_data: reading)
  unless status.success?
    raise 'nkf failed'
  end

  puts line.sub(/(.*)gen "([^"]*)"(.*)/, '\1gen "\2" "' + "#{hiragana}" + '"\3')
end

