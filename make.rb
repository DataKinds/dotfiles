#!/usr/bin/env ruby

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
  puts s
  `#{s}` unless DRY_RUN
end

case ARGV.first
when 'pull'
  RELATIVE_FOLDERS.each do |rel|
    cmd "cp -r #{BASE_FOLDER.join rel} ./#{rel}"
  end
when 'install'
  cmd "find . -type f -not -name 'make.rb' -not -path '*/.git/*' -exec cp -ri '{}' '#{BASE_FOLDER}{}'"
else
  puts "usage: #{__FILE__} [pull | install] (--dry)"
  exit -1
end
