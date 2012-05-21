;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
*window
[window_middle width=400 height=450 title="圖片位移"]

[line title="編號" name="f.參數.layer" x=30 y=50 type=list target="*選擇前景層"]

[eval exp="drawFrame('相對數值',3,15,95,kag.fore.layers[5],314)"]
[line title="橫向位移" name="f.參數.x" x=30 y=115]
[line title="縱向位移" name="f.參數.y" x=30 y=145]
[line title="透明" name="f.參數.opacity" x=30 y=175]

[eval exp="drawFrame('移動效果',3,15,230,kag.fore.layers[5],314)"]
[line title="時間" name="f.參數.time" x=30 y=250]
[line title="加速度" name="f.參數.accel" x=30 y=280]
[check title="可略過" name="f.參數.canskip" x=30 y=315]
[s]

*確認
[commit]
[eval exp="commitLine(f.參數)"]
[jump storage="tag_direct.ks" target=*擦除窗口]

*關閉選單
[jump storage="tag_direct.ks" target=*關閉選單]

*選擇前景層
[list_fglayer x=34 y=50]
[s]

*關閉下拉菜單
[rclick enabled="false"]
[current layer="message6"]
[er]
[layopt layer="message6" visible="false"]
[jump target=*window]
