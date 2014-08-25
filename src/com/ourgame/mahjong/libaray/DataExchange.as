package com.ourgame.mahjong.libaray
{
	import com.ourgame.mahjong.libaray.vo.RoomInfo;
	import com.ourgame.mahjong.libaray.vo.TableInfo;
	import com.ourgame.mahjong.libaray.vo.UserInfo;
	import com.wecoit.data.ArrayList;
	
	/**
	 * 交换数据
	 * @author SiaoLeon
	 */
	public class DataExchange
	{
		// -------------------------------------------------------------------------------------------------------- 静态常量
		
		// -------------------------------------------------------------------------------------------------------- 静态变量
		
		// -------------------------------------------------------------------------------------------------------- 静态方法
		
		// -------------------------------------------------------------------------------------------------------- 静态函数
		
		// -------------------------------------------------------------------------------------------------------- 属性
		
		public var ourgameID:String;
		
		public var username:String;
		
		public var rolename:String;
		
		public var nickname:String;
		
		public var ticket:String;
		
		public var channelID:uint;
		
		public var roomList:ArrayList;
		
		public var room:RoomInfo;
		
		public var table:TableInfo;
		
		public var user:UserInfo;
		
		public var socket:SocketProcessor;
		
		public var tableProxy:ITableProxy;
		
		// -------------------------------------------------------------------------------------------------------- 变量
		
		// -------------------------------------------------------------------------------------------------------- 构造
		
		/**
		 * 构造函数
		 */
		public function DataExchange()
		{
			super();
			
			this.roomList = new ArrayList();
			this.user = new UserInfo();
			this.socket = new SocketProcessor();
		}
		
		// -------------------------------------------------------------------------------------------------------- 方法
		
		/**
		 * 根据ID获取房间
		 * @param id
		 * @return
		 */
		public function getRoomByID(id:uint):RoomInfo
		{
			for (var i:int = 0; i < this.roomList.length; i++)
			{
				var room:RoomInfo = this.roomList.element(i);
				
				if (room.id == id)
				{
					return room;
				}
			}
			
			return null;
		}
	
		// -------------------------------------------------------------------------------------------------------- 函数
	
	}
}
