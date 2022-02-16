require "optparse"

require_relative "./functions/vpass.rb"
require_relative "./functions/mufg.rb"
require_relative "./functions/suica.rb"

EXPORT_FILENAME = "out/export.csv"

def main
  opt = OptionParser.new
  argv = opt.parse(ARGV)

  clazz = nil
  if argv == ["vpass"]
    clazz = Functions::Vpass
  elsif argv == ["mufg"]
    clazz = Functions::Mufg
  elsif argv == ["suica"]
    clazz = Functions::Suica
  else
    return
  end

  names = []
  Dir.glob("data/**/*.csv") do |filename|
    names.push(filename)
  end

  clazz = clazz.new
  all_items = []
  names.sort.each do |filename|
    p filename
    index = 0
    items = []
    CSV.foreach(filename, encoding: clazz.encoding) do |row|
      # 行に対する処理
      convert_row = clazz.convert(index, row)
      index = index + 1
      next if convert_row.nil?
      items.push(convert_row)
    end

    all_items.concat(items)
  end

  clazz.export(EXPORT_FILENAME, all_items)
end

main
