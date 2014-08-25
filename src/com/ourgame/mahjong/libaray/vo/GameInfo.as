package com.ourgame.mahjong.libaray.vo
{
	import com.ourgame.mahjong.libaray.DataExchange;
	import com.wecoit.data.HashMap;
	import com.wecoit.data.ValueObject;
	import com.wecoit.data.XmlValue;
	
	import flash.display.DisplayObject;
	import flash.system.ApplicationDomain;
	
	/**
	 * 游戏
	 * @author SiaoLeon
	 */
	public class GameInfo extends ValueObject
	{
		// -------------------------------------------------------------------------------------------------------- 静态常量
		
		// -------------------------------------------------------------------------------------------------------- 静态变量
		
		// -------------------------------------------------------------------------------------------------------- 静态方法
		
		// -------------------------------------------------------------------------------------------------------- 静态函数
		
		// -------------------------------------------------------------------------------------------------------- 属性
		
		public function get id():uint
		{
			return this.getProperty("id", 0);
		}
		
		public function get name():String
		{
			return this.getProperty("name", "");
		}
		
		public function get path():String
		{
			return this.getProperty("path", "");
		}
		
		public function get url():String
		{
			return this.getProperty("url", "");
		}
		
		public function get main():DisplayObject
		{
			return this.assets.getValue(this.name);
		}
		
		public function get assets():HashMap
		{
			return this.getProperty("assets", new HashMap());
		}
		
		public function get data():DataExchange
		{
			return this.getProperty("data", new DataExchange());
		}
		
		public function get domain():ApplicationDomain
		{
			return this.getProperty("domain", new ApplicationDomain(ApplicationDomain.currentDomain));
		}
		
		public function set domain(value:ApplicationDomain):void
		{
			this.setProperty("domain", value);
		}
		
		// -------------------------------------------------------------------------------------------------------- 变量
		
		// -------------------------------------------------------------------------------------------------------- 构造
		
		/**
		 * 构造函数
		 */
		public function GameInfo(info:XmlValue, data:DataExchange)
		{
			super();
			
			this.setProperty("id", info.attribute("id"));
			this.setProperty("name", info.name);
			this.setProperty("path", info.attribute("path"));
			this.setProperty("url", info.value);
			this.setProperty("data", data);
		}
	
		// -------------------------------------------------------------------------------------------------------- 方法
	
		// -------------------------------------------------------------------------------------------------------- 函数
	
	}
}
