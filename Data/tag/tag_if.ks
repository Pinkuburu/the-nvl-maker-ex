;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
*window
[window_middle width=400 height=300 title="条件分歧"]

[group title="条件分歧" name="f.参数.tagname" x=30 y=50 comp="if"]
[group title="继续分歧" name="f.参数.tagname" x=30 y=80 comp="elsif"]

[line title="表达式" name="f.参数.exp" type="cond" x=30 y=140]

[s]

*生成条件
[call storage="window_cond.ks"]
[jump target=*window]

*确认
[commit]
[eval exp="commitLine(f.参数)"]
[jump storage="tag_direct.ks" target=*擦除窗口]

*关闭选单
[jump storage="tag_direct.ks" target=*关闭选单]
