#!/usr/bin/env ruby

# TODO: There's a lot of sensitive info we don't want to copy from emacs

require 'pathname'

BASE_FOLDER = Pathname.new('~/')
RELATIVE_FOLDERS = %w(
  .config/rofi
  .config/i3status
  .config/i3
  .emacs.d
)
DRY_RUN = ARGV.any? { |arg| arg.chomp == '--dry' }
puts "Dry run!" if DRY_RUN

def cmd(s)
  puts "$ #{s}"
  unless DRY_RUN
    print "==> "
    puts `#{s}`
    puts
  end
end

case ARGV.first
when 'pull'
  RELATIVE_FOLDERS.each do |rel|
    cmd "rsync -avhuP #{BASE_FOLDER.join(rel).to_s.chomp '/'}/ ./#{rel.chomp '/'}/"
  end
when 'install'
  cmd "find . -type f -not -name 'make.rb' -not -path '*/.git/*' -exec cp -ri '{}' '#{BASE_FOLDER}{}'"
else
  puts "usage: #{__FILE__} [pull | install] (--dry)"
  exit -1
end
