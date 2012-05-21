;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
[iscript]
function updateFile()
{
   drawBox("文件",kag.fore.layers[7],20,50,200,15,f.list,f.curpage-1);
   //設定滾動條位置
   with(kag.fore.layers[9])
   {
      .visible=true;
      .top=kag.fore.layers[7].top+66;
      if (f.page>1) .top+=(int)(f.curpage-1)*277/(f.page-1);
   }
}
[endscript]
;---------------------------------------------------------------
;.ks文件選擇
;---------------------------------------------------------------
*window
[window_up width=450 height=450 title="選擇文件"]
;滾動條
[image layer=9 storage="edit_slider_button" left=&"(int)kag.fore.layers[7].left+225"]
;翻頁按鈕
[button_page x=225 y=50 length=325]
;滾動條按鈕
[button_slider x=225 y=66]
[iscript]
//計算頁數
countPage(f.list.count,15);
//默認顯示第一頁
f.curpage=1;
//描繪box
f.window='file';
update();
//描繪按鈕
drawButtonLine(20,74,"edit_button_line2",15,20);
[endscript]
[s]

*確認
[if exp="f.list[f.select]!=void"]
[eval exp=&"tf.當前編輯值+'=\''+f.list[f.select]+'\''"]
[endif]

*關閉選單
[eval exp="f.window=''"]
[rclick enabled="false"]
[freeimage layer="7"]
[freeimage layer="8"]
[freeimage layer="9"]
[current layer="message7"]
[er]
[layopt layer="message7" visible="false"]
[return]
