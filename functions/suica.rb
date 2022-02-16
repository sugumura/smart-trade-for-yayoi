###
# Suica Readerのcsvを変換
#
# 設定
# |key                      |value     |
# |-------------------------|----------|
# |CSVファイルの文字コード     |Shift_JIS |
# |チャージと支払を別の列にする |✅         |
###
require "csv"
require_relative "../util.rb"

module Functions
  class Suica
    EXPORT_HEADERS = ["No", "日付", "処理金額", "チャージなど", "摘要", "残高"].freeze

    def encoding
      "CP932:UTF-8"
    end

    def export(path, items, encoding: "CP932")
      file = CSV.open(path, "w", encoding: encoding)
      file.puts EXPORT_HEADERS

      items.each do |item|
        file_item = [
          item[:no],
          item[:date].encode(Encoding::CP932, fallback: cp932_fallback),
          item[:price],
          item[:charge],
          item[:summary].encode(Encoding::CP932, fallback: cp932_fallback),
          item[:balance],
        ]
        file.puts(file_item)
      end
      file.close
    rescue Encoding::UndefinedConversionError
      file.close
      puts $!.error_char.dump   #=> "\u{a0}"
    end

    def convert(index, row)
      no, date, price, charge, summary1, summary2, balance = row
      return nil unless kanji_date_format?(date)
      if price.to_s.empty? && charge.to_s.empty?
        return nil
      end

      summary = "#{summary1} | #{summary2}"

      {
        index: index,
        no: no,
        date: date,
        price: price,
        charge: charge,
        summary: summary.gsub(/[\r\n]/, ""),
        balance: balance,
      }
    end
  end
end
