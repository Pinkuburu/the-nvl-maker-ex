;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;--------------------------------------------------
;預處理
;--------------------------------------------------
[iscript]
//將各層位置代入f.config_slpos.locate
for (var i=0;i<f.config_slpos.locate.count;i++)
{
  f.config_slpos.locate[i][0]=f.uilayer[i+7].left;
  f.config_slpos.locate[i][1]=f.uilayer[i+7].top;
}
//參數處理
f.參數=new Dictionary();
f.參數.num=f.config_slpos.locate.count;
f.參數.locate=[];
f.參數.locate.assign(f.config_slpos.locate);
[endscript]
;--------------------------------------------------
;檔案設定
;檔案數
;每個位置
;--------------------------------------------------
*window
[window_middle width=800 height=600 title="檔案設定"]
[line title="每頁檔案數" name="f.參數.num" x=30 y=50] [link target=*設定數量 hint="不超過30個且不超過總檔案個數"]設定[endlink]
;根據數量設定locate
[iscript]
for (var i=0;i<f.參數.num;i++)
{
   if (f.參數.locate[i]==void)
  {
     f.參數.locate[i]=[];
     f.參數.locate[i][0]="0";
     f.參數.locate[i][1]="0";
   }
   //描繪text框
   if (i<15)
   {
     drawEdit("檔案"+(i*1+1)+" x","f.參數.locate["+i+"][0]",30,80*1+i*30,120);
     drawEdit("y","f.參數.locate["+i+"][1]",180,80*1+i*30,100);
   }
   else
   {
     drawEdit("檔案"+(i*1+1)+" x","f.參數.locate["+i+"][0]",320,80*1+(i-15)*30,120);
     drawEdit("y","f.參數.locate["+i+"][1]",470,80*1+(i-15)*30,100);
   }
}
//將多餘刪除
f.參數.locate.count=f.參數.num;
[endscript]
[s]

*設定數量
[commit]
[iscript]
if ((int)f.參數.num<1) f.參數.num=1;
if ((int)f.參數.num>30) f.參數.num=30;
if ((int)f.參數.num>(int)f.setting.savedata.num) f.參數.num=(int)f.setting.savedata.num;
[endscript]
[jump target=*window]

*確認
[commit]
[iscript]
f.config_slpos.locate.assign(f.參數.locate);
[endscript]

*關閉選單
[freeimage layer="5"]
[current layer="message5"]
[er]
[layopt layer="message5" visible="false"]
[return]
