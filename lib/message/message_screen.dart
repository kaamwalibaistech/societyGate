import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final TextEditingController _controller = TextEditingController();
  // Dummy messages for UI preview - replace with your actual chat data source
  final List<ChatMessage> _messages = [
    ChatMessage(
        text: "Hello everyone!", senderId: "user2", isCurrentUser: false),
    ChatMessage(
        text: "Hi there!",
        senderId: "user1",
        isCurrentUser: true), // Assume 'user1' is the current user
    ChatMessage(
        text: "How's the project going?",
        senderId: "user3",
        isCurrentUser: false),
    ChatMessage(
        text: "Making good progress.", senderId: "user1", isCurrentUser: true),
    ChatMessage(
        text: "Need any help?", senderId: "user2", isCurrentUser: false),
  ];

  // Method to handle sending a message
  void _sendMessage() {
    if (_controller.text.trim().isNotEmpty) {
      setState(() {
        // Add the message to the local list (for UI update)
        // In a real app, send this to your backend/chat service
        _messages.add(ChatMessage(
          text: _controller.text.trim(),
          senderId: "user1", // Replace with actual current user ID
          isCurrentUser: true,
        ));
        _controller.clear(); // Clear the input field
      });
      // TODO: Implement logic to send the message to your backend/chat service
      // e.g., chatService.sendMessage(groupId, _controller.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Group Chat'),
        // Customize AppBar color if needed
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          // Message list area
          Expanded(
            child: ListView.builder(
              padding:
                  const EdgeInsets.all(12.0), // Add padding around the list
              reverse:
                  false, // Set to true if you want latest messages at the bottom and auto-scroll
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                // Build the message bubble based on whether it's the current user's message
                return _buildMessageBubble(message);
              },
            ),
          ),
          // Message input area
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    // Determine alignment and color based on the sender
    final alignment = message.isCurrentUser
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start;
    final color =
        message.isCurrentUser ? Colors.lightBlue[100] : Colors.grey[300];
    final bubbleAlignment =
        message.isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    final margin = message.isCurrentUser
        ? const EdgeInsets.only(
            top: 4.0,
            bottom: 4.0,
            left: 60.0,
            right: 8.0) // Indent from left for own messages
        : const EdgeInsets.only(
            top: 4.0,
            bottom: 4.0,
            right: 60.0,
            left: 8.0); // Indent from right for others' messages

    return Container(
      alignment: bubbleAlignment,
      margin: margin,
      child: Column(
        crossAxisAlignment: alignment,
        children: [
          // Display sender ID/Name above the bubble for others' messages
          if (!message.isCurrentUser)
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 3.0, left: 8.0), // Adjust padding as needed
              child: Text(
                message.senderId, // Replace with sender name if available
                style: TextStyle(fontSize: 12.0, color: Colors.grey[600]),
              ),
            ),
          // The chat bubble container
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
            decoration: BoxDecoration(
                color: color,
                // Add nice rounded corners
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18.0),
                    topRight: Radius.circular(18.0),
                    bottomLeft: message.isCurrentUser
                        ? Radius.circular(18.0)
                        : Radius.circular(0), // Pointy corner for sender
                    bottomRight: message.isCurrentUser
                        ? Radius.circular(0)
                        : Radius.circular(18.0) // Pointy corner for receiver
                    )),
            child: Text(
              message.text,
              style: const TextStyle(color: Colors.black87, fontSize: 15.0),
            ),
          ),
        ],
      ),
    );
  }

  // Widget for the text input field and send button
  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor, // Use card color for background
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -1),
            blurRadius: 4,
            color: Colors.black.withOpacity(0.1),
          ),
        ],
      ),
      child: SafeArea(
        // Ensure input isn't hidden by system UI (like keyboards)
        child: Row(
          children: [
            // Potentially add an attachment button here
            // IconButton(icon: Icon(Icons.attach_file), onPressed: () {}),
            Expanded(
              child: TextField(
                controller: _controller,
                minLines: 1,
                maxLines: 5, // Allow multi-line input
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  hintText: 'Type a message...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide.none, // No visible border
                  ),
                  filled: true,
                  fillColor:
                      Colors.grey[200], // Light grey background for input
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 10.0),
                ),
                // Send message when the user presses 'send' on the keyboard
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
            const SizedBox(width: 8.0),
            // Send button
            FloatingActionButton(
              mini: true, // Make the button smaller
              onPressed: _sendMessage,
              child: const Icon(Icons.send),
              elevation: 2.0,
            ),
          ],
        ),
      ),
    );
  }
}

// Define a simple message model
class ChatMessage {
  final String text;
  final String senderId; // In a real app, use a unique user ID
  final bool isCurrentUser;

  ChatMessage(
      {required this.text,
      required this.senderId,
      required this.isCurrentUser});
}
