/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package bot;

import java.util.*;
import java.io.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;

import org.jivesoftware.smack.Chat;
import org.jivesoftware.smack.ConnectionConfiguration;
import org.jivesoftware.smack.MessageListener;
import org.jivesoftware.smack.PacketCollector;
import org.jivesoftware.smack.PacketInterceptor;
import org.jivesoftware.smack.PacketListener;
import org.jivesoftware.smack.Roster;
import org.jivesoftware.smack.Roster.SubscriptionMode;
import org.jivesoftware.smack.RosterEntry;
import org.jivesoftware.smack.RosterListener;
import org.jivesoftware.smack.SASLAuthentication;
import org.jivesoftware.smack.XMPPConnection;
import org.jivesoftware.smack.XMPPException;
import org.jivesoftware.smack.debugger.ConsoleDebugger;
import org.jivesoftware.smack.filter.AndFilter;
import org.jivesoftware.smack.filter.FromContainsFilter;
import org.jivesoftware.smack.filter.IQTypeFilter;
import org.jivesoftware.smack.filter.OrFilter;
import org.jivesoftware.smack.filter.PacketFilter;
import org.jivesoftware.smack.filter.PacketTypeFilter;
import org.jivesoftware.smack.packet.IQ;
import org.jivesoftware.smack.packet.IQ.Type;
import org.jivesoftware.smack.packet.Message;
import org.jivesoftware.smack.packet.Packet;
import org.jivesoftware.smack.packet.Presence;
import org.jivesoftware.smack.provider.IQProvider;
import org.jivesoftware.smack.provider.ProviderManager;
import org.jivesoftware.smackx.ServiceDiscoveryManager;
import org.jivesoftware.smackx.packet.DiscoverItems;
import org.jivesoftware.smackx.pubsub.AccessModel;
import org.jivesoftware.smackx.pubsub.ConfigureForm;
import org.jivesoftware.smackx.pubsub.FormType;
import org.jivesoftware.smackx.pubsub.Item;
import org.jivesoftware.smackx.pubsub.ItemPublishEvent;
import org.jivesoftware.smackx.pubsub.LeafNode;
import org.jivesoftware.smackx.pubsub.Node;
import org.jivesoftware.smackx.pubsub.NodeExtension;
import org.jivesoftware.smackx.pubsub.PayloadItem;
import org.jivesoftware.smackx.pubsub.PubSubElementType;
import org.jivesoftware.smackx.pubsub.PubSubManager;
import org.jivesoftware.smackx.pubsub.PublishModel;
import org.jivesoftware.smackx.pubsub.SimplePayload;
import org.jivesoftware.smackx.pubsub.Subscription;
import org.jivesoftware.smackx.pubsub.SubscriptionsExtension;
import org.jivesoftware.smackx.pubsub.listener.ItemEventListener;
import org.jivesoftware.smackx.pubsub.packet.PubSub;
import org.jivesoftware.smackx.pubsub.packet.PubSubNamespace;
import org.xmlpull.mxp1.MXParser;
import org.xmlpull.v1.XmlPullParser;
import org.jivesoftware.whack.*;
public class Bot implements MessageListener, PacketListener {

    public XMPPConnection connection;
    public static String JIDs;

