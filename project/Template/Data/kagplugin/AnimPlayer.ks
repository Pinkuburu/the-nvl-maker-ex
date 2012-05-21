;---------------------------------------------------------------------------------------
;AnimPlayer.ks
;逐幀動畫播放插件 by VariableD & karryngai
;---------------------------------------------------------------------------------------
;加工·修改自由
;轉載請註明作者和出處
;---------------------------------------------------------------------------------------
;@animinit
;參數：
;file（必須） 文件名
;所有文件格式命名為"文件名 (數字).png"的圖片可以被識別，文件名和(數字)間有一個半角空格。
;（WINDOWS的批量重命名默認格式）
;數值必須從0開始，當找不到下一個數字時，視為一輪播放完畢
;loop 是否循環，默認為是
;target 循環時的起始幀，默認為0
;interval 每幀的間隔時間，默認為100毫秒，建議不要低於60（否則可能會卡）
;index 圖層的顯示順位，默認為50000-1
;
;left,top 左上點坐標
;width,height 寬度,高度
;
;@addpath storage="文件夾名" 可以加入文件夾
;---------------------------------------------------------------------------------------
@if exp="typeof(global.animplayer_object) == 'undefined'"
@iscript

//動畫層
class MyanimLayer
{
    var fore;
    var back;
    
    function MyanimLayer(window,owner)
    {
	this.owner = owner;
	this.window = window;
	
	fore = new Layer(window, window.fore.base);
	back = new Layer(window, window.back.base);
	
	fore.hitType = htMask;
	fore.hitThreshold = 256; 
	back.hitType = htMask;
	back.hitThreshold = 256;
	
	//可以在這裡隨便玩效果
//	fore.type=ltLighten;
//	back.type=ltLighten;
	
	fore.fillRect(0,0,1024,768,0x00000000); //清空圖層
	back.assignImages(fore);
	fore.setSizeToImageSize(); 
	back.setSizeToImageSize();      
    }
    
        function finalize()
    {
            invalidate fore;
            invalidate back;
    }

	function changeImage(image)
	{
		fore.loadImages(image); //圖片
		back.assignImages(fore);
	}

    //可見效果（由plugin控制）
        function resetVisibleState()
        {

            fore.visible = owner.foreVisible;
            back.visible = owner.backVisible;
        }
        
      //表裡交換
              function exchangeForeBack()
        {
                // trans時的表裡頁內容交換
                var tmp = fore;
                fore = back;
                back = tmp;
        }
        
        property index
        {
        	setter(x)
        	{
	        	fore.absolute=x;
	        	back.absolute=x;
        	}
        	
        	getter
        	{
        		return fore.absolute;
        	}
        }
        
        property left
        {
        	setter(x)
        	{
	        	fore.left=x;
	        	back.left=x;
        	}
        }
        
        property top
        {
        	setter(x)
        	{
	        	fore.top=x;
	        	back.top=x;
        	}
        }
        
        property width
        {
        	setter(x)
        	{
	        	fore.width=x;
	        	back.width=x;
        	}
        }
        
        property height
        {
        	setter(x)
        	{
	        	fore.height=x;
	        	back.height=x;
        	}
        }
}
//---------------------------------------------------------------------------------------
class AnimPlayerPlugin extends KAGPlugin
{
        
        var timer; // 計時器
        var interval=100;
        
        var window; 
        var foreVisible = true; 
        var backVisible = true; 
        var animLayer;
        var file;
        var index=50000-1;
        
        var count=0;//當前幀編號
        var loop=1;//是否循環
        var target=0;//循環標記，0為從第一幀開始循環
        
        var left=0;
        var top=0;
        var width=1024;
        var height=768;
        
       function AnimPlayerPlugin(window)
        {
                super.KAGPlugin();
                this.window = window;
        }
        
        function finalize()
        {
                invalidate timer if timer !== void;
                super.finalize(...);
        }
        
