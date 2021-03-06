;-------------------------------------------------------------------------------------------
;载入xml文件并返回变数
;-------------------------------------------------------------------------------------------
[iscript]
//添加数据库文件夹
Storages.addAutoPath("xml/");

//将tjs变数文件转为xml文件（测试用）
function tjs_to_xml(filename)
{
        //保存XML
        var a = Scripts.evalStorage(filename+".tjs");
        var b = tjsvartoxml(a);
        var c = new RegExp("><","g");
        var d = b.replace(c,">\n<");
        var e = d.split('\r\n',,true);
        e.save("xml/"+filename+".xml");
}

//读入XML文件并返回对应的tjs变数
function load_xml(filename)
{
	var a = [];
	a.load(filename+".xml");
	var b = a.join("\n",false,true);
	var c = xmltotjsvar(b);
	return c;
}
[endscript]
;-------------------------------------------------------------------------------------------
;对变数的处理
;-------------------------------------------------------------------------------------------
[iscript]
function load_dic()
{
	var a=%[];
	a=load_xml("dictionary");
	return a;
}
function load_arr()
{
	var a=[];
	a=load_xml("item");
	return a;
}

[endscript]
;-------------------------------------------------------------------------------------------
[return]
