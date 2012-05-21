;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;--------------------------------------------------
;對話框設定,包括left,top,frame,margin
;--------------------------------------------------
*window
[window_middle width=400 height=380 title="對話框樣式設定"]

[line title="圖片" name="f.參數.frame" x=30 y=50 type="pic" path="others"]

[line title="left" name="f.參數.left" x=30 y=80]
[line title="top " name="f.參數.top" x=30 y=110]

[line title="頁邊距設定" x=30 y=140]
[line title="左" name="f.參數.marginl" x=30 y=170]
[line title="右" name="f.參數.marginr" x=30 y=200]
[line title="上" name="f.參數.margint" x=30 y=230]
[line title="下" name="f.參數.marginb" x=30 y=260] [link hint="點此打開邊距設定窗口" target=*直接設定]□[endlink]
[s]


*直接設定
[call storage="window_margin.ks"]
[jump target=*window]

*選擇圖片
[call storage="window_picture.ks"]
[jump target=*window]

*確認
[commit]

*關閉選單
[freeimage layer="5"]
[current layer="message5"]
[er]
[layopt layer="message5" visible="false"]
[return]