    public void login(String userName, String password) throws XMPPException {
        ConnectionConfiguration cc = new ConnectionConfiguration("ankurs-macbook-pro.local", 5222, "ankurs-macbook-pro.local");
        connection = new XMPPConnection(cc);
        try {
            connection.connect();

            // You have to put this code before you login
            SASLAuthentication.supportSASLMechanism("PLAIN", 0);

            // You have to specify your Jabber ID addres WITHOUT @jabber.org at the end
            connection.login(userName, password);

            // See if you are authenticated
            System.out.println(connection.isAuthenticated());

// Register the listener.
            connection.addPacketListener(this, null);
//System.out.println(connection.getPacketListeners());
            // Create a pubsub manager using an existing Connection
//String pubSubAddress = connection.getServiceName();

            PubSubManager mgr = new PubSubManager(connection);
            //you cant find out all the nodes for ankurs-macbook-pro.local but find out all the users..and then query them for the nodes they have created. 

//            PubSub reply = (PubSub)sendPubsubPacket(Type.GET, new NodeExtension(PubSubElementType.SUBSCRIPTIONS_OWNER, getId()), PubSubNamespace.OWNER);
//		SubscriptionsExtension subElem = (SubscriptionsExtension)reply.getExtension(PubSubElementType.SUBSCRIPTIONS_OWNER);
//		return subElem.getSubscriptions();
//            
            // leaf = mgr.createNode("say5");
            ProviderManager p = ProviderManager.getInstance();
            p.addIQProvider("pubsub", "http://jabber.org/protocol/pubsub#owner", new IQParser());


//            PubSub request = new PubSub();
//		request.setTo("pubsub.ankurs-macbook-pro.local");
//		request.setType(Type.GET);
//		request.addExtension(new NodeExtension(PubSubElementType.SUBSCRIPTIONS, "say2"));
//               
//		request.setPubSubNamespace(PubSubNamespace.OWNER);
//		
//                
////                SubscriptionsExtension subElem = (SubscriptionsExtension)reply.getExtension(PubSubElementType.SUBSCRIPTIONS);
////                 subElem.getSubscriptions();
//
//		//request.addExtension(new NodeExtension(PubSubElementType.SUBSCRIPTIONS, "say3"));
//                
//                connection.sendPacket(request);
            // Obtain the ServiceDiscoveryManager associated with my Connection

//      ServiceDiscoveryManager discoManager = ServiceDiscoveryManager.getInstanceFor(connection);
//      
//      // Get the items of a given XMPP entity
//      // This example gets the items associated with online catalog service
//      DiscoverItems discoItems = discoManager.discoverItems("ankur@ankurs-macbook-pro.local");
//
//      // Get the discovered items of the queried XMPP entity
//      Iterator it = discoItems.getItems();
//      // Display the items of the remote XMPP entity
//      while (it.hasNext()) {
//          DiscoverItems.Item item = (DiscoverItems.Item) it.next();
//          System.out.println(item.getEntityID());
//          System.out.println(item.getNode());
//          System.out.println(item.getName());
//      }

            //Create the node

            // Get the node

            // Create the node
//      LeafNode leaf = mgr.createNode("tesvcvcxvxztNode");
//      ConfigureForm form = new ConfigureForm(FormType.submit);
//      form.setAccessModel(AccessModel.open);
//      form.setDeliverPayloads(false);
//      form.setNotifyRetract(true);
//      form.setPersistentItems(true);
//      form.setPublishModel(PublishModel.open);
//      
//      leaf.sendConfigurationForm(form);
//            leaf.send(new Item("p"));
////            // Get the node
//            List<Subscription> subscriptions = mgr.getSubscriptions();




//      
//      System.out.println(connection.getUser());
////      
//       Collection<String> ids = new ArrayList<String>(3);
//     ids.add("1");
//      ids.add("3");
//      ids.add("4");
//      
//      List<? extends Item> items = node.getItems();
//      System.out.println("fewr");
// dscdscdsdscds




//            List userList = new ArrayList();
//            // Discover the node subscriptions
//      <pubsub xmlns=’http://jabber.org/protocol/pubsub#owner’>
//<subscriptions node=’latest_books’/> </pubsub>

            //     List<Subscription> subscriptionsForNode = node.getSubscriptions();
//            for (int i = 0; i < subscriptionsForNode.size(); i++) {
//                Subscription subs = (Subscription) subscriptionsForNode.get(i);
//                String JID = subs.getJid();
//                if (!userList.contains(JID)) {
//                    userList.add(JID);
//                    try {
//                        sendPush(userList,node);
//                    } catch (UnsupportedEncodingException ex) {
//                        Logger.getLogger(Bot.class.getName()).log(Level.SEVERE, null, ex);
//                    } catch (IOException ex) {
//                        Logger.getLogger(Bot.class.getName()).log(Level.SEVERE, null, ex);
//                    }
//                }
//            }
        } catch (XMPPException e1) {
            e1.printStackTrace();
        }


    }

