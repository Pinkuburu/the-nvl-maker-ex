;---------------------------------------------------------------------------------------
;PicScroller
;图片循环移动插件-by VariableD
;---------------------------------------------------------------------------------------
;加工·修改自由
;转载请注明作者和出处
;---------------------------------------------------------------------------------------
;宏指令

;显示循环图片层
;@picscrollerinit
;参数：
;storage-用于循环显示的图片文件名（必须）
;direction-left（默认）/right/up/down图片滚动的方向（暂不支持斜方向）
;left-图片坐标（默认0）
;top-图片坐标（默认0）
;width-图片宽度（默认游戏分辨率）
;height-图片高度（默认游戏分辨率）
;index-图片层顺位（默认100-1）
;interval-移动一像素的间隔时间（默认10毫秒）

;消除循环图片层
;@picscrolleruninit
;参数：无
;---------------------------------------------------------------------------------------
@if exp="typeof(global.picscroller_object) == 'undefined'"
@iscript
//一个图层用于载入原图
//新建一个图层用于读取并显示(支持trans)
//一个timer

class MyScrollLayer
{
    var fore;
    var back;
    
     function MyScrollLayer(window,owner)
    {
        this.owner = owner;
        this.window = window;
        
        fore = new Layer(window, window.fore.base);
        back = new Layer(window, window.back.base);
        
        fore.hitType = htMask;
        fore.hitThreshold = 256; 
        back.hitType = htMask;
        back.hitThreshold = 256;
        
        fore.setSize(window.primaryLayer.width,window.primaryLayer.height); 
        fore.fillRect(0,0,window.primaryLayer.width,window.primaryLayer.height,0x00000000); //清空图层
        back.assignImages(fore);
        back.setSizeToImageSize();
    }
    
      function finalize()
    {
            invalidate fore;
            invalidate back;
    }

 //可见效果（由plugin控制）
        function resetVisibleState()
        {

            fore.visible = owner.foreVisible;
            back.visible = owner.backVisible;
        }
        
      //表里交换
              function exchangeForeBack()
        {
                // trans时的表里页内容交换
                var tmp = fore;
                fore = back;
                back = tmp;
        }
        
        //向左移动
        function toleft()
        {        	
        	var dleft=owner.pace;
        	var dtop=0;
        	var sleft=0;
        	var stop=0;
        	var src=owner.ml;
        	var sw=src.width;
        	var sh=src.height;
        	
        	fore.copyRect(dleft      , dtop, src, sleft, stop, sw, sh);
		fore.copyRect(sw+dleft, dtop, src, sleft, stop, sw, sh);
		back.assignImages(fore);
        }
        
        //向右移动
        function toright()
        {
		var dleft=owner.pace;
		var dtop=0;
		var sleft=0;
		var stop=0;
		var src=owner.ml;
		var sw=src.width;
		var sh=src.height;
		
        	fore.copyRect(dleft, dtop, src, sleft     , stop, sw, sh);
		fore.copyRect(0    , dtop, src, sw-dleft, stop, sw, sh);
		back.assignImages(fore);
        }
        
        //向上移动
        function toup()
        {
		var dleft=0;
		var dtop=owner.pace;
		var sleft=0;
		var stop=0;
		var src=owner.ml;
		var sw=src.width;
		var sh=src.height;
        	fore.copyRect(dleft      , dtop, src, sleft, stop, sw, sh);
		fore.copyRect(dleft, sh+dtop, src, sleft, stop, sw, sh);
		back.assignImages(fore);
        }
        //向下移动
        function todown()
        {
		var dleft=0;
		var dtop=owner.pace;
		var sleft=0;
		var stop=0;
		var src=owner.ml;
		var sw=src.width;
		var sh=src.height;
		
        	fore.copyRect(dleft, dtop, src, sleft, stop     , sw, sh);
		fore.copyRect(dleft , 0   ,  src, sleft, sh-dtop, sw, sh);
		back.assignImages(fore);
        }
        
