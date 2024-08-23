import 'package:flutter/material.dart';

class Message {
  final String text;
  final bool isSent;
  final Message? replyTo;

  Message({
    required this.text,
    required this.isSent,
    this.replyTo,
  });
}

class ChatScreen extends StatefulWidget {
  final String name;
  final String onlineStatus;

  const ChatScreen({
    Key? key,
    required this.name,
    required this.onlineStatus,
  }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Message> _messages = [];
  Message? _messageBeingRepliedTo;

  void _sendMessage() {
    final String messageText = _controller.text.trim();
    if (messageText.isNotEmpty) {
      setState(() {
        _messages.add(
          Message(
            text: messageText,
            isSent: true,
            replyTo: _messageBeingRepliedTo,
          ),
        );
        _controller.clear();
        _messageBeingRepliedTo = null; // Clear reply context after sending
      });
    }
  }

  void _onMessagePress(Message message) {
    setState(() {
      _messageBeingRepliedTo = message;
    });
  }

  Widget _buildReplyMessage(Message? replyTo) {
    if (replyTo == null) return SizedBox.shrink();

    return Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.only(bottom: 8.0, right: 16.0), 
    
      alignment: Alignment.centerRight, 
     
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.name),
            Text(
              widget.onlineStatus,
              style: TextStyle(
                fontSize: 12,
                color: widget.onlineStatus == "Online"
                    ? Colors.green
                    : Colors.grey,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.call),
            onPressed: () {
              // Call action
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isSentMessage = message.isSent;

                return GestureDetector(
                  onTap: () => _onMessagePress(message),
                  child: Align(
                    alignment: isSentMessage
                        ? Alignment.centerLeft // Align sent messages to the left
                        : Alignment.centerRight, // Align received messages to the right
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.7,
                      ),
                      decoration: BoxDecoration(
                        color: isSentMessage ? Colors.green[100] : Colors.blue[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: isSentMessage
                            ? CrossAxisAlignment.end // Align content to the end for sent messages
                            : CrossAxisAlignment.start, // Align content to the start for received messages
                        children: [
                          if (message.replyTo != null)
                            Align(
                              alignment: Alignment.centerRight, // Align reply container to the right
                              child: _buildReplyMessage(message.replyTo),
                            ),
                          Text(
                            message.text,
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (_messageBeingRepliedTo != null)
            Align(
              alignment: Alignment.centerRight, // Align reply container to the right
              child: Container(
                padding: EdgeInsets.all(8.0),
                margin: EdgeInsets.all(8.0),
                child: _buildReplyMessage(_messageBeingRepliedTo),
              ),
            ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: _sendMessage,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}









class RoundRectangleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RoundRectangleScreen'),
      ),
      body: Center(
        child: Text('This is the RoundRectangleScreen'),
      ),
    );
  }
}

class WhatsApp extends StatelessWidget {
  const WhatsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        leadingWidth: 100,
        leading: Center(
          child: Text(
            "Chats",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      "https://cdn.pixabay.com/photo/2016/03/23/04/01/woman-1274056_640.jpg"),
                    radius: 40,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Naina',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text('Sign Out'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => RoundRectangleScreen()),
                );
              },
            ),
            ListTile(
              title: Text('Marketplace'),
              onTap: () {
                // Handle Marketplace tap
              },
            ),
            ListTile(
              title: Text('Contact Us'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(
                      name: "Support",
                      onlineStatus: "Online",
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 100,
            color: Colors.grey[200],
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildAvatar("https://cdn.pixabay.com/photo/2020/05/11/11/23/woman-5157666_1280.jpg"),
                _buildAvatar("https://cdn.pixabay.com/photo/2020/10/14/03/18/man-5653200_640.jpg"),
                _buildAvatar("https://cdn.pixabay.com/photo/2019/10/22/13/43/man-4568761_640.jpg"),
                _buildAvatar("https://cdn.pixabay.com/photo/2023/01/24/13/23/viet-nam-7741017_640.jpg"),
                _buildAvatar("https://cdn.pixabay.com/photo/2024/06/25/13/12/woman-8852664_640.jpg"),
                _buildAvatar("https://cdn.pixabay.com/photo/2023/01/16/09/13/boy-guitar-style-image-7721942_640.jpg"),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildChatContainer(
                  context,
                  imageUrl: "https://cdn.pixabay.com/photo/2020/05/11/11/23/woman-5157666_1280.jpg",
                  name: "Anna Smith",
                  message: "Your order just arrived",
                  time: "12:30 PM",
                  onlineStatus: "Online",
                ),
                _buildChatContainer(
                  context,
                  imageUrl: "https://cdn.pixabay.com/photo/2020/10/14/03/18/man-5653200_640.jpg",
                  name: "David Martin",
                  message: "Your order just arrived",
                  time: "9:45 AM",
                  onlineStatus: "Offline",
                ),
                _buildChatContainer(
                  context,
                  imageUrl: "https://cdn.pixabay.com/photo/2019/10/22/13/43/man-4568761_640.jpg",
                  name: "Sarah Miller",
                  message: "Your order just arrived",
                  time: "8:15 AM",
                  onlineStatus: "Online",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(String url) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(url),
      ),
    );
  }

  Widget _buildChatContainer(
    BuildContext context, {
    required String imageUrl,
    required String name,
    required String message,
    required String time,
    required String onlineStatus,
  }) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      title: Text(name),
      subtitle: Text(message),
      trailing: Text(time),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              name: name,
              onlineStatus: onlineStatus,
            ),
          ),
        );
      },
    );
  }
}
