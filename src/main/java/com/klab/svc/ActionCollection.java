package com.klab.svc;

import java.util.HashMap;
import java.util.Map;

import com.klab.act.SampleDBAction;

/**
 * @author 최의신 (choies@kr.ibm.com)
 *
 */
public class ActionCollection
{
	private Map<String, IAction> actions;
	
	public ActionCollection()
	{
		actions = new HashMap<String, IAction>();
		_init();
	}
	
	/**
	 * 새로운 액션을 수행할 객체를 추가한다.
	 * 객체는 IAction 인터페이스를 구현해야 한다.
	 */
	private void _init()
	{
		actions.put("retrieve_car_info", new SampleDBAction());
	}
	
	/**
	 * @param actionId
	 * @return
	 */
	public IAction getAction(String actionId)
	{
		IAction action = null;
		
		if ( actionId != null )
		{
			action = actions.get(actionId);
			if ( action == null )
				System.out.println("@.@ NOT FOUND : " + actionId);
		}
		else {
			System.out.println("@.@ ACTION ID : NULL");
		}
		
		return action;
	}
}