       //属性
	property index
	{
	    setter(x) 
	    	{
			fore.absolute=x;
			back.absolute=x;
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

class PicScrollerPlugin extends KAGPlugin
{

var timer; // 计时器
var interval=10;

	var window; 
	var foreVisible; 
	var backVisible; 
	
	var scrollLayer;
	var ml;
	var storage;
	
	var left;
	var top;
	var width;
	var height;
	var index;
	
	var direction="left";
	var pace;

       function PicScrollerPlugin(window)
        {
                super.KAGPlugin();
                this.window = window;
                
                foreVisible=true;
                backVisible=true;
                
                left=0;
                top=0;
                width=window.primaryLayer.width;
                height=window.primaryLayer.height;
                index=100-1;
        
        }
        
        function finalize()
        {
                invalidate timer if timer !== void;
                super.finalize(...);
        }
        
        function loadImages(storage,key)
        {
        	//载入二方或四方连续背景图片
		ml=new Layer(kag,kag.fore.base);
		ml.loadImages(storage);
		ml.setSizeToImageSize();
        }
        
        function init(elm)
        {
		 storage=elm.storage;
		 loadImages(storage);
		
               if (elm.left!==void) this.left=(int)elm.left;
               if (elm.top!==void) this.top=(int)elm.top;
               if (elm.width!==void) this.width=(int)elm.width;
               if (elm.height!==void) this.height=(int)elm.height;
               if (elm.index!==void) this.index=(int)elm.index;
               
               if (elm.interval!==void) this.interval=(int)elm.interval;
               if (elm.direction!==void) this.direction=(string)elm.direction;
               
                scrollLayer=new MyScrollLayer(window,this);
                
                scrollLayer.left=this.left;
                scrollLayer.top=this.top;
                scrollLayer.width=this.width;
                scrollLayer.height=this.height;
                scrollLayer.index=this.index;


                   //计时器的具体设定
                timer = new Timer(onTimer, '');
                timer.interval = this.interval;

                foreVisible =  true;
                backVisible = true;
                resetVisibleState();
                
                dm("开始背景循环");
                
                pace=0;
                timer.enabled = true;
                
        }
        
        function onTimer()
        {
		switch (direction)
		{
			//左右
			case "left":
				pace--;
				scrollLayer.toleft();
				if (pace==-ml.width) pace=1;
				break;
			case "right":
				pace++;
				scrollLayer.toright();
				if (pace==ml.width) pace=-1;
				break;
			//上下
			case "up":
				pace--;
				scrollLayer.toup();
				if (pace==-ml.height) pace=1;
				break;
			case "down":
				pace++;
				scrollLayer.todown();
				if (pace==ml.height) pace=-1;
				break;
			case "leftup":
			
			case "leftdown":
			
			case "rightup":
			
			case "rightdown":
		
		}
		
        }
        
        function uninit()
        {
             if (timer===void) return;
		timer.enabled=false;
		timer=void;
		scrollLayer=void;
        }
        
        function pause()
        {
                timer.enabled=false;
        }
        
        function restart()
        {
                timer.enabled=true;
        }
        
        function resetVisibleState()
        {
                if (timer===void) return;
                scrollLayer.resetVisibleState(); 
        }
        
          function onStore(f, elm)
        {
        	var dic=f.picscrollers=%[];
        	dic.init = timer !== void;
		dic.foreVisible = foreVisible;
		dic.backVisible = backVisible;
		
		dic.storage=storage;
		dic.left=left;
		dic.top=top;
		dic.width=width;
		dic.height=height;
		dic.index=index;
		dic.interval=interval;
		dic.direction=direction;
		
        }
        
           function onRestore(f, clear, elm)
        {
                var dic = f.picscrollers;
                if(dic === void || !+dic.init)
                {
                        uninit();
                }
                else if(dic !== void && +dic.init)
                {
                        init(%[
	                        foreVisible:dic.foreVisible,
	                        backVisible:dic.backVisible,
	                        storage:dic.storage,
	                        left:dic.left,
	                        top:dic.top,
	                        width:dic.width,
	                        height:dic.height,
	                        index:dic.index,
	                        interval:dic.interval,
	                        direction:dic.direction,
                        ]);
                }
        }
        
         function onCopyLayer(toback)
        {
                // 表里复制的处理
                if(toback)
                {
                        // 表→里
                        backVisible = foreVisible;
                }
                else
                {
                        // 里→表
                        foreVisible = backVisible;
                }
                
                resetVisibleState();
                
        }
        
          function onExchangeForeBack()
        {
	           if (scrollLayer==void) return;
	           scrollLayer.exchangeForeBack(); //表里交换
        }

}
kag.addPlugin(global.picscroller_object = new PicScrollerPlugin(kag));
@endscript
@endif
;---------------------------------------------------------------------------------------
;宏设定

[macro name=picscrollerinit]
[eval exp="picscroller_object.init(mp)"]
[endmacro]

[macro name=picscrolleruninit]
[eval exp="picscroller_object.uninit()"]
[endmacro]

@return
