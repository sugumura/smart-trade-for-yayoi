# for スマート取引（弥生）

クレジットカードのCSVデータを弥生のスマート取引で扱えるように変換するスクリプト。
日付が入っていない行はスキップするので割引などは出力に入らない可能性があることに注意してください(ＷＥＢ明細書年会費割引など)

vpassのCSVファイルのみ対応しています

## How to use

dataフォルダにvpassからダウンロードしたcsvファイルを配置する

```
# 例
data/20220201.csv
data/20220202.csv
...
```

rubyスクリプトを実行する

```
$ ruby convert.rb
# output to out/export.csv
```

## スマート取引の設定

公式ガイドを参照

https://www.yayoi-kk.co.jp/smart/d_file/smart_operation_guide_01.pdf

```
参考）現預金の入出金以外の明細ファイルを取り込む > クレジットカード明細の取込
```
