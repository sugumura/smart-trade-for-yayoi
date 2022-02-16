UNDEFINED_SINGS = {
  "\u2014" => "\x81\x5C".force_encoding(Encoding::CP932), # — EM DASH
  "\u301C" => "\x81\x60".force_encoding(Encoding::CP932), # 〜 WAVE DASH
  "\u2016" => "\x81\x61".force_encoding(Encoding::CP932), # ‖ DOUBLE VERTICAL LINE
  "\u2212" => "\x81\x7C".force_encoding(Encoding::CP932), # − MINUS SIGN
  "\u00A2" => "\x81\x91".force_encoding(Encoding::CP932), # ¢ CENT SIGN
  "\u00A3" => "\x81\x92".force_encoding(Encoding::CP932), # £ POUND SIGN
  "\u00AC" => "\x81\xCA".force_encoding(Encoding::CP932), # ¬ NOT SIGN
}.freeze

# 2021/01/01, 2021/1/1のような日付判定
# @param [String] date
# @return [Boolean]
def date_format?(date)
  "#{date}".match(/\A[0-9]{4}\/\d{1,2}\/\d{1,2}\z/)
end

# 2021年01月01日, 2021年1月日のような日付判定
# @param [String] date
# @return [Boolean]
def kanji_date_format?(date)
  "#{date}".match(/\A[0-9]{4}年\d{1,2}月\d{1,2}日\z/)
end

def cp932_fallback
  UNDEFINED_SINGS
end
