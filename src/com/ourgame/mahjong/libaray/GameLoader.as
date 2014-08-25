package com.ourgame.mahjong.libaray
{
	import com.ourgame.mahjong.libaray.vo.GameInfo;
	import com.wecoit.data.Config;
	import com.wecoit.data.XmlValue;
	import com.wecoit.events.BytesEvent;
	import com.wecoit.loader.BytesResolver;
	import com.wecoit.loader.BytesStream;
	import com.wecoit.utils.string.stampUrl;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	
	[Event(name="open", type="com.wecoit.events.BytesEvent")]
	
	[Event(name="complete", type="com.wecoit.events.BytesEvent")]
	
	[Event(name="error", type="com.wecoit.events.BytesEvent")]
	
	[Event(name="progress", type="flash.events.ProgressEvent")]
	
	/**
	 * 游戏加载器
	 * @author SiaoLeon
	 */
	public class GameLoader extends EventDispatcher
	{
		// -------------------------------------------------------------------------------------------------------- 静态常量
		
		// -------------------------------------------------------------------------------------------------------- 静态变量
		
		// -------------------------------------------------------------------------------------------------------- 静态方法
		
		// -------------------------------------------------------------------------------------------------------- 静态函数
		
		// -------------------------------------------------------------------------------------------------------- 属性
		
		public function get connected():Boolean
		{
			return this.stream.connected || this.resolving;
		}
		
		private var _currentLoaded:int;
		
		/**
		 * 当前资源已加载量
		 * @return
		 */
		public function get currentLoaded():int
		{
			return this._currentLoaded;
		}
		
		private var _currentTotal:int;
		
		/**
		 * 当前资源总加载量
		 * @return
		 */
		public function get currentTotal():int
		{
			return this._currentTotal;
		}
		
		private var _countLoaded:int;
		
		/**
		 * 已加载资源个数
		 * @return
		 */
		public function get countLoaded():int
		{
			return this._countLoaded;
		}
		
		private var _countTotal:int;
		
		/**
		 * 加载资源总数
		 * @return
		 */
		public function get countTotal():int
		{
			return this._countTotal;
		}
		
		public var info:GameInfo;
		
		public var current:XmlValue;
		
		// -------------------------------------------------------------------------------------------------------- 变量
		
		private var resolving:Boolean;
		
		private var stream:BytesStream;
		
		private var games:Vector.<GameInfo>;
		
		private var queue:Vector.<XmlValue>;
		
		// -------------------------------------------------------------------------------------------------------- 构造
		
		/**
		 * 构造函数
		 */
		public function GameLoader()
		{
			this.games = new Vector.<GameInfo>();
			
			this.stream = new BytesStream();
			this.stream.addEventListener(BytesEvent.OPEN, onStreamOpen);
			this.stream.addEventListener(BytesEvent.ERROR, onStreamError);
			this.stream.addEventListener(ProgressEvent.PROGRESS, onStreamProgress);
			this.stream.addEventListener(BytesEvent.COMPLETE, onStreamComplete);
		}
		
		// -------------------------------------------------------------------------------------------------------- 方法
		
		public function load(game:GameInfo):void
		{
			if (this.queue != null && this.queue.length > 0)
			{
				this.games.push(game);
				return;
			}
			
			this.info = game;
			this.stream.load(new URLRequest(stampUrl(this.info.path + this.info.url)));
		}
		
		// -------------------------------------------------------------------------------------------------------- 函数
		
		private function onStreamOpen(event:BytesEvent):void
		{
			this._currentLoaded = 0;
			this._currentTotal = 0;
			this._countLoaded = (this.queue == null) ? 0 : this.countTotal - this.queue.length - 1;
			this._countTotal = (this.queue == null) ? 1 : this._countTotal;
			
			this.dispatchEvent(new BytesEvent(BytesEvent.OPEN));
		}
		
		private function onStreamError(event:BytesEvent):void
		{
			this.dispatchEvent(new BytesEvent(BytesEvent.ERROR));
		}
		
		private function onStreamProgress(event:ProgressEvent):void
		{
			this._currentLoaded = (this.queue == null) ? 0 : event.bytesLoaded;
			this._currentTotal = (this.queue == null) ? 0 : event.bytesTotal;
			
			this.dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS));
		}
		
		private function onStreamComplete(event:BytesEvent):void
		{
			this._countLoaded = (this.queue == null) ? 0 : this.countTotal - this.queue.length;
			this._countTotal = (this.queue == null) ? 1 : this._countTotal;
			
			var resolver:BytesResolver = new BytesResolver(this.info.domain);
			resolver.addEventListener(BytesEvent.COMPLETE, onResolverComplete);
			resolver.addEventListener(BytesEvent.ERROR, onResolverError);
			resolver.parser(this.stream.data);
			
			this.resolving = true;
		}
		
		private function onResolverError(event:BytesEvent):void
		{
			var resolver:BytesResolver = event.target as BytesResolver;
			resolver.removeEventListener(Event.COMPLETE, onResolverComplete);
			resolver.removeEventListener(IOErrorEvent.IO_ERROR, onResolverError);
			
			this.resolving = false;
			
			this.dispatchEvent(new BytesEvent(BytesEvent.ERROR));
		}
		
		private function onResolverComplete(event:BytesEvent):void
		{
			var resolver:BytesResolver = event.target as BytesResolver;
			resolver.removeEventListener(Event.COMPLETE, onResolverComplete);
			resolver.removeEventListener(IOErrorEvent.IO_ERROR, onResolverError);
			
			this.resolving = false;
			this.info.assets.put((this.current == null) ? this.info.name : this.current.name, resolver.content);
			
			if (this.queue == null)
			{
				if (resolver.content is XML)
				{
					var config:Config = new Config(resolver.content);
					this.queue = config.getOptions();
					
					this._countLoaded = 0;
					this._countTotal = this.queue.length;
					
					this.process();
				}
				else
				{
					this._countLoaded = 1;
					this._countTotal = 1;
					
					this.dispatchEvent(new BytesEvent(BytesEvent.COMPLETE));
					
					this.reset();
				}
			}
			else
			{
				if (this.queue.length > 0)
				{
					this.process();
				}
				else
				{
					this.dispatchEvent(new BytesEvent(BytesEvent.COMPLETE));
					
					this.reset();
					
					if (this.games.length > 0)
					{
						this.load(this.games.shift());
					}
				}
			}
		}
		
		private function reset():void
		{
			this.info = null;
			this.current = null;
			this.queue = null;
			
			this._currentLoaded = 0;
			this._currentTotal = 0;
			this._countLoaded = 0;
			this._countTotal = 0;
		}
		
		private function process():void
		{
			if (this.connected)
			{
				return;
			}
			
			this.current = this.queue.shift();
			
			var path:String = (this.current.attribute("path") == null) ? "" : this.current.attribute("path");
			var ver:String = (this.current.attribute("ver") == null) ? new Date().time.toString() : this.current.attribute("ver");
			
			this.stream.load(new URLRequest(this.info.path + path + this.current.value + "?ver=" + ver));
		}
	
	}
}
