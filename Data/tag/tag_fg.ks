;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
[iscript]
if (f.參數.left!=void || f.參數.top!=void)
{
   f.參數.locate=true;
}
[endscript]
*window
[window_middle width=690 height=370 title="顯示人物"]
[eval exp="drawFrame('基本信息',2,15,40,kag.fore.layers[5],314)"]
[line title="文件" name="f.參數.storage" x=30 y=60 type="pic" path="fgimage"]
[line title="編號" name="f.參數.layer" x=30 y=90 type=list target="*選擇前景層"]

[eval exp="drawFrame('顯示效果',5,15,150,kag.fore.layers[5],314)"]
[frame_trans x=30 y=170]

[eval exp="drawFrame('位置設定',4,345,40,kag.fore.layers[5],314)"]
[group title="不改變" name="f.參數.pos" x=360 y=60 comp=""]
[group title="居左" name="f.參數.pos" x=440 y=60 comp="left"]
[group title="居中" name="f.參數.pos" x=510 y=60 comp="center"]
[group title="居右" name="f.參數.pos" x=580 y=60 comp="right"]

[check title="直接指定" name="f.參數.locate" x=360 y=90]
[pos valuex="f.參數.left" valuey="f.參數.top" x=360 y=120 true="f.參數.locate"]

[eval exp="drawFrame('其他',1,345,210,kag.fore.layers[5],314)"]
[line title="透明度" name="f.參數.opacity" x=360 y=230]
[s]

*確認
[commit]

[iscript]
if (f.參數.locate==false)
{
   f.參數.left=void;
   f.參數.top=void;
}
[endscript]

[eval exp="commitLine(f.參數)"]
[jump storage="tag_direct.ks" target=*擦除窗口]

*關閉選單
[jump storage="tag_direct.ks" target=*關閉選單]

;-----------------------------------------------------------------
*切換方式
[list_method x=34 y=200]
[s]

*捲動方向
[list_from x=34 y=230]
[s]

*背景停留
[list_stay x=34 y=260]
[s]

*選擇前景層
[list_fglayer x=34 y=90]
[s]

*關閉下拉菜單
[rclick enabled="false"]
[current layer="message6"]
[er]
[layopt layer="message6" visible="false"]
[jump target=*window]
;-----------------------------------------------------------------
*選擇圖片
[call storage="window_picture.ks"]
[jump target=*window]

*選擇顏色
[call storage="window_color.ks"]
[jump target=*window]
