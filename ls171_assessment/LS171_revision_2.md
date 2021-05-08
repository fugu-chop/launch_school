### What is the internet?
The internet is a network of networks that enables the transfer of resources between networks and devices. The world wide web is a service that can be accessed via the internet. 

### What is a network?
A network, at it's simplest implementation, is two or more devices that are connected in such a way that the exchange of information is possible. In slightly more complex implementations, there may be multiple devices connected to a switch or hub, which can all exchange information (this is a Local Access Network, or LAN). The devices in this LAN, without a router, are unable to connect to, or exchange information with, other networks.

### What is a protocol?
A protocol is a system of rules designed to govern some aspect of network communication. A protocol could govern:
- Different aspects of communication, such as communication _within_ a network versus communication _across_ different networks (in the context of a layered model of network systems, this would be protocols across different layers)
- Different rules for the same aspect of communication, such as the use of TCP or UDP as a protocol for messages (in a layered system model, this the choice of multiple protocols on a single layer).

### Explain the 'layered system'
The layered system is a model of grouping the different functions of network communication into distinct 'groups'. There are two dominant network system models:
1. OSI (Open Systems Interconnection)
2. Internet Protocol Suite (Also known as a the TCP/IP or DoD model).

They are roughly equivalent (though some overlap does occur) in respect of the 'layers' that they describe. They differ in respect of how the layers are divided:
- The TCP/IP model divides the layers in terms of the __scope__ of communications (e.g. within a local network, between networks, etc). 
- The OSI model divides the layers in terms of the __functions__ that each layer provides (physical addressing, logical addressing and routing, encryption, compression, etc).

### What is encapsulation in the context of the layered system?
One key benefit of the layer system is the encapsulation of functionality within a layer. This means that through encapsulation, subsequent layers are 'insulated' from implementation or protocol specific details at higher layers - a layer higher in a layered system model can encapsulate it's data payload with headers as a protocol data unit and pass it down to another layer, whose responsibility is for another aspect of communication - it does not need to know anything about the specifics of the data payload of the protocol data unit; it only needs to structure it's headers and encapsulate the PDU from the previous layer into another PDU, to pass to the next layer for the next stage of network communication.

### Describe the physical layer.
The physical layer is the bottom most layer of the OSI model. The TCP/IP model does not specify a physical layer; the Link Layer has some physical functions built into it. The physical layer handles the conversion of data from bits into a signal (e.g. electrical signal for transmission across copper wires, light signals for transmission across fibre optic cables, or radio signals for wireless transmission). There is no common protocol at this layer, except for the laws of nature, which create limitations and provide forms that these transmissions must take to be received.

### Describe the characteristics of the physical layer.
The laws of nature create some limitations on the way that data can be transferred (we could regard these laws of nature as a 'protocol' for the physical layer). The two key limitations are:
1. Bandwidth - the amount of data that can be transferred in a given period of time (usually a second). In an analogy, we could equate this to the number of lanes on a road; more lanes allows for more vehicles (data) on the road at any one time
2. Latency - This is the time between transmission of a message and the receipt of the message, regarded as a 'delay'. We can think of this as a speed limit on the road. There are four key components to latency:
    - Propagation delay: This is the 'pure' delay in transmission of information, limited by the laws of nature (such as resistance in copper wires)
    - Transmission delay: This is the time taken to push data onto network devices before that data can be pushed onto another network device. We might regard this as the time taken to navigate an intersection on a road. 
    - Processing delay: Network devices need time to process data before transmitting it. This is the tie taken for that processing to occur. We could equate this to a checkpoint inspection before our car gets to an intersection.
    - Queuing delay: Network devices have a fixed capacity to process and transmit data. When this capacity is exceeded, the excess data is stored in a buffer, to be processed at a later time. The time that this data is 'waiting' to be processed is queuing delay. We could regard this as traffic leading up to the checkpoint, in our analogy.

### What is the Round Trip Time (RTT)?
Round trip time refers to the amount of time taken between the time of transmission, to receiving an acknowledgement for that message.

