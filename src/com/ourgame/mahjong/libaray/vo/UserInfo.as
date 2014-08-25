package com.ourgame.mahjong.libaray.vo
{
	import com.wecoit.data.ValueObject;
	
	/**
	 * 用户对象
	 * @author SiaoLeon
	 */
	public class UserInfo extends ValueObject
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
		
		public function set id(value:uint):void
		{
			this.setProperty("id", value);
		}
		
		public function get seat():int
		{
			return this.getProperty("seat", -1);
		}
		
		public function set seat(value:int):void
		{
			this.setProperty("seat", value);
		}
		
		public function get nickname():String
		{
			return this.getProperty("nickname", "");
		}
		
		public function set nickname(value:String):void
		{
			this.setProperty("nickname", value);
		}
		
		public function get chips():uint
		{
			return this.getProperty("chips", 0);
		}
		
		public function set chips(value:uint):void
		{
			this.setProperty("chips", value);
		}
		
		public function get coins():uint
		{
			return this.getProperty("coins", 0);
		}
		
		public function set coins(value:uint):void
		{
			this.setProperty("coins", value);
		}
		
		public function get masterScore():uint
		{
			return this.getProperty("masterScore", 0);
		}
		
		public function set masterScore(value:uint):void
		{
			this.setProperty("masterScore", value);
		}
		
		public function get sex():uint
		{
			return this.getProperty("sex", 0);
		}
		
		public function set sex(value:uint):void
		{
			this.setProperty("sex", value);
		}
		
		public function get headImage():String
		{
			return this.getProperty("headImage", "");
		}
		
		public function set headImage(value:String):void
		{
			this.setProperty("headImage", value);
		}
		
		public function get level():uint
		{
			return this.getProperty("level", 0);
		}
		
		public function set level(value:uint):void
		{
			this.setProperty("level", value);
		}
		
		public function get experience():uint
		{
			return this.getProperty("experience", 0);
		}
		
		public function set experience(value:uint):void
		{
			this.setProperty("experience", value);
		}
		
		public function get winRate():Number
		{
			return this.getProperty("winRate", 0);
		}
		
		public function set winRate(value:Number):void
		{
			this.setProperty("winRate", value);
		}
		
		// -------------------------------------------------------------------------------------------------------- 变量
		
		// -------------------------------------------------------------------------------------------------------- 构造
		
		/**
		 * 构造函数
		 */
		public function UserInfo(id:uint=0)
		{
			super();
			
			this.setProperty("id", id);
		}
		
		// -------------------------------------------------------------------------------------------------------- 方法
		
		override public function toString():String
		{
			return "[User(id=" + this.id + ",name=" + this.nickname + ",seat=" + this.seat + ",coins=" + this.coins + ",chips=" + this.chips + ",masterScore=" + this.masterScore + ")]";
		}
	
		// -------------------------------------------------------------------------------------------------------- 函数
	
	}
}
