;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
*window
[window_middle width=400 height=370 title="显示姓名栏(主角)"]
[eval exp="drawFrame('基本信息',2,15,40,kag.fore.layers[5],314)"]
[line title="简称" name="f.参数.tagname" x=30 y=60 type="list" target=*选择姓名]
[line title="颜色" name="f.参数.color" x=30 y=90 type="color"]
[eval exp="drawFrame('同时显示',3,15,150,kag.fore.layers[5],314)"]
[line title="头像" name="f.参数.face" x=30 y=170 type="pic" path="face"]
[line title="角色" name="f.参数.fg" x=30 y=200 type="pic" path="fgimage"]
[line title="编号" name="f.参数.layer" x=30 y=230 type=list target="*选择前景层"]
[s]

*确认
[commit]
[eval exp="commitLine(f.参数)"]
[jump storage="tag_direct.ks" target=*擦除窗口]

*关闭选单
[jump storage="tag_direct.ks" target=*关闭选单]

*选择前景层
[list_fglayer x=34 y=230]
[s]

*选择姓名
[list x=34 y=60 line=&"f.config_name.count-1" layer="message6"]
[link target=*关闭下拉菜单 exp="f.参数.tagname='主角'"]主角[endlink]
[iscript]
for (var i=2;i<f.config_name.count;i++)
{
      kag.tagHandlers.r(%[]);
      //描绘列表
      var setting=new Dictionary();
      setting.target="*关闭下拉菜单";
      setting.exp="f.参数.tagname=\'"+f.config_name[i].tag+"\'";
      kag.tagHandlers.link(setting);
      kag.tagHandlers.ch(%["text"=>f.config_name[i].tag]);
      kag.tagHandlers.endlink(%[]);

}
[endscript]
[s]

*关闭下拉菜单
[rclick enabled="false"]
[current layer="message6"]
[er]
[layopt layer="message6" visible="false"]
[jump target=*window]

*选择图片
[call storage="window_picture.ks"]
[jump target=*window]

*选择颜色
[call storage="window_color.ks"]
[jump target=*window]
