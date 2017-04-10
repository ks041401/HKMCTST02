package com.hkmc.servlet;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.TimeUnit;

import com.klab.ibatis.SqlSessionManager;
import com.klab.svc.ConversationSession;

/**
 * @author 최의신 (choies@kr.ibm.com)
 *
 */
public class ConversationLogger extends Thread
{
	private BlockingQueue<ConversationSession> logQueue;
	private boolean running;
	
	public ConversationLogger()
	{
		logQueue = new ArrayBlockingQueue<ConversationSession>(100);
	}
	
	/**
	 * 
	 */
	public void shutdown()
	{
		running = false;
	}
	
	/**
	 * @param msg
	 */
	public void addDialog(ConversationSession msg)
	{
		try {
			logQueue.put(msg);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * @param msg
	 * @throws Exception
	 */
	private void insertLog(ConversationSession msg) throws Exception
	{
		System.out.println("@.@ 대화 저장...");
		
		Map<String, String> parm = new HashMap<String, String>();
		
		// 파라미터 추가
		
		//SqlSessionManager.getSqlMapClient().insert("HKMC.insertDialog", parm);
	}
	
	
	/* (non-Javadoc)
	 * @see java.lang.Thread#run()
	 */
	public void run()
	{
		running = true;
		
        while(running)
        {
        	try
        	{
            	ConversationSession msg = logQueue.poll(50, TimeUnit.MILLISECONDS);
            	if ( msg != null )
            	{
            		insertLog(msg);
            	}
        	}catch(Exception e) {
        		e.printStackTrace();
        	}
        }
	}
}
