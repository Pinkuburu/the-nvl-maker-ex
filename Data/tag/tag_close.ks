;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
*window
[window_middle width=400 height=300 title="離開遊戲"]
[group title="離開遊戲" name="f.參數.tagname" x=30 y=50 comp="close"]
[group title="返回標題" name="f.參數.tagname" x=30 y=80 comp="gotostart"]

[check title="詢問" name="f.參數.ask" x=30 y=140]

[s]

*確認
[commit]
[eval exp="commitLine(f.參數)"]
[jump storage="tag_direct.ks" target=*擦除窗口]

*關閉選單
[jump storage="tag_direct.ks" target=*關閉選單]
