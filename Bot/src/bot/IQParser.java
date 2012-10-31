/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package bot;

import org.jivesoftware.smack.packet.IQ;
import org.jivesoftware.smack.packet.PacketExtension;
import org.jivesoftware.smack.provider.IQProvider;
import org.jivesoftware.smack.util.PacketParserUtils;
import org.jivesoftware.smackx.pubsub.packet.PubSub;
import org.jivesoftware.smackx.pubsub.packet.PubSubNamespace;
import org.xmlpull.v1.XmlPullParser;

/**
 *
 * @author ankurkothari
 */
public class IQParser implements IQProvider{
String node = "";
String j = "";
    public IQParser(){
        Bot.JIDs = "";
    }
    @Override
    public IQ parseIQ(XmlPullParser parser) throws Exception {
        IQ iqPacket = null;
        int eventType = parser.getEventType();
       
         while (eventType != XmlPullParser.END_DOCUMENT) {
             
          if(eventType == XmlPullParser.START_DOCUMENT) {
            //  System.out.println("Start document");
          } else if(eventType == XmlPullParser.START_TAG) {
              System.out.println("Start tag "+parser.getName());
              String value = parser.getAttributeValue(null, "jid");
              if(value != null){
              Bot.JIDs += parser.getAttributeValue(null, "jid") + ",";
              }
              String val = parser.getAttributeValue(null, "node");
              if(val != null){
             node = val;}
              
          j = Bot.JIDs;//.substring(0,Bot.JIDs.length() - 2);
             
             
          } else if(eventType == XmlPullParser.END_TAG) {
            //  System.out.println("End tag "+parser.getName());
              if(parser.getName().equals("iq"))
                  Bot.sendPush(j, node);
          } else if(eventType == XmlPullParser.TEXT) {
              System.out.println("Text "+parser.getText());
          }
          eventType = parser.next();
         }
         System.out.println("End document");
        PubSub pubsub = new PubSub();
//       String namespace = parser.getNamespace();
//       pubsub.setPubSubNamespace(PubSubNamespace.valueOfFromXmlns(namespace));
//       boolean done = false;
// 
//       while (!done)
//       {
//           int eventType = parser.next();
//           
//           if (eventType == XmlPullParser.START_TAG)
//           {
//               PacketExtension ext = PacketParserUtils.parsePacketExtension(parser.getName(), namespace, parser);
//               
//               if (ext != null)
//               {
//                       pubsub.addExtension(ext);
//               }
//           }
//           else if (eventType == XmlPullParser.END_TAG)
//           {
//               if (parser.getName().equals("pubsub"))
//               {
//                   done = true;
//               }
//           }
//       }
       
       
       return pubsub;
    }
    
}
