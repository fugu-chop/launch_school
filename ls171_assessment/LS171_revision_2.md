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
The conceptual definition of a socket is a combination of an IP address and a port (this should be distinguished from the implementation of a socket, e.g. UNIX sockets). Sockets are used as part of the multiplexing capabilities offered at the Transport layer. In a connection-oriented system, a socket object would be instantiated for each incoming socket, such that a dedicated virtual connection is established between client and server for each application process (the combination of the source and destination socket is known as a _four-tuple_). In a connectionless system, only a single socket object is instantiated on the server, and messages are simply responded to in the order they are received. In both cases, the socket of the client helps the server identify where to send a response to.

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

### What is the TCP handshake?

### What is pipelining?

### What is flow control?

### What is congestion avoidance?

### What is the application layer?

### What is HTTP?

### What is a URL? How is it different from a URI? *

### What are the components of a URL? *

### What is a query string parameter? Why would we use it/not use it?

### What is URL encoding and why would we use it?

### What is a server? What are the infrastructure components of a server?

### What are resources?

### What is statelessness? Why is it an issue with HTTP?

### How can we manage state with HTTP?

### What is a `GET` request? Describe the process of issuing a `GET` request.

### What is a `POST` request?

### What is a HTTP Header?

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
