###
# mufgのcsvを変換
###
require "csv"
require_relative "../util.rb"

module Functions
  class Mufg
    EXPORT_HEADERS = ["日付", "支払い金", "預かり金", "摘要"].freeze

    def encoding
      "CP932:UTF-8"
    end

    def export(path, items, encoding: "CP932")
      file = CSV.open(path, "w", encoding: encoding)
      file.puts EXPORT_HEADERS

      items.each do |item|
        file_item = [
          item[:date],
          item[:payment],
          item[:deposit],
          item[:summary].encode(Encoding::CP932, fallback: cp932_fallback),
        ]
        file.puts(file_item)
      end
      file.close
    rescue Encoding::UndefinedConversionError
      file.close
      puts $!.error_char.dump   #=> "\u{a0}"
    end

    def convert(index, row)
      date, summary1, summary2, payment, deposit, balance, note, _, payment_division = row
      return nil unless date_format?(date)

      summary = note.nil? ? "#{summary1} | #{summary2}" : "#{summary1} | #{summary2} | #{note}"

      {
        index: index,
        date: date,
        payment: payment,
        deposit: deposit,
        balance: balance,
        summary: summary,
      }
    end
  end
end
