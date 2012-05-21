;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
[iscript]
//初始值設定
f.參數.time=500;
[endscript]
*window
[window_middle width=400 height=300 title="停止音樂"]

[group title="停止音樂" name="f.參數.tagname" x=30 y=50 comp="stopbgm"]
[group title="音樂漸變" name="f.參數.tagname" x=30 y=80 comp="fadebgm"]
[group title="音樂漸出" name="f.參數.tagname" x=30 y=110 comp="fadeoutbgm"]

[if exp="f.參數.tagname=='fadeoutbgm'"]
[line title="時間" name="f.參數.time" x=30 y=150]
[elsif exp="f.參數.tagname=='fadebgm'"]
[line title="時間" name="f.參數.time" x=30 y=150]
[line title="音量" name="f.參數.volume" x=30 y=180]
[endif]

[s]

*確認
[commit]
[iscript]
//清理非必要參數
if (f.參數.tagname=="stopbgm") 
{
f.參數.time=void;
f.參數.volume=void;
}
else if (f.參數.tagname=="fadeoutbgm")
{
f.參數.volume=void;
}
[endscript]
[eval exp="commitLine(f.參數)"]
[jump storage="tag_direct.ks" target=*擦除窗口]

*關閉選單
[jump storage="tag_direct.ks" target=*關閉選單]
