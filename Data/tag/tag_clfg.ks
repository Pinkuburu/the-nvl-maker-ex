;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
*window
[window_middle width=690 height=370 title="消除前景"]

[eval exp="drawFrame('基本信息',2,15,40,kag.fore.layers[5],314)"]
[line title="编号" name="f.参数.layer" x=30 y=60 type=list target="*选择前景层"]
[check title="连同话框" name="f.参数.hidemes" x=30 y=90]
[check title="连同头像" name="f.参数.clface" x=170 y=90]
[eval exp="drawFrame('切换效果',5,15,150,kag.fore.layers[5],314)"]
[frame_trans x=30 y=170]

[s]

*确认
[commit]
[eval exp="commitLine(f.参数)"]
[jump storage="tag_direct.ks" target=*擦除窗口]

*关闭选单
[jump storage="tag_direct.ks" target=*关闭选单]

;-----------------------------------------------------------------
*切换方式
[list_method x=34 y=200]
[s]

*卷动方向
[list_from x=34 y=230]
[s]

*背景停留
[list_stay x=34 y=260]
[s]

*选择前景层
[list_glayer x=34 y=60]
[s]

*关闭下拉菜单
[rclick enabled="false"]
[current layer="message6"]
[er]
[layopt layer="message6" visible="false"]
[jump target=*window]
;-----------------------------------------------------------------
*选择图片
[call storage="window_picture.ks"]
[jump target=*window]

