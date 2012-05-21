;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
*window
[window_middle width=400 height=330 title="天氣效果"]
[line title="下雨" x=30 y=50]
[group title="ON" name="f.參數.tagname" x=100 y=50 comp="raininit"]
[group title="OFF" name="f.參數.tagname" x=170 y=50 comp="rainuninit"]
[line title="下雪" x=30 y=80]
[group title="ON" name="f.參數.tagname" x=100 y=80 comp="snowinit"]
[group title="OFF" name="f.參數.tagname" x=170 y=80 comp="snowuninit"]
[line title="舊電影" x=30 y=110]
[group title="ON" name="f.參數.tagname" x=100 y=110 comp="oldmovieinit"]
[group title="OFF" name="f.參數.tagname" x=170 y=110 comp="oldmovieuninit"]
[line title="櫻花" x=30 y=140]
[group title="ON" name="f.參數.tagname" x=100 y=140 comp="sakurainit"]
[group title="OFF" name="f.參數.tagname" x=170 y=140 comp="sakurauninit"]
[line title="紅葉" x=30 y=170]
[group title="ON" name="f.參數.tagname" x=100 y=170 comp="momijiinit"]
[group title="OFF" name="f.參數.tagname" x=170 y=170 comp="momijiuninit"]
[line title="霧氣" x=30 y=200]
[group title="ON" name="f.參數.tagname" x=100 y=200 comp="foginit"]
[group title="OFF" name="f.參數.tagname" x=170 y=200 comp="foguninit"]
[line title="螢火" x=30 y=230]
[group title="ON" name="f.參數.tagname" x=100 y=230 comp="fireflyinit"]
[group title="OFF" name="f.參數.tagname" x=170 y=230 comp="fireflyuninit"]
[s]

*確認
[commit]
[eval exp="commitLine(f.參數)"]
[jump storage="tag_direct.ks" target=*擦除窗口]

*關閉選單
[jump storage="tag_direct.ks" target=*關閉選單]