### What is the Link/Data Link Layer? What protocols does it use?
The Link/Data Link layer is responsible for the transfer of data within a local network, between devices. Within the OSI model, the Data Link layer is Layer 2 and comes in between the Physical layer (1) and the Network layer (3). Within the Internet Protocol Suite, the Link layer is layer 1, since this model doesn't define a specific layer for the physical network. Within both of these models, the Link/Data-Link layer works as an _interface between the workings of the physical network and the more logical layers above_. IT is also the lowest level that data encapsulation occurs.

The most commonly used protocol at this layer is the Ethernet protocol, which holds two particular responsibilities in achieving cross-device transfer of information:
1. Framing
2. Addressing

_Framing_ refers to encapsulating the data payload (i.e. the packet) from the Internet/Network layer with some headers into a _frame_, so that the data is consistently structured and can be interpreted by another network device. This frame is then passed to the physical layer for conversion into a signal and transmitted. An Ethernet frame will have a source and destination MAC address, which helps with addressing. 

_Addressing_ refers to the ability to send data to a particular recipient on a network. The way this is achieved in the Ethernet protocol is through the use of MAC (Media Access Control) addresses. MAC addresses are 'burned-in' to each physical device, and are unique. As data passes across various routers on networks, the router will have a table of all the devices connected to it, and their MAC addresses. 

On each 'hop', the _Address Resolution Protocol (ARP)_ is then used to determine the MAC address of the next hop by decapsulating the frame back to a packet (ARP queries the next endpoint by IP address, and that query returns the MAC address for that endpoint). The network device then re-encapsulates this packet as a frame, to be passed to the next device.

### What functionality does the Ethernet Protocol provide?
The Ethernet Protocol has both hardware specifications (e.g. how a CAT6 Ethernet cable should be manufactured) and rules for how information should be structured and sent across devices on a local network.

### What is the Internet/Network Layer? What protocols does it use?
The Internet/Network layer is responsible for the transfer of information across _different networks_. In the OSI model, the Network layer is layer 3 (between the Data Link and Transport layers). In the Internet Protocol Suite, the Internet layer is layer 2 (between the Link layer and the Transport layer). The most frequently used protocol at this layer is the Internet Protocol. 

the Internet Protocol has two specific functions:
1. Structuring data into an internet packet, so that it can be encapuslated and passed down to the Link/Data-Link layer (encapsulating the data payload from the Transport layer).
2. Addressing, or sending information to the correct location through use of IP addresses.

In terms of the data structure, the data payload at the Internet/Network layer is combined with a number of headers; some of the more important fields are:
- _Source and Destination IP addresses_, which direct the information across different networks to the correct device (and is how the Internet/Network layers achieve addressing)
- _Version_, which specifies the version of the Internet Protocol to be used (which will affect the headers) - e.g. IPv4 or IPv6
- _Time to Live_, which specifies how many 'hops' a packet travel before being discarded (this stops lost packets from endlessly circulating networks)

### How are IP addresses used to transmit data? *
IP addresses provide the Internet Protocol the ability to route data to specific hosts on different networks. IPv4 addresses are 32 bits long, split into 4 8-bit sections of hexadecimal numbers. Unlike the Link/Data-Link layer, the Network/Internet Layer is concerned with end-to-end communications and doesn't really worry about what specific path the information should take on a local network. In an Internet Packet, the header will contain a source and destination IP address, which represents the very start and end of the message's path.

IP addresses are hierarchical and logical (contrast this with MAC adddresses, which are flat and immutable). This is beneficial in that IP addresses can be reassigned as necessary to various devices within a network (all network devices have an IP address as well as a MAC address), as well as allowing for splitting a series of IP addresses into a subnet. This is useful, as routers (the primary device used to route information between networks, and the 'entry point' to a given network) only need to keep record of a certain range of IP addresses within their local network, instead of an incredibly large table of every single device ever created and it's MAC address, or the IP address of every single device within an addressable range.

### What is DNS? What is it's function?
The Domain Name System (DNS) is a hierarchical system of servers that translates the `host` in a URL to an IP address, which allows the correct routing of an HTTP request to a server that can fulfil that request. As no one single DNS server can contain a record of every single domain name and it's corresponding IP address, DNS servers are set up in a hierarchical fashion, so that if a particular DNS server does not know the IP address of a host, that request can be passed up the hierarchy until a server with the appropriate IP address is found.

