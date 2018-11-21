# WrapScriptforFFmpegX264
This is VBScripts for encoding with x264 of ffmpeg.  
ffmpegでx264エンコードするためのVBScriptです。  

## 特徴
`main.wsf`にファイルをD&Dするとエンコードを開始します。batファイルと違いファイル名に`! & % ...`などやUnicode文字があっても問題が生じません。 Unicode文字も使えます。 

エンコーダーは`libx264`を使います。30fps以下のソース映像を24fpsへエンコードする事を主目的にしています。インターレースはプログレッシブに変換されます。

出力映像の解像度から自動的に`crf`値を決定します。ソース解像度を気にせずほぼ同じ品質でエンコードできます。
~~~
    crf = a * log(width * height) / log(10) + b
~~~
`a`および`b`は定数です。オプションでcrf値を指定する事もできます。

出力映像の縦解像度を指定できます。  
`16：9`映像を`4:3`へクロップできます。
音声は再エンコードせずそのままコピーします。mpeg tsの時はビットストリームフィルタaac_adtstoascを使います。

## 使い方
[Blog Signal Flag Z](https://signal-flag-z.blogspot.com/2018/10/ffmpeg-libx264-VBScript.html)
~~~
    main.wsf [/Test:] [/Height:value] [/Gop:value] [/Crf:value] [/Tune:string] [/Preset:string] [/A:value] [/B:value] [/Ext:string] [/Fps:string] [/Crop:{43, 43+}] [/Detelecine] [/Deinterlace] [/Depth:{8, 10}] arg1 [arg2 arg3 ...] 
~~~
スクリプトと同じフォルダに`ffmpeg`と`ffprobe`を置いてください。
`main.wsf`にファイルをD&Dします。`main.wsf`のショートカットを作成し、リンク先を`cscript.exe main.wsf /Height:720`等としておくと便利です。
エンコードしたファイルはドロップしたファイルと同じフォルダに、同じ名前で拡張子`mkv`として出力されます。同名ファイルがある場合は`mkv`フォルダを作りそこに出力します。`mkv`フォルダ下に同名ファイルがある時は上書きします。

### options
| option | argument | description | default | example |
|:---:|:---|:---|:---|:---|
|/Test: |なし |エンコードせずエンコードコマンドを表示しクリップボードへコピー |false |`/Test` |
|/Heigh: |なし |高さでリサイズ |指定なし |`/Height:720` |
|/Gop: |数値 |gop長指定 |指定なし |`/Gop:48` |
|/Crf: |数値 |crf値指定 |出力解像度より決定 |`/Crf:26` |
|/Tune: |文字列 |tuneパラメータ |指定なし |`/Tune:Film` |
|/Preset: |文字列 |presetパラメータ |`medium` |`/Preset:slow` |
|/A: |数値 |a値 |`12.85097209` |`/A:12.9` |
|/B: |数値 |b値 |`-55.17605647` |`/B:-54` |
|/Ext: |文字列 |出力ファイルの拡張子　コンテナを決める |`mkv` |`/Ext:mp4` |
|/Fps: |文字列 or 数値 |fps値指定 |入力と同じ |`/Fps:30` `/Fps:24000/1001` |
|/Crop: |`43` or `43+` |4:3にクロップ `43+`はやや幅広  |指定なし |`/Crop:43` `/Crop:43+` |
|/Detelecine |なし |テレシネ解除を強制  |指定なし |`/Detelecine` |
|/Deinterlace |なし |インターレース解除に`mcdeint`を使用  |インターレース時は`bwdif`で解除 |`/Deinterlace` |
|/Depth: |文字列 |`8`or`10` ビット深度指定 |`8` |`/Depth` `/Depth:10` |
<!---|/Bsfa: |文字列 |オーディオbitstream filter指定 |指定なし |`/Bsfa:aac_adtstoasc` |--->
<!---|/Pixfmt: |文字列 |pix_fmtの設定 |`yuv420p` |`/Pixfmt:yuv420p10le` |--->
