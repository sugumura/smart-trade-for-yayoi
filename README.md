# for スマート取引（弥生）

クレジットカードのCSVデータを弥生のスマート取引で扱えるように変換するスクリプト。
日付が入っていない行はスキップするので割引などは出力に入らない可能性があることに注意してください(ＷＥＢ明細書年会費割引など)

vpassと三菱UFJ銀行のCSVファイルのみ対応しています

## How to use

dataフォルダにcsvファイルを配置する

```
# 例
data/20220201.csv
data/20220202.csv
...
```

rubyスクリプトを実行する

```
# vpass
$ ruby convert.rb vpass
# output to out/export.csv


# 三菱東京UFJ
$ ruby convert.rb mufg
# output to out/export.csv
```

## スマート取引の設定

公式ガイドを参照

https://www.yayoi-kk.co.jp/smart/d_file/smart_operation_guide_01.pdf

```
参考）現預金の入出金以外の明細ファイルを取り込む > クレジットカード明細の取込
```