    @Override
    public void processPacket(Packet packet) {
        Message message = (Message) packet;
        if (message.getType() == Message.Type.chat) {
            if (message.getBody().equals("registered")) {
                Roster roster = connection.getRoster();
                try {
                    roster.createEntry(message.getFrom(), message.getFrom(), null);
                } catch (XMPPException ex) {
                    Logger.getLogger(Bot.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            System.out.println(message.getFrom() + " says: " + message.getBody());
            PubSubManager mgr = new PubSubManager(connection);
            int index = message.getBody().indexOf("create");
            if (index >= 0) {
                int i = message.getBody().indexOf(" ");
                LeafNode leaf;
                try {
                    System.out.println(message.getBody().substring(i + 1) + "|");
                    leaf = mgr.createNode(message.getBody().substring(i + 1));
                    ConfigureForm form = new ConfigureForm(FormType.submit);
                    form.setAccessModel(AccessModel.open);
                    form.setDeliverPayloads(true);
                    form.setNotifyRetract(true);
                    form.setPersistentItems(true);
                    form.setPublishModel(PublishModel.open);

                    leaf.sendConfigurationForm(form);
                    sendMessage(message.getBody(), message.getFrom());
                    leaf.addItemEventListener(new ItemEventCoordinator());

                } catch (XMPPException ex) {
                    Logger.getLogger(Bot.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            int index1 = message.getBody().indexOf("publish");
            if (index1 >= 0) {
                int i = message.getBody().indexOf(" ");
                int j = message.getBody().lastIndexOf(" ");
                LeafNode leaf;
                try {
                    leaf = (LeafNode) mgr.getNode(message.getBody().substring(i + 1, j));
                    leaf.send(new PayloadItem(message.getBody().substring(j + 1),
                            new SimplePayload(message.getBody().substring(j + 1), "pubsub:event", "<title>" + message.getFrom() + ": " + message.getBody().substring(j + 1) + "</title>")));//message.getBody().substring(j+1))

                    PubSub request = new PubSub();
                    request.setTo("pubsub.ankurs-macbook-pro.local");
                    request.setType(Type.GET);
                    request.addExtension(new NodeExtension(PubSubElementType.SUBSCRIPTIONS, leaf.getId()));

                    request.setPubSubNamespace(PubSubNamespace.OWNER);

                    connection.sendPacket(request);


                } catch (XMPPException ex) {
                    ex.printStackTrace();
                }
            }
        }
    }

    class ItemEventCoordinator implements ItemEventListener {

        @Override
        public void handlePublishedItems(ItemPublishEvent items) {

            List<Item> itemsList = items.getItems();
            for (int i = 0; i < itemsList.size(); i++) {
                System.out.println((((Item) itemsList.get(i))).toXML());
                System.out.println(items.toString());
            }


//               PubSub request = new PubSub();
//		request.setTo("pubsub.ankurs-macbook-pro.local");
//		request.setType(Type.GET);
//		request.addExtension(new NodeExtension(PubSubElementType.SUBSCRIPTIONS, items.getNodeId()));
////               
//		request.setPubSubNamespace(PubSubNamespace.OWNER);
//	        connection.sendPacket(request);
        }
    }

    public void sendMessage(String message, String to) throws XMPPException {
        Chat chat = connection.getChatManager().createChat(to, this);
        chat.sendMessage(message);
    }

    public void displayBuddyList() {
        Roster roster = connection.getRoster();
        roster.setSubscriptionMode(SubscriptionMode.accept_all);
        roster.addRosterListener(new RosterListener() {
            public void entriesDeleted(Collection<String> addresses) {
                System.out.println("deleted");
            }

            public void entriesUpdated(Collection<String> addresses) {
                System.out.println("updated");
            }

            public void presenceChanged(Presence presence) {
                System.out.println(presence.getType());
                System.out.println("Presence changed: " + presence.getFrom() + " " + presence);
            }

            @Override
            public void entriesAdded(Collection<String> arg0) {
                System.out.println("added");

            }
        });
        Collection<RosterEntry> entries = roster.getEntries();

        System.out.println("\n\n" + entries.size() + " buddy(ies):");
        for (RosterEntry r : entries) {
            System.out.println(r.getUser());
        }
    }

    public void disconnect() {
        connection.disconnect();
    }

    public void processMessage(Chat chat, Message message) {


        if (message.getType() == Message.Type.chat) {
            if (message.getBody().equals("registered")) {
                Roster roster = connection.getRoster();
                try {
                    roster.createEntry(message.getFrom(), message.getFrom(), null);
                } catch (XMPPException ex) {
                    Logger.getLogger(Bot.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            System.out.println(message.getFrom() + " says: " + message.getBody());
            PubSubManager mgr = new PubSubManager(connection);
            int index = message.getBody().indexOf("create");
            if (index >= 0) {
                int i = message.getBody().indexOf(" ");
                LeafNode leaf;
                try {
                    System.out.println(message.getBody().substring(i + 1) + "|");
                    leaf = mgr.createNode(message.getBody().substring(i + 1));
                    ConfigureForm form = new ConfigureForm(FormType.submit);
                    form.setAccessModel(AccessModel.open);
                    form.setDeliverPayloads(true);
                    form.setNotifyRetract(true);
                    form.setPersistentItems(true);
                    form.setPublishModel(PublishModel.open);

                    leaf.sendConfigurationForm(form);
                    sendMessage(message.getBody(), message.getFrom());
                    leaf.addItemEventListener(new ItemEventCoordinator());

                } catch (XMPPException ex) {
                    Logger.getLogger(Bot.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            

//             int index2 = message.getBody().indexOf("createme");
//            if (index2 >= 0) {
//                int i = message.getBody().indexOf(" ");
//                LeafNode leaf;
//                try {
//                    System.out.println(message.getBody().substring(i + 1) + "|");
//                    leaf = mgr.createNode(message.getBody().substring(i + 1));
//                    ConfigureForm form = new ConfigureForm(FormType.submit);
//                    form.setAccessModel(AccessModel.open);
//                    form.setDeliverPayloads(true);
//                    form.setNotifyRetract(true);
//                    form.setPersistentItems(true);
//                    form.setPublishModel(PublishModel.open);
//
//                    leaf.sendConfigurationForm(form);
//                    sendMessage(message.getBody(), message.getFrom());
//                    leaf.addItemEventListener(new ItemEventCoordinator());
//
//                } catch (XMPPException ex) {
//                    Logger.getLogger(Bot.class.getName()).log(Level.SEVERE, null, ex);
//                }
//            }
            
            int index1 = message.getBody().indexOf("publish");
            if (index1 >= 0) {
                int i = message.getBody().indexOf(" ");
                int j = message.getBody().lastIndexOf(" ");
                LeafNode leaf;
                try {
                    leaf = (LeafNode) mgr.getNode(message.getBody().substring(i + 1, j));
                    leaf.send(new PayloadItem(message.getBody().substring(j + 1),
                            new SimplePayload(message.getBody().substring(j + 1), "pubsub:event", "<title>" + message.getFrom() + ": " + message.getBody().substring(j + 1) + "</title>")));//message.getBody().substring(j+1))

                    PubSub request = new PubSub();
                    request.setTo("pubsub.ankurs-macbook-pro.local");
                    request.setType(Type.GET);
                    request.addExtension(new NodeExtension(PubSubElementType.SUBSCRIPTIONS, leaf.getId()));

                    request.setPubSubNamespace(PubSubNamespace.OWNER);

                    connection.sendPacket(request);


                } catch (XMPPException ex) {
                    ex.printStackTrace();
                }
            }
        }
    }

    public static void main(String args[]) throws XMPPException, IOException {
        // declare variables
        Bot c = new Bot();
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        String msg;


        // turn on the enhanced debugger
        XMPPConnection.DEBUG_ENABLED = true;


        // Enter your login information here
        c.login("bot", "bot");

        c.displayBuddyList();

        System.out.println("-----");

        System.out.println("Who do you want to talk to? - Type contacts full email address:");
        String talkTo = br.readLine();

        System.out.println("-----");
        System.out.println("All messages will be sent to " + talkTo);
        System.out.println("Enter your message in the console:");
        System.out.println("-----\n");

        while (!(msg = br.readLine()).equals("bye")) {
            c.sendMessage(msg, talkTo);
        }

        c.disconnect();
        System.exit(0);
    }

    public static void sendPush(String userList, String node) throws UnsupportedEncodingException, IOException {
        String listString = null;
        String j = userList.substring(0, userList.lastIndexOf(","));
        System.out.println(j);
        DefaultHttpClient httpclient = new DefaultHttpClient();
        HttpPost httpPost = new HttpPost("http://push.herokuapp.com/push/push");
        List<NameValuePair> nvps = new ArrayList<NameValuePair>();
        nvps.add(new BasicNameValuePair("jabber_ids", j));

        nvps.add(new BasicNameValuePair("node", node));
        httpPost.setEntity(new UrlEncodedFormEntity(nvps));
        HttpResponse response2 = httpclient.execute(httpPost);

        try {
            System.out.println(response2.getStatusLine());
            HttpEntity entity2 = response2.getEntity();
            // do something useful with the response body
            // and ensure it is fully consumed
            EntityUtils.consume(entity2);
        } finally {
            httpPost.releaseConnection();
        }
    }
}
//node.getSubscriptions gives all the subscribers for the particular node. 
//   // Discover the node subscriptions
//      List<Subscription> subscriptions = node.getSubscriptions();
//      Subscription subs = subscriptions.