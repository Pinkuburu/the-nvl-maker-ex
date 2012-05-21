;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
*window
[window_middle width=400 height=400 title="調用地圖"]
[line title="文件" name="f.參數.storage" x=30 y=50 type="map"]
[eval exp="drawFrame('顯示效果',5,15,100,kag.fore.layers[5],314)"]
[frame_trans x=30 y=120]
[s]

*確認
[commit]
[eval exp="commitLine(f.參數)"]
[jump storage="tag_direct.ks" target=*擦除窗口]

*關閉選單
[jump storage="tag_direct.ks" target=*關閉選單]

;-----------------------------------------------------------------
*切換方式
[list_method x=34 y=150]
[s]

*捲動方向
[list_from x=34 y=180]
[s]

*背景停留
[list_stay x=34 y=210]
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
;-----------------------------------------------------------------
*選擇文件
[call storage="window_file.ks"]
[jump target=*window]
;-----------------------------------------------------------------
