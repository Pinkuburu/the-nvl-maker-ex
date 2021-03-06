;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
*window
[window_middle width=400 height=450 title="图片位移"]

[line title="编号" name="f.参数.layer" x=30 y=50 type=list target="*选择前景层"]

[eval exp="drawFrame('相对数值',3,15,95,kag.fore.layers[5],314)"]
[line title="横向位移" name="f.参数.x" x=30 y=115]
[line title="纵向位移" name="f.参数.y" x=30 y=145]
[line title="透明" name="f.参数.opacity" x=30 y=175]

[eval exp="drawFrame('移动效果',3,15,230,kag.fore.layers[5],314)"]
[line title="时间" name="f.参数.time" x=30 y=250]
[line title="加速度" name="f.参数.accel" x=30 y=280]
[check title="可略过" name="f.参数.canskip" x=30 y=315]
[s]

*确认
[commit]
[eval exp="commitLine(f.参数)"]
[jump storage="tag_direct.ks" target=*擦除窗口]

*关闭选单
[jump storage="tag_direct.ks" target=*关闭选单]

*选择前景层
[list_fglayer x=34 y=50]
[s]

*关闭下拉菜单
[rclick enabled="false"]
[current layer="message6"]
[er]
[layopt layer="message6" visible="false"]
[jump target=*window]