### What is the transport layer?
The Transport layer is responsible for providing multiplexing and demultiplexing capabilities - i.e. the ability to send multiple types of application data over a single communication channel. Multiplexing at the Transport layer relies on instantiating (potentially multiple) socket object on the server to interpret data coming in from different sockets (i.e. the combination of IP address and Port).

In the OSI model, the Transport layer is a layer between the Presentation and Network layers. In the Internet Protocol Suite, the Transport layer is layer 3 (between the Application and Internet layer), which combines parts of the Session and Transport layer in the OSI model. The two most popular protocols at the Transport layer are Transmission Control Protocol (TCP) and User Datagram Protocol (UDP). Which one is used will depend on the use-cases of the underlying application.

### What is multiplexing? Why is it necessary?
Multiplexing refers to the capability for transfer multiple signals over a single channel. It can exist on the physical layer (e.g. refracting light at different angles over the same single fibre optic cable to transfer multiple signals), but in the case of the Transport layer, exists as the ability to transport different sources of application data over a single communication channel by assigning different sources of application data to different sockets (a combination of IP address and port number). The server may have a single or multiple socket objects instantiated on it's end (depending on whether a connection-oriented or connection oriented implementation is required). This socket helps the server interpret the incoming application data, but also correctly send the data to the correct recipient.

Without multiplexing, the transmission of information would be extremely slow and time consuming, as multiple connections would have to be set up to transfer each source of application data, which is inefficient.

### What is a port? What is it used for?
A port is an identifier for a specific application process. It is used through the multiplexing capabilities of the Transport layer. A port will typically be combined with an IP address to create a socket, which provides a specific location where a request can be sent from and responded to by the server. On the server end, some ports are reserved for well known applications (e.g. port 80 is reserved on the server end for HTTP requests). On the client end, ephemeral ports (i.e. temporary ports) as assigned to applications for usage. Which ports these are depends on the client's operating system.

### What is a socket? What is it used for?
The conceptual definition of a socket is a combination of an IP address and a port, and can be regarded as a communication end-point (this should be distinguished from the implementation of a socket). Sockets are used as part of the multiplexing capabilities offered at the Transport layer. In a connection-oriented system, a socket object would be instantiated for each incoming socket, such that a dedicated virtual connection is established between client and server for each application process (the combination of the source and destination socket is known as a _four-tuple_). In a connectionless system, only a single socket object is instantiated on the server, and messages are simply responded to in the order they are received. In both cases, the socket of the client helps the server identify where to send a response to.

### What is a connection-oriented network system? What is an example of this?
A connection-oriented network system establishes dedicated sockets for each source of application data between the client and the server. A connection-oriented network system enables reliability function by enabling things like:
1. In-order delivery
2. Handling duplicate messages
3. Handling retransmission of lost/corrupted messages
4. Error checking (though this is still possible at lower levels such as the Network/Internet layer when using the Internet Protocol v4). An example of a connection-oriented network system is the Transmission Control Protocol at the Transport layer. While connection-oriented network systems can provide reliability that other layers do not enable, this comes at the cost of additional latency due to the additional processing of more TCP segment headers, potential retransmission, head-of-line blocking when retransmission is required/message arrive at the server out of order. 

### What is a connectionless network system? What is an example of this?
A connectionless network system is one that relies on a single socket object on the server to handle all incoming application data requests, such that requests are responded to as and when they are received. By default, it does not allow for reliability functions like in-order delivery, but these can be built in by the application developer. The advantage of connectionless network systems is reduced latency - with fewer headers and back and forth-exchange of messages between client and server, message transfer can be faster. Connectionless systems also can have more flexibility - it is easier to build additional reliability functions on top of a connectionless system than disabling or removing functions from a connection-oriented network system. An example of a connectionless network system is the User Datagram Protocol (UDP) on the Transport layer.

