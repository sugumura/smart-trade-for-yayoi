require "csv"

EXPORT_HEADERS = ["利用日", "購入額", "返金額", "摘要", "部門"].freeze
EXPORT_FILENAME = "out/export.csv"
UNDEFINED_SINGS = {
  "\u2014" => "\x81\x5C".force_encoding(Encoding::CP932), # — EM DASH
  "\u301C" => "\x81\x60".force_encoding(Encoding::CP932), # 〜 WAVE DASH
  "\u2016" => "\x81\x61".force_encoding(Encoding::CP932), # ‖ DOUBLE VERTICAL LINE
  "\u2212" => "\x81\x7C".force_encoding(Encoding::CP932), # − MINUS SIGN
  "\u00A2" => "\x81\x91".force_encoding(Encoding::CP932), # ¢ CENT SIGN
  "\u00A3" => "\x81\x92".force_encoding(Encoding::CP932), # £ POUND SIGN
  "\u00AC" => "\x81\xCA".force_encoding(Encoding::CP932), # ¬ NOT SIGN
}

def export_csv(items)
  file = CSV.open(EXPORT_FILENAME, "w", encoding: "CP932")
  file.puts EXPORT_HEADERS

  items.each do |item|
    file_item = [
      item[:date],
      item[:price],
      0,
      item[:tekiyou].encode(Encoding::Windows_31J, fallback: UNDEFINED_SINGS),
      "",
    ]
    file.puts(file_item)
  end
  file.close
rescue Encoding::UndefinedConversionError
  file.close
  puts $!.error_char.dump   #=> "\u{a0}"
end

def date_format?(date)
  "#{date}".match(/\A[0-9]{4}\/(0[1-9]|1[0-2])\/(0[1-9]|[12][0-9]|3[01])\z/)
end

# vpassからDLしたCSVに対応
def convert_vpass_csv(index, row)
  date, tekiyou1, price1, _, _, price2, tekiyou2 = row
  return nil unless date_format?(date)

  tekiyou = tekiyou2.nil? ? tekiyou1 : "#{tekiyou1} | #{tekiyou2}"

  {
    index: index,
    date: date,
    price: price1 || price2,
    tekiyou: tekiyou,
  }
end

def main
  names = []
  Dir.glob("data/**/*.csv") do |filename|
    names.push(filename)
  end

  all_items = []
  names.sort.each do |filename|
    p filename
    index = 0
    items = []
    CSV.foreach(filename, encoding: "CP932:UTF-8") do |row|
      # 行に対する処理
      convert_row = convert_vpass_csv(index, row)
      index = index + 1
      next if convert_row.nil?
      items.push(convert_row)
    end

    all_items.concat(items)
  end

  export_csv all_items
end

main
