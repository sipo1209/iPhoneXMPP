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

    @Override
    public IQ parseIQ(XmlPullParser parser) throws Exception {
        PubSub pubsub = new PubSub();
       String namespace = parser.getNamespace();
       pubsub.setPubSubNamespace(PubSubNamespace.valueOfFromXmlns(namespace));
       boolean done = false;
 
       while (!done)
       {
           int eventType = parser.next();
           
           if (eventType == XmlPullParser.START_TAG)
           {
               PacketExtension ext = PacketParserUtils.parsePacketExtension(parser.getName(), namespace, parser);
               
               if (ext != null)
               {
                       pubsub.addExtension(ext);
               }
           }
           else if (eventType == XmlPullParser.END_TAG)
           {
               if (parser.getName().equals("pubsub"))
               {
                   done = true;
               }
           }
       }
       return pubsub;
    }
    
}