### What is network reliability? How do we achieve network reliability?
Network reliability means that messages exchanged between client and server have additional checks to ensure that messages are received, in order. There are typically four components of reliability that we can observe (e.g. in a connection-oriented network system).
1. In-order delivery - messages are processed in the order that they are sent (not necessarily received)
2. Error-checking - the TCP segment has a checksum field, though other lower layers can also have a checksum field (e.g. the packet at the Network/Internet layer when the Internet Protocol v4 is used).
3. Handling duplication - the `sequence` and `acknowledgement` header fields allow the server to detect and disregard duplicate messages
4. Handling retransmission - TCP requires acknowledgment messages for requests, and so when an acknowledgment message is not received by the client, TCP will handle re-sending the message.

Network reliability is typically associated with connection-oriented systems, due to the dedicated connections (via sockets) established between client and server for each source of application data. However, reliability functions can be added on top of connectionless network systems like UDP by the application developer.

### What is TCP? What are it's downsides/upsides? *
TCP (Transmission Control Protocol) is a protocol that can be used at the Transport layer. TCP is connection oriented, meaning that individual socket objects are established as dedicated connections between the client and server for different application data. TCP is frequently used because of the reliability mechanisms; in theory, before any application can be sent to the server, a TCP connection must be established between the client and server for each request (though in practice connection types like `keepalives` and pipelining allow multiple requests to be sent per connection).

The obvious benefit of TCP as a connection oriented network system is reliability. Layers beneath the Transport layer do not have reliability mechanisms - certain layers can implement a `checksum` header field as part of error checking. However, if a protocol data unit is found to have been corrupted or an error is found, that message is simply dropped, with no provision for resubmission. TCP handles this through the TCP handshake - if an acknowledgment message is not received for a request within a specified amount of time, the message will be resent.

