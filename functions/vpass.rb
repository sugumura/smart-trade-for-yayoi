###
# vpassのcsvを変換
###
require "csv"
require_relative "../util.rb"

module Functions
  class Vpass
    EXPORT_HEADERS = ["利用日", "購入額", "返金額", "摘要", "部門"].freeze

    def export(path, items, encoding: "CP932")
      file = CSV.open(path, "w", encoding: encoding)
      file.puts EXPORT_HEADERS

      items.each do |item|
        file_item = [
          item[:date],
          item[:price],
          0,
          item[:summary].encode(Encoding::CP932, fallback: cp932_fallback),
          "",
        ]
        file.puts(file_item)
      end
      file.close
    rescue Encoding::UndefinedConversionError
      file.close
      puts $!.error_char.dump   #=> "\u{a0}"
    end

    def convert(index, row)
      date, summary1, price1, _, _, price2, summary2 = row
      return nil unless date_format?(date)

      summary = summary2.nil? ? summary1 : "#{summary1} | #{summary2}"

      {
        index: index,
        date: date,
        price: price1 || price2,
        summary: summary,
      }
    end
  end
end
