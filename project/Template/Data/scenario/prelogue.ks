*start|序章
@bgm storage="BGM074.ogg"
@bg storage="BG04a"
@fg pos="center" storage="fg01_01"
@dia
@history output="true"
@nvl娘 face="face01_01"
欢迎来到THE NVL Maker的世界～[w]
;----------
@history output="false"
@eval exp="f.姓='普'"
@eval exp="f.名='文二'"
@nowait
请输入主角名字：[r]
姓氏：[edit name=f.姓][r]
名字：[edit name=f.名][r]
@links target="*输入完毕" text="确定" hint="点这里继续~"
@endnowait
@history output="true"
@s
;----------
*输入完毕
@commit
@er
@主角
好的，主角的姓氏是[emb exp=f.姓]，名字是[emb exp=f.名]。[w]
@fg pos="center" storage="fg01_02"
@nvl娘 face="face01_02"
接下来，测试一下选择吧。[lr]
;----------
@selstart
@selbutton target="*选择A" text="我要选择A"
@selbutton target="*选择B" text="我要选择B"
@selend
;----------
*选择A
@clsel
@bg clfg="1" storage="cg_01"
@addcg storage="cg_01"
@raininit
@npc id="路人甲"
你选择了A。第一张CG现在可以在特别模式里查看了。[w]
@rainuninit
@jump target="*合并"
;----------
*选择B
@clsel
@bg clfg="1" storage="cg_02"
@addcg storage="cg_02"
@npc id="路人甲"
你选择了B。第二张CG现在可以在特别模式里查看了。[w]
;----------
*合并
@hidemes
@backlay
@image visible="1" page="back" layer="base" storage="BG01a"
@image visible="1" page="back" layer="0" pos="center" storage="fg01_02"
@trans time="800" rule="rule_27" method="universal"
@wt
@showmes
@nvl娘
@vo storage="Konnichiha01@22"
不管选择了A还是B，最后你都会看到这句话。[w]
@scr
试试另外一个样式的对话框……[lr]
你也可以切换文字的颜色。[l][font color=0x3366FF]比如这样……[resetfont][lr][r]
改变[font size=30]大[font size=18]小[resetfont]也没有问题哟。[w]
@style align="center"
居中显示文字。[lr]
@resetstyle
@nowait
瞬间显示文字。[lr]
@endnowait
@locate y="200" x="300"
在指定位置显示文字。[w]
在对话中[graph char=false storage=momiji_0]显示图片。[w]
@dia
@nvl娘
现在换回来了……[lr]
测试一下地图选择吧。[w]
@map storage="sample.map"
*map01
@clmap
@nvl娘
地图测试完毕……[lr]准备好就自动返回标题了哦。[w]
@gotostart
