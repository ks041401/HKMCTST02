package com.klab.svc;

import java.util.Set;
import java.util.ArrayList;
import java.util.Map;
import java.util.Map.Entry;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.ibm.watson.developer_cloud.conversation.v1.ConversationService;
import com.ibm.watson.developer_cloud.conversation.v1.model.MessageRequest;
import com.ibm.watson.developer_cloud.conversation.v1.model.MessageResponse;

/**
 * @author 최의신 (choies@kr.ibm.com)
 *
 */
public class WatsonConversation
{
	private String username;
	private String password;
	private String usWorkId = "3261c966-efc1-4705-a305-1a2c4b2d8d5a";
	private String krWorkId = "5134c3f5-e49c-4a0e-a2e9-a6a497af8d90";
	
	private ConversationService service;
	private ActionCollection actionCollection;

	public WatsonConversation()
	{
		try
		{
			loadConfig();
		}catch(Exception e ) {
			e.printStackTrace();
		}

		actionCollection = new ActionCollection();
	}
	
	/**
	 * @throws Exception
	 */
	private void loadConfig() throws Exception
	{
		String VCAP_SERVICES = System.getenv("VCAP_SERVICES");
		if (VCAP_SERVICES != null) {
			JsonObject obj = (JsonObject) new JsonParser().parse(VCAP_SERVICES);
			Entry<String, JsonElement> dbEntry = null;
			Set<Entry<String, JsonElement>> entries = obj.entrySet();
			for (Entry<String, JsonElement> eachEntry : entries) {
				if (eachEntry.getKey().toLowerCase().contains("conversation")) {
					dbEntry = eachEntry;
					break;
				}
			}
			if (dbEntry == null) {
				throw new RuntimeException("Could not find Conversation key in VCAP_SERVICES env variable");
			}

			obj = (JsonObject) ((JsonArray) dbEntry.getValue()).get(0);
			obj = (JsonObject) obj.get("credentials");
			
			username = obj.get("username").getAsString();
			password = obj.get("password").getAsString();
			
			//username = "ef169fc8-e030-40f4-9c42-5cf2991e9a5a";
			//password = "vERjOl8HFpbj";
			
			service = new ConversationService(ConversationService.VERSION_DATE_2017_02_03);
			service.setUsernameAndPassword(username, password);			

		} else {
			throw new RuntimeException("VCAP_SERVICES not found");
		}
	}
	
	
	/**
	 * @param session
	 * @param text
	 * @param isKr
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void message(ConversationSession session, String text, boolean isKr) throws Exception
	{
		session.reset();
		
		MessageRequest newMessage = new MessageRequest.Builder()
				  .inputText(text)
				  .context(session.getContext())
				  .build();

		MessageResponse response = service.message(isKr ? krWorkId : usWorkId, newMessage).execute();
		
		Map<String, Object> output = response.getOutput();
		
		Object action = output.get("action");
		if ( action != null )
		{
			IAction exAct = actionCollection.getAction(action.toString());
			
			if ( exAct != null )
			{
				try
				{
					Map<String, Object> rs = exAct.doAction(action.toString(), session.getParamaters());
					session.setActionResult(rs);
				}catch(Exception ig) {
					ig.printStackTrace();
				}
			}
			
			newMessage = new MessageRequest.Builder()
					  .inputText(text)
					  .context(session.getContext())
					  .build();

			response = service.message(isKr ? krWorkId : usWorkId, newMessage).execute();
		}

		System.out.println(response);
		
		session.getIntents().addAll(response.getIntents());
		session.getEntities().addAll(response.getEntities());

		session.putAll(response.getContext());
		
		/*
		 * 텍스트를 저장
		 */
		session.setInputString(text);
		Object rs = response.getOutput().get("text");
		if ( rs instanceof ArrayList & ((ArrayList)rs).size() > 0 )
		{
			session.getOutputString().addAll((ArrayList)rs);
		}
	}
}
