package com.ourgame.mahjong.libaray
{
	import com.netease.protobuf.Message;
	import com.ourgame.mahjong.libaray.events.SocketEvent;
	import com.ourgame.mahjong.libaray.vo.socket.MJDataPack;
	import com.ourgame.mahjong.libaray.vo.socket.MJDataResolver;
	import com.wecoit.debug.Log;
	import com.wecoit.net.socket.IBytesData;
	import com.wecoit.net.socket.ISocketHandler;
	import com.wecoit.net.socket.SocketClient;
	
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	
	[Event(name="connected", type="com.ourgame.mahjong.libaray.events.SocketEvent")]
	
	[Event(name="error", type="com.ourgame.mahjong.libaray.events.SocketEvent")]
	
	[Event(name="closed", type="com.ourgame.mahjong.libaray.events.SocketEvent")]
	
	[Event(name="disconnect", type="com.ourgame.mahjong.libaray.events.SocketEvent")]
	
	[Event(name="flush", type="com.ourgame.mahjong.libaray.events.SocketEvent")]
	
	[Event(name="recive", type="com.ourgame.mahjong.libaray.events.SocketEvent")]
	
	/**
	 * Socket处理器
	 * @author SiaoLeon
	 */
	public class SocketProcessor extends EventDispatcher implements ISocketHandler
	{
		// -------------------------------------------------------------------------------------------------------- 静态常量
		
		// -------------------------------------------------------------------------------------------------------- 静态变量
		
		// -------------------------------------------------------------------------------------------------------- 静态方法
		
		// -------------------------------------------------------------------------------------------------------- 静态函数
		
		// -------------------------------------------------------------------------------------------------------- 属性
		
		/**
		 * Socket客户端
		 */
		public var client:SocketClient;
		
		// -------------------------------------------------------------------------------------------------------- 变量
		
		// -------------------------------------------------------------------------------------------------------- 构造
		
		/**
		 * 构造函数
		 */
		public function SocketProcessor()
		{
			this.client = new SocketClient();
			this.client.resolver = new MJDataResolver();
			this.client.handler = this;
		}
		
		// -------------------------------------------------------------------------------------------------------- 方法
		
		public function onConnect():void
		{
			Log.info("Socket " + this.client.host + ":" + this.client.port + " 已连接。");
			
			this.dispatchEvent(new SocketEvent(SocketEvent.CONNECTED));
		}
		
		public function onIoError():void
		{
			Log.error("Socket " + this.client.host + ":" + this.client.port + " 连接失败！");
			
			this.dispatchEvent(new SocketEvent(SocketEvent.ERROR));
		}
		
		public function onSecurityError():void
		{
			Log.error("Socket " + this.client.host + ":" + this.client.port + " 安全策略连接失败！");
			
			this.dispatchEvent(new SocketEvent(SocketEvent.ERROR));
		}
		
		public function onFlush(data:IBytesData):void
		{
			Log.info("Socket " + this.client.host + ":" + this.client.port + " 发送数据：" + (data as MJDataPack).type + "|" + data);
			
			this.dispatchEvent(new SocketEvent(SocketEvent.FLUSH, data));
		}
		
		public function onRecive(data:Object):void
		{
			Log.info("Socket " + this.client.host + ":" + this.client.port + " 接收数据：" + (data as MJDataPack).type + "|" + data);
			
			this.dispatchEvent(new SocketEvent(SocketEvent.RECIVE, data as IBytesData));
		}
		
		public function onClose():void
		{
			Log.info("Socket " + this.client.host + ":" + this.client.port + " 关闭连接。");
			
			this.dispatchEvent(new SocketEvent(SocketEvent.CLOSED));
		}
		
		public function onDisconnect():void
		{
			Log.error("Socket " + this.client.host + ":" + this.client.port + " 已被断开！");
			
			this.dispatchEvent(new SocketEvent(SocketEvent.DISCONNECT));
		}
		
		/**
		 * 建立Socket连接
		 */
		public function connect(host:String, port:uint):void
		{
			if (this.client.connected)
			{
				this.client.close();
			}
			
			Log.debug("Socket", "请求连接", host, port);
			
			this.client.connect(host, port);
		}
		
		/**
		 * 发送Socket数据
		 * @param type
		 * @param msg
		 */
		public function send(type:int, msg:Message=null):void
		{
			var body:ByteArray = new ByteArray();
			
			if (msg != null)
			{
				msg.writeTo(body);
			}
			
			this.client.send(new MJDataPack(type, body));
		}
		
		/**
		 * 模拟Socket数据
		 * @param type
		 * @param msg
		 */
		public function push(type:int, msg:Message=null):void
		{
			var body:ByteArray = new ByteArray();
			
			if (msg != null)
			{
				msg.writeTo(body);
			}
			
			this.client.push(new MJDataPack(type, body));
		}
		
		/**
		 * 关闭Socket连接
		 */
		public function close():void
		{
			this.client.close();
		}
	
		// -------------------------------------------------------------------------------------------------------- 函数
	
	}
}