        //創建
        function init(elm)
        {

		this.file=elm.file;
		
		if (elm.index!==void) this.index=(int)elm.index;
        	if (elm.loop!==void) this.loop=(int)elm.loop;//是否循環
        	if (elm.target!==void) this.target=(int)elm.target;//循環的起始點
        	
		if (elm.interval!==void) this.interval=(int)elm.interval;
		
		if (elm.left!==void) this.left=(int)elm.left;
		if (elm.top!==void) this.top=(int)elm.top;
		if (elm.width!==void) this.width=(int)elm.width;
		if (elm.height!==void) this.height=(int)elm.height;
		
		animLayer=new MyanimLayer(window,this);
		
		animLayer.left=this.left;
		animLayer.top=this.top;
		animLayer.width=this.width;
		animLayer.height=this.height;
		animLayer.index=this.index;
		
        	   //計時器的具體設定
                timer = new Timer(onTimer, '');
                timer.interval = this.interval;

                
                foreVisible = true;
                backVisible = true;
                resetVisibleState();
                
                dm("開始播放動畫："+file+"，循環："+loop);
                
                timer.enabled = true;
                
        }
        
        function uninit()
        {
		count=0;
		timer=void;
		animLayer=void; 
        }
        
        function pause()
        {
        	timer.enabled=false;
        }
        
        function restart()
        {
        	timer.enabled=true;
        }
        
	function loadpic(filename)
	{
		if (Storages.isExistentStorage(filename))  //假如找得到此圖片
		{
			animLayer.changeImage(filename);
			count++;
		}
		else if (loop) //找不到圖片且要求循環，返回重設filename的值
		{
			dm("動畫循環");
			return false;
		}
		else //找不到圖片，不要求循環，正常結束
		{
			dm("動畫結束");
			uninit();
		}
		
		return true;
		
	}
		
        function onTimer()
        {
             if (timer===void) return;
		var filename=file+" ("+count+").png";
		
		var show=loadpic(filename);
		
		//假如沒有圖片，又要求循環，重設file的值開始新的循環
		if (show==false)
		{
			//從指定幀開始循環
			count=target;
			filename=file+" ("+target+").png";
			loadpic(filename);
		}

        }
        
                function resetVisibleState()
        {
                if (timer===void) return;
                animLayer.resetVisibleState(); 
        }
        
         function onStore(f, elm)
        {
        	var dic = f.animplayers = %[];
        	
        	   dic.init = timer !== void;
        	   
                dic.foreVisible = foreVisible;
                dic.backVisible = backVisible;

                dic.file=file;
                
                dic.count=count;
                dic.loop=loop;
                dic.target=target;

                dic.index=index;
                dic.interval=interval;
                
                dic.left=left;
                dic.top=top;
                dic.width=width;
                dic.height=height;

        }
        
           function onRestore(f, clear, elm)
        {
         // 當讀取時……
                var dic = f.animplayers;
                if(dic === void || !+dic.init)
                {
                        uninit();
                }
                else if(dic !== void && +dic.init)
                {
                        init(%[
                        file : dic.file,
                        count :dic.count,
                        loop : dic.loop,
                        target : dic.target,
                        index : dic.index,
                        interval : dic.interval,
                        left : dic.left,
                        top : dic.top,
                        width : dic.width,
                        height : dic.height,
                        forevisible : dic.foreVisible,
                        backvisible : dic.backVisible ] );
                }
        }
        
        function onCopyLayer(toback)
        {
                // 表裡複製的處理
                if(toback)
                {
                        // 表→裡
                        backVisible = foreVisible;
                }
                else
                {
                        // 裡→表
                        foreVisible = backVisible;
                }
                
                resetVisibleState();
                
        }
        
                function onExchangeForeBack()
        {
           if (animLayer==void) return;
           animLayer.exchangeForeBack(); //表裡交換
        }
        
}

kag.addPlugin(global.animplayer_object = new AnimPlayerPlugin(kag));

@endscript
@endif
;---------------------------------------------------------------------------------------

@macro name=addpath
@eval exp="Storages.addAutoPath(mp.storage+'/')"
@if exp="Storages.isExistentStorage(mp.storage+'.xp3')"
@eval exp="Storages.addAutoPath(mp.storage+'.xp3>')"
@endif
@if exp="Storages.isExistentStorage(System.exePath+mp.storage+'.xp3')"
@eval exp="Storages.addAutoPath(System.exePath+mp.storage+'.xp3>')"
@endif
@endmacro

[macro name=animinit]
[eval exp="animplayer_object.init(mp)"]
[endmacro]

[macro name=animuninit]
[eval exp="animplayer_object.uninit()"]
[endmacro]

[macro name=animpause]
[eval exp="animplayer_object.pause()"]
[endmacro]

@return
