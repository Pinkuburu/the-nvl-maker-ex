;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
[iscript]
f.參數.elsif1=false;
f.參數.elsif2=false;
f.參數.else=false;
[endscript]

*window
[window_middle width=400 height=330 title="創建分歧"]
[line title="條件" name="f.參數.exp" type="cond" x=30 y=50]

[check title="繼續分歧" name="f.參數.elsif1" x=30 y=80]
[line true="f.參數.elsif1" title="條件" name="f.參數.exp1" type="cond" x=30 y=110]

[check title="繼續分歧" name="f.參數.elsif2" x=30 y=140]
[line true="f.參數.elsif2" title="條件" name="f.參數.exp2" type="cond" x=30 y=170]

[check title="加入默認分歧的情況" name="f.參數.else" x=30 y=200]

[s]

*生成條件
[call storage="window_cond.ks"]
[jump target=*window]

*確認
[commit]
;[eval exp="commitLine(f.參數)"]
[iscript]
if (f.參數.exp!=void)
{
	//開始分歧
	var dic=%[];
	dic.tagname="if";
	dic.exp=f.參數.exp;
	commitLine(dic);

	//繼續分歧
	if (f.參數.elsif1)
	{
		var dic=%[];
		dic.tagname="elsif";
		dic.exp=f.參數.exp1;
		
		addLine(dic);
	}
	//繼續分歧
	if (f.參數.elsif2)
	{
		var dic=%[];
		dic.tagname="elsif";
		dic.exp=f.參數.exp2;
		
		addLine(dic);
	}
	
	//默認分歧
	if (f.參數.else)
	{
		var dic=%[];
		dic.tagname="else";		
		addLine(dic);
	}

	//分歧結束
	var dic=%[];
	dic.tagname="endif";
	addLine(dic);

}
[endscript]
[jump storage="tag_direct.ks" target=*擦除窗口]

*關閉選單
[jump storage="tag_direct.ks" target=*關閉選單]
