# for スマート取引（弥生）

クレジットカードのCSVデータを弥生のスマート取引で扱えるように変換するスクリプト。
日付が入っていない行はスキップするので割引などは出力に入らない可能性があることに注意(ＷＥＢ明細書年会費割引など)

対応CSV

- vpass
- 三菱UFJ銀行
- Suica (Suica Reader)


## How to use

dataフォルダにcsvファイルを配置する

```
# 例
data/20220201.csv
data/20220202.csv
...
```

## 実行


### vpass

```
$ ruby convert.rb vpass
# output to out/export.csv
```


### 三菱UFJ銀行

```
$ ruby convert.rb mufg
# output to out/export.csv
```

### Suica (Suica Reader)

AndroidのSuica ReaderのCSV  
https://play.google.com/store/apps/details?id=yanzm.products.suicareader&hl=en_US&gl=US

設定で以下を行う

|key|value|
|---|-----|
|CSVファイルの文字コード |Shift_JIS |
|チャージと支払を別の列にする |✅ |

```
$ ruby convert.rb suica
# output to out/export.csv
```

## スマート取引の設定

公式ガイドを参照

https://www.yayoi-kk.co.jp/smart/d_file/smart_operation_guide_01.pdf

```
参考）現預金の入出金以外の明細ファイルを取り込む > クレジットカード明細の取込
```