The potential downside of TCP is the additional latency associated with having to establish a TCP connection through the TCP handshake prior to each request. Another consequence of in-order delivery (not necessarily TCP specifically) is _head of line_ blocking - this occurs when a message is received by the server out of order compared to the order in which the messages were sent. If a message is out of order, TCP will require the missing message to be received (or retransmitted, if necessary) before subsequent messages are processed (though this isn't a problem unique to the Transport layer).

### What is UDP? What are it's downsides/upsides?
The User Datagram Protocol (UDP) is a Transport layer protocol. It is a connectionless network system, meaning that only a single socket object is instantiated on the server end to handle all incoming requests from different application sources, where requests are dealt with as and when they come. The key disadvantage when compared with TCP is the lack of reliability; by default, UDP does not provide for things like in-order delivery, retransmission or duplication checking (though these could be built in as required by a developer). The advantage is the reduced latency from not having overheads like a TCP handshake every time a message is transferred - with UDP, an application can simply start sending data without waiting for a connection to be established with the _application process of the server_.

### What is the TCP handshake?
The TCP handshake is a process of establishing a TCP connection with the _application process of the server_ before any application data can be sent. In theory, it should occur on each request, though connection types like `keepalives` and pipelining mean that often multiple requests can be sent per connection. There are three key steps to the TCP handshake:
1. The client sends a `SYN` message (i.e. TCP segment with no payload, and `SYN` header value of `1`) to the server.
2. The server, receiving the `SYN` message, sends a `SYN ACK` message (i.e. TCP segment with no payload, and `SYN` and `ACK` header values of `1`) back to the client.
3. The client, receiving the `SYN ACK` message, sends an `ACK` message back to the server. At this point, the client is able to start sending application data to the server. The server is only able to start sending application data responses _after_ it has received the `ACK` message.

### What is pipelining?
Pipelining is the mechanism for using a single connection to send multiple requests at one time. It is a better utilisation of the available bandwidth on a connection, as particularly for TCP connections, the in-order delivery capabilities mean we would have to wait for each message to be sent and an acknowledgment received individually before the next message could be sent. Reliability is still preserved through pipelining, as the server would send multiple acknowledgments at the one time.

A TCP segment can set the number of messages to be sent simultanenously through the `window size` header value (which is also a method of ensuring congestion avoidance throughout the network and implementing flow control between devices).

### What is flow control? *
Flow control is the ability to avoid overwhelming a receiver with too much data. The receiver has a limited capacity to process and respond to incoming requests. As that capacity is exceeded, excess data is sent to a buffer. If that buffer starts becoming full, the receiver can send an acknowledgment message with a reduced `window size` header value, indicating to the sender that it should slow down the amount of messages being sent, so that the receiver can work through the stored data in the buffer. This `window size` header value can be dynamically adjusted through the course of message exchange, allowing more messages to be sent as the receiver's buffer starts to empty.

### What is congestion avoidance? *
Congestion avoidance is the mechanism through which TCP ensures that the underlying network is not overwhelmed by the message exchange process between a sender and receiver. Network devices on the network through which messages are passed have a limited capacity to process and transmit messages. As this capacity is exceeded, excess messages are passed to that device's buffer. However, if that buffer becomes full, excess messages are simply dropped, and need to be retransmitted. TCP monitors the level of transmission required - if the number of messages requiring re-transmission suddenly spikes, this can indicate that a particular connection is sending too much data over the network. TCP can then adjust the `window size` header value on the segments to slow down the rate of data transfer.

### What is the application layer? *
The application layer is the top layer in both the OSI and Internet Protocol Suite network models. There are numerous protocols at the application layer, depending on the actual application itself; in general, the protocols at this layer are responsible for providing communication services to the application itself, as well as structuring the application data for encapsulation and interpretation by other application services (e.g. on a server).

### What is HTTP?
HTTP (HyperText Transfer Protocol) is an application layer protocol that provides uniformity to the way that resources on the web are transferred. It is a text-based protocol (meaning messages are communicated in plain text) and operates on a request/response cycle; a client will issue a request, while the server will respond with a resource or action.

### What is a URL? How is it different from a URI? *
A URI (Uniform Resource Identifier) is a sequence of characters that identify an abstract or physical resource. A URL (Uniform Resource Locator), in addition to being a URI, identifies the primary access mechanism for that resource (e.g. a network location).

### What are the components of a URL? *
A URL has potentially 5 components:
1. The _scheme_: This indicates _how_ a resource can be accessed, usually be specifying a protocol. The scheme is identified as the sequence of characters preceeding `://` in a URL. 
2. The _host_: This indicates _where_ the resource is hosted on the internet (e.g. `www.google.com`). As part of accessing a host, a web browser would typically make a call to the DNS server so that the host can be translated to an IP address.
3. The _path_: This is a more specific locator for a resource, and is optional.
4. The _port_: This is only necessary if the request is issued to a non-default port; otherwise it is assumed to be part of a URL, even if not explicitly stated in the URL string.
5. Query Strings: These allow for additional information to be passed to the server as part of a `GET` request. In the URL, they will be found after a `?` character, as `name=value` pairs, separated by `&` characters. These are optional.

### What is a query string parameter? Why would we use it/not use it?
A query string parameter is an optional part of a URL, that can be used to pass additional information to a server as part of a `GET` request. They can also assist in simulating statefulness.

They are `name=value` pairs that follow a `?` character in a URL, and are separated by `&` symbols. While query string parameters provide additional flexibility in `GET` requests, there are circumstances where they might not be appropriate:
1. Query Strings have a maximum length. This means that if there is a large volume of information that needs to be conveyed to a server as part of a request, the information might be truncated. A `POST` request might be more appropriate in this case.
2. Query Strings are unencrypted. As HTTP is a text-based protocol, query strings can easily be read in the message exchange process. This makes them unsuitable for conveying sensitive information, like passwords or usernames. `POST` requests, or encryption of messages might be useful here.
3. Unsupported characters. If our query strings contain data that has characters outside of the 128 standard ASCII character set, or uses characters that are required for interpreting a URL, they need to be encoded first.

### What is URL encoding and why would we use it?
URL encoding is the process of converting certain characters that are unsupported by the 128 standard ASCII character set, or are unsafe or reserved for URL use. An offending character will typically be replaced with a `%` symbol followed by a two digit hexadecimal number that represents the ASCII character (the ASCII code). Unsafe or reserved characters are those that could be interpreted as part of the data being transferred, or used in the interpretation of the URL itself. 

### What is a server? What are the infrastructure components of a server?
A server is a machine that listens for incoming requests and responds. A server will typically have three distinct types of infrastructure to them (the actual number of components and their configuration might differ)
1. Web server: This infrastructure is used for retrieving static assets, such as images, CSS or JavaScript files, that don't require processing or business logic applied to them
2. Application server: This is used when the response requires some degree of processing or business logic applied. This is where server-side application code lives  when deployed.
3. Data store: This is where data can be created, retrieved, updated or deleted in a persistent fashion, perhaps as a relational database.

### What are resources?
Resources is the generic term for anything that can be accessed through the internet via a URL. 

### What is statelessness? Why is it an issue with HTTP?
HTTP is a stateless protocol. This means that each request/response pair is independent of all other requests/responses, and have no context of what information those pairs contain. This is helpful in that information does not have to be persisted between requests, but does create challenges for creating good user experiences, when users might expect their previous actions to impact their future experience (e.g. logging into an application should create a different experience and provide different functionality than if they had not logged in). Developers can simulate statefulness using things like sessions, cookies and query string parameters.

### How can we manage state with HTTP?
We can manage state with HTTP using a number of techniques. One technique is through using sessions, through a session id. On the request from a client, the server can check if there is a valid session id associated with a particular user (a session id could be something like a cookie). If there is, the server can then recreate an application state using session-specific resources, and return this as a response to the client. The steps include:
1. Checking if a session id exists with the request (these are usually stored on the client's browser). If not, the server can generate a session id and send this as part of the response.
2. If a session id does exist, whether that session id is still valid. 
3. Associating the session id with resources specific to a particular application state.
4. Retrieving the state specific application data, and returning this in the response to the user. 

We can also simulate state by using a query string; the query strings provide more specific information as part of a request, and can be used to generate a more specific response, based on the information passed through the query string.

### What is a `GET` request? Describe the process of issuing a `GET` request.
A `GET` request is a type of request issued through a web browser, usually with the intent of retrieving some information from the server. A `GET` request will be issued through a request-line, which includes information that helps the server interpret the request and what information to return as part of the response. Standard information included with a request-line include:
1. The request `method` - this identifies the _type_ of request (e.g. `GET`, `POST` `DELETE`)
2. The `host` - this identifies where the request should be sent to, and is required as part of HTTP v1.1.
3. The `path` - this identifies where the specific _resource_ is located
4. The `version` - this identifies what version of HTTP should be used as part of the request/response cycle. This is required as of HTTPv1.

### What is a `POST` request?
A `POST` request is most frequently used when we want the server to perform some action. They are most useful when sending requests where the use of query string parameters may not be fit for use, such as sending large volumes of information (the query string has a character limit), or when there is sensitive information that needs to be sent as part of a request (since query strings are sent as plain text as part of a `GET` request).

### What is a HTTP Header?
HTTP headers are colon-separated plaintext metadata that is sent along with a request or response that helps the host interpret the message. 

Some standard __request__ headers include:
- `Host`: This is equivalent to the `host` in a URL (e.g. `www.google.com`)
- `Accept-Language`: This specifies what language the response resources should be in (e.g. `en-US,en;q=0.8`)
- `User-Agent`: This identifies the client (e.g. `Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5)`)
- `Connection`; This specifies what type of connection the client would prefer (e.g. `keep-alive`)

Some standard __response__ headers include:
- `Status`: This indicates the status of the request (e.g. `302 Found`). This is always returned, and required as part of a HTTP response header.
- `Content-Encoding`: This identifies the encoding used on the data returned by the server (e.g. `gzip`)
- `Server`: The name of the server returning the data (e.g. `thin 1.5.0 codename Knife`)
- `Location`: In the case of a status 302, this indicates where the resource has been relocated to, and where the browser should issue another request to (e.g. `https://www.github.com/login`)
- `Content-Type`: This indicates the format of the data returned (e.g. `text/html; charset=UTF-8`)

### HTTP is a text protocol, and has some security issues. How do we mitigate these security issues?

### What are some ways in which HTTP is vulnerable to hackers?

### What is Transport Layer Security? What does it do?

### What is the TLS Handshake?

### What is a Cipher Suite?

### What is encryption in the context of TLS?

### What is symmetric key encryption? What is asymmetric key encryption? What's the difference?

### What is authentication in the context of TLS?

### What is a certificate?

### What is the chain of trust?

### What is integrity in the context of TLS?
