;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;--------------------------------------------------
;地圖據點設定
;--------------------------------------------------
*window
[window_middle width=700 height=365 title="地圖據點設定"]
[iscript]
drawFrame("顯示設定",2,15,40,kag.fore.layers[5],314);
drawFrame("按鈕音效",2,345,40,kag.fore.layers[5],314);
drawFrame("按鈕圖形",5,15,145,kag.fore.layers[5],314);
drawFrame("執行操作",3,345,145,kag.fore.layers[5],314);
[endscript]

[line title="地名" name="f.參數.place" x=30 y=60]
[line title="條件" name="f.參數.cond" type="cond" x=30 y=90]

[line title="x" name="f.參數.x" x=30 y=165]
[line title="y" name="f.參數.y" x=30 y=195]
[line title="一般" name="f.參數.normal" x=30 y=225 type="pic" path="map"]
[line title="選中" name="f.參數.over" x=30 y=255 type="pic" path="map" copyfrom="f.參數.normal"]
[line title="按下" name="f.參數.on" x=30 y=285 type="pic" path="map" copyfrom="f.參數.over"]

[line title="選中SE" name="f.參數.enterse" x=360 y=60 type="sound"]
[line title="按下SE" name="f.參數.clickse" x=360 y=90 type="sound"]

[line title="劇本" name="f.參數.storage" x=360 y=165 type="script"]
[line title="標籤" name="f.參數.target" x=360 y=195]
[line title="表達式" name="f.參數.exp" x=360 y=225]
[s]

*生成條件
[call storage="window_cond.ks"]
[jump target=*window]

*選擇圖片
[call storage="window_picture.ks"]
[jump target=*window]

*選擇音聲
[call storage="window_bgm.ks"]
[jump target=*window]

*選擇文件
[call storage="window_file.ks"]
[jump target=*window]

*確認
[commit]
[iscript]
//防止出錯用——假如參數開頭不是星號，強制加入星號
if (f.參數.target!=void && f.參數.target[0]!="*") f.參數.target="*"+f.參數.target;
[endscript]
[eval exp=&"tf.當前操作層+'.Reset(f.參數)'"]

*關閉選單
[freeimage layer="5"]
[current layer="message5"]
[er]
[layopt layer="message5" visible="false"]
[return]
