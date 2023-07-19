#!/usr/bin/env ruby

require 'pathname'
require 'fileutils'
require 'pry'
# Our working directory should always be the script's directory
Dir.chdir(Pathname(__FILE__).dirname.expand_path)
puts "Cwd: #{Pathname('.').expand_path}"

# ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#  _______________
# ( Folder config )
#  ---------------
#         o   ^__^
#          o  (oo)\_______
#             (__)\       )\/\
#                 ||----w |
#                 ||     ||
# ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
BASE_FOLDER = Pathname.new('~/')
RELATIVE_FOLDERS = %w(
  .config/rofi
  .config/i3status
  .config/i3
)
RELATIVE_GLOBS = [*%w(
  .emacs.d/*.el
  .emacs.d/elisp/*.el
), *RELATIVE_FOLDERS.map{ |dir| File.join dir, '**/*' }]
IGNORE_GLOBS = %w(
  **/.emacs.d/custom.el
  *~
)
[RELATIVE_FOLDERS, RELATIVE_GLOBS].each do |pathset|
  pathset.map! { |p| BASE_FOLDER + Pathname.new(p) }
end

# ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#  ___________
# ( Main code )
#  -----------
#         o   ^__^
#          o  (oo)\_______
#             (__)\       )\/\
#                 ||----w |
#                 ||     ||
# ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DRY_RUN = ARGV.any? { |arg| arg.chomp == '--dry' }
if DRY_RUN
  puts "Dry run!"
  FileUtils = FileUtils::DryRun
end
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
  RELATIVE_GLOBS.each do |rel|
    Dir.glob(rel.expand_path BASE_FOLDER) do |a_path|
      a_path = Pathname a_path
      if IGNORE_GLOBS.map{|ig| a_path.fnmatch ig}.any?
        puts "skipping #{a_path}"
        next
      end
      rel_path = Pathname(a_path).relative_path_from(BASE_FOLDER.expand_path)
      unless rel_path.dirname.directory? or rel_path.dirname == '.'
        FileUtils.mkpath rel_path.dirname, verbose: true
      end
      FileUtils.cp a_path, rel_path, verbose: true
    end
  end
when 'oldpull'
  RELATIVE_FOLDERS.each do |rel|
    cmd "rsync -avhuP #{BASE_FOLDER.join(rel).to_s.chomp '/'}/ ./#{rel.chomp '/'}/"
  end
when 'install'
  cmd "find . -type f -not -name 'make.rb' -not -path '*/.git/*' -exec cp -ri '{}' '#{BASE_FOLDER}{}'"
else
  puts "usage: #{__FILE__} [pull | install] (--dry)"
  exit -1
end
